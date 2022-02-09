Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74906C433FE
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 08:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbiBIIVf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 03:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiBIIVe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 03:21:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCB4C0613CA;
        Wed,  9 Feb 2022 00:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QzwLw7j8eTvZsRbJglcJOtBbwWYohx/2fo0FBI/zHLQ=; b=qbb/LvbPae0W4D0XDY2KH6i5fw
        dJv0VcVaAkIjaEQGX9kfyAJotc73hbJOcdVNLPTfpDK6F/vmR+B/1rzA05qjG9NYhOPcA/GE5oOR1
        gPhQGJ4/xEWDoM/g9UnM1NbmhmrG6tgdbQHSdx13abiMUlPG5CtDzsiNB7Vwyf3T2pp4Vj67i2rYN
        Kfs2+waN6YecrlZyF5x7oeSuA44uvdz3CtLALgvr7UOUbDtm9HEGNwtP0RCRKCwD6E4fgy6tBnVcX
        9tbJq2T4MZ5UTXB7L5OnO1ItjqFxg7SQcH6gjMH95ehITZJuTEVgb4bWEjf9Fu4i/9M9CdnZOqNUP
        KQ4qE5dg==;
Received: from [2001:4bb8:188:3efc:ea2:7599:7eeb:4b5a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHiEG-00GbBT-Vq; Wed, 09 Feb 2022 08:21:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 3/5] memstick/mspro_block: fix handling of read-only devices
Date:   Wed,  9 Feb 2022 09:21:18 +0100
Message-Id: <20220209082121.2628452-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209082121.2628452-1-hch@lst.de>
References: <20220209082121.2628452-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use set_disk_ro to propagate the read-only state to the block layer
instead of checking for it in ->open and leaking a reference in case
of a read-only device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/memstick/core/mspro_block.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index c0450397b6735..7ea312f0840e0 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -186,13 +186,8 @@ static int mspro_block_bd_open(struct block_device *bdev, fmode_t mode)
 
 	mutex_lock(&mspro_block_disk_lock);
 
-	if (msb && msb->card) {
+	if (msb && msb->card)
 		msb->usage_count++;
-		if ((mode & FMODE_WRITE) && msb->read_only)
-			rc = -EROFS;
-		else
-			rc = 0;
-	}
 
 	mutex_unlock(&mspro_block_disk_lock);
 
@@ -1239,6 +1234,9 @@ static int mspro_block_init_disk(struct memstick_dev *card)
 	set_capacity(msb->disk, capacity);
 	dev_dbg(&card->dev, "capacity set %ld\n", capacity);
 
+	if (msb->read_only)
+		set_disk_ro(msb->disk, true);
+
 	rc = device_add_disk(&card->dev, msb->disk, NULL);
 	if (rc)
 		goto out_cleanup_disk;
-- 
2.30.2

