Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55879C432BE
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E1E260F44
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbhHZNpi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 09:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbhHZNph (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 09:45:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9921DC061757
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OOFxk9Lqi2jLPr09w+yqqosyP42I2sEjVl6HeyWH8CQ=; b=RbmlRJ8aJE+vFupjPS/pX28hQ/
        g5RgfCn4xhDgGJM9RlZNGdbtLWoQy06QGjbtJBHDbcZxmDSJHH1XUtYHqYxIY7tDip63WpmpZzgNg
        fWB1NNC57Ep8YCmcCqMOscZL9d0smgiIqSSYka47Fmb+VQ7YqPV/k99HIv8tqcEgL7OK5xzBHWVsC
        J1IXovmOUtic4mQArFRuXEwVNnQK6kIh5UgbRqnZN9e8pyBu6j86kfZZKV/YW+gVaBicbzucIs33D
        oBs49PLTobHwOFWOklPlpvO13739xeDcLaQxv7vckaQptwzzTO9JVslVXknNGJ8xqxi4cKYpBMqOZ
        357ksujw==;
Received: from [2001:4bb8:193:fd10:d9d9:6c15:481b:99c4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJFer-00DLPm-0Y; Thu, 26 Aug 2021 13:43:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 4/8] loop: return void from the ->release method in loop_func_table
Date:   Thu, 26 Aug 2021 15:38:06 +0200
Message-Id: <20210826133810.3700-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826133810.3700-1-hch@lst.de>
References: <20210826133810.3700-1-hch@lst.de>
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
index 2c705ea7f218..c2392ce2a819 100644
--- a/drivers/block/cryptoloop.c
+++ b/drivers/block/cryptoloop.c
@@ -153,17 +153,11 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
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
index 508a168fddaa..680974601161 100644
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

