Return-Path: <SRS0=61bd=TH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6831C004C9
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 09:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628892087F
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 09:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHnsTuV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfEGJOD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 May 2019 05:14:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33832 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfEGJOD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 May 2019 05:14:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id f7so10902434wrq.1;
        Tue, 07 May 2019 02:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:newsgroups:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GDKHQ0tjbO/eijQ7QEZ0tXsibpTksjQI9nsjSh++M8Q=;
        b=MHnsTuV80HeugVACgM5L3Y98IlK0yXqN0CCLcjjkrZfjLjb/vHSs445SXe1FKBxljy
         Qd1WKdSDU1/yCBciZ0Fh5kZ1l3Ps0/jC0B4bTT9aS7qZ1d1ypI5a7kYZNuHH9skxMn37
         ze/XjxA5T43fld+TehIqixmb4zPRPhjzjvVjTMPVh4LmpAifdS6mmGfHQrt859pPuCOE
         7nv/02SbQ1A5RJaD9w4qBiT2AGAXLiw/MFZCBvfMROBWdHgvYw0pDuD0X2ysVY5h2B/k
         WjewMy7GrskxEJWYGKdgiLfWHVilBw18hMtZd7zt8maxLNj+F6GAoXPrqlp0SZDhrsEL
         I7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:newsgroups:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GDKHQ0tjbO/eijQ7QEZ0tXsibpTksjQI9nsjSh++M8Q=;
        b=F4isrVR2D6ICVmHLT5D2zCg4EOfRLQK6MIShb4dumzcFzt6xOLsmHE4J1c4nVLd5p7
         RQcpExNGtK0GnYP6mJE3WwNi7yPTJKypaW3T7HTCHZW+kF0A486+rXOzMvMcjx89SQci
         t7ZQPxjEDlt1BH7JEIuKx1VKBTq886i62DBOYAWWtUwLUUzjZ1hG1W5IpqQ/MMaQ/nB9
         fLZ1U57yf63osbp8SPBiwjAQyhIAYkcg3rkX+xGxBOa9DlKJ23beD4BhdTkZHpykhImT
         OTIjzrGpIqbbpan5zC3AOic0xGarHj4aeVVSZqlgAt6eWnL4iFIvmvfQxiF6jlCn7Luo
         /paA==
X-Gm-Message-State: APjAAAX0LdQH9VBnzBPC57/Hoe1dVgIc7i7+STH1wOQMkRtOL3LiQCqF
        DRAYvD0e10BH1JOV0BxacgU=
X-Google-Smtp-Source: APXvYqwA04q4SaGZby8TRA5BxE7FFBl42JGczYpnh1J5nFHZEJ8pKPKua6+y7G2jSABdlPvNUhz7bQ==
X-Received: by 2002:a5d:49cb:: with SMTP id t11mr11794061wrs.67.1557220441308;
        Tue, 07 May 2019 02:14:01 -0700 (PDT)
Received: from [172.16.8.139] (host-89-243-246-193.as13285.net. [89.243.246.193])
        by smtp.gmail.com with ESMTPSA id j10sm38944915wrb.0.2019.05.07.02.13.59
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 02:13:59 -0700 (PDT)
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: Re: [PATCH 3/3] block/diskstats: more accurate approximation of
 io_ticks for slow disks
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Newsgroups: gmane.linux.kernel,gmane.linux.block
References: <155413438394.3201.15211440151043943989.stgit@buzz>
 <155413438824.3201.15254568091182734151.stgit@buzz>
X-Mozilla-News-Host: news://nntp.gmane.org
Message-ID: <d5d39e1c-59f2-b5d8-0189-020efaed4ce8@gmail.com>
Date:   Tue, 7 May 2019 10:13:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155413438824.3201.15254568091182734151.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/04/2019 16:59, Konstantin Khlebnikov wrote:
> Currently io_ticks is approximated by adding one at each
> start and end of requests if jiffies has changed.
> This works perfectly for requests shorter than a jiffy.
> 
> Fix for slow requests is simple: at the end of request add
> count of jiffies passed since last update.
> 
> Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Thanks for working on this!  I noticed the problem behaviour using the 
Fedora 29 kernel [1].  I wasn't sure how it could be fixed.  Now I found 
this patch series, but I still have some questions :-).

[1] 
https://unix.stackexchange.com/questions/517132/dd-is-running-at-full-speed-but-i-only-see-20-disk-utilization-why

With these patches, `atopsar -d 2` shows about 100% "busy" when running 
a simple `dd` command, instead of 20 or 35%.  So that looked promising.

I saw some samples showing 112, 113, and 114% utilization. 
Unfortunately I'm not sure exactly how to reproduce that.  I think it 
happened during filesystem buffered writes (i.e. `dd` without 
`oflag=direct`), with the IO scheduler set to "none", on my SATA HDD.

Getting some "101% busy" samples seemed fairly easy to trigger, but I am 
not sure whether that is just a rounding error in `atopsar` :-(.


Q1)

 > Fix for slow requests is simple: at the end of request add
 > count of jiffies passed since last update.

Even considering the simple case of a single CPU, the approximation may 
be "less accurate" when requests complete out of order.  Is that right?

  t        1      10     20   30
  io1      start              end
  io2             start  end
  io_ticks 1      2      11   21

            ^^^^^^
               \
                 9 ticks not accounted as "busy"


