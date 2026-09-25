## Unidad 1: Clases y objetos
---
> **Nota:** Para añadir argumentos a la función `main`: ve a las propiedades del proyecto, apartado **Run** y en **Arguments** añádelos separados por espacios. Si quieres una cadena con espacios, debes ponerla entrecomillada.
---

### Clases y Objetos
> *TIP: Click derecho en el código ➔ "Insert Code" para generar bloques automáticos como constructores, getters, setters, toString, etc.* 

```java
class Coche {
    
    // Atributos privados
    private String matricula;
    private double precio;
    private int cilindrada;
    
    // Constructor
    public Coche(String matr, double pre, int cil) {
        matricula = matr;
        precio = pre;
        cilindrada = cil;
    }

    @Override
    public String toString() {
        return "Coche{" + "matricula=" + matricula + ", precio=" + precio + ", cilindrada=" + cilindrada + '}';
    }

    // Los getter y setter. Si hay atributos privados, los set no deberían ser públicos habitualmente
    public String getMatricula() {
        return matricula;
    }

    public double getPrecio() {
        return precio;
    }

    public int getCilindrada() {
        return cilindrada;
    }

    /*
    protected void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    protected void setPrecio(double precio) {
        this.precio = precio;
    }

    protected void setCilindrada(int cilindrada) {
        this.cilindrada = cilindrada;
    }
    */
}
```

---

> **AVISO:** La principal diferencia para usar las clases de envoltura (**Wrappers** como `Integer` en vez de `int`) es la posibilidad de almacenar valores `null`. Esto es **fundamental** al trabajar con bases de datos.
