Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F42C54EE9
	for <linux-block@archiver.kernel.org>; Mon, 19 Sep 2022 14:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiISOlR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Sep 2022 10:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiISOlB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2022 10:41:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C376F1
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 07:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vUCIx1yCpMppbaXbcvweqkW9qIO2w9E+swsy/lTt4JQ=; b=49JvCQqyMPHkZFcGia4V42vymw
        4Xl5umhzMLK44mZ+0lVnHbQ9H2l9dK2YNTKiCSzg1e1A3TLEl9c0gEO1Lx068fWQdFLxfEN2Dzuf6
        gTa+IT10BmrpJpCKqUB7E0XtkL4aBl0mBe6pHkzI2W3XndsIU72al0l1A86IjAZsibTNE9mL1/M3a
        m+iKpwI24Chq6RM13cI9Vz+paNh9fInO3swRv7tblColkX653krcl2DlY/ibqdSWytUPTGc9+m8yW
        S9VlDsPhvNkeefgZl3HLW3+cVMyMIOXTaXZCULnKWX1hekwBqMpYqUkRyWU1QyePT9LOBcEe14XeJ
        aDQv5JlQ==;
Received: from [2001:4bb8:189:f4ee:184d:7c69:5714:93ca] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaHx5-00C946-Ge; Mon, 19 Sep 2022 14:40:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, dusty@dustymabe.com,
        ming.lei@redhat.com
Subject: [PATCH] Revert "block: freeze the queue earlier in del_gendisk"
Date:   Mon, 19 Sep 2022 16:40:49 +0200
Message-Id: <20220919144049.978907-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit a09b314005f3a0956ebf56e01b3b80339df577cc.

Dusty Mabe reported consistent hang during CoreOS shutdown with a MD 
RAID1 setup.  Although apparently similar hangs happened before,
and this patch most likely is not the root cause it made it much
more severe.  Revert it until we can figure out what is going on
with the md driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>

---
 block/genhd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index d36fabf0abc1f..988ba52fd3316 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -602,7 +602,6 @@ void del_gendisk(struct gendisk *disk)
 	 * Prevent new I/O from crossing bio_queue_enter().
 	 */
 	blk_queue_start_drain(q);
-	blk_mq_freeze_queue_wait(q);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
@@ -626,6 +625,8 @@ void del_gendisk(struct gendisk *disk)
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
 	device_del(disk_to_dev(disk));
 
+	blk_mq_freeze_queue_wait(q);
+
 	blk_throtl_cancel_bios(disk->queue);
 
 	blk_sync_queue(q);
-- 
2.30.2

