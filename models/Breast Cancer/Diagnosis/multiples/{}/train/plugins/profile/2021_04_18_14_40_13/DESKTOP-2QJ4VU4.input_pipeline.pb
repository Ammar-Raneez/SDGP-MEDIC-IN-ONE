	Έ����M@Έ����M@!Έ����M@	�@U��۴?�@U��۴?!�@U��۴?"e
=type.googleapis.com/tensorflow.profiler.PerGenericStepDetails$Έ����M@?�ܵ�|�?Aŏ1w�M@Y=�U����?*	������P@2F
Iterator::Model�!��u��?!"�%<E@)M�O��?1Jx���k>@:Preprocessing2l
5Iterator::Model::ParallelMapV2::Zip[1]::ForeverRepeat�0�*��?!�_{�eE>@)�J�4�?1Y1P�M9@:Preprocessing2U
Iterator::Model::ParallelMapV2����Mb�?!�k��(@)����Mb�?1�k��(@:Preprocessing2v
?Iterator::Model::ParallelMapV2::Zip[0]::FlatMap[0]::Concatenate������?!D.+Jx1@)ŏ1w-!?1��ί=�&@:Preprocessing2Z
#Iterator::Model::ParallelMapV2::ZipjM�?!�h����L@)U���N@s?1�rY1P@:Preprocessing2�
OIterator::Model::ParallelMapV2::Zip[0]::FlatMap[0]::Concatenate[0]::TensorSlice����Mbp?!�k��@)����Mbp?1�k��@:Preprocessing2x
AIterator::Model::ParallelMapV2::Zip[1]::ForeverRepeat::FromTensorF%u�k?!��(�@)F%u�k?1��(�@:Preprocessing2f
/Iterator::Model::ParallelMapV2::Zip[0]::FlatMapS�!�uq�?!i���C.4@)��H�}]?1(፦ί@:Preprocessing:�
]Enqueuing data: you may want to combine small input data chunks into fewer but larger chunks.
�Data preprocessing: you may increase num_parallel_calls in <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#map" target="_blank">Dataset map()</a> or preprocess the data OFFLINE.
�Reading data from files in advance: you may tune parameters in the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch size</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave cycle_length</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer_size</a>)
�Reading data from files on demand: you should read data IN ADVANCE using the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer</a>)
�Other data reading or processing: you may consider using the <a href="https://www.tensorflow.org/programmers_guide/datasets" target="_blank">tf.data API</a> (if you are not using it now)�
:type.googleapis.com/tensorflow.profiler.BottleneckAnalysis�
device�Your program is NOT input-bound because only 0.1% of the total step time sampled is waiting for input. Therefore, you should focus on reducing other time.no*no9�@U��۴?#You may skip the rest of this page.B�
@type.googleapis.com/tensorflow.profiler.GenericStepTimeBreakdown�
	?�ܵ�|�??�ܵ�|�?!?�ܵ�|�?      ��!       "      ��!       *      ��!       2	ŏ1w�M@ŏ1w�M@!ŏ1w�M@:      ��!       B      ��!       J	=�U����?=�U����?!=�U����?R      ��!       Z	=�U����?=�U����?!=�U����?JCPU_ONLYY�@U��۴?b 