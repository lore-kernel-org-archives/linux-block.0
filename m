Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB9CC4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879E061103
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 06:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhG0G3J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 02:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhG0G3J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 02:29:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93C3C061757
        for <linux-block@vger.kernel.org>; Mon, 26 Jul 2021 23:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PsMZTrHbgtLbWDWD8gKvRloSFoILBL7uSFyFeqlMMSs=; b=DjIp27oY9FO8+U+mIASRDiEDGG
        m+33IP5Je+fVuYQANpAoO2Wn6AFYrQnUBahfGMZI+pp1dRvVqc9wRUhr7kdnrgnGRQ/z1MWS6Mdte
        xQqBTWgNHv+ints66VUUVKSwBDUwVt2fb2g0GAdm1Te1bv7PvoVtMxKe487270+zFZ1/Vr6ZnoN4Y
        syLk1pDxk6k6omIX6VQR6++Nml6Ou4wYkzUhn2+9Xl2E30dadz/gUi9Q+tWT3aFj2VGFMTn4v/hau
        gEMmgs43juikc0EVGaNuLe0IB6KbctQttPlV8tEMeFtEArU33rkEuNbO/S78MjYmNteC8ji0hu8o4
        jhBis44Q==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8GZM-00EkS3-6c; Tue, 27 Jul 2021 06:28:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 2/6] block: use the %pg format specifier in printk_all_partitions
Date:   Tue, 27 Jul 2021 08:25:14 +0200
Message-Id: <20210727062518.122108-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727062518.122108-1-hch@lst.de>
References: <20210727062518.122108-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Simplify printing the partition name by using the %pg format specifier
that is equivalent to a bdevname call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 80ad85822419..e07b1b028875 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -683,7 +683,6 @@ void __init printk_all_partitions(void)
 	while ((dev = class_dev_iter_next(&iter))) {
 		struct gendisk *disk = dev_to_disk(dev);
 		struct block_device *part;
-		char name_buf[BDEVNAME_SIZE];
 		char devt_buf[BDEVT_SIZE];
 		unsigned long idx;
 
@@ -703,11 +702,10 @@ void __init printk_all_partitions(void)
 		xa_for_each(&disk->part_tbl, idx, part) {
 			if (!bdev_nr_sectors(part))
 				continue;
-			printk("%s%s %10llu %s %s",
+			printk("%s%s %10llu %pg %s",
 			       bdev_is_partition(part) ? "  " : "",
 			       bdevt_str(part->bd_dev, devt_buf),
-			       bdev_nr_sectors(part) >> 1,
-			       disk_name(disk, part->bd_partno, name_buf),
+			       bdev_nr_sectors(part) >> 1, part,
 			       part->bd_meta_info ?
 					part->bd_meta_info->uuid : "");
 			if (bdev_is_partition(part))
-- 
2.30.2

