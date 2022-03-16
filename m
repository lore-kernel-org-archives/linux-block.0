Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119D1C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 08:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354595AbiCPIq6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 04:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354620AbiCPIq6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 04:46:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3196264BE4
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 01:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wG748xja2qha/1f4Jrn2/OTebVsKlo5KlY91E/Gevs8=; b=HCgK6cSUBgs+0lVtKCAVamt/el
        FS81Q2mnNH09U+ibJRvlfrLM1dznfx8OvpWmnahb3IDxG2curGIKVvENU4svrD7LhJHyP1JrSJ4zl
        LqqfVzdXSGvx6H6vIHwKo+RZZgW/fEzd6gSQRJcKQO2Qxy561+fF+3lfufTcLnaL8w8vTAMZSL0xH
        BNlmem7azFhKHT/cifHqn3Cn1g424k2ZCurBV7U2ZeWBOZstgkxHYUa4A66yYaXjMkSZjsmCVHy+n
        e+TJ6WoL2SB3U/t/27zFWzDkNxidF8PhgGrhxoe4BOjHqWT4NHKCcmlscfhXFFcrwdtK9uuWn94uq
        kL3Q5/Eg==;
Received: from [46.140.54.162] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUPHn-00CCFX-Bq; Wed, 16 Mar 2022 08:45:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/8] loop: implement ->free_disk
Date:   Wed, 16 Mar 2022 09:45:17 +0100
Message-Id: <20220316084519.2850118-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316084519.2850118-1-hch@lst.de>
References: <20220316084519.2850118-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ensure that the lo_device which is stored in the gendisk private
data is valid until the gendisk is freed.  Currently the loop driver
uses a lot of effort to make sure a device is not freed when it is
still in use, but to to fix a potential deadlock this will be relaxed
a bit soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0813f63d5bbd2..cbaa18bcad1fe 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1765,6 +1765,14 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 	mutex_unlock(&lo->lo_mutex);
 }
 
+static void lo_free_disk(struct gendisk *disk)
+{
+	struct loop_device *lo = disk->private_data;
+
+	mutex_destroy(&lo->lo_mutex);
+	kfree(lo);
+}
+
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
 	.open =		lo_open,
@@ -1773,6 +1781,7 @@ static const struct block_device_operations lo_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl =	lo_compat_ioctl,
 #endif
+	.free_disk =	lo_free_disk,
 };
 
 /*
@@ -2064,14 +2073,13 @@ static void loop_remove(struct loop_device *lo)
 {
 	/* Make this loop device unreachable from pathname. */
 	del_gendisk(lo->lo_disk);
-	blk_cleanup_disk(lo->lo_disk);
+	blk_cleanup_queue(lo->lo_disk->queue);
 	blk_mq_free_tag_set(&lo->tag_set);
 	mutex_lock(&loop_ctl_mutex);
 	idr_remove(&loop_index_idr, lo->lo_number);
 	mutex_unlock(&loop_ctl_mutex);
-	/* There is no route which can find this loop device. */
-	mutex_destroy(&lo->lo_mutex);
-	kfree(lo);
+
+	put_disk(lo->lo_disk);
 }
 
 static void loop_probe(dev_t dev)
-- 
2.30.2

