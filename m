Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D4CC3526F
	for <linux-block@archiver.kernel.org>; Mon, 30 May 2022 14:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiE3OWZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 May 2022 10:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241395AbiE3ORd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 10:17:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB26690CC4
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GgEdfIAwgIGH5YP8c/JQol2oJF+0f2WQqtcED/uBNWE=; b=L4a5MI3Vy1EHUrKqJrZ1yPPE3o
        Ltbz9flOXntx5UdAras1lQ1v4eN8N/VEB+gcScELfcEb6nqVtVH7WaWA4N5xGxm9e/U5iqwa4XB/8
        2OwdK7PDw3D6egef4Ffl0gOyU/DDCrapc+2y5qCPW5sI34d0r2zuQdJ+OloICsSFRCsP4CYw//vTB
        6Xjhbhi/FSQcWYDudRHNSKEdogzOssKetE0689qeJVkePpbfvJfnk7B0rrdBbdMsv6RN8AXP2Nnen
        d0R6Yh2eZc6NeCOLLSd8NrZ5bEwmMu6leGZEjc3Gplvwwgxyy4DuwRbYbtwSGA/bCbQzDIHa+OrWq
        mkDCZIfQ==;
Received: from [2001:4bb8:185:a81e:fda9:da32:3b0c:8358] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvfiZ-006rQ9-3b; Mon, 30 May 2022 13:45:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: freeze the queue earlier in del_gendisk
Date:   Mon, 30 May 2022 15:45:48 +0200
Message-Id: <20220530134548.3108185-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220530134548.3108185-1-hch@lst.de>
References: <20220530134548.3108185-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Freeze the queue earlier in del_gendisk so that the state does not
change while we remove debugfs and sysfs files.

Ming mentioned that being able to observer request in debugfs might
be useful while the queue is being frozen in del_gendisk, which is
made possible by this change.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 36532b9318419..8ff5b187791af 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -621,6 +621,7 @@ void del_gendisk(struct gendisk *disk)
 	 * Prevent new I/O from crossing bio_queue_enter().
 	 */
 	blk_queue_start_drain(q);
+	blk_mq_freeze_queue_wait(q);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
@@ -644,8 +645,6 @@ void del_gendisk(struct gendisk *disk)
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
 	device_del(disk_to_dev(disk));
 
-	blk_mq_freeze_queue_wait(q);
-
 	blk_throtl_cancel_bios(disk->queue);
 
 	blk_sync_queue(q);
-- 
2.30.2

