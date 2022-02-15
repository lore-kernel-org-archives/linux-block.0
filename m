Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610C3C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 10:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbiBOKGN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 05:06:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiBOKGM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 05:06:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A762524F
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 02:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mEpu3vLLpJD6+zaWJH61Lv4c0zETFy7I0xIIePhVsvQ=; b=BHGTNtDeaOoBo8NYTj1iBNOdp+
        Fn8V0hfyOae5XZH3axH1f85+af3IOnUA170vntD5j3VadxXKbTM8Y5J4SdLba0/YimYh7ITn+q1er
        qpONzYw41R0HYECxF/O8qCiBtyhWQ/5QDAvLEigEAAOjGO0pHzzzTIFVK5Stp+KWbbdJTlHofLwOT
        IyNhCtHDI6xhrg8RQnembUuyN76kD/wD8B8NConXszH/vzswdvc5D+7AfSmXc6En5FAXq/wl2U0MS
        Cdbr2D+j2fIokW5VC7zr7nPc0gukffLWoa5bVcLLeaHhJGyMl+SR5qZd9FoGw5AksH4h+iMymo0Oo
        tqxReBFA==;
Received: from [2001:4bb8:184:543c:6bdf:22f4:7f0a:fe97] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJuia-002E73-9Y; Tue, 15 Feb 2022 10:05:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 5/5] dm: remove dm_dispatch_clone_request
Date:   Tue, 15 Feb 2022 11:05:40 +0100
Message-Id: <20220215100540.3892965-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215100540.3892965-1-hch@lst.de>
References: <20220215100540.3892965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold dm_dispatch_clone_request into it's only caller, and use a switch
statement to single dispatch for the handling of the different return
values from blk_insert_cloned_request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-rq.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 8f6117342d322..6948d5db90925 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -303,17 +303,6 @@ static void end_clone_request(struct request *clone, blk_status_t error)
 	dm_complete_request(tio->orig, error);
 }
 
-static blk_status_t dm_dispatch_clone_request(struct request *clone, struct request *rq)
-{
-	blk_status_t r;
-
-	r = blk_insert_cloned_request(clone);
-	if (r != BLK_STS_OK && r != BLK_STS_RESOURCE && r != BLK_STS_DEV_RESOURCE)
-		/* must complete clone in terms of original request */
-		dm_complete_request(rq, r);
-	return r;
-}
-
 static int dm_rq_bio_constructor(struct bio *bio, struct bio *bio_orig,
 				 void *data)
 {
@@ -394,13 +383,20 @@ static int map_request(struct dm_rq_target_io *tio)
 		/* The target has remapped the I/O so dispatch it */
 		trace_block_rq_remap(clone, disk_devt(dm_disk(md)),
 				     blk_rq_pos(rq));
-		ret = dm_dispatch_clone_request(clone, rq);
-		if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE) {
+		ret = blk_insert_cloned_request(clone);
+		switch (ret) {
+		case BLK_STS_OK:
+			break;
+		case BLK_STS_RESOURCE:
+		case BLK_STS_DEV_RESOURCE:
 			blk_rq_unprep_clone(clone);
 			blk_mq_cleanup_rq(clone);
 			tio->ti->type->release_clone_rq(clone, &tio->info);
 			tio->clone = NULL;
 			return DM_MAPIO_REQUEUE;
+		default:
+			/* must complete clone in terms of original request */
+			dm_complete_request(rq, ret);
 		}
 		break;
 	case DM_MAPIO_REQUEUE:
-- 
2.30.2

