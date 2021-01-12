Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C243C433E0
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBDA22D2A
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbhALE1z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 23:27:55 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42623 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbhALE1z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 23:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610425675; x=1641961675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+dzMfelXKXKTtvlSdWk9DFOOoxVVf6e3u02T42xzOzM=;
  b=m3qLDUDSTylXMRUV/syV7FhNHqYCK63njIcTu37JGi9LYTTndgm8E4l0
   vITzFu6W/+XeusAZnsGFLvJBOlSG8JTXSxxcbEWm7oSi135S4HOxL743E
   yyEo+kOgqhM4TUXb9enxTW1JzgJr6QH2Xk1YFwtg4Dg8wnP4gKhbxfm90
   xgg53RQWWNcD+J8VCjJwdauGRljbYx1dDZzbkjg46mShscrjkE+K0EP3o
   ZkTE1FOGOpn0MXkvS1m6ewHnrcHwsY+iXrh+niZLLnMxG1+as7xnDfGTC
   L7wnqs6v2flZ1Avz3AZvMbEAhtUnqDPkKzClO5LoTmykXrYv1MxJ60O1i
   g==;
IronPort-SDR: 7FGhWyqfYaObv5ON45zAIoI6Vkfm7uavj2A2H6velOZVjZBvBL6GDQymz7ZSXY4skIr7etxFHM
 2s8g3zU62p+IZ0TG5W5LySSf9gqLbe6ij2e9qRUt49R/+wgxNNWRZtGIasRZBEBf9s1qsd7O7E
 rgci1aoWIgnOn9f2E41kS8YH2DdgZo2zHrchzyHwQerjznWk+7ftc0tD2B0E2baW1WpPkTu3CV
 KfQLQfERUqByA1umOpHXnGudpoURQf93RKRj4r2GPYNu7Lnbj/oB7Km8CHnCyrQp26UyM/0cww
 mII=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="267504787"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:26:49 +0800
IronPort-SDR: lg4u8IOroxriMYnGtsTVload1teXtVaqN3DjzFk3ydi4oDz9zVyM69yxXA6jjoB0Oc6GQV6NVF
 WoBDOwK1b344AUUDotal6pJHrRxEv6oWglcZeYEn5iTkwzsql6Ni511RGdo2eeqzEhnLxL7tYC
 qGM1kctA/AUavhcsfj+PHTDUPtYNkVaM0R5Pb+UzTS7yeUq0teGLbxkRd1jdJ0uHVA09gQ3TuZ
 Uq46MQy89dD2F5e/uzu5KZAu44ncJFeBGacuYoSYuiXWylVbQH76qyoIc9rumU7bquykq/vI7V
 ej0auU8/Hct78cJ+gVL7HSs+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 20:11:35 -0800
IronPort-SDR: TL3SMAN4xBZTCWgOcB7qrMyfXMq+v+dIkYcgd8fk8wm/f0XrOO7oKqKfN6qbvV81ui7rbbUL+D
 jYYVBqeZTPdsnA0SWeIOLBJ+vgFR9dOG+Ey7HKAa5NBWHp1R6VVemmMlhFYk/KVecLUqCwrzn1
 OZ6Um8+0/xsCkbYy/nU7ojODUrrkPU1I/AVyHghuDphaFIJ9bPd96jTIp1w1+xGLfR9+dPXBnj
 SOiXrsH9cstotShUvkwy4s/4L7nFk6+j06UVVjRaFG/QB/DqUGzPOU+AwASS9WDIKc9i1oUCEU
 U8E=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:26:49 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V9 2/9] nvmet: add lba to sect conversion helpers
Date:   Mon, 11 Jan 2021 20:26:16 -0800
Message-Id: <20210112042623.6316-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In this preparation patch, we add helpers to convert lbas to sectors &
sectors to lba. This is needed to eliminate code duplication in the ZBD
backend.

Use these helpers in the block device backend.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  8 +++-----
 drivers/nvme/target/nvmet.h       | 10 ++++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 125dde3f410e..23095bdfce06 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -256,8 +256,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	if (is_pci_p2pdma_page(sg_page(req->sg)))
 		op |= REQ_NOMERGE;
 
-	sector = le64_to_cpu(req->cmd->rw.slba);
-	sector <<= (req->ns->blksize_shift - 9);
+	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 
 	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
 		bio = &req->b.inline_bio;
@@ -345,7 +344,7 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
 	int ret;
 
 	ret = __blkdev_issue_discard(ns->bdev,
-			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),
+			nvmet_lba_to_sect(ns, range->slba),
 			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
 			GFP_KERNEL, 0, bio);
 	if (ret && ret != -EOPNOTSUPP) {
@@ -414,8 +413,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
-	sector = le64_to_cpu(write_zeroes->slba) <<
-		(req->ns->blksize_shift - 9);
+	sector = nvmet_lba_to_sect(req->ns, write_zeroes->slba);
 	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
 		(req->ns->blksize_shift - 9));
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 592763732065..8776dd1a0490 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -603,4 +603,14 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
 	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
 }
 
+static inline __le64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)
+{
+	return cpu_to_le64(sect >> (ns->blksize_shift - SECTOR_SHIFT));
+}
+
+static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
+{
+	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
+}
+
 #endif /* _NVMET_H */
-- 
2.22.1

