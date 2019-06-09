Return-Path: <SRS0=xEhu=UI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBF2C28EBD
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 10:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C682083D
	for <linux-block@archiver.kernel.org>; Sun,  9 Jun 2019 10:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="MBSFyD+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfFIK5k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jun 2019 06:57:40 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:43714 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728029AbfFIK5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 9 Jun 2019 06:57:40 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jun 2019 06:57:38 EDT
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 8CBFC2E1466;
        Sun,  9 Jun 2019 13:50:11 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id AvnTB6LtJ3-oAoSGrki;
        Sun, 09 Jun 2019 13:50:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1560077411; bh=TkrE/YW1ROZAltUXeGcoZ+KS+2RwAzKxGf1L9XLuf+w=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=MBSFyD+aZGU6vXuIHy0Vvv4IDTZQqkk0A1wyXeNN5pJgTYbn4XO2d+dyl+OWoyIy1
         bWg39yLyKsSoIHMsmpX8Dbdak/KDEsdQrGOdcGSjQmfsFqsPtsaS1QN1gkQWtPGzCN
         kCCwrdSeEj5PoUYFiS0s5ueiGuzI0rlqiFS9jbao=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d25:9e27:4f75:a150])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id BEZTieY99Z-oAYOoxXB;
        Sun, 09 Jun 2019 13:50:10 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH 3/3] block/diskstats: more accurate approximation of
 io_ticks for slow disks
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
References: <155413438394.3201.15211440151043943989.stgit@buzz>
 <155413438824.3201.15254568091182734151.stgit@buzz>
 <d5d39e1c-59f2-b5d8-0189-020efaed4ce8@gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <dda99f92-ba4c-736f-a5da-02e5ffbf93f4@yandex-team.ru>
Date:   Sun, 9 Jun 2019 13:50:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d5d39e1c-59f2-b5d8-0189-020efaed4ce8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 07.05.2019 12:13, Alan Jenkins wrote:
> On 01/04/2019 16:59, Konstantin Khlebnikov wrote:
>> Currently io_ticks is approximated by adding one at each
>> start and end of requests if jiffies has changed.
>> This works perfectly for requests shorter than a jiffy.
>>
>> Fix for slow requests is simple: at the end of request add
>> count of jiffies passed since last update.
>>
>> Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> Thanks for working on this!  I noticed the problem behaviour using the Fedora 29 kernel [1].  I wasn't sure how it could be fixed.  Now I 
> found this patch series, but I still have some questions :-).
> 
> [1] https://unix.stackexchange.com/questions/517132/dd-is-running-at-full-speed-but-i-only-see-20-disk-utilization-why
> 
> With these patches, `atopsar -d 2` shows about 100% "busy" when running a simple `dd` command, instead of 20 or 35%.  So that looked promising.
> 
> I saw some samples showing 112, 113, and 114% utilization. Unfortunately I'm not sure exactly how to reproduce that.  I think it happened 
> during filesystem buffered writes (i.e. `dd` without `oflag=direct`), with the IO scheduler set to "none", on my SATA HDD.
> 
> Getting some "101% busy" samples seemed fairly easy to trigger, but I am not sure whether that is just a rounding error in `atopsar` :-(.

I suppose atop/sar divides delta(io_ticks) and delta(real_time)

With my patch io_tics accounts whole operation then it ends
it could be started at previous interval of atop statistics.
as a result delta(io_ticks) will be bigger than delta(real_time).

> 
> 
> Q1)
> 
>  > Fix for slow requests is simple: at the end of request add
>  > count of jiffies passed since last update.
> 
> Even considering the simple case of a single CPU, the approximation may be "less accurate" when requests complete out of order.  Is that right?
> 
>   t        1      10     20   30
>   io1      start              end
>   io2             start  end
>   io_ticks 1      2      11   21
> 
>             ^^^^^^
>                \
>                  9 ticks not accounted as "busy"

Yep. Without my patch there will be also 9 tick gap between ends.

> 
> 
> At least, I found something fun happens if I run `dd if=/dev/urandom of=~/t bs=1M oflag=direct` at the same time as `dd if=/dev/sda 
> of=/dev/null bs=1M oflag=direct` .  With scheduler=none, it reduces "busy" from 100%, down to 97%.  With scheduler=mq-deadline, it reduces 
> "busy" from 100% to 60% :-).  Even though the system "iowait" is about 100% (equivalent to one CPU).
> 
> (Environment: My /dev/sda max read speed is about 150MB/s.  My /dev/urandom read speed is about 140 MB/s.  I have 4 logical CPUs).
> 
> It feels like it should be possible to improve io_ticks, by basically changing the condition in your fix, from (end==true), to (inflight>0). 
> Would that make sense?

inflight now per-cpu counter for performance reason.
request starts on one cpu and completes on another so it's hard to check exact count.

> 
> 
> Q2) But what most confuses me, is that I think `io_ticks` is defined as a per-cpu field.  And the per-cpu fields are summed into one value, 
> which is reported to userspace.
> 
> I have tried playing with a couple `dd iflag=direct` readers, using `taskset` to pin them to different CPUs, but I only got 98-102% "busy". 
> It did not rise to 200% :-).
> 
> i) Is it possible to see 200% "busy", due to per-cpu ioticks?

