Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1891C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 19:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E1B20834
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 19:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E1B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeLAGwa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:52:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbeLAGwa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Dec 2018 01:52:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E58EC02835C;
        Fri, 30 Nov 2018 19:42:09 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1470104C53F;
        Fri, 30 Nov 2018 19:42:04 +0000 (UTC)
Date:   Fri, 30 Nov 2018 14:42:04 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "Alasdair G. Kergon" <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] block: delete part_round_stats and switch to less
 precise counting
Message-ID: <20181130194203.GA14625@redhat.com>
References: <20181128004249.147084927@debian.vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128004249.147084927@debian.vm>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 30 Nov 2018 19:42:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27 2018 at  7:42pm -0500,
Mikulas Patocka <mpatocka@redhat.com> wrote:

> We want to convert to per-cpu in_flight counters.
> 
> The function part_round_stats needs the in_flight counter every jiffy, it
> would be too costly to sum all the percpu variables every jiffy, so it
> must be deleted. part_round_stats is used to calculate two counters -
> time_in_queue and io_ticks.
> 
> time_in_queue can be calculated without part_round_stats, by adding the
> duration of the I/O when the I/O ends (the value is almost as exact as the
> previously calculated value, except that time for in-progress I/Os is not
> counted).
> 
> io_ticks can be approximated by increasing the value when I/O is started
> or ended and the jiffies value has changed. If the I/Os take less than a
> jiffy, the value is as exact as the previously calculated value. If the
> I/Os take more than a jiffy, io_ticks can drift behind the previously
> calculated value.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>  block/bio.c               |   26 ++++++++++++++++--
>  block/blk-core.c          |   64 +++-------------------------------------------
>  block/blk-merge.c         |    1 
>  block/genhd.c             |    4 --
>  block/partition-generic.c |    4 --
>  include/linux/genhd.h     |    3 --
>  6 files changed, 29 insertions(+), 73 deletions(-)
> 
> Index: linux-block/block/bio.c
> ===================================================================
> --- linux-block.orig/block/bio.c	2018-11-26 23:44:17.000000000 +0100
> +++ linux-block/block/bio.c	2018-11-26 23:44:17.000000000 +0100
> @@ -1663,13 +1663,29 @@ defer:
>  }
>  EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
>  
> +void update_io_ticks(int cpu, struct hd_struct *part, unsigned long now)
> +{
> +	unsigned long stamp;
> +again:
> +	stamp = READ_ONCE(part->stamp);
> +	if (unlikely(stamp != now)) {
> +		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
> +			__part_stat_add(cpu, part, io_ticks, 1);
> +		}
> +	}
> +	if (part->partno) {
> +		part = &part_to_disk(part)->part0;
> +		goto again;
> +	}
> +}
> +
>  void generic_start_io_acct(struct request_queue *q, int op,
>  			   unsigned long sectors, struct hd_struct *part)
>  {
>  	const int sgrp = op_stat_group(op);
>  	int cpu = part_stat_lock();
>  
> -	part_round_stats(q, cpu, part);
> +	update_io_ticks(cpu, part, jiffies);
>  	part_stat_inc(cpu, part, ios[sgrp]);
>  	part_stat_add(cpu, part, sectors[sgrp], sectors);
>  	part_inc_in_flight(q, part, op_is_write(op));
> @@ -1681,12 +1697,16 @@ EXPORT_SYMBOL(generic_start_io_acct);
>  void generic_end_io_acct(struct request_queue *q, int req_op,
>  			 struct hd_struct *part, unsigned long start_time)
>  {
> -	unsigned long duration = jiffies - start_time;
> +	unsigned long now = jiffies;
> +	unsigned long duration = now - start_time;
>  	const int sgrp = op_stat_group(req_op);
>  	int cpu = part_stat_lock();
>  
> +	update_io_ticks(cpu, part, now);
>  	part_stat_add(cpu, part, nsecs[sgrp], jiffies_to_nsecs(duration));
> -	part_round_stats(q, cpu, part);
> +	part_stat_add(cpu, part, time_in_queue, duration);
> +	if (part->partno)
> +		part_stat_add(cpu, &part_to_disk(part)->part0, time_in_queue, duration);
>  	part_dec_in_flight(q, part, op_is_write(req_op));
>  
>  	part_stat_unlock();
> Index: linux-block/block/blk-core.c
> ===================================================================
> --- linux-block.orig/block/blk-core.c	2018-11-26 23:44:17.000000000 +0100
> +++ linux-block/block/blk-core.c	2018-11-26 23:44:17.000000000 +0100
> @@ -583,63 +583,6 @@ struct request *blk_get_request(struct r
>  }
>  EXPORT_SYMBOL(blk_get_request);
>  
> -static void part_round_stats_single(struct request_queue *q, int cpu,
> -				    struct hd_struct *part, unsigned long now,
> -				    unsigned int inflight)
> -{
> -	if (inflight) {
> -		__part_stat_add(cpu, part, time_in_queue,
> -				inflight * (now - part->stamp));
> -		__part_stat_add(cpu, part, io_ticks, (now - part->stamp));
> -	}
> -	part->stamp = now;
> -}
> -
> -/**
> - * part_round_stats() - Round off the performance stats on a struct disk_stats.
> - * @q: target block queue
> - * @cpu: cpu number for stats access
> - * @part: target partition
> - *
> - * The average IO queue length and utilisation statistics are maintained
> - * by observing the current state of the queue length and the amount of
> - * time it has been in this state for.
> - *
> - * Normally, that accounting is done on IO completion, but that can result
> - * in more than a second's worth of IO being accounted for within any one
> - * second, leading to >100% utilisation.  To deal with that, we call this
> - * function to do a round-off before returning the results when reading
> - * /proc/diskstats.  This accounts immediately for all queue usage up to
> - * the current jiffies and restarts the counters again.
> - */
> -void part_round_stats(struct request_queue *q, int cpu, struct hd_struct *part)
> -{
> -	struct hd_struct *part2 = NULL;
> -	unsigned long now = jiffies;
> -	unsigned int inflight[2];
> -	int stats = 0;
> -
> -	if (part->stamp != now)
> -		stats |= 1;
> -
> -	if (part->partno) {
> -		part2 = &part_to_disk(part)->part0;
> -		if (part2->stamp != now)
> -			stats |= 2;
> -	}
> -
> -	if (!stats)
> -		return;
> -
> -	part_in_flight(q, part, inflight);
> -
> -	if (stats & 2)
> -		part_round_stats_single(q, cpu, part2, now, inflight[1]);
> -	if (stats & 1)
> -		part_round_stats_single(q, cpu, part, now, inflight[0]);
> -}
> -EXPORT_SYMBOL_GPL(part_round_stats);
> -
>  void blk_put_request(struct request *req)
>  {
>  	blk_mq_free_request(req);
> @@ -1408,9 +1351,11 @@ void blk_account_io_done(struct request
>  		cpu = part_stat_lock();
>  		part = req->part;
>  
> +		update_io_ticks(cpu, part, jiffies);
>  		part_stat_inc(cpu, part, ios[sgrp]);
>  		part_stat_add(cpu, part, nsecs[sgrp], now - req->start_time_ns);
> -		part_round_stats(req->q, cpu, part);
> +		part_stat_add(cpu, part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));

(Extra indentation offered a clue...)
Are you missing an 'if (part->partno)' conditional here?

> +			part_stat_add(cpu, &part_to_disk(part)->part0, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
>  		part_dec_in_flight(req->q, part, rq_data_dir(req));
>  
>  		hd_struct_put(part);

