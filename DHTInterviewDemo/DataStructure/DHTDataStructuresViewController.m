//
//  DHTDataStructuresViewController.m
//  DHTInterviewDemo
//
//  Created by happyo on 16/5/10.
//  Copyright © 2016年 happyo. All rights reserved.
//

#import "DHTDataStructuresViewController.h"

// LinkList
typedef struct Node {
    char data;
    struct Node *next;
} Node, *LinkList;

// Stack
typedef struct {
    char *top;
    char *base;
    int stackSize;
} SqStack;

// Binary Tree
typedef struct BiTNode {
    char data;
    struct BiTNode *lChild;
    struct BiTNode *rChild;
} BiTNode, *BiTree;

void printChar(char data)
{
    printf("%c", data);
}

void preOrderTraverse(BiTree T, void (* printChar) (char data)) {
    if (T && T->data) {
        printChar(T->data);
        
        if (T->lChild) {
            preOrderTraverse(T->lChild, printChar);
        }
        
        if (T->rChild) {
            preOrderTraverse(T->rChild, printChar);
        }
    }
}

// Buddle Sort

void buddleSort()
{
    int a[10] = {5, 3, 4, 6, 8, 1, 9, 2, 7, 10};
    int length = 10;
    for (int i = 0; i < length - 1; i++) {
        //
        for (int j = i + 1; j < length; j++) {
            if (a[i] > a[j]) {
                int swap = a[j];
                a[j] = a[i];
                a[i] = swap;
            }
        }
    }
    
    for (int i = 0; i < length; i++) {
        printf("\n%i", a[i]);
    }
}

// Quick Sort

void quickSort(int a[10], int low,int high)
{
    if (low < high) {
        int pivotkey = a[low];
        int temp;
        int i = low;
        int j = high;
        
        while (i < j) {
            
            while(a[i] <= pivotkey && i < j)
                i++;
            while(a[j] > pivotkey)
                j--;
            if(i < j){
                temp=a[i];
                a[i]=a[j];
                a[j]=temp;
            }
            
        }
        
        temp = pivotkey;
        a[low]=a[j];
        a[j]=temp;

        quickSort(a, low, j - 1);
        quickSort(a, j + 1, high);
    }
    
}

@implementation DHTDataStructuresViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self studyBinaryTree];
//    
//    buddleSort();
    
    int a[10] = {5, 3, 4, 6, 8, 1, 9, 2, 7, 10};
    quickSort(a, 0, 9);
    
    for (int i = 0; i < 10; i++) {
        printf("\n%i", a[i]);
    }
}

- (void)studyBinaryTree
{
    BiTNode *node = (BiTNode *)malloc(sizeof(BiTNode));
    node->data = 'a';
    
    BiTNode *lNode = (BiTNode *)malloc(sizeof(BiTNode));
    lNode->data = 'b';
    lNode->lChild = NULL;
    lNode->rChild = NULL;

    BiTNode *rNode = (BiTNode *)malloc(sizeof(BiTNode));
    rNode->data = 'c';
    rNode->lChild = NULL;
    rNode->rChild = NULL;
    
    node->lChild = lNode;
    node->rChild = rNode;

    preOrderTraverse(node, printChar);
}

@end
