Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95766C4332F
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 07:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiCXHxE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 03:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348730AbiCXHxD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 03:53:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB8399682
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=A2Q06m/LYxunrDsvF/NawvPuXR8LHtFwXlMKubqZCD8=; b=E1PoEhrblmHGtnsD1hoHW5N4Ts
        uiUzSN8qWVHazv8sKZQ9FmxD+OnNgMMJMJiFSy/d+7Jkx5wCk3CLvNAcjXbjMOJxGNQyq1JHTGd0C
        QEpqnAFxt+WdxyPjx1VsvK0uoZq4MIoDXYZ6ciR3pORdpZ94UpTYfByTtLfSyRRarJNkj30DBVZVC
        OUAYuxc+IXrF52Vlw3o2sKMZtFiMiM/wG01eG3A+zRcsTyW814qukpwYXPnAmPatFKUmOqwLYI64a
        VhNktVUU2AQk1FbgJ0r7y8d5PsXuG0zt6KLpBbYDio1Lc38nDeauFX+dQ80Amm87vmob26ygpEhSp
        EVuEHy7Q==;
Received: from [2001:4bb8:19a:b822:f71:16c0:5841:924e] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXIFf-00FzTR-Hz; Thu, 24 Mar 2022 07:51:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: [PATCH 01/13] nbd: use the correct block_device in nbd_ioctl
Date:   Thu, 24 Mar 2022 08:51:07 +0100
Message-Id: <20220324075119.1556334-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220324075119.1556334-1-hch@lst.de>
References: <20220324075119.1556334-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The bdev parameter to ->ioctl contains the block device that the ioctl
is called on, which can be the partition.  But the code in nbd_ioctl
that uses it really wants the whole device for things like the bd_openers
check.  Switch to not pass the bdev along and always use nbd->disk->part0
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/nbd.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5a1f98494dddf..795f65a5c9661 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1217,11 +1217,11 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 	return -ENOSPC;
 }
 
-static void nbd_bdev_reset(struct block_device *bdev)
+static void nbd_bdev_reset(struct nbd_device *nbd)
 {
-	if (bdev->bd_openers > 1)
+	if (nbd->disk->part0->bd_openers > 1)
 		return;
-	set_capacity(bdev->bd_disk, 0);
+	set_capacity(nbd->disk, 0);
 }
 
 static void nbd_parse_flags(struct nbd_device *nbd)
@@ -1389,7 +1389,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config));
 }
 
-static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *bdev)
+static int nbd_start_device_ioctl(struct nbd_device *nbd)
 {
 	struct nbd_config *config = nbd->config;
 	int ret;
@@ -1408,7 +1408,7 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 	flush_workqueue(nbd->recv_workq);
 
 	mutex_lock(&nbd->config_lock);
-	nbd_bdev_reset(bdev);
+	nbd_bdev_reset(nbd);
 	/* user requested, ignore socket errors */
 	if (test_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags))
 		ret = 0;
@@ -1417,12 +1417,11 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 	return ret;
 }
 
-static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
-				 struct block_device *bdev)
+static void nbd_clear_sock_ioctl(struct nbd_device *nbd)
 {
 	sock_shutdown(nbd);
-	__invalidate_device(bdev, true);
-	nbd_bdev_reset(bdev);
+	__invalidate_device(nbd->disk->part0, true);
+	nbd_bdev_reset(nbd);
 	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
 			       &nbd->config->runtime_flags))
 		nbd_config_put(nbd);
@@ -1448,7 +1447,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 	case NBD_DISCONNECT:
 		return nbd_disconnect(nbd);
 	case NBD_CLEAR_SOCK:
-		nbd_clear_sock_ioctl(nbd, bdev);
+		nbd_clear_sock_ioctl(nbd);
 		return 0;
 	case NBD_SET_SOCK:
 		return nbd_add_socket(nbd, arg, false);
@@ -1468,7 +1467,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		config->flags = arg;
 		return 0;
 	case NBD_DO_IT:
-		return nbd_start_device_ioctl(nbd, bdev);
+		return nbd_start_device_ioctl(nbd);
 	case NBD_CLEAR_QUE:
 		/*
 		 * This is for compatibility only.  The queue is always cleared
-- 
2.30.2

