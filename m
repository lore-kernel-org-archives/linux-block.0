Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07176C433FE
	for <linux-block@archiver.kernel.org>; Mon, 14 Nov 2022 04:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiKNE0r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Nov 2022 23:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbiKNE0p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Nov 2022 23:26:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7656BE1C
        for <linux-block@vger.kernel.org>; Sun, 13 Nov 2022 20:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xHigtz3XdnkNZRvwViOPYm+cRW4fwlHM+9uzpVde0bA=; b=oEaq5yoRc9LnOnM+hrbm4RnTU+
        nznT/d3Qb2Ex4vGk18hmLTrY7Dd96jMge/VPDjMttiOFrZlDOUTDxo4ruKYwILQ58TkFPPskWFCbd
        UVpzGFwNs4ir+Lqx+YtqOMfZfU5jJynkj2zDV9/1Y+0VPZN9Byw8bzou0U3TdGCFZEX13FVU1D++O
        Lh5stfUAKX9bUIRdw4Lx7XebqT3MhozcszvRaQ4ROWWgHO+2Cj76m8qn/J4V6C/uU04vtjVkwER1j
        bjfDTVX83mwAVOgWaQiGenhI8YfX0FON3kV/nLWXX7IRzBwjO1jH/G8orU26pBS042Df8zzQ7+XZu
        XMnxblcA==;
Received: from [2001:4bb8:191:2606:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouR3T-00Fv5F-4d; Mon, 14 Nov 2022 04:26:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 1/5] blk-crypto: pass a gendisk to blk_crypto_sysfs_{,un}register
Date:   Mon, 14 Nov 2022 05:26:33 +0100
Message-Id: <20221114042637.1009333-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221114042637.1009333-1-hch@lst.de>
References: <20221114042637.1009333-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for changes to the block layer sysfs handling by passing the
readily available gendisk to blk_crypto_sysfs_{,un}register.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-crypto-internal.h | 10 ++++++----
 block/blk-crypto-sysfs.c    |  7 ++++---
 block/blk-sysfs.c           |  4 ++--
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index e6818ffaddbf8..b8a00847171f6 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -21,9 +21,9 @@ extern const struct blk_crypto_mode blk_crypto_modes[];
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 
-int blk_crypto_sysfs_register(struct request_queue *q);
+int blk_crypto_sysfs_register(struct gendisk *disk);
 
-void blk_crypto_sysfs_unregister(struct request_queue *q);
+void blk_crypto_sysfs_unregister(struct gendisk *disk);
 
 void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
 			     unsigned int inc);
@@ -67,12 +67,14 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
-static inline int blk_crypto_sysfs_register(struct request_queue *q)
+static inline int blk_crypto_sysfs_register(struct gendisk *disk)
 {
 	return 0;
 }
 
-static inline void blk_crypto_sysfs_unregister(struct request_queue *q) { }
+static inline void blk_crypto_sysfs_unregister(struct gendisk *disk)
+{
+}
 
 static inline bool bio_crypt_rq_ctx_compatible(struct request *rq,
 					       struct bio *bio)
diff --git a/block/blk-crypto-sysfs.c b/block/blk-crypto-sysfs.c
index fd93bd2f33b75..e05f145cd797f 100644
--- a/block/blk-crypto-sysfs.c
+++ b/block/blk-crypto-sysfs.c
@@ -126,8 +126,9 @@ static struct kobj_type blk_crypto_ktype = {
  * If the request_queue has a blk_crypto_profile, create the "crypto"
  * subdirectory in sysfs (/sys/block/$disk/queue/crypto/).
  */
-int blk_crypto_sysfs_register(struct request_queue *q)
+int blk_crypto_sysfs_register(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
 	struct blk_crypto_kobj *obj;
 	int err;
 
@@ -149,9 +150,9 @@ int blk_crypto_sysfs_register(struct request_queue *q)
 	return 0;
 }
 
-void blk_crypto_sysfs_unregister(struct request_queue *q)
+void blk_crypto_sysfs_unregister(struct gendisk *disk)
 {
-	kobject_put(q->crypto_kobject);
+	kobject_put(disk->queue->crypto_kobject);
 }
 
 static int __init blk_crypto_sysfs_init(void)
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 02e94c4beff17..bd223a3bef47d 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -836,7 +836,7 @@ int blk_register_queue(struct gendisk *disk)
 			goto put_dev;
 	}
 
-	ret = blk_crypto_sysfs_register(q);
+	ret = blk_crypto_sysfs_register(disk);
 	if (ret)
 		goto put_dev;
 
@@ -913,7 +913,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	 */
 	if (queue_is_mq(q))
 		blk_mq_sysfs_unregister(disk);
-	blk_crypto_sysfs_unregister(q);
+	blk_crypto_sysfs_unregister(disk);
 
 	mutex_lock(&q->sysfs_lock);
 	elv_unregister_queue(q);
-- 
2.30.2

