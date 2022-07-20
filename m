Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD0C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 13:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbiGTNFt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 09:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiGTNFs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 09:05:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB01813DFC
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=B0TeGr1M86m3aggP8EnFWmQQS5bL+tVhg81MV4XC8Hs=; b=OhSn1a0K+ij3EKOPEd068aOQ9C
        dlseNYTjzihdgwbdeKrlGnMoYPnE+9UPK/38KnWToj1ernfK8Mvj0H95gxwM2NkcnJNc9moa/AeQE
        7Q5y2qqSHX6LeJWeBo2HImsopGmd6Ygiu3A8mcRoDkk2RdjveAxgnNFW+yRpEtLJ5+eL+w4RDL3Eq
        l+6KyD6ukrmU59uYHeKoCw3DjGrAQObc6DajG9iGyhiZYehDyvqvyW+YqWyOZ/E0e0QMYPwzzCHz9
        2RwhPlcwFm+vheC+7WufPxtrEeRZg3LHsIlkdyYHSUc+OwJ1RDiOJKkx5hZbljMJ/qHV9Xh/QrNwL
        wyS2dXZA==;
Received: from 089144204193.atnat0013.highway.webapn.at ([89.144.204.193] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oE9Od-005iUO-1c; Wed, 20 Jul 2022 13:05:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: call blk_mq_exit_queue from disk_release for never added disks
Date:   Wed, 20 Jul 2022 15:05:41 +0200
Message-Id: <20220720130541.1323531-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720130541.1323531-1-hch@lst.de>
References: <20220720130541.1323531-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To undo the all initialization from blk_mq_init_allocated_queue in case
of a probe failure where add_disk is never called we have to call
blk_mq_exit_queue from put_disk.

This relies on the fact that drivers always call blk_mq_free_tag_set
after calling put_disk in the probe error path if they have a gendisk
at all.

We should be doing this in general, but can't do it for the normal
teardown case (yet) as the tagset can be gone by the time the disk is
released once it was added.  I hope to sort this out properly eventually
but for now this isolated hack will do it.

Fixes: 6f8191fdf41d ("block: simplify disk shutdown")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 44dfcf67ed96a..e1d5b10ac1931 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1138,6 +1138,18 @@ static void disk_release(struct device *dev)
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
 
+	/*
+	 * To undo the all initialization from blk_mq_init_allocated_queue in
+	 * case of a probe failure where add_disk is never called we have to
+	 * call blk_mq_exit_queue here. We can't do this for the more common
+	 * teardown case (yet) as the tagset can be gone by the time the disk
+	 * is released once it was added.
+	 */
+	if (queue_is_mq(disk->queue) &&
+	    test_bit(GD_OWNS_QUEUE, &disk->state) &&
+	    !test_bit(GD_ADDED, &disk->state))
+		blk_mq_exit_queue(disk->queue);
+
 	blkcg_exit_queue(disk->queue);
 
 	disk_release_events(disk);
@@ -1403,6 +1415,9 @@ EXPORT_SYMBOL(__blk_alloc_disk);
  * This decrements the refcount for the struct gendisk. When this reaches 0
  * we'll have disk_release() called.
  *
+ * Note: for blk-mq disk put_disk must be called before freeing the tag_set
+ * when handling probe errors (that is before add_disk() is called).
+ *
  * Context: Any context, but the last reference must not be dropped from
  *          atomic context.
  */
-- 
2.30.2

