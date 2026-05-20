from typing import List

from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

# CORRECCIÓN: Se eliminaron los puntos (.) de los imports locales
import crud
import models
import schemas
from database import engine, get_db
from auth import (
    crear_token_acceso,
    verificar_token,
    USUARIO_ADMIN,
)

# Crear tablas automáticamente
models.Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="SafeDriver API",
    description="Sistema Inteligente de Prevención de Fatiga y Seguridad Vial",
    version="1.0.0",
)

# CORS para Flutter
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# ─────────────────────────────────────────────────────────────
# SISTEMA
# ─────────────────────────────────────────────────────────────
@app.get("/", tags=["Sistema"])
def root():
    return {
        "status": "online",
        "sistema": "SafeDriver v1.0",
    }


# ─────────────────────────────────────────────────────────────
# LOGIN
# ─────────────────────────────────────────────────────────────
@app.post("/token", tags=["Seguridad"])
def login(
    form_data: OAuth2PasswordRequestForm = Depends(),
):
    if (
        form_data.username != USUARIO_ADMIN["username"]
        or form_data.password != USUARIO_ADMIN["password"]
    ):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Usuario o contraseña incorrectos",
        )

    token = crear_token_acceso(
        {"sub": form_data.username}
    )

    return {
        "access_token": token,
        "token_type": "bearer",
    }


# ─────────────────────────────────────────────────────────────
# CONDUCTORES
# ─────────────────────────────────────────────────────────────
@app.post(
    "/conductores/",
    response_model=schemas.ConductorOut,
    status_code=201,
    tags=["Conductores"],
)
def crear_conductor(
    conductor: schemas.ConductorCreate,
    db: Session = Depends(get_db),
    usuario: str = Depends(verificar_token),
):
    return crud.crear_conductor(db, conductor)


@app.get(
    "/conductores/",
    response_model=List[schemas.ConductorOut],
    tags=["Conductores"],
)
def listar_conductores(
    db: Session = Depends(get_db),
):
    return crud.obtener_conductores(db)


@app.get(
    "/conductores/{conductor_id}",
    response_model=schemas.ConductorOut,
    tags=["Conductores"],
)
def obtener_conductor(
    conductor_id: int,
    db: Session = Depends(get_db),
):
    conductor = crud.obtener_conductor(
        db,
        conductor_id,
    )

    if not conductor:
        raise HTTPException(
            status_code=404,
            detail="Conductor no encontrado",
        )

    return conductor


@app.put(
    "/conductores/{conductor_id}",
    response_model=schemas.ConductorOut,
    tags=["Conductores"],
)
def actualizar_conductor(
    conductor_id: int,
    conductor: schemas.ConductorCreate,
    db: Session = Depends(get_db),
    usuario: str = Depends(verificar_token),
):
    actualizado = crud.actualizar_conductor(
        db,
        conductor_id,
        conductor,
    )

    if not actualizado:
        raise HTTPException(
            status_code=404,
            detail="Conductor no encontrado",
        )

    return actualizado


@app.delete(
    "/conductores/{conductor_id}",
    tags=["Conductores"],
)
def eliminar_conductor(
    conductor_id: int,
    db: Session = Depends(get_db),
    usuario: str = Depends(verificar_token),
):
    eliminado = crud.eliminar_conductor(
        db,
        conductor_id,
    )

    if not eliminado:
        raise HTTPException(
            status_code=404,
            detail="Conductor no encontrado",
        )

    return {"message": "Conductor eliminado correctamente"}


# ─────────────────────────────────────────────────────────────
# VEHÍCULOS
# ─────────────────────────────────────────────────────────────
@app.post(
    "/vehiculos/",
    response_model=schemas.VehiculoOut,
    status_code=201,
    tags=["Vehículos"],
)
def crear_vehiculo(
    vehiculo: schemas.VehiculoCreate,
    db: Session = Depends(get_db),
    usuario: str = Depends(verificar_token),
):
    conductor = crud.obtener_conductor(
        db,
        vehiculo.conductor_id,
    )

    if not conductor:
        raise HTTPException(
            status_code=404,
            detail="Conductor no encontrado",
        )

    return crud.crear_vehiculo(db, vehiculo)


@app.get(
    "/vehiculos/",
    response_model=List[schemas.VehiculoOut],
    tags=["Vehículos"],
)
def listar_vehiculos(
    db: Session = Depends(get_db),
):
    return crud.obtener_vehiculos(db)


@app.put(
    "/vehiculos/{vehiculo_id}",
    response_model=schemas.VehiculoOut,
    tags=["Vehículos"],
)
def actualizar_vehiculo(
    vehiculo_id: int,
    vehiculo: schemas.VehiculoCreate,
    db: Session = Depends(get_db),
    usuario: str = Depends(verificar_token),
):
    conductor = crud.obtener_conductor(
        db,
        vehiculo.conductor_id,
    )

    if not conductor:
        raise HTTPException(
            status_code=404,
            detail="Conductor no encontrado",
        )

    actualizado = crud.actualizar_vehiculo(
        db,
        vehiculo_id,
        vehiculo,
    )

    if not actualizado:
        raise HTTPException(
            status_code=404,
            detail="Vehículo no encontrado",
        )

    return actualizado


@app.delete(
    "/vehiculos/{vehiculo_id}",
    tags=["Vehículos"],
)
def eliminar_vehiculo(
    vehiculo_id: int,
    db: Session = Depends(get_db),
    usuario: str = Depends(verificar_token),
):
    eliminado = crud.eliminar_vehiculo(
        db,
        vehiculo_id,
    )

    if not eliminado:
        raise HTTPException(
            status_code=404,
            detail="Vehículo no encontrado",
        )

    return {"message": "Vehículo eliminado correctamente"}


# ─────────────────────────────────────────────────────────────
# ALERTAS
# ─────────────────────────────────────────────────────────────
@app.post(
    "/alertas/",
    response_model=schemas.AlertaOut,
    status_code=201,
    tags=["Alertas"],
)
def registrar_alerta(
    alerta: schemas.AlertaCreate,
    db: Session = Depends(get_db),
    usuario: str = Depends(verificar_token),
):
    if not crud.obtener_conductor(
        db,
        alerta.conductor_id,
    ):
        raise HTTPException(
            status_code=404,
            detail="Conductor no encontrado",
        )

    vehiculo = crud.obtener_vehiculo(
        db,
        alerta.vehiculo_id,
    )

    if not vehiculo:
        raise HTTPException(
            status_code=404,
            detail="Vehículo no encontrado",
        )

    return crud.crear_alerta(db, alerta)


@app.get(
    "/alertas/",
    response_model=List[schemas.AlertaOut],
    tags=["Alertas"],
)
def listar_alertas(
    conductor_id: int = None,
    db: Session = Depends(get_db),
    usuario: str = Depends(verificar_token),
):
    return crud.obtener_alertas(
        db,
        conductor_id,
    )