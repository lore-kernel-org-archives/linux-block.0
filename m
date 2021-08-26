Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1406C432BE
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C798860F44
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbhHZNo2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 09:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbhHZNo1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 09:44:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE82C0613C1
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=45isoRoifxsJDfkcXcy58532wNESge97Y4Vns5YD/MU=; b=EVsssLJ3z9sNmJI+8oBQsRj7r5
        /EDPmn/3VEi7ujPCSNuWg56uhFak5eCsCxxeZydD4/KCKRVAeC1/Rf7Hs+MQoAUJT8P9vhSH52Ft1
        JTGINPRL/FXY73AmKsy/fLHSjTV3aMvpIu8vcHNs/DhMNsStarRZEBUkI/pzeP24Ejk3pdB20DjR9
        sa5B6L4dOXaID6RnOXTgeeBJOrubmoa10ACZcVzI+A7X6TgCtaTjehBhFkCoDQOjQzIkIe5BzawnN
        Qka9nlH8KJ3lapDYDSRE5sNWH1TknlyaRarRoEcrOE69KfYfNhh2Tav7CuGZQD8VUdnvlHSgiy9pp
        yYuWeFlw==;
Received: from [2001:4bb8:193:fd10:d9d9:6c15:481b:99c4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJFe3-00DLNB-Gg; Thu, 26 Aug 2021 13:42:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 3/8] loop: remove the ->ioctl method in loop_func_table
Date:   Thu, 26 Aug 2021 15:38:05 +0200
Message-Id: <20210826133810.3700-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826133810.3700-1-hch@lst.de>
References: <20210826133810.3700-1-hch@lst.de>
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
index 1a65dec47b07..2c705ea7f218 100644
--- a/drivers/block/cryptoloop.c
+++ b/drivers/block/cryptoloop.c
@@ -153,12 +153,6 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
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
@@ -175,7 +169,6 @@ cryptoloop_release(struct loop_device *lo)
 static struct loop_func_table cryptoloop_funcs = {
 	.number = LO_CRYPT_CRYPTOAPI,
 	.init = cryptoloop_init,
-	.ioctl = cryptoloop_ioctl,
 	.transfer = cryptoloop_transfer,
 	.release = cryptoloop_release,
 	.owner = THIS_MODULE
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 35d8b30d1f25..508a168fddaa 100644
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

