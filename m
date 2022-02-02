Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773ECC433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 16:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345629AbiBBQBR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 11:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345628AbiBBQBR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 11:01:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF60C061714
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=53g90lZBMh/ldzirlFZP4n9i+Wwo32QW2GhtYSf7T5E=; b=v56pgGCEOMyc3JXNRaB7TS7FAX
        IauoereXezUReiBaeO1d4C4O4ReBujjrvVSs7ieQZzqLMQWM9HbpLtntMdw4gxo+pLCk7+7dKS5Pn
        2/hOVdHcobJGn0oTmM/80YlS73Fb7QRqOB0266M6tKLHtcRT5oAgcjuSD1z2wlWQpCTrDxVWz0QHQ
        jCQUKDh2BwlImzd+yEAPnwXCtrUGuTruBap8+57GacXtW6cvTG1SQ0CZHvLCxnhcpEPpNuGMZ+EYe
        KMp7XreppkL0bYnqeS53zyRNVRDI3asQ8kxbrWr1UEXHY2/TURV+iCgqgBbNyrRBGwXi1Q8VXHy/3
        kFSlvD/A==;
Received: from [2001:4bb8:191:327d:b3e5:1ccd:eaac:6609] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFI4I-00G7wt-54; Wed, 02 Feb 2022 16:01:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: [PATCH 01/13] drbd: set ->bi_bdev in drbd_req_new
Date:   Wed,  2 Feb 2022 17:00:57 +0100
Message-Id: <20220202160109.108149-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202160109.108149-1-hch@lst.de>
References: <20220202160109.108149-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure the newly allocated bio has the correct bi_bdev set from the
start.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_req.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 3235532ae0778..8d44e96c4c4ef 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -31,6 +31,7 @@ static struct drbd_request *drbd_req_new(struct drbd_device *device, struct bio
 	memset(req, 0, sizeof(*req));
 
 	req->private_bio = bio_clone_fast(bio_src, GFP_NOIO, &drbd_io_bio_set);
+	bio_set_dev(req->private_bio, device->ldev->backing_bdev);
 	req->private_bio->bi_private = req;
 	req->private_bio->bi_end_io = drbd_request_endio;
 
@@ -1151,8 +1152,6 @@ drbd_submit_req_private_bio(struct drbd_request *req)
 	else
 		type = DRBD_FAULT_DT_RD;
 
-	bio_set_dev(bio, device->ldev->backing_bdev);
-
 	/* State may have changed since we grabbed our reference on the
 	 * ->ldev member. Double check, and short-circuit to endio.
 	 * In case the last activity log transaction failed to get on
-- 
2.30.2

