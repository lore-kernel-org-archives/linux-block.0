Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4213C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6678220863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6678220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeLAIzX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:55:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeLAIzX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Dec 2018 03:55:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D42CE86E;
        Fri, 30 Nov 2018 21:44:43 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51FA17A5FE;
        Fri, 30 Nov 2018 21:44:34 +0000 (UTC)
Date:   Fri, 30 Nov 2018 16:44:33 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "Alasdair G. Kergon" <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/3] block: switch to per-cpu in-flight counters
Message-ID: <20181130214433.GA15049@redhat.com>
References: <20181128004250.325095242@debian.vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128004250.325095242@debian.vm>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 30 Nov 2018 21:44:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27 2018 at  7:42pm -0500,
Mikulas Patocka <mpatocka@redhat.com> wrote:

> Now when part_round_stats is gone, we can switch to per-cpu in-flight
> counters.
> 
> We use the local-atomic type local_t, so that if part_inc_in_flight or
> part_dec_in_flight is reentrantly called from an interrupt, the value will
> be correct.
> 
> The other counters could be corrupted due to reentrant interrupt, but the
> corruption only results in slight counter skew - the in_flight counter
> must be exact, so it needs local_t.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>  block/bio.c           |    4 ++--
>  block/blk-core.c      |    4 ++--
>  block/blk-merge.c     |    2 +-
>  block/genhd.c         |   47 +++++++++++++++++++++++++++++++++++------------
>  drivers/md/dm.c       |    4 +---
>  include/linux/genhd.h |    7 ++++---
>  6 files changed, 45 insertions(+), 23 deletions(-)
> 
> Index: linux-block/block/genhd.c
> ===================================================================
> --- linux-block.orig/block/genhd.c	2018-11-28 00:09:59.000000000 +0100
> +++ linux-block/block/genhd.c	2018-11-28 00:09:59.000000000 +0100
> @@ -45,53 +45,76 @@ static void disk_add_events(struct gendi
>  static void disk_del_events(struct gendisk *disk);
>  static void disk_release_events(struct gendisk *disk);
>  
> -void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
> +void part_inc_in_flight(struct request_queue *q, int cpu, struct hd_struct *part, int rw)
>  {
>  	if (queue_is_mq(q))
>  		return;
>  
> -	atomic_inc(&part->in_flight[rw]);
> +	local_inc(per_cpu_ptr(part->dkstats, cpu)->in_flight);
>  	if (part->partno)
> -		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
> +		local_inc(per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_flight);
>  }
>  
> -void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
> +void part_dec_in_flight(struct request_queue *q, int cpu, struct hd_struct *part, int rw)
>  {
>  	if (queue_is_mq(q))
>  		return;
>  
> -	atomic_dec(&part->in_flight[rw]);
> +	local_dec(per_cpu_ptr(part->dkstats, cpu)->in_flight);
>  	if (part->partno)
> -		atomic_dec(&part_to_disk(part)->part0.in_flight[rw]);
> +		local_dec(per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_flight);
>  }


The above is wrong, needs this incremental fix:

diff --git a/block/genhd.c b/block/genhd.c
index 2ed431098953..3397288a2926 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -50,9 +50,9 @@ void part_inc_in_flight(struct request_queue *q, int cpu, struct hd_struct *part
 	if (queue_is_mq(q))
 		return;
 
-	local_inc(per_cpu_ptr(part->dkstats, cpu)->in_flight);
+	local_inc(&per_cpu_ptr(part->dkstats, cpu)->in_flight[rw]);
 	if (part->partno)
-		local_inc(per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_flight);
+		local_inc(&per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_flight[rw]);
 }
 
 void part_dec_in_flight(struct request_queue *q, int cpu, struct hd_struct *part, int rw)
@@ -60,9 +60,9 @@ void part_dec_in_flight(struct request_queue *q, int cpu, struct hd_struct *part
 	if (queue_is_mq(q))
 		return;
 
-	local_dec(per_cpu_ptr(part->dkstats, cpu)->in_flight);
+	local_dec(&per_cpu_ptr(part->dkstats, cpu)->in_flight[rw]);
 	if (part->partno)
-		local_dec(per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_flight);
+		local_dec(&per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_flight[rw]);
 }
 
 unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part)
