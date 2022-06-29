Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C00C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 21:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiF2VzS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 17:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiF2VzR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 17:55:17 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3DC20F6F
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 14:55:16 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 59so26975195qvb.3
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 14:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aea/5SE2fqdgOQZcTcu0s6QMHRrZWr3dDOv9618JjIw=;
        b=mtCOlDelsA57V8hOQLOt/uDX+XImwBrh6Orr/ntf9cmmmNwq+TlOPUfeuhzhC7Qnra
         Jh4Xs7v3BLmPtoB+QvJFKlQ1zZArW0rdYL1qvz2o3a/5WtMCp8vg6Zw7eEl6yE6UUvPS
         pqN3H88kqSOzYxOFpCPgvffXm6m1wsZLb2RqDCz4MLfV5x0mgmcVwsJZNkwK2SaU4xrT
         3nS8pk9lkPK6CTIQosmoF0qg7xZUqZK63DIaXYNTNMopE2n1phFZpmtL7dTdNd2SU4Mp
         irK9dE3hE7bfy+Me/Ds10kCeMrjWCRMI9Psraw8IXeWRH3MVH2ryV3qcrRYQ5etRb1+m
         zEKg==
X-Gm-Message-State: AJIora9KXaJWG3iAHh8UfF6b4YvIhIQtiCS4MaqEKcWSf2lD2Jkx8HQj
        08hfvh2RRhXwTtwhhnkQ1aZa
X-Google-Smtp-Source: AGRyM1viI+CzApaPiScSoPhn3qnTdzxpeun+Zl6mSNYXOZ5ELYg64jnA9NzY6PKXq79JEpKAbuW0fw==
X-Received: by 2002:ac8:7f16:0:b0:31b:f6dd:abf with SMTP id f22-20020ac87f16000000b0031bf6dd0abfmr4475170qtk.523.1656539715930;
        Wed, 29 Jun 2022 14:55:15 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id v22-20020ac87496000000b003051f450049sm11532659qtq.8.2022.06.29.14.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:55:15 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Eric Biggers <ebiggers@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 5.20 v2 1/3] dm: improve BLK_STS_DM_REQUEUE and BLK_STS_AGAIN handling
Date:   Wed, 29 Jun 2022 17:55:11 -0400
Message-Id: <20220629215513.37860-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220629215513.37860-1-snitzer@kernel.org>
References: <20220629215513.37860-1-snitzer@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

If either BLK_STS_DM_REQUEUE or BLK_STS_AGAIN is returned for POLLED
io, we requeue the original bio into deferred list and kick md->wq to
re-submit it to block layer.

Improve the handling in the following way:

1) Factor out dm_handle_requeue() for handling dm_io requeue.

2) Unify handling for BLK_STS_DM_REQUEUE and BLK_STS_AGAIN: clear
   REQ_POLLED for BLK_STS_DM_REQUEUE too, for the sake of simplicity,
   given BLK_STS_DM_REQUEUE is very unusual.

3) Queue md->wq explicitly in dm_handle_requeue(), so requeue handling
   becomes more robust.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm.c | 70 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 84929bd137d0..c987f9ad24a4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -880,22 +880,41 @@ static int __noflush_suspending(struct mapped_device *md)
 	return test_bit(DMF_NOFLUSH_SUSPENDING, &md->flags);
 }
 
-static void dm_io_complete(struct dm_io *io)
+/*
+ * Return true if the dm_io's original bio is requeued.
+ * io->status is updated with error if requeue disallowed.
+ */
+static bool dm_handle_requeue(struct dm_io *io)
 {
-	blk_status_t io_error;
-	struct mapped_device *md = io->md;
 	struct bio *bio = io->split_bio ? io->split_bio : io->orig_bio;
+	bool handle_requeue = (io->status == BLK_STS_DM_REQUEUE);
+	bool handle_polled_eagain = ((io->status == BLK_STS_AGAIN) &&
+				     (bio->bi_opf & REQ_POLLED));
+	struct mapped_device *md = io->md;
+	bool requeued = false;
 
-	if (io->status == BLK_STS_DM_REQUEUE) {
+	if (handle_requeue || handle_polled_eagain) {
 		unsigned long flags;
+
+		if (bio->bi_opf & REQ_POLLED) {
+			/*
+			 * Upper layer won't help us poll split bio
+			 * (io->orig_bio may only reflect a subset of the
+			 * pre-split original) so clear REQ_POLLED.
+			 */
+			bio_clear_polled(bio);
+		}
+
 		/*
-		 * Target requested pushing back the I/O.
+		 * Target requested pushing back the I/O or
+		 * polled IO hit BLK_STS_AGAIN.
 		 */
 		spin_lock_irqsave(&md->deferred_lock, flags);
-		if (__noflush_suspending(md) &&
-		    !WARN_ON_ONCE(dm_is_zone_write(md, bio))) {
-			/* NOTE early return due to BLK_STS_DM_REQUEUE below */
+		if ((__noflush_suspending(md) &&
+		     !WARN_ON_ONCE(dm_is_zone_write(md, bio))) ||
+		    handle_polled_eagain) {
 			bio_list_add_head(&md->deferred, bio);
+			requeued = true;
 		} else {
 			/*
 			 * noflush suspend was interrupted or this is
@@ -906,6 +925,21 @@ static void dm_io_complete(struct dm_io *io)
 		spin_unlock_irqrestore(&md->deferred_lock, flags);
 	}
 
+	if (requeued)
+		queue_work(md->wq, &md->work);
+
+	return requeued;
+}
+
+static void dm_io_complete(struct dm_io *io)
+{
+	struct bio *bio = io->split_bio ? io->split_bio : io->orig_bio;
+	struct mapped_device *md = io->md;
+	blk_status_t io_error;
+	bool requeued;
+
+	requeued = dm_handle_requeue(io);
+
 	io_error = io->status;
 	if (dm_io_flagged(io, DM_IO_ACCOUNTED))
 		dm_end_io_acct(io);
@@ -925,23 +959,9 @@ static void dm_io_complete(struct dm_io *io)
 	if (unlikely(wq_has_sleeper(&md->wait)))
 		wake_up(&md->wait);
 
-	if (io_error == BLK_STS_DM_REQUEUE || io_error == BLK_STS_AGAIN) {
-		if (bio->bi_opf & REQ_POLLED) {
-			/*
-			 * Upper layer won't help us poll split bio (io->orig_bio
-			 * may only reflect a subset of the pre-split original)
-			 * so clear REQ_POLLED in case of requeue.
-			 */
-			bio_clear_polled(bio);
-			if (io_error == BLK_STS_AGAIN) {
-				/* io_uring doesn't handle BLK_STS_AGAIN (yet) */
-				queue_io(md, bio);
-				return;
-			}
-		}
-		if (io_error == BLK_STS_DM_REQUEUE)
-			return;
-	}
+	/* Return early if the original bio was requeued */
+	if (requeued)
+		return;
 
 	if (bio_is_flush_with_data(bio)) {
 		/*
-- 
2.15.0

