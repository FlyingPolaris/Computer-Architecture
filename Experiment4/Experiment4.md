# 实验4 高速缓存的性能
余北辰519030910245

## Exercise 1: Cache Visualization

### 场景1

* Cache 命中率是多少？

命中率为75%。



* 为什么会出现这个cache命中率？

cache采取直接映射的方式；循环每重复一次，会访问四个地址，且每次循环访问的地址相同，故第一轮循环时全部cache miss，之后的三轮循环命中率都为100%，最终的命中率为75%。



* 增加Rep Count参数的值，可以提高命中率吗? 为什么?

可以，因为除了第一轮循环全部cache miss之外，之后的各轮循环全部cache hit。因此Rep Count越多，hit rate越高。



* 为了最大化hit rate，在不修改cache参数的情况下，如何修改程序中的参数（program parameters）？

增加Rep Count参数的值，原因如上所述；将Option的值改为1，因为这样在第一个循环内读操作发生cache miss，而写操作也能cache hit。



### 场景2

* Cache 命中率是多少？

命中率为75%。



* 为什么会出现这个cache命中率？

由于一块是4个word，也就是16个Byte，等于4个int型数据的大小。也就是说每次cache miss后，会将连续的四个int型数据写入cache。 而step size为2，且option的值为1，也就是说每四次访问的内容都在一个块中。其中第一次会发生miss，之后三次都是hit，所以命中率是75%。



cache采取四路组相联映射的方式，因此一共有4个组，组号为2位。因此每经过$2^{4+2}=64$个bytes,也就是16个int型数据，会出现一次组号相同的情况。而Array Size为256Bytes，也就是说一共有64个int型数据；而cache中一组也正好有4块，因此所有的数据正好将cache给填满，不用发生替换。因此最终的命中率就是75%。



* 增加Rep Count 参数的值，例如重复无限次，命中率是多少? 为什么?



## 2

