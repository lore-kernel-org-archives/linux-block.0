Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D47CC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138E720989
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZMLDyEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138E720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeLEUYt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:24:49 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38375 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLEUYt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 15:24:49 -0500
Received: by mail-qk1-f196.google.com with SMTP id d19so12696542qkg.5
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 12:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/MmpQWfVqjIcIBzc1IhAmuNIPGv+IYi6voBAs2gkkkI=;
        b=oZMLDyEixH85J4sIUD1wmhel7oo/NXb5Ir16aUhweca/LwChRGYdLzEGPapBcHRtn5
         /XOWqU+SY/qvRPa3BjhjnF3+XwPMW0thuYiuEe+u+KQy/57e/cna61l6HMs0Xx5ZB2pX
         Ju9B/ScvVwZq3ekMo6ASTFwrysQrAS93pp5LTET60sLJqTf3Pl/qzlxDlbYGGnoQPs76
         W0iiGiSAfRcZtO3bRdBGCbfmXQFqIh7CCJU3RAVuHbI44XZ9FxIFZRZK0Mr332VVJbHy
         kItlSOk0SY7syd1hBjoXJzXMvfHnxGy6ikulGUvHrlkvSPzlF0sHlVJVYID6jTGi2mNN
         Rh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=/MmpQWfVqjIcIBzc1IhAmuNIPGv+IYi6voBAs2gkkkI=;
        b=BhYMOkwV0F9fXtYPnuqke29QxZj8zL6ltKW2wakq09dxCimpsj0/TdhWThJhSOUmUT
         ZlYosCjYgupvnkCvyk/S4JgMwFw6KhmwST+vH1PpFlDIhxdxSQ9lgzhf4frRR9NFHXVv
         bskIm4MrOGiMLSXkXQ6mibPJ/7s5KmjnAFzZ/c4XBC409SRz1aLF+Ehgq9Ey3xwoPqWM
         I86nSrAfgBs5EFxRarui8Ke/+6sg6ExlXYLmJEINFJS0OztUtLE0Igia02WzE/G+SetN
         mai5lJcdjwB3EhzDVpt19V0saVvIoUUmjy/XTQngY7FrP2nQOybNPdWfptFU1FRC9Syh
         xCDw==
X-Gm-Message-State: AA+aEWaRRQadKLXQVx1pwfblc9qc3Qe8AJ94KxJTC/2cfTSxfXyUgSyw
        XZIM6+UsB2nB/KcXMhwkUck=
X-Google-Smtp-Source: AFSGD/XDRY6zz++uNJeWsIYIZGuAPXV86dEHzvxrI+U7lqyKaGr0GePKcLIMFRNxdhluTlRyUTbhfA==
X-Received: by 2002:a37:9cd4:: with SMTP id f203mr24203387qke.155.1544041488238;
        Wed, 05 Dec 2018 12:24:48 -0800 (PST)
Received: from localhost (pool-68-160-144-192.bstnma.fios.verizon.net. [68.160.144.192])
        by smtp.gmail.com with ESMTPSA id n68sm7914741qte.66.2018.12.05.12.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 12:24:47 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v3 7/7] dm: remove the pending IO accounting
Date:   Wed,  5 Dec 2018 15:24:33 -0500
Message-Id: <20181205202433.95823-8-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181205202433.95823-1-snitzer@redhat.com>
References: <20181205202433.95823-1-snitzer@redhat.com>
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
2.18.0

