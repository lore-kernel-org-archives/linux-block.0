Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F74ECDB474
	for <linux-block@archiver.kernel.org>; Tue, 17 Oct 2023 18:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjJQSso (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Oct 2023 14:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjJQSso (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2023 14:48:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F43D3;
        Tue, 17 Oct 2023 11:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cl8di6G3DxLLFf5MtSBQgO7MOKUrZZ/L+falVxOQuKg=; b=UYWaETAjbVF1TF5AWFnEd2BOv1
        UYLxmX1xpq33/xS5o+//DLjuFFRDybdy6/xDYyukec8TdQo1RhAHTXlBwSR4HLxpakXzKc6KCGhIZ
        TtYs/1Izxqoqt1KutZNfApLPSUQpUhf5rSRksn+sJ7hpgnLU/FSDAo3gSlKmcpMVHxZ6b3VXKegSx
        on7F9aMyj+JdT73fT827+VJ0t0qMOzljjgz5quwpQxfRTCaqW0QeEO+Q18/QOp73uoByRImHln4/S
        9pIsPL/RmV+Mmmma1r8dEhrcRDTTJxjDdVdChuGWFQuPk9e4SkhzE1CYB28dg6RIV3IzoNZS/dpiQ
        0zysKpyA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qsp7P-00D0Le-0h;
        Tue, 17 Oct 2023 18:48:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, Denis Efremov <efremov@linux.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] block: assert that we're not holding open_mutex over blk_report_disk_dead
Date:   Tue, 17 Oct 2023 20:48:22 +0200
Message-Id: <20231017184823.1383356-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017184823.1383356-1-hch@lst.de>
References: <20231017184823.1383356-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

blk_report_disk_dead() has the following major callers:

(1) del_gendisk()
(2) blk_mark_disk_dead()

Since del_gendisk() acquires disk->open_mutex it's clear that all
callers are assumed to be called without disk->open_mutex held.
In turn, blk_report_disk_dead() is called without disk->open_mutex held
in del_gendisk().

All callers of blk_mark_disk_dead() call it without disk->open_mutex as
well.

Ensure that it is clear that blk_report_disk_dead() is called without
disk->open_mutex on purpose by asserting it and a comment in the code.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 4a16a424f57d4f..c9d06f72c587e8 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -559,6 +559,13 @@ static void blk_report_disk_dead(struct gendisk *disk, bool surprise)
 	struct block_device *bdev;
 	unsigned long idx;
 
+	/*
+	 * On surprise disk removal, bdev_mark_dead() may call into file
+	 * systems below. Make it clear that we're expecting to not hold
+	 * disk->open_mutex.
+	 */
+	lockdep_assert_not_held(&disk->open_mutex);
+
 	rcu_read_lock();
 	xa_for_each(&disk->part_tbl, idx, bdev) {
 		if (!kobject_get_unless_zero(&bdev->bd_device.kobj))
-- 
2.39.2

