Return-Path: <borntraeger@de.ibm.com>
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
References: <be80d226-2211-8e6c-dc30-a45088fe14b6@de.ibm.com>
 <20180329114313.GC17537@ming.t460p>
 <adb2321f-ebed-d65a-c4d0-275c492fed53@de.ibm.com>
 <20180330025340.GB12412@ming.t460p>
 <f4ac3dba-9b06-9896-38b3-0b173a072d3d@de.ibm.com>
 <20180405160503.GA20818@ming.t460p> <20180405161142.GA20972@ming.t460p>
 <3a72f42f-db90-6092-5e1b-0579d2095daa@de.ibm.com>
 <20180406084106.GA8940@ming.t460p>
 <e3701f81-8616-31b5-cf29-2f788f06aa64@de.ibm.com>
 <20180406092309.GB9605@ming.t460p>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 6 Apr 2018 12:19:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180406092309.GB9605@ming.t460p>
Content-Type: text/plain; charset=utf-8
Message-Id: <e2dbf168-8583-2011-6520-02bf17051cd2@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>



On 04/06/2018 11:23 AM, Ming Lei wrote:
> On Fri, Apr 06, 2018 at 10:51:28AM +0200, Christian Borntraeger wrote:
>>
>>
>> On 04/06/2018 10:41 AM, Ming Lei wrote:
>>> On Thu, Apr 05, 2018 at 07:39:56PM +0200, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 04/05/2018 06:11 PM, Ming Lei wrote:
>>>>>>
>>>>>> Could you please apply the following patch and provide the dmesg boot log?
>>>>>
>>>>> And please post out the 'lscpu' log together from the test machine too.
>>>>
>>>> attached.
>>>>
>>>> As I said before this seems to go way with CONFIG_NR_CPUS=64 or smaller.
>>>> We have 282 nr_cpu_ids here (max 141CPUs on that z13 with SMT2) but only 8 Cores
>>>> == 16 threads.
>>>
>>> OK, thanks!
>>>
>>> The most weird thing is that hctx->next_cpu is computed as 512 since
>>> nr_cpu_id is 282, and hctx->next_cpu should have pointed to one of
>>> possible CPU.
>>>
>>> Looks like it is a s390 specific issue, since I can setup one queue
>>> which has same mapping with yours:
>>>
>>> 	- nr_cpu_id is 282
>>> 	- CPU 0~15 is online
>>> 	- 64 queues null_blk
>>> 	- still run all hw queues in .complete handler
>>>
>>> But can't reproduce this issue at all.
>>>
>>> So please test the following patch, which may tell us why hctx->next_cpu
>>> is computed wrong:
>>
>> I see things like
>>
>> [    8.196907] wrong next_cpu 512, blk_mq_map_swqueue, first_and
>> [    8.196910] wrong next_cpu 512, blk_mq_map_swqueue, first_and
>> [    8.196912] wrong next_cpu 512, blk_mq_map_swqueue, first_and
>> [    8.196913] wrong next_cpu 512, blk_mq_map_swqueue, first_and
>> [    8.196914] wrong next_cpu 512, blk_mq_map_swqueue, first_and
>> [    8.196915] wrong next_cpu 512, blk_mq_map_swqueue, first_and
>> [    8.196916] wrong next_cpu 512, blk_mq_map_swqueue, first_and
>> [    8.196916] wrong next_cpu 512, blk_mq_map_swqueue, first_and
>> [    8.196917] wrong next_cpu 512, blk_mq_map_swqueue, first_and
>> [    8.196918] wrong next_cpu 512, blk_mq_map_swqueue, first_and
>>
>> which is exactly what happens if the find and and operation fails (returns size of bitmap).
> 
> Given both 'cpu_online_mask' and 'hctx->cpumask' are shown as correct
> in your previous debug log, it means the following function returns
> totally wrong result on S390.
> 
> 	cpumask_first_and(hctx->cpumask, cpu_online_mask);
> 
> The debugfs log shows that each hctx->cpumask includes one online
> CPU(0~15).

Really? the last log (with the latest patch applied  shows a lot of contexts
that do not have CPUs in 0-15:

e.g. 
[    4.049828] dump CPUs mapped to this hctx:
[    4.049829] 18 
[    4.049829] 82 
[    4.049830] 146 
[    4.049830] 210 
[    4.049831] 274 

> 
> So looks it isn't one issue in block MQ core.
> 
> Thanks,
> Ming
> 
