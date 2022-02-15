Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891F2C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 09:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbiBOJpr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 04:45:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbiBOJpo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 04:45:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A1AE61E1;
        Tue, 15 Feb 2022 01:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QzwLw7j8eTvZsRbJglcJOtBbwWYohx/2fo0FBI/zHLQ=; b=KFBBkcir0Gjj7a6jdeW8oy/0tu
        yEN93eOfiPFKOZWq43GZvKKP+Ru3bHGuy2gH3s8jlv7yRpo4e6JTFlqwqVzyvuKdQnAravZUnMs+n
        crXaizk2u8HF+rbgGwgSIgExcHurmzKa9/QEsoHRaVhRxBH00bDa92gsDBkypLVrACgZNcBwwW04b
        wYdpngs8cCE3p8YVQqkXQGh9XXaaJM/x6yaju77D4ccB/Gc89bC3p1usLf8kcINNyD42Oc7QvoOCn
        k7aReUE0jqd8dvviej3PbCilN9MNiOtyU2807LpbUXGbqXCsawMG92BCan9qTtYRDcW03k4V292Ay
        mftApjNA==;
Received: from [2001:4bb8:184:543c:6bdf:22f4:7f0a:fe97] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJuOj-002648-KX; Tue, 15 Feb 2022 09:45:26 +0000
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
Date:   Tue, 15 Feb 2022 10:45:12 +0100
Message-Id: <20220215094514.3828912-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215094514.3828912-1-hch@lst.de>
References: <20220215094514.3828912-1-hch@lst.de>
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

