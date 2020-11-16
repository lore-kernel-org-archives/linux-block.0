Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F085DC63777
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 21:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D02922240
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 21:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gIJroEqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgKPVUe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 16:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgKPVUd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 16:20:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B68C0613CF
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2020 13:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Al4j1ytf0tEOG5tBSliKujyJqA951M78b84DTEt+Z9Y=; b=gIJroEqzFf3yya0CgMJkNw1jeS
        i015bBPj7ed14352RvXie2iqIzvhnF6eMuApVoCr/GhQdwPVCDZAcuHxEz1ViPGoOZ5HnXUxQCcV+
        dTNt0p27sMIwiSkixVukduBNboPpx3iZiHh6ZWlhQ9kgUL06PbF5UJUZRbvKAp1HUcsL1KOWstbta
        HoUdfNq8kzS04HmtphiWM2EL2Uqdhzskgqt+tMRI+5cpRJYnwlMrnkxNAK5koyS1te62EBb7gcW0V
        vX3s4cu7PbkHbcj1AFtJubR8qdrfppuuiqiIvOU+ti290wmqwZlJwP66qVv70EL1wUcq3Ooo+gH6p
        que+IcRA==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kelvJ-0007PK-58; Mon, 16 Nov 2020 21:20:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 6/6] dm: remove the block_device reference in struct mapped_device
Date:   Mon, 16 Nov 2020 22:20:20 +0100
Message-Id: <20201116212020.1099154-7-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116212020.1099154-1-hch@lst.de>
References: <20201116212020.1099154-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Get rid of the long-lasting struct block_device reference in
struct mapped_device.  The only remaining user is the freeze code,
where we can trivially look up the block device at freeze time
and release the reference at thaw time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-core.h |  2 --
 drivers/md/dm.c      | 19 ++++++++-----------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index d522093cb39dda..b1b400ed76fe90 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -107,8 +107,6 @@ struct mapped_device {
 	/* kobject and completion */
 	struct dm_kobject_holder kobj_holder;
 
-	struct block_device *bdev;
-
 	struct dm_stats stats;
 
 	/* for blk-mq request-based DM support */
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 6d7eb72d41f9ea..83fe1e7f13e6b0 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1744,11 +1744,6 @@ static void cleanup_mapped_device(struct mapped_device *md)
 
 	cleanup_srcu_struct(&md->io_barrier);
 
-	if (md->bdev) {
-		bdput(md->bdev);
-		md->bdev = NULL;
-	}
-
 	mutex_destroy(&md->suspend_lock);
 	mutex_destroy(&md->type_lock);
 	mutex_destroy(&md->table_devices_lock);
@@ -1840,10 +1835,6 @@ static struct mapped_device *alloc_dev(int minor)
 	if (!md->wq)
 		goto bad;
 
-	md->bdev = bdget_disk(md->disk, 0);
-	if (!md->bdev)
-		goto bad;
-
 	dm_stats_init(&md->stats);
 
 	/* Populate the mapping, nobody knows we exist yet */
@@ -2384,12 +2375,17 @@ struct dm_table *dm_swap_table(struct mapped_device *md, struct dm_table *table)
  */
 static int lock_fs(struct mapped_device *md)
 {
+	struct block_device *bdev;
 	int r;
 
 	WARN_ON(md->frozen_sb);
 
-	md->frozen_sb = freeze_bdev(md->bdev);
+	bdev = bdget_disk(md->disk, 0);
+	if (!bdev)
+		return -ENOMEM;
+	md->frozen_sb = freeze_bdev(bdev);
 	if (IS_ERR(md->frozen_sb)) {
+		bdput(bdev);
 		r = PTR_ERR(md->frozen_sb);
 		md->frozen_sb = NULL;
 		return r;
@@ -2405,7 +2401,8 @@ static void unlock_fs(struct mapped_device *md)
 	if (!test_bit(DMF_FROZEN, &md->flags))
 		return;
 
-	thaw_bdev(md->bdev, md->frozen_sb);
+	thaw_bdev(md->frozen_sb->s_bdev, md->frozen_sb);
+	bdput(md->frozen_sb->s_bdev);
 	md->frozen_sb = NULL;
 	clear_bit(DMF_FROZEN, &md->flags);
 }
-- 
2.29.2

