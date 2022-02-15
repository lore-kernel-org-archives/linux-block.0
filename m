Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FB0C4167E
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 09:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbiBOJpr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 04:45:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiBOJpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 04:45:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C6AE61E1;
        Tue, 15 Feb 2022 01:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HHdkFhXzph/YEDr3VFGzAg3QAN/EIa/uRvErt377FsM=; b=OkuenPis41IFgBaM7GOBx+GoBK
        9Gbf5tI7j+blagAr7HYn3WE4vnD8rAZLBYazaOyavFkwC17i6lSD8ibCG3/G1qmM0bBJI6HqVFxom
        RSNbalhzQV9kGnwGFLJUCMIicfLdIvFfzvFPcAjgOkFIDz81OjQWJRhhs/SCUpA/q6dSFM1V0x+ow
        nUOGnLPogfOMYEhoN2bS7CyCB80fgLFEFNLqZ/CrYOPlT36Bzt9MMlos/Irn8mqaHca4vJ6EcEp7+
        glZRgGjQ7HlxbJDHHvmNVAzCYUDgu7sF/uXfg9qivXl91PuQRBMpC7gJlmtNSN7UIKjcoBV1EKKVr
        xTbxIigw==;
Received: from [2001:4bb8:184:543c:6bdf:22f4:7f0a:fe97] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJuOm-00265t-C9; Tue, 15 Feb 2022 09:45:28 +0000
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
Subject: [PATCH 4/5] memstick/mspro_block: simplify refcounting
Date:   Tue, 15 Feb 2022 10:45:13 +0100
Message-Id: <20220215094514.3828912-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215094514.3828912-1-hch@lst.de>
References: <20220215094514.3828912-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Implement the ->free_disk method to free the msb_data structure only once
the last gendisk reference goes away instead of keeping a local
refcount.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/memstick/core/mspro_block.c | 49 +++++------------------------
 1 file changed, 7 insertions(+), 42 deletions(-)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index 7ea312f0840e0..725ba74ded308 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -133,7 +133,6 @@ struct mspro_devinfo {
 
 struct mspro_block_data {
 	struct memstick_dev   *card;
-	unsigned int          usage_count;
 	unsigned int          caps;
 	struct gendisk        *disk;
 	struct request_queue  *queue;
@@ -178,48 +177,16 @@ static int mspro_block_complete_req(struct memstick_dev *card, int error);
 
 /*** Block device ***/
 
-static int mspro_block_bd_open(struct block_device *bdev, fmode_t mode)
-{
-	struct gendisk *disk = bdev->bd_disk;
-	struct mspro_block_data *msb = disk->private_data;
-	int rc = -ENXIO;
-
-	mutex_lock(&mspro_block_disk_lock);
-
-	if (msb && msb->card)
-		msb->usage_count++;
-
-	mutex_unlock(&mspro_block_disk_lock);
-
-	return rc;
-}
-
-
-static void mspro_block_disk_release(struct gendisk *disk)
+static void mspro_block_bd_free_disk(struct gendisk *disk)
 {
 	struct mspro_block_data *msb = disk->private_data;
 	int disk_id = MINOR(disk_devt(disk)) >> MSPRO_BLOCK_PART_SHIFT;
 
 	mutex_lock(&mspro_block_disk_lock);
-
-	if (msb) {
-		if (msb->usage_count)
-			msb->usage_count--;
-
-		if (!msb->usage_count) {
-			kfree(msb);
-			disk->private_data = NULL;
-			idr_remove(&mspro_block_disk_idr, disk_id);
-			put_disk(disk);
-		}
-	}
-
+	idr_remove(&mspro_block_disk_idr, disk_id);
 	mutex_unlock(&mspro_block_disk_lock);
-}
 
-static void mspro_block_bd_release(struct gendisk *disk, fmode_t mode)
-{
-	mspro_block_disk_release(disk);
+	kfree(msb);
 }
 
 static int mspro_block_bd_getgeo(struct block_device *bdev,
@@ -235,10 +202,9 @@ static int mspro_block_bd_getgeo(struct block_device *bdev,
 }
 
 static const struct block_device_operations ms_block_bdops = {
-	.open    = mspro_block_bd_open,
-	.release = mspro_block_bd_release,
-	.getgeo  = mspro_block_bd_getgeo,
-	.owner   = THIS_MODULE
+	.owner		= THIS_MODULE,
+	.getgeo		= mspro_block_bd_getgeo,
+	.free_disk	= mspro_block_bd_free_disk,
 };
 
 /*** Information ***/
@@ -1221,7 +1187,6 @@ static int mspro_block_init_disk(struct memstick_dev *card)
 	msb->disk->first_minor = disk_id << MSPRO_BLOCK_PART_SHIFT;
 	msb->disk->minors = 1 << MSPRO_BLOCK_PART_SHIFT;
 	msb->disk->fops = &ms_block_bdops;
-	msb->usage_count = 1;
 	msb->disk->private_data = msb;
 
 	sprintf(msb->disk->disk_name, "mspblk%d", disk_id);
@@ -1339,7 +1304,7 @@ static void mspro_block_remove(struct memstick_dev *card)
 	mspro_block_data_clear(msb);
 	mutex_unlock(&mspro_block_disk_lock);
 
-	mspro_block_disk_release(msb->disk);
+	put_disk(msb->disk);
 	memstick_set_drvdata(card, NULL);
 }
 
-- 
2.30.2

