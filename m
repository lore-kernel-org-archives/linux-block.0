Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FAFC433FE
	for <linux-block@archiver.kernel.org>; Sat,  5 Nov 2022 08:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKEII0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Nov 2022 04:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiKEIIX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Nov 2022 04:08:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC7D2B26B
        for <linux-block@vger.kernel.org>; Sat,  5 Nov 2022 01:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=DdOijYG5VeBUmaqK6SWjUz/jVGdimFT89AXjxt6lFrM=; b=JahA1K7St1AivjxGgDJOyt+HYn
        3flQbKnGs3tTHD92ShQG9Z6TFgTKaMgnsuUNu4tRQOaILXWK6c22CTTrp33ed/xPE4tk7VXUNd384
        6B56tYDCNYDrvgYsplBO1fuPTIZU5CE3sdARzUx7gSI7JT4H7DIJwyyUk9Uih9pUuUi9Jc/aqz58J
        ueDxPpPYrQAWvwbiXKXBkzrKYMwXDGC54zuS3yw2RyOKPIsoG/WEd8AaV8aJw40VS1mDy1MoaaKY7
        WGj+x2i4SiPYE+9kkeCa+M6LuUze3Kwvvu0hvjeo76dB0j5Xy7l2LLGFkZdKy2P0Ximk/2N7N4sP0
        ZkrzZntQ==;
Received: from [2001:4bb8:182:29ca:2575:8443:617d:3eec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1orEDx-0064JF-Uj; Sat, 05 Nov 2022 08:08:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/3] blk-crypto: pass a gendisk to blk_crypto_sysfs_register
Date:   Sat,  5 Nov 2022 09:08:13 +0100
Message-Id: <20221105080815.775721-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for changes to the block layer sysfs handling by passing the
readily available gendisk to blk_crypto_sysfs_register.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-crypto-internal.h | 4 ++--
 block/blk-crypto-sysfs.c    | 3 ++-
 block/blk-sysfs.c           | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index e6818ffaddbf8..32990299dace1 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -21,7 +21,7 @@ extern const struct blk_crypto_mode blk_crypto_modes[];
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 
-int blk_crypto_sysfs_register(struct request_queue *q);
+int blk_crypto_sysfs_register(struct gendisk *disk);
 
 void blk_crypto_sysfs_unregister(struct request_queue *q);
 
@@ -67,7 +67,7 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
-static inline int blk_crypto_sysfs_register(struct request_queue *q)
+static inline int blk_crypto_sysfs_register(struct gendisk *disk)
 {
 	return 0;
 }
diff --git a/block/blk-crypto-sysfs.c b/block/blk-crypto-sysfs.c
index fd93bd2f33b75..a638a2eecfc89 100644
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
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 02e94c4beff17..440149d0e21b9 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -836,7 +836,7 @@ int blk_register_queue(struct gendisk *disk)
 			goto put_dev;
 	}
 
-	ret = blk_crypto_sysfs_register(q);
+	ret = blk_crypto_sysfs_register(disk);
 	if (ret)
 		goto put_dev;
 
-- 
2.30.2

