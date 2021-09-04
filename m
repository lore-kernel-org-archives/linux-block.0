Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998B2C43219
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8987661056
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350771AbhIDBgv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 21:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350870AbhIDBgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 21:36:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319D4C0617AD;
        Fri,  3 Sep 2021 18:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9wOyTGIy2lYyV34pVMUavNLLhw5CZPDfOmRGSHe5G74=; b=xkZvP5ZJzlgo3QnfVTe/XW+q5P
        2a6JB4U1p9xPFJHtEfpcfuie2AVscy0s2HVlbrJS1bKqPc+RnCE1+/RLEdI8iD/bSorKm8tOCUGY3
        n9q+SyfA105FyDi0ml2LsASoVw8DIjySAkDsriljusGXxlvsrQet56z5KYPfRNE0v3QhpwToODOWk
        3o6gOttNw9JWIVspX7wdY6dwKp8cGLLNzsOtP/FCIonu1I+4ZdM7qQumG0YItNBgEWkMS9TbZ8U5C
        tVYE4idFX6A5rMsO8k6wyeqQRstvt9lty3MTEEnnTt5d/dhmzDlRJfNAikpg8OP4pf+IkVrCOI0b5
        ErAc0PDw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKan-00DLbR-QA; Sat, 04 Sep 2021 01:35:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 13/14] block/ataflop: provide a helper for cleanup up an atari disk
Date:   Fri,  3 Sep 2021 18:35:35 -0700
Message-Id: <20210904013536.3181237-14-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210904013536.3181237-1-mcgrof@kernel.org>
References: <20210904013536.3181237-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of using two separate code paths for cleaning up an atari disk,
use one. We take the more careful approach to check for *all* disk
types, as is done on exit. The init path didn't have that check as
the alternative disk types are only probed for later, they are not
initialized by default.

Yes, there is a shared tag for all disks.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/ataflop.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 97f1c19f9c02..e9d874f51597 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2009,6 +2009,20 @@ static void ataflop_probe(dev_t dev)
 	mutex_unlock(&ataflop_probe_lock);
 }
 
+static void atari_cleanup_floppy_disk(struct atari_floppy_struct *fs)
+{
+	int type;
+
+	for (type = 0; type < NUM_DISK_MINORS; type++) {
+		if (!fs->disk[type])
+			continue;
+		if (fs->registered[type])
+			del_gendisk(fs->disk[type]);
+		blk_cleanup_disk(fs->disk[type]);
+	}
+	blk_mq_free_tag_set(&fs->tag_set);
+}
+
 static int __init atari_floppy_init (void)
 {
 	int i;
@@ -2079,10 +2093,8 @@ static int __init atari_floppy_init (void)
 	return 0;
 
 err:
-	while (--i >= 0) {
-		blk_cleanup_disk(unit[i].disk[0]);
-		blk_mq_free_tag_set(&unit[i].tag_set);
-	}
+	while (--i >= 0)
+		atari_cleanup_floppy_disk(&unit[i]);
 
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 out_unlock:
@@ -2131,18 +2143,10 @@ __setup("floppy=", atari_floppy_setup);
 
 static void __exit atari_floppy_exit(void)
 {
-	int i, type;
+	int i;
 
-	for (i = 0; i < FD_MAX_UNITS; i++) {
-		for (type = 0; type < NUM_DISK_MINORS; type++) {
-			if (!unit[i].disk[type])
-				continue;
-			if (unit[i].registered[type])
-				del_gendisk(unit[i].disk[type]);
-			blk_cleanup_disk(unit[i].disk[type]);
-		}
-		blk_mq_free_tag_set(&unit[i].tag_set);
-	}
+	for (i = 0; i < FD_MAX_UNITS; i++)
+		atari_cleanup_floppy_disk(&unit[i]);
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 
 	del_timer_sync(&fd_timer);
-- 
2.30.2

