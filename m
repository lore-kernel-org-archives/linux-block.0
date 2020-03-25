Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DA7C54FCF
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 03:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9367520724
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 03:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLB5WWSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgCYDkr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 23:40:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35582 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727253AbgCYDkq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 23:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585107644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NzZ/iEZeQLHh1Y/Ua0zpzMRctI+bdZqgFy9kntWeYZ4=;
        b=OLB5WWSnK6KCRvR+cYmAZu0BDMef0lby7MvZ9vXOOm1yGR1xRMLluSjpE47fq37PJEsyly
        O/4wCy34LF2GaT2eOS82X+Fy+adJEJisBYoMAZ7JRPaKxyolIWDkcjxH2KpZWcuIwgrO16
        hF+CtiDiWGAM+0LBeZMwmfx1+Oz4pyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-L4ILdnHvOPmI4BD13INyDA-1; Tue, 24 Mar 2020 23:40:40 -0400
X-MC-Unique: L4ILdnHvOPmI4BD13INyDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97D048017CC;
        Wed, 25 Mar 2020 03:40:39 +0000 (UTC)
Received: from ming.t460p (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 409825D9C5;
        Wed, 25 Mar 2020 03:40:29 +0000 (UTC)
Date:   Wed, 25 Mar 2020 11:40:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH v3 1/3] block/diskstats: more accurate approximation of
 io_ticks for slow disks
Message-ID: <20200325034024.GC6086@ming.t460p>
References: <158503038812.1955.7827988255138056389.stgit@buzz>
 <158503198072.1955.16227279292140721351.stgit@buzz>
 <20200324140656.GA23550@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324140656.GA23550@ming.t460p>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 24, 2020 at 10:06:56PM +0800, Ming Lei wrote:
