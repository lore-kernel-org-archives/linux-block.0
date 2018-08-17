Return-Path: <mail@maciej.szmigiero.name>
Subject: Re: [PATCH] cfq: clear queue pointers from cfqg after unpinning them
 in cfq_pd_offline
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
 jiufei.xue@linux.alibaba.com, Caspar Zhang <caspar@linux.alibaba.com>
References: <ba086112-65b1-c20f-0694-35d1ca0415d9@maciej.szmigiero.name>
 <4FF39F18-108B-43BD-85A2-A09DB7755865@linaro.org>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <11f9f800-f7d8-288d-4b17-f026170d5eba@maciej.szmigiero.name>
Date: Fri, 17 Aug 2018 19:38:05 +0200
MIME-Version: 1.0
In-Reply-To: <4FF39F18-108B-43BD-85A2-A09DB7755865@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 17.08.2018 19:30, Paolo Valente wrote:
> 
> 
>> Il giorno 17 ago 2018, alle ore 19:28, Maciej S. Szmigiero <mail@maciej.szmigiero.name> ha scritto:
>>
>> The current linux-block, 4.18 and 4.17 can reliably be crashed within few
>> minutes by running the following bash snippet:
>>
>> mkfs.ext4 -v /dev/sda3 && mount /dev/sda3 /mnt/test/ -t ext4;
>> while true; do
>> 	mkdir /sys/fs/cgroup/unified/test/;
>> 	echo $$ >/sys/fs/cgroup/unified/test/cgroup.procs;
>> 	dd if=/dev/zero of=/mnt/test/test-$(( RANDOM * 10 / 32768 )) bs=1M count=1024 &
>> 	echo $$ >/sys/fs/cgroup/unified/cgroup.procs;
>> 	sleep 1;
>> 	kill -KILL $!; wait $!;
>> 	rmdir /sys/fs/cgroup/unified/test;
>> done
>>
>> # cat /sys/block/sda/queue/scheduler
>> noop [cfq]
>> # cat /sys/block/sda/queue/rotational
>> 1
>> # cat /sys/fs/cgroup/unified/cgroup.subtree_control
>> cpu io memory pids
>>
>> The backtraces vary but often they are NULL pointer dereferences due to
>> various cfqq fields being NULL.
>> Or BUG_ON(cfqq->ref <= 0) in cfq_put_queue() triggers due to cfqq reference
>> count being zero.
>>
>> Bisection points at
>> commit 4c6994806f70 ("blk-throttle: fix race between blkcg_bio_issue_check() and cgroup_rmdir()").
>> The prime suspect looked like .pd_offline_fn() method being called multiple
>> times, but from analyzing the mentioned commit this didn't seem possible
>> and runtime trials have confirmed that.
>>
>> However, CFQ's cfq_pd_offline() implementation of the above method were
>> leaving queue pointers intact in cfqg after unpinning them.
>> After making sure that they are cleared to NULL in this function I can no
>> longer reproduce the crash.
>>
> 
> By chance, did you check whether is BFQ is ok in this respect?

I wasn't able to crash BFQ with the above test and in fact had run my
machines on BFQ until I was able to find a fix for this in CFQ.

Also, BFQ has a bit similar code in bfq_put_async_queues() that is
called from bfq_pd_offline() that is already NULL-ing the passed
pointer.

> Thanks,
> Paolo

Regards,
Maciej