At least, I found something fun happens if I run `dd if=/dev/urandom 
of=~/t bs=1M oflag=direct` at the same time as `dd if=/dev/sda 
of=/dev/null bs=1M oflag=direct` .  With scheduler=none, it reduces 
"busy" from 100%, down to 97%.  With scheduler=mq-deadline, it reduces 
"busy" from 100% to 60% :-).  Even though the system "iowait" is about 
100% (equivalent to one CPU).

(Environment: My /dev/sda max read speed is about 150MB/s.  My 
/dev/urandom read speed is about 140 MB/s.  I have 4 logical CPUs).

It feels like it should be possible to improve io_ticks, by basically 
changing the condition in your fix, from (end==true), to (inflight>0). 
Would that make sense?


Q2) But what most confuses me, is that I think `io_ticks` is defined as 
a per-cpu field.  And the per-cpu fields are summed into one value, 
which is reported to userspace.

I have tried playing with a couple `dd iflag=direct` readers, using 
`taskset` to pin them to different CPUs, but I only got 98-102% "busy". 
It did not rise to 200% :-).

i) Is it possible to see 200% "busy", due to per-cpu ioticks?

ii) If so, then can per-cpu ioticks also cause us to see 100% "busy", 
when IO's were only inflight for 50% of the time (but on two different 
CPUs)?

     If it is possible to trigger both of these cases, this metric seems 
very difficult to trust and use in any reliable way.  It seems 
preferable to disable it altogether and force people to use more 
trustworthy metrics.  E.g. system-wide "iowait", and iostat field 11 
"weighted # of milliseconds spent doing I/Os" which `iostat` uses to 
show "average queue length".

     Or the "special pleading" approach?  Should ioticks accounted at 
the level of the hardware queue, and be disabled if the device has is 
using more than one hardware queue?


Q3) In case I am mistaken in some way, and Q2 is not an issue at all:

I still think reporting over 100% utilization is something new.  At 
least the comments I see were removed in the "Fixes" commit seem to 
agree.  That one error of 14% ("114% busy") that I saw, seems fairly big 
:-).

I wonder if we can better explain how much of a rough approximation this 
metric is now, e.g. in Documentation/iostats.txt ?

So far I don't know what the real description and limitations would be...

I think it would be understandable e.g. if we were able to say "busy%" 
should show around 100% when the device is used around 100% of the time, 
and definitely 0% when it is idle, but is probably not as accurate as 
"iowait". ("iowait" reported by the CPU scheduler.  Not to say these are 
the same or equivalent.  And I understand "iowait" is another ball of 
approximations and confusion.)


Regards
Alan


> ---
>   block/bio.c           |    8 ++++----
>   block/blk-core.c      |    4 ++--
>   include/linux/genhd.h |    2 +-
>   3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index c0a60f3e9b7b..245056797999 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1729,14 +1729,14 @@ void bio_check_pages_dirty(struct bio *bio)
>   	schedule_work(&bio_dirty_work);
>   }
>   
> -void update_io_ticks(struct hd_struct *part, unsigned long now)
> +void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
>   {
>   	unsigned long stamp;
>   again:
>   	stamp = READ_ONCE(part->stamp);
>   	if (unlikely(stamp != now)) {
>   		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
> -			__part_stat_add(part, io_ticks, 1);
> +			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
>   		}
>   	}
>   	if (part->partno) {
> @@ -1752,7 +1752,7 @@ void generic_start_io_acct(struct request_queue *q, int op,
>   
>   	part_stat_lock();
>   
> -	update_io_ticks(part, jiffies);
> +	update_io_ticks(part, jiffies, false);
>   	part_stat_inc(part, ios[sgrp]);
>   	part_stat_add(part, sectors[sgrp], sectors);
>   	part_inc_in_flight(q, part, op_is_write(op));
> @@ -1770,7 +1770,7 @@ void generic_end_io_acct(struct request_queue *q, int req_op,
>   
>   	part_stat_lock();
>   
> -	update_io_ticks(part, now);
> +	update_io_ticks(part, now, true);
>   	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
>   	part_dec_in_flight(q, part, op_is_write(req_op));
>   
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d89168b167e9..6e8f0b9e7731 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1334,7 +1334,7 @@ void blk_account_io_done(struct request *req, u64 now)
>   		part_stat_lock();
>   		part = req->part;
>   
> -		update_io_ticks(part, jiffies);
> +		update_io_ticks(part, jiffies, true);
>   		part_stat_inc(part, ios[sgrp]);
>   		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
>   		part_dec_in_flight(req->q, part, rq_data_dir(req));
> @@ -1375,7 +1375,7 @@ void blk_account_io_start(struct request *rq, bool new_io)
>   		rq->part = part;
>   	}
>   
> -	update_io_ticks(part, jiffies);
> +	update_io_ticks(part, jiffies, false);
>   
>   	part_stat_unlock();
>   }
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 2f5a9ed7e86e..8ece8e02c609 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -410,7 +410,7 @@ static inline void free_part_info(struct hd_struct *part)
>   	kfree(part->info);
>   }
>   
> -void update_io_ticks(struct hd_struct *part, unsigned long now);
> +void update_io_ticks(struct hd_struct *part, unsigned long now, bool end);
>   
>   /* block/genhd.c */
>   extern void device_add_disk(struct device *parent, struct gendisk *disk,
> 
> 

