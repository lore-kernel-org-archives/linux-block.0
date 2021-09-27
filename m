Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AF6C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E743610A2
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbhI0WHS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbhI0WGi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:06:38 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC27C05174A;
        Mon, 27 Sep 2021 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RL6C/c6i2qfpkU1bbRAF0GVGBtIpDSTv1FipAKcuxm0=; b=Fdp20N4R49x/LULSjNRNLrIb+5
        oUNu4U2e1NlyPtQTdPkCg4RgHXyBsFgf97Zlc+EG7JKKtbmhMLx734twtXRJTLgwWwVD1WZ5ySMlw
        AxInYkPCr4zN2SBpSs1Aj5uMsiZToiVB1Eo0zKjkj8mQUI4lU32uE7tyUtEeRA0gTlUWvUMCPGU6S
        RPJzvdf4sm9FQmAALucLoW+ucfOMHyP4XAT7frCM5YomYcbpqtSp+G8oXZGd8G68VZ1qSS/NVgyX6
        1xY7nMjTjoCWK0a8D/0rkySJJN8576BWSPIDi7IJ9fXv49U/Xez9GX/v/JjgrTZGt63rPM469dMWf
        F4/oznOA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyiG-004VIk-4E; Mon, 27 Sep 2021 22:03:04 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 12/14] block/ataflop: add registration bool before calling del_gendisk()
Date:   Mon, 27 Sep 2021 15:03:00 -0700
Message-Id: <20210927220302.1073499-13-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220302.1073499-1-mcgrof@kernel.org>
References: <20210927220302.1073499-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The ataflop assumes del_gendisk() is safe to call, this is only
true because add_disk() does not return a failure, but that will
change soon. And so, before we get to adding error handling for
that case, let's make sure we keep track of which disks actually
get registered. Then we use this to only call del_gendisk for them.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/ataflop.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 6a865d42b1fd..97f1c19f9c02 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -298,6 +298,7 @@ static struct atari_floppy_struct {
 				   disk change detection) */
 	int flags;		/* flags */
 	struct gendisk *disk[NUM_DISK_MINORS];
+	bool registered[NUM_DISK_MINORS];
 	int ref;
 	int type;
 	struct blk_mq_tag_set tag_set;
@@ -2000,8 +2001,10 @@ static void ataflop_probe(dev_t dev)
 		return;
 	mutex_lock(&ataflop_probe_lock);
 	if (!unit[drive].disk[type]) {
-		if (ataflop_alloc_disk(drive, type) == 0)
+		if (ataflop_alloc_disk(drive, type) == 0) {
 			add_disk(unit[drive].disk[type]);
+			unit[drive].registered[type] = true;
+		}
 	}
 	mutex_unlock(&ataflop_probe_lock);
 }
@@ -2065,6 +2068,7 @@ static int __init atari_floppy_init (void)
 		unit[i].track = -1;
 		unit[i].flags = 0;
 		add_disk(unit[i].disk[0]);
+		unit[i].registered[0] = true;
 	}
 
 	printk(KERN_INFO "Atari floppy driver: max. %cD, %strack buffering\n",
@@ -2133,7 +2137,8 @@ static void __exit atari_floppy_exit(void)
 		for (type = 0; type < NUM_DISK_MINORS; type++) {
 			if (!unit[i].disk[type])
 				continue;
-			del_gendisk(unit[i].disk[type]);
+			if (unit[i].registered[type])
+				del_gendisk(unit[i].disk[type]);
 			blk_cleanup_disk(unit[i].disk[type]);
 		}
 		blk_mq_free_tag_set(&unit[i].tag_set);
-- 
2.30.2

