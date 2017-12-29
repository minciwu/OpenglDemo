//
//  OpenGlCommenUtil.m
//  Light
//
//  Created by luo luo on 29/12/2017.
//  Copyright © 2017 ChangeStrong. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "OpenGlCommenUtil.h"

//设置一个三角形顶点数组
SceneTriangle SceneTriangleMake(SceneVertex vertexA,SceneVertex vertexB,SceneVertex vertexC)
{
    SceneTriangle triangle = {vertexA,vertexB,vertexC};
    return triangle;
}

/**
 *  以点0为出发点，通过叉积计算平面法向量
 *
 *  @param triangle 三角形
 *
 *  @return 平面法向量
 */
GLKVector3 SceneTriangleFaceNormal(
                                   const SceneTriangle triangle)
{
    //通过顶点1和顶点0决定一个向量
    GLKVector3 vectorA = GLKVector3Subtract(
                                            triangle.vertices[1].position,
                                            triangle.vertices[0].position);
    GLKVector3 vectorB = GLKVector3Subtract(
                                            triangle.vertices[2].position,
                                            triangle.vertices[0].position);
    //通过两个向量的叉积决定的三角形的法向量
    return SceneVector3UnitNormal(
                                  vectorA,
                                  vectorB);
}

/**
 *  计算三角形平面法向量，更新每个点的平面法向量
 *
 *  @param someTriangles 三角形数组
 *
 */

void SceneTrianglesUpdateFaceNormals(
                                     SceneTriangle someTriangles[NUM_FACES])
{
    int                i;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (i=0; i<NUM_FACES; i++)
    {
        //获取三角形的法向量
        GLKVector3 faceNormal = SceneTriangleFaceNormal(
                                                        someTriangles[i]);
       
        someTriangles[i].vertices[0].normal = faceNormal;
        someTriangles[i].vertices[1].normal = faceNormal;
        someTriangles[i].vertices[2].normal = faceNormal;
        
        [dict setObject:[NSString stringWithFormat:@"X:%f Y:%f Z:%f",faceNormal.x,faceNormal.y,faceNormal.z] forKey:[NSString stringWithFormat:@"index:%d",i]];
    }
    
    NSLog(@"新的法向量:%@",dict);
}

/**
 *  计算各三角形的法向量，通过平均值求出每个点的法向量
 *
 *  @param someTriangles 三角形数组
 *
 */
void SceneTrianglesUpdateVertexNormals(
                                       SceneTriangle someTriangles[NUM_FACES])
{
    SceneVertex newVertexA = vertexA;
    SceneVertex newVertexB = vertexB;
    SceneVertex newVertexC = vertexC;
    SceneVertex newVertexD = vertexD;
    SceneVertex newVertexE = someTriangles[3].vertices[0];
    SceneVertex newVertexF = vertexF;
    SceneVertex newVertexG = vertexG;
    SceneVertex newVertexH = vertexH;
    SceneVertex newVertexI = vertexI;
    //每个三角形的法向量数组
    GLKVector3 faceNormals[NUM_FACES];
    
    
    for (int i=0; i<NUM_FACES; i++)
    {
        faceNormals[i] = SceneTriangleFaceNormal(
                                                 someTriangles[i]);
    }
    
    
    //通过平均值求出每个点的法向量
    newVertexA.normal = faceNormals[0];
    newVertexB.normal = GLKVector3MultiplyScalar(
                                                 GLKVector3Add(
                                                               GLKVector3Add(
                                                                             GLKVector3Add(
                                                                                           faceNormals[0],
                                                                                           faceNormals[1]),
                                                                             faceNormals[2]),
                                                               faceNormals[3]), 0.25);
    newVertexC.normal = faceNormals[1];
    newVertexD.normal = GLKVector3MultiplyScalar(
                                                 GLKVector3Add(
                                                               GLKVector3Add(
                                                                             GLKVector3Add(
                                                                                           faceNormals[0],
                                                                                           faceNormals[2]),
                                                                             faceNormals[4]),
                                                               faceNormals[6]), 0.25);
    newVertexE.normal = GLKVector3MultiplyScalar(
                                                 GLKVector3Add(
                                                               GLKVector3Add(
                                                                             GLKVector3Add(
                                                                                           faceNormals[2],
                                                                                           faceNormals[3]),
                                                                             faceNormals[4]),
                                                               faceNormals[5]), 0.25);
    newVertexF.normal = GLKVector3MultiplyScalar(
                                                 GLKVector3Add(
                                                               GLKVector3Add(
                                                                             GLKVector3Add(
                                                                                           faceNormals[1],
                                                                                           faceNormals[3]),
                                                                             faceNormals[5]),
                                                               faceNormals[7]), 0.25);
    newVertexG.normal = faceNormals[6];
    newVertexH.normal = GLKVector3MultiplyScalar(
                                                 GLKVector3Add(
                                                               GLKVector3Add(
                                                                             GLKVector3Add(
                                                                                           faceNormals[4],
                                                                                           faceNormals[5]),
                                                                             faceNormals[6]),
                                                               faceNormals[7]), 0.25);
    newVertexI.normal = faceNormals[7];
    
    //用新的点创建三角形
    someTriangles[0] = SceneTriangleMake(
                                         newVertexA,
                                         newVertexB,
                                         newVertexD);
    someTriangles[1] = SceneTriangleMake(
                                         newVertexB,
                                         newVertexC,
                                         newVertexF);
    someTriangles[2] = SceneTriangleMake(
                                         newVertexD,
                                         newVertexB,
                                         newVertexE);
    someTriangles[3] = SceneTriangleMake(
                                         newVertexE,
                                         newVertexB,
                                         newVertexF);
    someTriangles[4] = SceneTriangleMake(
                                         newVertexD,
                                         newVertexE,
                                         newVertexH);
    someTriangles[5] = SceneTriangleMake(
                                         newVertexE,
                                         newVertexF,
                                         newVertexH);
    someTriangles[6] = SceneTriangleMake(
                                         newVertexG,
                                         newVertexD,
                                         newVertexH);
    someTriangles[7] = SceneTriangleMake(
                                         newVertexH,
                                         newVertexF,
                                         newVertexI);
}

