Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24B8C43331
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 13:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E922078A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 13:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YZurTUac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCYNCa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:02:30 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:39384 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727129AbgCYNCa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 09:02:30 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 221D62E1614;
        Wed, 25 Mar 2020 16:02:27 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id n8GlL8OM7f-2PtqAQAE;
        Wed, 25 Mar 2020 16:02:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1585141347; bh=Pz4DD9gshYiNtXEWT5kDJvNb7yJzHhGdcxZucNz+1fU=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=YZurTUacvHKUdg8moh8IMGkwcXqM20aESBHxjuq4xS0tNO0yuTgzEuxy5C8vLmgAP
         MvMzvBcvvTGcsNhJlhHnr3lUlo3tqpowmxM8lORpHZr9BYfAPWDpli93/tCNM4QOzS
         5hR7G5aPjkr00xgbY5u28Z0AvPnwZoM2TfrS0Ryo=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8204::1:e])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id f0qznRAmnk-2Pa4Me0T;
        Wed, 25 Mar 2020 16:02:25 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH v3 1/3] block/diskstats: more accurate approximation of
 io_ticks for slow disks
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
References: <158503038812.1955.7827988255138056389.stgit@buzz>
 <158503198072.1955.16227279292140721351.stgit@buzz>
 <20200324140656.GA23550@ming.t460p> <20200325034024.GC6086@ming.t460p>
 <841346dd-95b0-859f-79ec-dfbdedc16628@yandex-team.ru>
 <4f267148-8d6a-e3c8-2518-b2a3bd579454@yandex-team.ru>
 <20200325085432.GA31035@ming.t460p>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <f4a84e7d-02d4-657d-c2d9-31c98ff31615@yandex-team.ru>
