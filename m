Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642C8C4321E
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6D8610E8
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350887AbhIDBgm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 21:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350773AbhIDBgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 21:36:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B55C0613CF;
        Fri,  3 Sep 2021 18:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RL6C/c6i2qfpkU1bbRAF0GVGBtIpDSTv1FipAKcuxm0=; b=URrwwvgIxVPSlVVolkwgurYTBg
        3YgJDMw8sg8oEXMbQ0qqxFDvKvQvhX0TBKhLPSRAj3ZDzKiGSom/ggK3zZ6AV8nCajNRNrZqSqppO
        lFfXMszOtuas35e1+P5Fs/rB4WkCb4KXK4nhoh7Te2myNukFQdO9Y15Foi8xFmgmh347mmzgS3N/2
        UrhHDjeUxxzi1EM/QuVt0Whyi6c7mXPVo6gFNVtNCkn4mctLyDrKtY+ua6/qv0jX2+xKQE6ys17hn
        IvjZyh8WWH7vuNGnlWlaT1PWb6zfZMivpQyqgxbUteOuBhg/onf4gzaYU8JVPqFmW7UUQOzDCP0h2
        /VLbk1IA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKan-00DLbP-Oq; Sat, 04 Sep 2021 01:35:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 12/14] block/ataflop: add registration bool before calling del_gendisk()
Date:   Fri,  3 Sep 2021 18:35:34 -0700
Message-Id: <20210904013536.3181237-13-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210904013536.3181237-1-mcgrof@kernel.org>
References: <20210904013536.3181237-1-mcgrof@kernel.org>
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

