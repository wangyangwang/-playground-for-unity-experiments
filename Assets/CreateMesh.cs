using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CreateMesh : MonoBehaviour {
    public Vector3[] newVertices;
    public Vector2[] newUV;
    public int[] newTriangles;

	// Use this for initialization
	void Start () {
        //Mesh mesh = new Mesh();
        //GetComponent<MeshFilter>().mesh = mesh;
        //mesh.Clear();
        //mesh.vertices = newVertices;
        //mesh.uv = newUV;
        //mesh.triangles = newTriangles;
	}
	
	// Update is called once per frame
	void Update () {
        Mesh mesh = GetComponent<MeshFilter>().mesh;
        Vector3[] vertices = mesh.vertices;
        Vector3[] normals = mesh.normals;

        for (int i = 0; i < vertices.Length;i++){
            vertices[i] += new Vector3(Mathf.PerlinNoise(vertices[i].x, vertices[i].y) - 0.5f, Mathf.PerlinNoise(vertices[i].x, vertices[i].y) - 0.5f, Mathf.PerlinNoise(vertices[i].x, vertices[i].y) - 0.5f);
        }
        mesh.vertices = vertices;
		
	}
}