/**
 *  以每个顶点的坐标为起点，顶点坐标加上法向量的偏移值作为终点，更新法线显示数组
 *  最后一条线是光源
 *
 *  @param someTriangles          三角型数组
 *  @param lightPosition          光源位置
 *  @param someNormalLineVertices 法线显示顶点数组
 */
void SceneTrianglesNormalLinesUpdate(
                                     const SceneTriangle someTriangles[NUM_FACES],
                                     GLKVector3 lightPosition,
                                     GLKVector3 someNormalLineVertices[NUM_LINE_VERTS])
{
    int                       trianglesIndex;
    int                       lineVetexIndex = 0;
    
    
    for (trianglesIndex = 0; trianglesIndex < NUM_FACES;
         trianglesIndex++)
    {
        someNormalLineVertices[lineVetexIndex++] =
        someTriangles[trianglesIndex].vertices[0].position;
        //顶点坐标+法向量
        someNormalLineVertices[lineVetexIndex++] =
        GLKVector3Add(
                      someTriangles[trianglesIndex].vertices[0].position,
                      GLKVector3MultiplyScalar(
                                               someTriangles[trianglesIndex].vertices[0].normal,
                                               0.5));
        someNormalLineVertices[lineVetexIndex++] =
        someTriangles[trianglesIndex].vertices[1].position;
        someNormalLineVertices[lineVetexIndex++] =
        GLKVector3Add(
                      someTriangles[trianglesIndex].vertices[1].position,
                      GLKVector3MultiplyScalar(
                                               someTriangles[trianglesIndex].vertices[1].normal,
                                               0.5));
        someNormalLineVertices[lineVetexIndex++] =
        someTriangles[trianglesIndex].vertices[2].position;
        someNormalLineVertices[lineVetexIndex++] =
        GLKVector3Add(
                      someTriangles[trianglesIndex].vertices[2].position,
                      GLKVector3MultiplyScalar(
                                               someTriangles[trianglesIndex].vertices[2].normal,
                                               0.5));
    }
    
    //光照方向
    someNormalLineVertices[lineVetexIndex++] =
    lightPosition;
    
    someNormalLineVertices[lineVetexIndex] = GLKVector3Make(
                                                            0.0,
                                                            0.0,
                                                            -0.5);
}

#pragma mark Utility GLKVector3
/**
 *  通过向量A和向量B的叉积求出平面法向量，单元化后返回
 *
 *  @param vectorA 向量A
 *  @param vectorB 向量B
 *
 *  @return 单元平面法向量
 */
GLKVector3 SceneVector3UnitNormal(
                                  const GLKVector3 vectorA,
                                  const GLKVector3 vectorB)
{
    return GLKVector3Normalize(
                               GLKVector3CrossProduct(vectorA, vectorB));
}