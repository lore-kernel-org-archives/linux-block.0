Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B52C43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 14:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiFXOOx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 10:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiFXOOt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 10:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB0FA53A4B
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 07:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656080088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4BOPgddaomH0Frmgz7ghXQOS8IWaxm01iI4jakXgGP4=;
        b=izHl5Opyk9VnCaBMmzzBtnkaLeY3O7SyBLyafWDOrXR5Cuy1vYqg4fPKoEjTnlUgOk7f14
        i9cGiYqb25wCuxgQ1OzeWAr1l5chWf3gYaBC7Be+Tbh95i+tkOr5kFt+ZiIU4Fi3hRYNsd
        AXeKZ+fOCpyZwr/ejhcknn55thhkv0o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-1nV8Fdb6MDmiyDmYgo0YdQ-1; Fri, 24 Jun 2022 10:14:43 -0400
X-MC-Unique: 1nV8Fdb6MDmiyDmYgo0YdQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59DB2180A385;
        Fri, 24 Jun 2022 14:14:43 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A99540CFD0A;
        Fri, 24 Jun 2022 14:14:41 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5.20 3/4] dm: improve handling for DM_REQUEUE and AGAIN
Date:   Fri, 24 Jun 2022 22:12:54 +0800
Message-Id: <20220624141255.2461148-4-ming.lei@redhat.com>
In-Reply-To: <20220624141255.2461148-1-ming.lei@redhat.com>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case that BLK_STS_DM_REQUEUE is returned or BLK_STS_AGAIN is returned
for POLLED io, we requeue the original bio into deferred list and
request md->wq to re-submit it to block layer.

Improve the handling in the following way:

1) unify handling for BLK_STS_DM_REQUEUE and BLK_STS_AGAIN, and clear
REQ_POLLED for BLK_STS_DM_REQUEUE too, for the sake of simplicity,
given BLK_STS_DM_REQUEUE is very unusual

2) queue md->wq explicitly in __dm_io_complete(), so requeue handling
becomes more robust

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm.c | 58 +++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a9e5e429c150..ee22c763873f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -884,20 +884,39 @@ static int __noflush_suspending(struct mapped_device *md)
 	return test_bit(DMF_NOFLUSH_SUSPENDING, &md->flags);
 }
 
-static void dm_handle_requeue(struct dm_io *io)
+/* Return true if the original bio is requeued */
+static bool dm_handle_requeue(struct dm_io *io)
 {
-	if (io->status == BLK_STS_DM_REQUEUE) {
-		struct bio *bio = io->split_bio ? io->split_bio : io->orig_bio;
-		struct mapped_device *md = io->md;
+	struct bio *bio = io->split_bio ? io->split_bio : io->orig_bio;
+	bool need_requeue = (io->status == BLK_STS_DM_REQUEUE);
+	bool handle_eagain = (io->status == BLK_STS_AGAIN) &&
+		(bio->bi_opf & REQ_POLLED);
+	struct mapped_device *md = io->md;
+	bool requeued = false;
+
+	if (need_requeue || handle_eagain) {
 		unsigned long flags;
+
+		if (bio->bi_opf & REQ_POLLED) {
+			/*
+			 * Upper layer won't help us poll split bio
+			 * (io->orig_bio may only reflect a subset of the
+			 * pre-split original) so clear REQ_POLLED in case
+			 * of requeue.
+			 */
+			bio_clear_polled(bio);
+		}
+
 		/*
 		 * Target requested pushing back the I/O.
 		 */
 		spin_lock_irqsave(&md->deferred_lock, flags);
-		if (__noflush_suspending(md) &&
-		    !WARN_ON_ONCE(dm_is_zone_write(md, bio))) {
+		if ((__noflush_suspending(md) &&
+		    !WARN_ON_ONCE(dm_is_zone_write(md, bio))) ||
+				handle_eagain) {
 			/* NOTE early return due to BLK_STS_DM_REQUEUE below */
 			bio_list_add_head(&md->deferred, bio);
+			requeued = true;
 		} else {
 			/*
 			 * noflush suspend was interrupted or this is
@@ -907,6 +926,10 @@ static void dm_handle_requeue(struct dm_io *io)
 		}
 		spin_unlock_irqrestore(&md->deferred_lock, flags);
 	}
+
+	if (requeued)
+		queue_work(md->wq, &md->work);
+	return requeued;
 }
 
 static void dm_io_complete(struct dm_io *io)
@@ -914,8 +937,9 @@ static void dm_io_complete(struct dm_io *io)
 	struct bio *bio = io->split_bio ? io->split_bio : io->orig_bio;
 	struct mapped_device *md = io->md;
 	blk_status_t io_error;
+	bool requeued;
 
-	dm_handle_requeue(io);
+	requeued = dm_handle_requeue(io);
 
 	io_error = io->status;
 	if (dm_io_flagged(io, DM_IO_ACCOUNTED))
@@ -936,23 +960,9 @@ static void dm_io_complete(struct dm_io *io)
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
+	/* We have requeued, so return now */
+	if (requeued)
+		return;
 
 	if (bio_is_flush_with_data(bio)) {
 		/*
-- 
2.31.1