> On Tue, Mar 24, 2020 at 09:39:40AM +0300, Konstantin Khlebnikov wrote:
> > Currently io_ticks is approximated by adding one at each start and end of
> > requests if jiffies counter has changed. This works perfectly for requests
> > shorter than a jiffy or if one of requests starts/ends at each jiffy.
> > 
> > If disk executes just one request at a time and they are longer than two
> > jiffies then only first and last jiffies will be accounted.
> > 
> > Fix is simple: at the end of request add up into io_ticks jiffies passed
> > since last update rather than just one jiffy.
> > 
> > Example: common HDD executes random read 4k requests around 12ms.
> > 
> > fio --name=test --filename=/dev/sdb --rw=randread --direct=1 --runtime=30 &
> > iostat -x 10 sdb
> > 
> > Note changes of iostat's "%util" 8,43% -> 99,99% before/after patch:
> > 
> > Before:
> > 
> > Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
> > sdb               0,00     0,00   82,60    0,00   330,40     0,00     8,00     0,96   12,09   12,09    0,00   1,02   8,43
> > 
> > After:
> > 
> > Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
> > sdb               0,00     0,00   82,50    0,00   330,00     0,00     8,00     1,00   12,10   12,10    0,00  12,12  99,99
> > 
> > For load estimation "%util" is not as useful as average queue length,
> > but it clearly shows how often disk queue is completely empty.
> > 
> > Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch to less precise counting")
> > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > ---
> >  Documentation/admin-guide/iostats.rst |    5 ++++-
> >  block/bio.c                           |    8 ++++----
> >  block/blk-core.c                      |    4 ++--
> >  include/linux/genhd.h                 |    2 +-
> >  4 files changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
> > index df5b8345c41d..9b14b0c2c9c4 100644
> > --- a/Documentation/admin-guide/iostats.rst
> > +++ b/Documentation/admin-guide/iostats.rst
> > @@ -100,7 +100,7 @@ Field 10 -- # of milliseconds spent doing I/Os (unsigned int)
> >  
> >      Since 5.0 this field counts jiffies when at least one request was
> >      started or completed. If request runs more than 2 jiffies then some
> > -    I/O time will not be accounted unless there are other requests.
> > +    I/O time might be not accounted in case of concurrent requests.
> >  
> >  Field 11 -- weighted # of milliseconds spent doing I/Os (unsigned int)
> >      This field is incremented at each I/O start, I/O completion, I/O
> > @@ -143,6 +143,9 @@ are summed (possibly overflowing the unsigned long variable they are
> >  summed to) and the result given to the user.  There is no convenient
> >  user interface for accessing the per-CPU counters themselves.
> >  
> > +Since 4.19 request times are measured with nanoseconds precision and
> > +truncated to milliseconds before showing in this interface.
> > +
> >  Disks vs Partitions
> >  -------------------
> >  
> > diff --git a/block/bio.c b/block/bio.c
> > index 0985f3422556..b1053eb7af37 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -1762,14 +1762,14 @@ void bio_check_pages_dirty(struct bio *bio)
> >  	schedule_work(&bio_dirty_work);
> >  }
> >  
> > -void update_io_ticks(struct hd_struct *part, unsigned long now)
> > +void update_io_ticks(struct hd_struct *part, unsigned long now, bool end)
> >  {
> >  	unsigned long stamp;
> >  again:
> >  	stamp = READ_ONCE(part->stamp);
> >  	if (unlikely(stamp != now)) {
> >  		if (likely(cmpxchg(&part->stamp, stamp, now) == stamp)) {
> > -			__part_stat_add(part, io_ticks, 1);
> > +			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
> >  		}
> >  	}
> >  	if (part->partno) {
> > @@ -1785,7 +1785,7 @@ void generic_start_io_acct(struct request_queue *q, int op,
> >  
> >  	part_stat_lock();
> >  
> > -	update_io_ticks(part, jiffies);
> > +	update_io_ticks(part, jiffies, false);
> >  	part_stat_inc(part, ios[sgrp]);
> >  	part_stat_add(part, sectors[sgrp], sectors);
> >  	part_inc_in_flight(q, part, op_is_write(op));
> > @@ -1803,7 +1803,7 @@ void generic_end_io_acct(struct request_queue *q, int req_op,
> >  
> >  	part_stat_lock();
> >  
> > -	update_io_ticks(part, now);
> > +	update_io_ticks(part, now, true);
> >  	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
> >  	part_stat_add(part, time_in_queue, duration);
> >  	part_dec_in_flight(q, part, op_is_write(req_op));
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index abfdcf81a228..4401b30a1751 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -1337,7 +1337,7 @@ void blk_account_io_done(struct request *req, u64 now)
> >  		part_stat_lock();
> >  		part = req->part;
> >  
> > -		update_io_ticks(part, jiffies);
> > +		update_io_ticks(part, jiffies, true);
> >  		part_stat_inc(part, ios[sgrp]);
> >  		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
> >  		part_stat_add(part, time_in_queue, nsecs_to_jiffies64(now - req->start_time_ns));
> > @@ -1379,7 +1379,7 @@ void blk_account_io_start(struct request *rq, bool new_io)
> >  		rq->part = part;
> >  	}
> >  
> > -	update_io_ticks(part, jiffies);
> > +	update_io_ticks(part, jiffies, false);
> >  
> >  	part_stat_unlock();
> >  }
> > diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> > index d5c75df64bba..f1066f10b062 100644
> > --- a/include/linux/genhd.h
> > +++ b/include/linux/genhd.h
> > @@ -467,7 +467,7 @@ static inline void free_part_info(struct hd_struct *part)
> >  	kfree(part->info);
> >  }
> >  
> > -void update_io_ticks(struct hd_struct *part, unsigned long now);
> > +void update_io_ticks(struct hd_struct *part, unsigned long now, bool end);
> >  
> >  /* block/genhd.c */
> >  extern void device_add_disk(struct device *parent, struct gendisk *disk,
> > 
> 
> Looks fine:
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

BTW, there is still some gap(%65 vs. 99%) between this fix and the original
accounting(before applying Mike/Mikulas's 7 patches), and it might be
one thing to improve in future.

1) test, sda is single queue virtio-scsi, which is emulated by one HDD
image

2) fio test script:
fio --direct=1 --size=128G --bsrange=4k-4k \
		--runtime=20 --numjobs=1 \
		--ioengine=libaio --iodepth=16 \
		--iodepth_batch_submit=16 \
		--iodepth_batch_complete_min=16 \
		--group_reporting=1 --filename=/dev/sda \
		--name=seq-test --rw=read

3) result:
- v5.6-rc with this patch
Run status group 0 (all jobs):
   READ: bw=79.4MiB/s (83.3MB/s), 79.4MiB/s-79.4MiB/s (83.3MB/s-83.3MB/s), io=155
88MiB (1665MB), run=20001-20001msec

Disk stats (read/write):
  sda: ios=25039/0, merge=375596/0, ticks=18823/0, in_queue=4330, util=99.43%


- commit 112f158f66cb (which is previous commit of 5b18b5a73760)
Run status group 0 (all jobs):
   READ: bw=81.4MiB/s (85.3MB/s), 81.4MiB/s-81.4MiB/s (85.3MB/s-85.3MB/s), io=166
28MiB (1707MB), run=20001-20001msec

Disk stats (read/write):
  sda: ios=25749/0, merge=386236/0, ticks=17963/0, in_queue=12976, util=65.20%


Thanks,
Ming

