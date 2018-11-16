Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFAEC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 00:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3542146D
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 00:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3542146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeKPKqg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:46:36 -0500
Received: from 109-183-129-149.customers.tmcz.cz ([109.183.129.149]:46220 "EHLO
        leontynka.twibright.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeKPKqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 05:46:36 -0500
X-Greylist: delayed 1873 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Nov 2018 05:46:35 EST
Received: from debian.vm ([192.168.192.2])
        by leontynka.twibright.com with smtp (Exim 4.89)
        (envelope-from <mpatocka@redhat.com>)
        id 1gNRdE-0001CW-DB; Fri, 16 Nov 2018 01:05:09 +0100
Received: by debian.vm (sSMTP sendmail emulation); Fri, 16 Nov 2018 01:05:07 +0100
Message-Id: <20181116000507.773533534@debian.vm>
User-Agent: quilt/0.65
Date:   Fri, 16 Nov 2018 01:04:18 +0100
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Mike Snitzer <msnitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Alasdair G. Kergon" <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 2/3] dm: use percpu counters
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=dm-percpu.patch
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use percpu inflight counters to avoid cache line bouncing and improve
performance.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/md/dm-core.h |    5 +++++
 drivers/md/dm.c      |   50 ++++++++++++++++++++++++++++++++++----------------
 2 files changed, 39 insertions(+), 16 deletions(-)

Index: linux-dm/drivers/md/dm-core.h
===================================================================
--- linux-dm.orig/drivers/md/dm-core.h	2018-11-15 22:06:37.000000000 +0100
+++ linux-dm/drivers/md/dm-core.h	2018-11-15 22:06:37.000000000 +0100
@@ -24,6 +24,10 @@ struct dm_kobject_holder {
 	struct completion completion;
 };
 
+struct dm_percpu {
+	unsigned inflight[2];
+};
+
 /*
  * DM core internal structure that used directly by dm.c and dm-rq.c
  * DM targets must _not_ deference a mapped_device to directly access its members!
@@ -63,6 +67,7 @@ struct mapped_device {
 	/*
 	 * A list of ios that arrived while we were suspended.
 	 */
+	struct dm_percpu __percpu *counters;
 	struct work_struct work;
 	wait_queue_head_t wait;
 	spinlock_t deferred_lock;
Index: linux-dm/drivers/md/dm.c
===================================================================
--- linux-dm.orig/drivers/md/dm.c	2018-11-15 22:06:37.000000000 +0100
+++ linux-dm/drivers/md/dm.c	2018-11-15 22:09:31.000000000 +0100
@@ -648,19 +648,32 @@ static void free_tio(struct dm_target_io
 
 int md_in_flight(struct mapped_device *md)
 {
-	return atomic_read(&dm_disk(md)->part0.in_flight[READ]) +
-	       atomic_read(&dm_disk(md)->part0.in_flight[WRITE]);
+	int cpu;
+	unsigned sum = 0;
+	for_each_possible_cpu(cpu) {
+		struct dm_percpu *p = per_cpu_ptr(md->counters, cpu);
+		sum += p->inflight[READ] + p->inflight[WRITE];
+	}
+	return (int)sum;
 }
 
 static void start_io_acct(struct dm_io *io)
 {
 	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
+	struct hd_struct *part;
+	int sgrp, cpu;
 
 	io->start_time = jiffies;
 
-	generic_start_io_acct(md->queue, bio_op(bio), bio_sectors(bio),
-			      &dm_disk(md)->part0);
+	part = &dm_disk(md)->part0;
+	sgrp = op_stat_group(bio_op(bio));
+	cpu = part_stat_lock();
+	__part_stat_add(cpu, part, ios[sgrp], 1);
+	__part_stat_add(cpu, part, sectors[sgrp], bio_sectors(bio));
+	part_stat_unlock();
+
+	this_cpu_inc(md->counters->inflight[bio_data_dir(bio)]);
 
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
@@ -673,25 +686,24 @@ static void end_io_acct(struct dm_io *io
 	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
 	unsigned long duration = jiffies - io->start_time;
+	struct hd_struct *part;
+	int sgrp, cpu;
 
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
 				    true, duration, &io->stats_aux);
 
-	/*
-	 * make sure that atomic_dec in generic_end_io_acct is not reordered
-	 * with previous writes
-	 */
-	smp_mb__before_atomic();
-	generic_end_io_acct(md->queue, bio_op(bio), &dm_disk(md)->part0,
-			    io->start_time);
-	/*
-	 * generic_end_io_acct does atomic_dec, this barrier makes sure that
-	 * atomic_dec is not reordered with waitqueue_active
-	 */
-	smp_mb__after_atomic();
+	part = &dm_disk(md)->part0;
+	sgrp = op_stat_group(bio_op(bio));
+	cpu = part_stat_lock();
+	__part_stat_add(cpu, part, nsecs[sgrp], jiffies_to_nsecs(duration));
+	part_stat_unlock();
+
+	smp_wmb();
+	this_cpu_dec(md->counters->inflight[bio_data_dir(bio)]);
 
+	smp_mb();
 	/* nudge anyone waiting on suspend queue */
 	if (unlikely(waitqueue_active(&md->wait))) {
 		if (!md_in_flight(md))
@@ -1822,6 +1834,8 @@ static void cleanup_mapped_device(struct
 	if (md->queue)
 		blk_cleanup_queue(md->queue);
 
+	free_percpu(md->counters);
+
 	cleanup_srcu_struct(&md->io_barrier);
 
 	if (md->bdev) {
@@ -1892,6 +1906,10 @@ static struct mapped_device *alloc_dev(i
 	if (!md->disk)
 		goto bad;
 
+	md->counters = alloc_percpu(struct dm_percpu);
+	if (!md->counters)
+		goto bad;
+
 	init_waitqueue_head(&md->wait);
 	INIT_WORK(&md->work, dm_wq_work);
 	init_waitqueue_head(&md->eventq);

