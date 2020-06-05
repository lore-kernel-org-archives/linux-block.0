Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3649BC433E1
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 14:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18ECC20663
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 14:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgFEOVq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:21:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43496 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728273AbgFEOVp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 10:21:45 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C42337A00F821C728404;
        Fri,  5 Jun 2020 22:21:40 +0800 (CST)
Received: from [10.133.219.224] (10.133.219.224) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 5 Jun 2020 22:21:32 +0800
Subject: Re: [RFC PATCH] blk-mq: provide more tags for woken-up process when
 tag allocation is busy
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        <linux-block@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200603073931.94435-1-houtao1@huawei.com>
 <20200604100121.GA2234582@T590>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <7430b61f-f4a5-4582-e91c-1d46e43a3a64@huawei.com>
Date:   Fri, 5 Jun 2020 22:21:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20200604100121.GA2234582@T590>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.224]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On 2020/6/4 18:01, Ming Lei wrote:
> Hi Hou Tao,
> 
> On Wed, Jun 03, 2020 at 03:39:31PM +0800, Hou Tao wrote:
>> When there are many free-bit waiters, current batch wakeup method will
>> wake up at most wake_batch processes when wake_batch bits are freed.
>> The perfect result is each process will get a free bit, however the
>> real result is that a waken-up process may being unable to get
>> a free bit and will call io_schedule() multiple times. That's because
>> other processes (e.g. wake-up before) in the same wake-up batch
>> may have already allocated multiple free bits.
>>
>> And the race leads to two problems. The first one is the unnecessary
>> context switch, because multiple processes are waken up and then
>> go to sleep afterwards. And the second one is the performance
>> degradation when there is spatial locality between requests from
>> one process (e.g. split IO for HDD), because one process can not
>> allocated requests continuously for the split IOs, and
>> the sequential IOs will be dispatched separatedly.
> 
> I guess this way is a bit worse for HDD since sequential IO may be
> interrupted by other context.
Yes.

>>
>> To fix the problem, we mimic the way how SQ handles this situation:
> 
> Do you mean the SQ way is the congestion control code in __get_request()?
> If not, could you provide more background of SQ's way for this issue?
> Cause it isn't easy for me to associate your approach with SQ's code.
> 
The congestion control is accomplished by both __get_request() and __freed_request().
In __get_request(), the max available requests is  nr_requests * 1.5 when
there are multiple threads try to allocate requests, and in __free_requests()
it only start to wake up waiter when the busy requests is less than nr_requests,
so half of nr_request is free when the waiter is woken-up.

The approach in the patch is buggy, because it doesn't check whether
the number of busy bits is greater than the number of to-be-stashed
bits. So we just add an atomic (bit_busy) in struct sbitmap to track
the number of busy bits and use the number to decide whether
we should wake one process or not:

+#define SBQ_WS_ACTIVE_MIN 4
+
+/* return true when fallback to batched wake-up is needed */
+static bool sbitmap_do_stash_and_wakeup(struct sbitmap_queue *sbq)
+{
+       bool fall_back = false;
+       int ws_active;
+       struct sbq_wait_state *ws;
+       int max_busy;
+       int bit_busy;
+       int wake_seq;
+       int old;
+
+       ws_active = atomic_read(&sbq->ws_active);
+       if (!ws_active)
+               goto done;
+
+       if (ws_active < SBQ_WS_ACTIVE_MIN) {
+               fall_back = true;
+               goto done;
+       }
+
+       /* stash and make sure free bits >= depth / 4 */
+       max_busy = max_t(int, sbq->sb.depth * 3 / 4, 1);
+       bit_busy = atomic_read(&sbq->bit_busy);
+       if (bit_busy > max_busy)
+               goto done;
+
+retry:
+       ws = sbq_wake_ptr(sbq);
+       if (!ws)
+               goto done;
+
+       wake_seq = atomic_read(&ws->wake_seq);
+       old = atomic_cmpxchg(&ws->wake_seq, wake_seq, wake_seq + 1);
+       if (old == wake_seq) {
+               sbq_index_atomic_inc(&sbq->wake_index);
+               wake_up(&ws->wait);
+               goto done;
+       }
+
+done:
+       return fall_back;
+}
+
 static bool __sbq_wake_up(struct sbitmap_queue *sbq)
 {
        struct sbq_wait_state *ws;
        unsigned int wake_batch;
        int wait_cnt;

+       if (sbq->flags & SBQ_FLAG_BATCH_BIT_ALLOC) {
+               if (!sbitmap_do_stash_and_wakeup(sbq))
+                       return false;
+       }
+
        ws = sbq_wake_ptr(sbq);
        if (!ws)
                return false;

>> 1) stash a bulk of free bits
>> 2) wake up a process when a new bit is freed
>> 3) woken-up process consumes the stashed free bits
>> 4) when stashed free bits are exhausted, goto step 1)
>>>> Because the tag allocation path or io submit path is much faster than
>> the tag free path, so when the race for free tags is intensive,
> 
> Indeed, I guess you mean bio_endio is slow.
> 
Yes, thanks for the correction.

