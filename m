Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF771C433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE7122D05
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbhALE2f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 23:28:35 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:60620 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730406AbhALE2f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 23:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610425715; x=1641961715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b7JlLdLhTEJHSJkJ2Ot7J3cXNRNUJqtnFvAN4lx8PoE=;
  b=dE3uWV6TSdd+FCFGvPPTuNkW3Z/IfxTgnXuFxXAflsKzAvpLr5WV3J1g
   /GNEBCvf5vIh17dQoV1Iqbrev51nrKaeKJf/IJa/nVMTpeCp/1Cp/Q/iV
   nN1eFZ4NLgxECigg3GmXT1GnsO2B9KeUlp6uJmcJdoBUc3iYGzrEau9SK
   pm6EIQf893zeqFWWes5wV8Q+1ELZQvCLFE/Qz0osxwiB0TSTwovvycNap
   OHx21MOnGh+JyON5InRtCUbCo0ecfzG2BoNJQmxf0rktoN64BeQpR5K/3
   VeBXoQsEDK9z/8yJVyVPsQCqCbAq7JlXVOe99GEXgfSdDg79wLCxLz/qn
   Q==;
IronPort-SDR: VOIw82T3DeXshPYcAmQGoE7TOSLrJKmxJWPEeEnmIV8gCN3h2MbwALdAABsv5QrWsQ8GT7nf9A
 lLVL37k1nSYy9VITc7hssC7DTp/2sZy4AwruTA4yeTmxMQtaMV9UaUJ4CNFluoxMigQa4PyoYu
 s61dRh5z9uQdlD/XEyhKnc+1ejuX3rWrjMXFIiS+1kiKr+0WmrqfyqQx5syt2HQafvMdXUj/rK
 S3cd+9p0fqK6kvQI/W2pTJv8VLowOCI+LG28QuQZwNV0xzTp336iORIhRHlIO0lOiT91+IMLN/
 05g=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="158381152"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:27:29 +0800
IronPort-SDR: Ns/zCeppbo4+D88zZtNZL9vGwZjbBmgSyMhJPdWRXrKvxQkw2J1PYGZoobGuAuLl5weY0hNvVr
 aR/JJAUpU6bTihXun+bvWkMYJuUqfDxLrysv4xfsk/iMdmExsegm70Vc9UFP9KlLq3Ti/QLA+/
 KnaXGeei7yhyX0dnh7YV8jhvF7L4ln6QcIUEINx64dwB2OHrCR373jyYalzjY0nLmvRRKMEhSc
 zxLbfRozZqMHDVCx5Il7HrSWZD1u3POi+e+4pXuKLSXqSlfWkOhOeAN2D8HAstxSxOdk6xqMjD
 iLhj7PwTWiPphKLUbJgNXYXZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 20:10:22 -0800
IronPort-SDR: o/sg1RlO55nBZvuaf2UOWUKg+CwrJQNyX5ExWX1SiQ1CQgy3BqgOm1LU6PVb42JWsHrs1QDrz3
 J4uJFV4zVQf6HISX5Eyak8w1215IcPdF0qV6tiyMi7rmneB27b5IacvY31BmKRQmfMifwJdI6O
 ilxFN4yx2Lcch6etVa3iripRW7bx1OkyKCMAqN0sVauyJcMtAb19GNvzUQFF7IAq+s35HG8MzY
 OyGtGIawg02tKIBBBAuIliFJgPfrBuIYFc4kVsoQYs7Xf1YHt4zwOXnUpOZml5byXfy6e9HCE5
 GNM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:27:29 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V9 6/9] nvmet: add bio init helper for different backends
Date:   Mon, 11 Jan 2021 20:26:20 -0800
Message-Id: <20210112042623.6316-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the addition of the zns backend now we have two different backends
with the same bio initialization code. That leads to having duplicate
code in two backends: generic bdev and generic zns.

Add a helper function to reduce the duplicate code such that helper
function initializes the various bio initialization parameters such as
bio block device, op flags, sector, end io callback, and private member,

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  6 +-----
 drivers/nvme/target/nvmet.h       | 11 +++++++++++
 drivers/nvme/target/zns.c         |  6 +++---
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 72746e29cb0d..b1fb0bb1f39f 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -267,11 +267,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 
 	bio = nvmet_req_bio_get(req, NULL);
-	bio_set_dev(bio, req->ns->bdev);
-	bio->bi_iter.bi_sector = sector;
-	bio->bi_private = req;
-	bio->bi_end_io = nvmet_bio_done;
-	bio->bi_opf = op;
+	nvmet_bio_init(bio, req->ns->bdev, op, sector, req, nvmet_bio_done);
 
 	blk_start_plug(&plug);
 	if (req->metadata_len)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 3fc84f79cce1..1ec9e1b35c67 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -668,4 +668,15 @@ static inline struct bio *nvmet_req_bio_get(struct nvmet_req *req,
 	return bio;
 }
 
+static inline void nvmet_bio_init(struct bio *bio, struct block_device *bdev,
+				  unsigned int op, sector_t sect, void *private,
+				  bio_end_io_t *bi_end_io)
+{
+	bio_set_dev(bio, bdev);
+	bio->bi_opf = op;
+	bio->bi_iter.bi_sector = sect;
+	bio->bi_private = private;
+	bio->bi_end_io = bi_end_io;
+}
+
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index c32e93a3c7e1..92213bed0006 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -281,6 +281,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 {
 	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 	struct request_queue *q = req->ns->bdev->bd_disk->queue;
+	unsigned int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
 	unsigned int max_sects = queue_max_zone_append_sectors(q);
 	u16 status = NVME_SC_SUCCESS;
 	unsigned int total_len = 0;
@@ -297,9 +298,8 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	}
 
 	bio = nvmet_req_bio_get(req, NULL);
-	bio_set_dev(bio, req->ns->bdev);
-	bio->bi_iter.bi_sector = sect;
-	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
+	nvmet_bio_init(bio, req->ns->bdev, op, sect, NULL, NULL);
+
 	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
 		bio->bi_opf |= REQ_FUA;
 
-- 
2.22.1