Date:   Wed, 25 Mar 2020 16:02:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325085432.GA31035@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25/03/2020 11.54, Ming Lei wrote:
> On Wed, Mar 25, 2020 at 11:02:39AM +0300, Konstantin Khlebnikov wrote:
>>
>>
>> On 25/03/2020 09.28, Konstantin Khlebnikov wrote:
>>>
>>>
>>> On 25/03/2020 06.40, Ming Lei wrote:
>>>> On Tue, Mar 24, 2020 at 10:06:56PM +0800, Ming Lei wrote:
>>>>> On Tue, Mar 24, 2020 at 09:39:40AM +0300, Konstantin Khlebnikov wrote:
>>>>>> Currently io_ticks is approximated by adding one at each start and end of
>>>>>> requests if jiffies counter has changed. This works perfectly for requests
>>>>>> shorter than a jiffy or if one of requests starts/ends at each jiffy.
>>>>>>
>>>>>> If disk executes just one request at a time and they are longer than two
>>>>>> jiffies then only first and last jiffies will be accounted.
>>>>>>
>>>>>> Fix is simple: at the end of request add up into io_ticks jiffies passed
>>>>>> since last update rather than just one jiffy.
>>>>>>
>>>>>> Example: common HDD executes random read 4k requests around 12ms.
>>>>>>
>>>>>> fio --name=test --filename=/dev/sdb --rw=randread --direct=1 --runtime=30 &
>>>>>> iostat -x 10 sdb
>>>>>>
>>>>>> Note changes of iostat's "%util" 8,43% -> 99,99% before/after patch:
>>>>>>
>>>>>> Before:
>>>>>>
>>>>>> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
>>>>>> sdb               0,00     0,00   82,60    0,00   330,40     0,00     8,00     0,96   12,09   12,09    0,00   1,02   8,43
>>>>>>
>>>>>> After:
>>>>>>
>>>>>> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
>>>>>> sdb               0,00     0,00   82,50    0,00   330,00     0,00     8,00     1,00   12,10   12,10    0,00  12,12  99,99
>>>>>>
>>>>>> For load estimation "%util" is not as useful as average queue length,
>>>>>> but it clearly shows how often disk queue is completely empty.
>>>>>>
>>>>>> Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
>>>>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>>>>> ---
>>>>>>    Documentation/admin-guide/iostats.rst |    5 ++++-
>>>>>>    block/bio.c                           |    8 ++++----
>>>>>>    block/blk-core.c                      |    4 ++--
>>>>>>    include/linux/genhd.h                 |    2 +-
>>>>>>    4 files changed, 11 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
>>>>>> index df5b8345c41d..9b14b0c2c9c4 100644
>>>>>> --- a/Documentation/admin-guide/iostats.rst
>>>>>> +++ b/Documentation/admin-guide/iostats.rst
>>>>>> @@ -100,7 +100,7 @@ Field 10 -- # of milliseconds spent doing I/Os (unsigned int)
>>>>>>        Since 5.0 this field counts jiffies when at least one request was
>>>>>>        started or completed. If request runs more than 2 jiffies then some
>>>>>> -    I/O time will not be accounted unless there are other requests.
>>>>>> +    I/O time might be not accounted in case of concurrent requests.
>>>>>>    Field 11 -- weighted # of milliseconds spent doing I/Os (unsigned int)
>>>>>>        This field is incremented at each I/O start, I/O completion, I/O
>>>>>> @@ -143,6 +143,9 @@ are summed (possibly overflowing the unsigned long variable they are
>>>>>>    summed to) and the result given to the user.  There is no convenient
>>>>>>    user interface for accessing the per-CPU counters themselves.
>>>>>> +Since 4.19 request times are measured with nanoseconds precision and
>>>>>> +truncated to milliseconds before showing in this interface.
>>>>>> +
>>>>>>    Disks vs Partitions
>>>>>>    -------------------
>>>>>> diff --git a/block/bio.c b/block/bio.c
>>>>>> index 0985f3422556..b1053eb7af37 100644
>>>>>> --- a/block/bio.c
>>>>>> +++ b/block/bio.c
>>>>>> @@ -1762,14 +1762,14 @@ void bio_check_pages_dirty(struct bio *bio)
>>>>>>        schedule_work(&bio_dirty_work);
>>>>>>    }
>>>>>> -void update_io_ticks(struct hd_struct *part, unsigned long now)
>>>>>> +void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
>>>>>>    {
>>>>>>        unsigned long stamp;
>>>>>>    again:
>>>>>>        stamp = READ_ONCE(part->stamp);
>>>>>>        if (unlikely(stamp != now)) {
>>>>>>            if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
>>>>>> -            __part_stat_add(part, io_ticks, 1);
>>>>>> +            __part_stat_add(part, io_ticks, end ? now - stamp : 1);
>>>>>>            }
>>>>>>        }
>>>>>>        if (part->partno) {
>>>>>> @@ -1785,7 +1785,7 @@ void generic_start_io_acct(struct request_queue *q, int op,
>>>>>>        part_stat_lock();
>>>>>> -    update_io_ticks(part, jiffies);
>>>>>> +    update_io_ticks(part, jiffies, false);
>>>>>>        part_stat_inc(part, ios[sgrp]);
>>>>>>        part_stat_add(part, sectors[sgrp], sectors);
>>>>>>        part_inc_in_flight(q, part, op_is_write(op));
>>>>>> @@ -1803,7 +1803,7 @@ void generic_end_io_acct(struct request_queue *q, int req_op,
>>>>>>        part_stat_lock();
>>>>>> -    update_io_ticks(part, now);
>>>>>> +    update_io_ticks(part, now, true);
>>>>>>        part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
>>>>>>        part_stat_add(part, time_in_queue, duration);
>>>>>>        part_dec_in_flight(q, part, op_is_write(req_op));
>>>>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>>>>> index abfdcf81a228..4401b30a1751 100644
>>>>>> --- a/block/blk-core.c
>>>>>> +++ b/block/blk-core.c
>>>>>> @@ -1337,7 +1337,7 @@ void blk_account_io_done(struct request *req, u64 now)
>>>>>>            part_stat_lock();
>>>>>>            part = req->part;
>>>>>> -        update_io_ticks(part, jiffies);
>>>>>> +        update_io_ticks(part, jiffies, true);
>>>>>>            part_stat_inc(part, ios[sgrp]);
>>>>>>            part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
>>>>>>            part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
>>>>>> @@ -1379,7 +1379,7 @@ void blk_account_io_start(struct request *rq, bool new_io)
>>>>>>            rq->part = part;
>>>>>>        }
>>>>>> -    update_io_ticks(part, jiffies);
>>>>>> +    update_io_ticks(part, jiffies, false);
>>>>>>        part_stat_unlock();
>>>>>>    }
>>>>>> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
>>>>>> index d5c75df64bba..f1066f10b062 100644
>>>>>> --- a/include/linux/genhd.h
>>>>>> +++ b/include/linux/genhd.h
>>>>>> @@ -467,7 +467,7 @@ static inline void free_part_info(struct hd_struct *part)
>>>>>>        kfree(part->info);
>>>>>>    }
>>>>>> -void update_io_ticks(struct hd_struct *part, unsigned long now);
>>>>>> +void update_io_ticks(struct hd_struct *part, unsigned long now, bool end);
>>>>>>    /* block/genhd.c */
>>>>>>    extern void device_add_disk(struct device *parent, struct gendisk *disk,
>>>>>>
>>>>>
>>>>> Looks fine:
>>>>>
>>>>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>>>>
>>>> BTW, there is still some gap(%65 vs. 99%) between this fix and the original
>>>> accounting(before applying Mike/Mikulas's 7 patches), and it might be
>>>> one thing to improve in future.
>>>>
>>>> 1) test, sda is single queue virtio-scsi, which is emulated by one HDD
>>>> image
>>>>
>>>> 2) fio test script:
>>>> fio --direct=1 --size=128G --bsrange=4k-4k \
>>>>          --runtime=20 --numjobs=1 \
>>>>          --ioengine=libaio --iodepth=16 \
>>>>          --iodepth_batch_submit=16 \
>>>>          --iodepth_batch_complete_min=16 \
>>>>          --group_reporting=1 --filename=/dev/sda \
>>>>          --name=seq-test --rw=read
>>>>
>>>> 3) result:
>>>> - v5.6-rc with this patch
>>>> Run status group 0 (all jobs):
>>>>      READ: bw=79.4MiB/s (83.3MB/s), 79.4MiB/s-79.4MiB/s (83.3MB/s-83.3MB/s), io=155
>>>> 88MiB (1665MB), run=20001-20001msec
>>>>
>>>> Disk stats (read/write):
>>>>     sda: ios=25039/0, merge=375596/0, ticks=18823/0, in_queue=4330, util=99.43%
>>>>
>>>>
>>>> - commit 112f158f66cb (which is previous commit of 5b18b5a73760)
>>>> Run status group 0 (all jobs):
>>>>      READ: bw=81.4MiB/s (85.3MB/s), 81.4MiB/s-81.4MiB/s (85.3MB/s-85.3MB/s), io=166
>>>> 28MiB (1707MB), run=20001-20001msec
>>>>
>>>> Disk stats (read/write):
>>>>     sda: ios=25749/0, merge=386236/0, ticks=17963/0, in_queue=12976, util=65.20%
>>>>
>>
>> Oh, no. Your result is opposite.
>>
>> Well, 99.43% with this patch is actually more correct result:
>> every millisecond there is at least one request in disk.
>>
>> Old code sampled in-flight at start and end of each request, not regularly every jiffy.
> 
> It doesn't matter if it is regularly every jiffy, or the sample point.
> 
> It is perfect to just sample at start and end, and not necessary to
> do it in merge.
> 
> What matters is that only IO time is accounted. And when there isn't
> any IO in-flight, the time shouldn't be accounted into io_ticks.
> That is it, however, the new approach can't do that at all.