>> we can ensure:
>> 1) only few processes will be waken up and will exhaust the stashed
>>    free bits quickly.
>> 2) these processes will be able to allocate multiple requests
>>    continuously.
>>
>> An alternative fix is to dynamically adjust the number of woken-up
>> process according to the number of waiters and busy bits, instead of
>> using wake_batch each time in __sbq_wake_up(). However it will need
>> to record the number of busy bits all the time, so use the
>> stash-wake-use method instead.
>>
>> The following is the result of a simple fio test:
>>
>> 1. fio (random read, 1MB, libaio, iodepth=1024)
>>
>> (1) 4TB HDD (max_sectors_kb=256)
>>
>> IOPS (bs=1MB)
>> jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
>> 1    | 120      | 120    | 119
>> 24   | 120      | 105    | 121
>> 48   | 122      | 102    | 121
>> 72   | 120      | 100    | 119
>>
>> context switch per second
>> jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
>> 1    | 1058     | 1162   | 1188
>> 24   | 1047     | 1715   | 1105
>> 48   | 1109     | 1967   | 1105
>> 72   | 1084     | 1908   | 1106
>>
>> (2) 1.8TB SSD (set max_sectors_kb=256)
>>
>> IOPS (bs=1MB)
>> jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
>> 1    | 1077     | 1075   | 1076
>> 24   | 1079     | 1075   | 1076
>> 48   | 1077     | 1076   | 1076
>> 72   | 1077     | 1076   | 1077
>>
>> context switch per second
>> jobs | 4.18-sq  | 5.6.15 | 5.6.15-patched |
>> 1    | 1833     | 5123   | 5264
>> 24   | 2143     | 15238  | 3859
>> 48   | 2182     | 19015  | 3617
>> 72   | 2268     | 19050  | 3662
>>
>> (3) 1.5TB nvme (set max_sectors_kb=256)
>>
>> 4 read queue, 72 CPU
>>
>> IOPS (bs=1MB)
>> jobs | 5.6.15 | 5.6.15-patched |
>> 1    | 3018   | 3018
>> 18   | 3015   | 3016
>> 36   | 3001   | 3005
>> 54   | 2993   | 2997
>> 72   | 2984   | 2990
>>
>> context switch per second
>> jobs | 5.6.15 | 5.6.15-patched |
>> 1    | 6292   | 6469
>> 18   | 19428  | 4253
>> 36   | 21290  | 3928
>> 54   | 23060  | 3957
>> 72   | 24221  | 4054
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>> Hi,
>>
>> We found the problems (excessive context switch and few performance
>> degradation) during the performance comparison between blk-sq (4.18)
>> and blk-mq (5.16) on HDD, but we can not find a better way to fix it.
>>
>> It seems that in order to implement batched request allocation for
>> single process, we need to use an atomic variable to track
>> the number of busy bits. It's suitable for HDD or SDD, because the
>> IO latency is greater than 1ms, but no sure whether or not it's OK
>> for NVMe device.
>
> Do you have benchmark on NVMe/SSD with 4k BS?
> 
The following is the randread test on SSD and NVMe.

1. fio randread 4KB

(1) SSD 1.8TB (nr_tags=1024, nr_requests=256)

It seems that when there is no race for tag allocation, the performance is the same,
but when there are intensive race for tag allocation, the performance gain is huge.

total iodepth=256, so when jobs=2, iodepth=256/2=128

jobs | 5.6   | 5.6 patched
1    | 193k  | 192k
2    | 197k  | 196k
4    | 198k  | 198k
8    | 197k  | 197k
16   | 197k  | 198k
32   | 198k  | 198k
64   | 195k  | 195k
128  | 193k  | 192k
256  | 198k  | 198k

total iodepth=512

jobs | 5.6   | 5.6 patched
1    | 193k  | 194k
2    | 197k  | 196k
4    | 198k  | 197k
8    | 197k  | 219k
16   | 197k  | 394k
32   | 198k  | 395k
64   | 196k  | 592k
128  | 199k  | 591k
256  | 196k  | 591k
512  | 198k  | 591k

total iodepth=1024

jobs | 5.6   | 5.6 patched
1    | 195k  | 192k
2    | 196k  | 197k
4    | 197k  | 197k
8    | 198k  | 197k
16   | 197k  | 198k
32   | 197k  | 243k
64   | 197k  | 393k
128  | 197k  | 986k
256  | 200k  | 976k
512  | 203k  | 984k
1024 | 202k  | 354k

(2) NVMe 1.5TB (nr_tags=1023)

It seems there is no performance impact on NVMe device, but the
the number of context switch will be reduced.

total iodepth=256, so when jobs=2, iodepth=256/2=128

jobs | 5.6   | 5.6 patched
1    | 398k  | 394k
4    | 774k  | 775k
16   | 774k  | 774k
64   | 774k  | 775k
256  | 778k  | 784k

total iodepth=1024

jobs | 5.6   | 5.6 patched
1    | 406k  | 405k
4    | 774k  | 773k
16   | 774k  | 774k
64   | 777k  | 773k
256  | 783k  | 783k
1024 | 764k  | 755k

total iodepth=2048

jobs | 5.6   | 5.6 patched
1    | 369k  | 377k
4    | 774k  | 774k
16   | 774k  | 774k
64   | 767k  | 773k
256  | 784k  | 781k
1024 | 741k  | 1416k
2048 | 754k  | 753k

Regards,
Tao

>>
>> Suggestions and comments are welcome.
>>
>> Regards,
>> Tao
>> ---
>>  block/blk-mq-tag.c      |  4 ++++
>>  include/linux/sbitmap.h |  7 ++++++
>>  lib/sbitmap.c           | 49 +++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 60 insertions(+)
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 586c9d6e904a..fd601fa6c684 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -180,6 +180,10 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>>  	sbitmap_finish_wait(bt, ws, &wait);
>>  
>>  found_tag:
>> +	if (READ_ONCE(bt->stash_ready) &&
>> +	    !atomic_dec_if_positive(&bt->stashed_bits))
>> +		WRITE_ONCE(bt->stash_ready, false);
>> +
> 
> Is it doable to move the above code into sbitmap_queue_do_stash_and_wake_up(),
> after wake_up(&ws->wait)?
> 
> Or at least it should be done for successful allocation after context
> switch?
> 
> 
> Thanks, 
> Ming
> 
> .
> 
