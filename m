Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB6AC4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659D160FDA
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbhHRGaV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237947AbhHRGaN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:30:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9233FC061764
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6Q2BLEsy1d1GX6c8DJKkFPhp1q0z4Hnvix+JFjEdaO8=; b=uYb1pohLd9Gpd0qrNd5b2yZlXu
        kypra1dj1wPlcmSQPBkKb/dleRybhQ+AlsdUy8RQ6oneytK9slyLRNyqdX6eBZvkwFUvMLGU9skb/
        uuZkRGiQ2UYe0mc6fyWo9NLuVOEg4Jje2Px0dkfupmC3C3RSGEBtQHfr3mpDYlCDz5EXdogachr3Z
        A/XuMVZa3T3hlAVLqUb0RLK41b/IQ2suM5HDv838oTi9r3A0xjaKcUJHr/7Zsh4PMpJxEl8jRXaHo
        mlyFR4TdnuJW9qu3sV4yIPWYgiij0s6qTklw8mVrSmkbFRUfjlUGCZ4KIw2I0+4Gs8pox1ulk4olh
        CNK/licg==;
Received: from 213-225-12-39.nat.highway.a1.net ([213.225.12.39] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGF2D-003R5y-OQ; Wed, 18 Aug 2021 06:27:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/7] loop: remove the ->ioctl method in loop_func_table
Date:   Wed, 18 Aug 2021 08:24:49 +0200
Message-Id: <20210818062455.211065-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818062455.211065-1-hch@lst.de>
References: <20210818062455.211065-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Never set to anything useful.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/cryptoloop.c | 7 -------
 drivers/block/loop.c       | 4 +---
 drivers/block/loop.h       | 3 ---
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
index 3cabc335ae74..8be35d37e379 100644
--- a/drivers/block/cryptoloop.c
+++ b/drivers/block/cryptoloop.c
@@ -154,12 +154,6 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
 	return err;
 }
 
-static int
-cryptoloop_ioctl(struct loop_device *lo, int cmd, unsigned long arg)
-{
-	return -EINVAL;
-}
-
 static int
 cryptoloop_release(struct loop_device *lo)
 {
@@ -176,7 +170,6 @@ cryptoloop_release(struct loop_device *lo)
 static struct loop_func_table cryptoloop_funcs = {
 	.number = LO_CRYPT_CRYPTOAPI,
 	.init = cryptoloop_init,
-	.ioctl = cryptoloop_ioctl,
 	.transfer = cryptoloop_transfer,
 	.release = cryptoloop_release,
 	.owner = THIS_MODULE
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index fa1c298a8cfb..b0dfea6d4371 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1169,7 +1169,6 @@ loop_set_status_from_info(struct loop_device *lo,
 	if (!xfer)
 		xfer = &none_funcs;
 	lo->transfer = xfer->transfer;
-	lo->ioctl = xfer->ioctl;
 
 	lo->lo_flags = info->lo_flags;
 
@@ -1383,7 +1382,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 
 	loop_release_xfer(lo);
 	lo->transfer = NULL;
-	lo->ioctl = NULL;
 	lo->lo_device = NULL;
 	lo->lo_encryption = NULL;
 	lo->lo_offset = 0;
@@ -1809,7 +1807,7 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
 		err = loop_set_block_size(lo, arg);
 		break;
 	default:
-		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
+		err = -EINVAL;
 	}
 	mutex_unlock(&lo->lo_mutex);
 	return err;
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 1988899db63a..dcde46afc675 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -43,8 +43,6 @@ struct loop_device {
 	struct loop_func_table *lo_encryption;
 	__u32           lo_init[2];
 	kuid_t		lo_key_owner;	/* Who set the key */
-	int		(*ioctl)(struct loop_device *, int cmd, 
-				 unsigned long arg); 
 
 	struct file *	lo_backing_file;
 	struct block_device *lo_device;
@@ -91,7 +89,6 @@ struct loop_func_table {
 	int (*init)(struct loop_device *, const struct loop_info64 *); 
 	/* release is called from loop_unregister_transfer or clr_fd */
 	int (*release)(struct loop_device *); 
-	int (*ioctl)(struct loop_device *, int cmd, unsigned long arg);
 	struct module *owner;
 }; 
 
-- 
2.30.2