Yeah, should be right but something fishy in old statistics anyway.

It looks timestamp (part->stamp) sometimes updated non-atomically
without queue_lock.

> 
>> And accounted whole jiffy as inactive if in-flight currently is zero.
>> This way statistics was biased to samples where queue is empty.
> 
> It is just one sequential read test, single job, and there are lots of
> merge, so disk utilization shouldn't be close to 100%, should it?

Why not? It doesn't took a long time to complete request and issue another.

Look, for single-thread fio iostat show %util 100% but avgqu-sz is 1 too
it's estimated using total I/O time which counted in nanoseconds.

Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0,00     0,00   83,30    0,00   333,20     0,00     8,00     1,00   11,98   11,98    0,00  12,00 100,00

Probably old blk stack was generally slower and delayed requests somewhere.

> 
> With your patch, now it is much easy to observe 100% utilization.
> 
> More ticks are counted in v5.6-rc with this patch than old kernel, the
> reason is that new approach counts 1 tick for IDLE time(no any IO)
> in blk_account_io_start(). Old approach knows if there is any in-flight
> IO, if there isn't, the period since last stamp is thought as IO idle,
> and that time won't be accounted. >
> However, the new approach doesn't know IO IDLE period at all, just
> add 1 tick for this period.

There is I/O during jiffy when request starts =) So it's counted as 1.
This kind of rounding up I/O shorter than jiffy.

> 
> 
> Thanks,
> Ming
>
