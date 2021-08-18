Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877E3C4320A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 699FA610C7
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbhHRGbV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237998AbhHRGbR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:31:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BED2C061764
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gf6rmcj4NCzc/1uqEsBYTol8DBvlZjYrHFA7N5VL4Pw=; b=R7aJ/6T4H/0zO/aKfP/TJHn6FW
        OSEZ0cfJ95N9XoSQ+FAvEloVlu36SgywflROxv5EBPPMlN/3+zVFGNO0YPnPQvO9ZhqnROZwwtd0V
        VPO14YiIu/CegWRtNd6mL7Kzm6QBi2CkZYdQxE3tyf6idYirvL31zyS4OOV41iuZWeS+jev8qRVvR
        eIDpVG4RJS4tF2Yf+hMCZSF5g/gufLYLLpNLANBrNeAPJDz+aln7o0mMzFW5HOinOuVsU3XOeIWx1
        6m7KiwHMN2Df/1oEbY5wxhHoEzEYcTGWjT1fZyB0J1VfURz/gRWfMS/icZx/2M2EXs4sCOTrUPEfz
        FuAxyidw==;
Received: from 213-225-12-39.nat.highway.a1.net ([213.225.12.39] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGF4K-003REv-8k; Wed, 18 Aug 2021 06:29:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 2/7] loop: return void from the ->release method in loop_func_table
Date:   Wed, 18 Aug 2021 08:24:50 +0200
Message-Id: <20210818062455.211065-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818062455.211065-1-hch@lst.de>
References: <20210818062455.211065-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Returning an error here is no useful.  So remove the cargo culted check
in cryptoloop and remove the return value.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/cryptoloop.c | 12 +++---------
 drivers/block/loop.c       | 10 +++-------
 drivers/block/loop.h       |  2 +-
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
index 8be35d37e379..1d9e56860e56 100644
--- a/drivers/block/cryptoloop.c
+++ b/drivers/block/cryptoloop.c
@@ -154,17 +154,11 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
 	return err;
 }
 
-static int
+static void
 cryptoloop_release(struct loop_device *lo)
 {
-	struct crypto_sync_skcipher *tfm = lo->key_data;
-	if (tfm != NULL) {
-		crypto_free_sync_skcipher(tfm);
-		lo->key_data = NULL;
-		return 0;
-	}
-	printk(KERN_ERR "cryptoloop_release(): tfm == NULL?\n");
-	return -EINVAL;
+	crypto_free_sync_skcipher(lo->key_data);
+	lo->key_data = NULL;
 }
 
 static struct loop_func_table cryptoloop_funcs = {
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b0dfea6d4371..d63e9f2c9e9b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1084,20 +1084,18 @@ static void loop_update_rotational(struct loop_device *lo)
 		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
 }
 
-static int
+static void
 loop_release_xfer(struct loop_device *lo)
 {
-	int err = 0;
 	struct loop_func_table *xfer = lo->lo_encryption;
 
 	if (xfer) {
 		if (xfer->release)
-			err = xfer->release(lo);
+			xfer->release(lo);
 		lo->transfer = NULL;
 		lo->lo_encryption = NULL;
 		module_put(xfer->owner);
 	}
-	return err;
 }
 
 static int
@@ -1140,9 +1138,7 @@ loop_set_status_from_info(struct loop_device *lo,
 	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
 		return -EINVAL;
 
-	err = loop_release_xfer(lo);
-	if (err)
-		return err;
+	loop_release_xfer(lo);
 
 	if (info->lo_encrypt_type) {
 		unsigned int type = info->lo_encrypt_type;
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index dcde46afc675..7b84ef724de1 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -88,7 +88,7 @@ struct loop_func_table {
 			int size, sector_t real_block);
 	int (*init)(struct loop_device *, const struct loop_info64 *); 
 	/* release is called from loop_unregister_transfer or clr_fd */
-	int (*release)(struct loop_device *); 
+	void (*release)(struct loop_device *); 
 	struct module *owner;
 }; 
 
-- 
2.30.2

