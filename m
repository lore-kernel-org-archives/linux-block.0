Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AB9C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CAF20863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CAF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeLAJdd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:33:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbeLAJdd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Dec 2018 04:33:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7E123001860;
        Fri, 30 Nov 2018 22:22:46 +0000 (UTC)
Received: from localhost (unknown [10.16.197.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DAFE106222C;
        Fri, 30 Nov 2018 22:22:42 +0000 (UTC)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v2 6/6] dm: remove the pending IO accounting
Date:   Fri, 30 Nov 2018 17:22:26 -0500
Message-Id: <20181130222226.77216-7-snitzer@redhat.com>
In-Reply-To: <20181130222226.77216-1-snitzer@redhat.com>
References: <20181130222226.77216-1-snitzer@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 30 Nov 2018 22:22:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

Remove the "pending" atomic counters, that duplicate block-core's
in_flight counters, and update md_in_flight() to look at percpu
in_flight counters.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-core.h |  2 --
 drivers/md/dm.c      | 34 +++++++++++++++-------------------
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 224d44503a06..6fe883fac471 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -65,7 +65,6 @@ struct mapped_device {
 	 */
 	struct work_struct work;
 	wait_queue_head_t wait;
-	atomic_t pending[2];
 	spinlock_t deferred_lock;
 	struct bio_list deferred;
 
@@ -119,7 +118,6 @@ struct mapped_device {
 	struct srcu_struct io_barrier;
 };
 
-int md_in_flight(struct mapped_device *md);
 void disable_write_same(struct mapped_device *md);
 void disable_write_zeroes(struct mapped_device *md);
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a8ae7931bce7..ff6e5a5902f2 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -646,25 +646,30 @@ static void free_tio(struct dm_target_io *tio)
 	bio_put(&tio->clone);
 }
 
-int md_in_flight(struct mapped_device *md)
+static bool md_in_flight(struct mapped_device *md)
 {
-	return atomic_read(&md->pending[READ]) +
-	       atomic_read(&md->pending[WRITE]);
+	int cpu;
+	struct hd_struct *part = &dm_disk(md)->part0;
+
+	for_each_possible_cpu(cpu) {
+		if (local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[0]) ||
+		    local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[1]))
+			return true;
+	}
+
+	return false;
 }
 
 static void start_io_acct(struct dm_io *io)
 {
 	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
-	int rw = bio_data_dir(bio);
 
 	io->start_time = jiffies;
 
 	generic_start_io_acct(md->queue, bio_op(bio), bio_sectors(bio),
 			      &dm_disk(md)->part0);
 
-	atomic_inc(&md->pending[rw]);
-
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
@@ -676,8 +681,6 @@ static void end_io_acct(struct dm_io *io)
 	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
 	unsigned long duration = jiffies - io->start_time;
-	int pending;
-	int rw = bio_data_dir(bio);
 
 	generic_end_io_acct(md->queue, bio_op(bio), &dm_disk(md)->part0,
 			    io->start_time);
@@ -687,16 +690,11 @@ static void end_io_acct(struct dm_io *io)
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
 				    true, duration, &io->stats_aux);
 
-	/*
-	 * After this is decremented the bio must not be touched if it is
-	 * a flush.
-	 */
-	pending = atomic_dec_return(&md->pending[rw]);
-	pending += atomic_read(&md->pending[rw^0x1]);
-
 	/* nudge anyone waiting on suspend queue */
-	if (!pending)
-		wake_up(&md->wait);
+	if (unlikely(waitqueue_active(&md->wait))) {
+		if (!md_in_flight(md))
+			wake_up(&md->wait);
+	}
 }
 
 /*
@@ -1904,8 +1902,6 @@ static struct mapped_device *alloc_dev(int minor)
 	if (!md->disk)
 		goto bad;
 
-	atomic_set(&md->pending[0], 0);
-	atomic_set(&md->pending[1], 0);
 	init_waitqueue_head(&md->wait);
 	INIT_WORK(&md->work, dm_wq_work);
 	init_waitqueue_head(&md->eventq);
-- 
2.15.0

