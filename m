Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E71AC432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CB020661
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ThXy0ykT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfLCJjS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:39:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfLCJjR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 04:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cl6DErnYywuBNiTuVq8pI49RhMOPOBTZno8uKgIYA2g=; b=ThXy0ykTmjuL99/vFcjNKNW2VJ
        mq6E169ELOvmlmj4pZdfSww7SUZnCfRwCypnkZmdiKYDX0c7rBkkRuAEPgxoFJL83jPZOQd+JHZe0
        TqYo59ACJ51BkKKF+qbWBoBksmvGuKOINCYJcRCTz/b35zCIHI7iHLX/WQTVYXHo5khT5no2/G7+M
        eVVCKLQcRMSBzQoKwC0CM17MKLvJuKuMQBbr6nyNxwb553cWctRl4UJP8ce/u3J0xbcEONkyWyw0o
        Xlh4uGtahOC2d5V7DudDI97dT7VoWQFx3OFY4qX3eIxob2dmxT9MZiOXsXReKBu4Bml/Q9Z+8oy0T
        IEnZPe9w==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic4eJ-00025H-KD; Tue, 03 Dec 2019 09:39:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
Subject: [PATCH 2/8] null_blk: cleanup null_gendisk_register
Date:   Tue,  3 Dec 2019 10:39:02 +0100
Message-Id: <20191203093908.24612-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191203093908.24612-1-hch@lst.de>
References: <20191203093908.24612-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use a saner size calculation, and do a trivial cleanup on the zone
revalidation to prepare to future changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/null_blk_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 53ba9c7f2786..dd6026289fbf 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1559,14 +1559,14 @@ static int init_driver_queues(struct nullb *nullb)
 
 static int null_gendisk_register(struct nullb *nullb)
 {
+	sector_t size = ((sector_t)nullb->dev->size * SZ_1M) >> SECTOR_SHIFT;
 	struct gendisk *disk;
-	sector_t size;
+	int ret;
 
 	disk = nullb->disk = alloc_disk_node(1, nullb->dev->home_node);
 	if (!disk)
 		return -ENOMEM;
-	size = (sector_t)nullb->dev->size * 1024 * 1024ULL;
-	set_capacity(disk, size >> 9);
+	set_capacity(disk, size);
 
 	disk->flags |= GENHD_FL_EXT_DEVT | GENHD_FL_SUPPRESS_PARTITION_INFO;
 	disk->major		= null_major;
@@ -1577,9 +1577,8 @@ static int null_gendisk_register(struct nullb *nullb)
 	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
 
 	if (nullb->dev->zoned) {
-		int ret = blk_revalidate_disk_zones(disk);
-
-		if (ret != 0)
+		ret = blk_revalidate_disk_zones(disk);
+		if (ret)
 			return ret;
 	}
 
-- 
2.20.1