Nope. Percpu io_ticks accounts steps of single (per-partition) atomic time stamp.

	stamp = READ_ONCE(part->stamp);
	if (unlikely(stamp != now)) {
		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
		}
	}

> 
> ii) If so, then can per-cpu ioticks also cause us to see 100% "busy", when IO's were only inflight for 50% of the time (but on two different 
> CPUs)?
> 
>      If it is possible to trigger both of these cases, this metric seems very difficult to trust and use in any reliable way.  It seems 
> preferable to disable it altogether and force people to use more trustworthy metrics.  E.g. system-wide "iowait", and iostat field 11 
> "weighted # of milliseconds spent doing I/Os" which `iostat` uses to show "average queue length".

Yep. io_ticks is a legacy. "weighted" counters better resembles for modern parallel hardware.

> 
>      Or the "special pleading" approach?  Should ioticks accounted at the level of the hardware queue, and be disabled if the device has is  > using more than one hardware queue?
> 
> 
> Q3) In case I am mistaken in some way, and Q2 is not an issue at all:
> 
> I still think reporting over 100% utilization is something new.  At least the comments I see were removed in the "Fixes" commit seem to 
> agree.  That one error of 14% ("114% busy") that I saw, seems fairly big :-).
> 
> I wonder if we can better explain how much of a rough approximation this metric is now, e.g. in Documentation/iostats.txt ?
> 
> So far I don't know what the real description and limitations would be...
> 
> I think it would be understandable e.g. if we were able to say "busy%" should show around 100% when the device is used around 100% of the 
> time, and definitely 0% when it is idle, but is probably not as accurate as "iowait". ("iowait" reported by the CPU scheduler.  Not to say 
> these are the same or equivalent.  And I understand "iowait" is another ball of approximations and confusion.)

Current approach emulates legacy io_ticks with minimal effort.

Right now io_ticks counts jiffies when was at least one request was started or completed.
Time between these events are not accounted. Probably it would be better to document it in this way.

> 
> 
> Regards
> Alan
> 
> 
>> ---
>>   block/bio.c           |    8 ++++----
>>   block/blk-core.c      |    4 ++--
>>   include/linux/genhd.h |    2 +-
>>   3 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/block/bio.c b/block/bio.c
>> index c0a60f3e9b7b..245056797999 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -1729,14 +1729,14 @@ void bio_check_pages_dirty(struct bio *bio)
>>       schedule_work(&bio_dirty_work);
>>   }
>> -void update_io_ticks(struct hd_struct *part, unsigned long now)
>> +void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
>>   {
>>       unsigned long stamp;
>>   again:
>>       stamp = READ_ONCE(part->stamp);
>>       if (unlikely(stamp != now)) {
>>           if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
>> -            __part_stat_add(part, io_ticks, 1);
>> +            __part_stat_add(part, io_ticks, end ? now - stamp : 1);
>>           }
>>       }
>>       if (part->partno) {
>> @@ -1752,7 +1752,7 @@ void generic_start_io_acct(struct request_queue *q, int op,
>>       part_stat_lock();
>> -    update_io_ticks(part, jiffies);
>> +    update_io_ticks(part, jiffies, false);
>>       part_stat_inc(part, ios[sgrp]);
>>       part_stat_add(part, sectors[sgrp], sectors);
>>       part_inc_in_flight(q, part, op_is_write(op));
>> @@ -1770,7 +1770,7 @@ void generic_end_io_acct(struct request_queue *q, int req_op,
>>       part_stat_lock();
>> -    update_io_ticks(part, now);
>> +    update_io_ticks(part, now, true);
>>       part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
>>       part_dec_in_flight(q, part, op_is_write(req_op));
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index d89168b167e9..6e8f0b9e7731 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1334,7 +1334,7 @@ void blk_account_io_done(struct request *req, u64 now)
>>           part_stat_lock();
>>           part = req->part;
>> -        update_io_ticks(part, jiffies);
>> +        update_io_ticks(part, jiffies, true);
>>           part_stat_inc(part, ios[sgrp]);
>>           part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
>>           part_dec_in_flight(req->q, part, rq_data_dir(req));
>> @@ -1375,7 +1375,7 @@ void blk_account_io_start(struct request *rq, bool new_io)
>>           rq->part = part;
>>       }
>> -    update_io_ticks(part, jiffies);
>> +    update_io_ticks(part, jiffies, false);
>>       part_stat_unlock();
>>   }
>> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
>> index 2f5a9ed7e86e..8ece8e02c609 100644
>> --- a/include/linux/genhd.h
>> +++ b/include/linux/genhd.h
>> @@ -410,7 +410,7 @@ static inline void free_part_info(struct hd_struct *part)
>>       kfree(part->info);
>>   }
>> -void update_io_ticks(struct hd_struct *part, unsigned long now);
>> +void update_io_ticks(struct hd_struct *part, unsigned long now, bool end);
>>   /* block/genhd.c */
>>   extern void device_add_disk(struct device *parent, struct gendisk *disk,
>>
>>
> 
