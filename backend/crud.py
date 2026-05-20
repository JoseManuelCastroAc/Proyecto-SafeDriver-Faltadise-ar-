from sqlalchemy.orm import Session
# CORRECCIÓN: Se separaron los módulos y se quitaron los puntos (.)
import models
import schemas


# ─────────────────────────────────────────────────────────────
# CONDUCTORES
# ─────────────────────────────────────────────────────────────
def crear_conductor(db: Session, conductor: schemas.ConductorCreate):
    nuevo = models.Conductor(
        nombre=conductor.nombre,
        licencia=conductor.licencia,
    )
    db.add(nuevo)
    db.commit()
    db.refresh(nuevo)
    return nuevo


def obtener_conductores(db: Session):
    return db.query(models.Conductor).all()


def obtener_conductor(db: Session, conductor_id: int):
    return (
        db.query(models.Conductor)
        .filter(models.Conductor.id == conductor_id)
        .first()
    )


def actualizar_conductor(
    db: Session,
    conductor_id: int,
    conductor_data: schemas.ConductorCreate,
):
    conductor = obtener_conductor(db, conductor_id)
    if not conductor:
        return None

    conductor.nombre = conductor_data.nombre
    conductor.licencia = conductor_data.licencia

    db.commit()
    db.refresh(conductor)
    return conductor


def eliminar_conductor(db: Session, conductor_id: int):
    conductor = obtener_conductor(db, conductor_id)
    if not conductor:
        return False

    db.delete(conductor)
    db.commit()
    return True


# ─────────────────────────────────────────────────────────────
# VEHÍCULOS
# ─────────────────────────────────────────────────────────────
def crear_vehiculo(db: Session, vehiculo: schemas.VehiculoCreate):
    nuevo = models.Vehiculo(
        placa=vehiculo.placa,
        modelo=vehiculo.modelo,
        conductor_id=vehiculo.conductor_id,
    )
    db.add(nuevo)
    db.commit()
    db.refresh(nuevo)
    return nuevo


def obtener_vehiculos(db: Session):
    return db.query(models.Vehiculo).all()


def obtener_vehiculo(db: Session, vehiculo_id: int):
    return (
        db.query(models.Vehiculo)
        .filter(models.Vehiculo.id == vehiculo_id)
        .first()
    )


def actualizar_vehiculo(
    db: Session,
    vehiculo_id: int,
    vehiculo_data: schemas.VehiculoCreate,
):
    vehiculo = obtener_vehiculo(db, vehiculo_id)
    if not vehiculo:
        return None

    vehiculo.placa = vehiculo_data.placa
    vehiculo.modelo = vehiculo_data.modelo
    vehiculo.conductor_id = vehiculo_data.conductor_id

    db.commit()
    db.refresh(vehiculo)
    return vehiculo


def eliminar_vehiculo(db: Session, vehiculo_id: int):
    vehiculo = obtener_vehiculo(db, vehiculo_id)
    if not vehiculo:
        return False

    db.delete(vehiculo)
    db.commit()
    return True


# ─────────────────────────────────────────────────────────────
# ALERTAS
# ─────────────────────────────────────────────────────────────
def crear_alerta(db: Session, alerta: schemas.AlertaCreate):
    nueva = models.Alerta(**alerta.model_dump())
    db.add(nueva)
    db.commit()
    db.refresh(nueva)
    return nueva


def obtener_alertas(db: Session, conductor_id: int = None):
    query = db.query(models.Alerta)

    if conductor_id:
        query = query.filter(
            models.Alerta.conductor_id == conductor_id
        )

    return query.order_by(models.Alerta.timestamp.desc()).all()