Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B656EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbiGNSIt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbiGNSIm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:42 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672907665
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:39 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso3864874pjh.1
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E07NoOAxOLwJ9+SgKQCgjb7uv/M3sfpG+Jo6OvzoUeA=;
        b=x9aB/lqMWsk3MA9//LYWAGMclJEZNEMopk9auR/PQa1nxFluI2T3xiVA6jPigoZrvH
         Nc/61v36X8okEUJX7hABy4mLLt4sZE8gPj1sw8AQPt9Ungff9SvPM1PwbhMk/mOS58kJ
         SqZ3QXgxuDBpLX+sbaawHeRFGrdxMpfnjKQaTJwpdRKbWC4wgCKHjF+jmz6VXDB7Nmr+
         +Ln5wPi9yE10NkJNrpGOUif7LYXF0sRgiBwVd8qI94YdFP/wckgVM3ftNhWMlc1NiEbU
         R8XpqaLEcIK0Rep0KEju73p0QG43n1kBpOcYR4CWtf+0vJfN/tAkTzmzPOa7Np/A7EeD
         VJtA==
X-Gm-Message-State: AJIora9jtPG5l+RnxGjQaBsdpIMAbdxhku6fu3yFg+Q2UiXNGP0XMwfb
        AXz1lQFUueLza13Yz8Isrc7PaLKyZeE=
X-Google-Smtp-Source: AGRyM1svFy2PBnslwRvDkgB3GziDRXxoIj+mPpInq20x1FF5e0n9zC6Kh5AChir8eJ2ZOtQGvJynrw==
X-Received: by 2002:a17:902:d2cf:b0:16c:223e:a3e8 with SMTP id n15-20020a170902d2cf00b0016c223ea3e8mr9582860plc.125.1657822117839;
        Thu, 14 Jul 2022 11:08:37 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:37 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 38/63] nvme/target: Use the new blk_opf_t type
Date:   Thu, 14 Jul 2022 11:07:04 -0700
Message-Id: <20220714180729.1065367-39-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for variables
that represent a request operation combined with request flags. Rename
those variables from 'op' into 'opf'.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 17 +++++++++--------
 drivers/nvme/target/zns.c         |  6 +++---
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 27a72504d31c..2dc1c1035626 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -246,7 +246,8 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	struct scatterlist *sg;
 	struct blk_plug plug;
 	sector_t sector;
-	int op, i, rc;
+	blk_opf_t opf;
+	int i, rc;
 	struct sg_mapping_iter prot_miter;
 	unsigned int iter_flags;
 	unsigned int total_len = nvmet_rw_data_len(req) + req->metadata_len;
@@ -260,26 +261,26 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	}
 
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
-		op = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
+		opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
-			op |= REQ_FUA;
+			opf |= REQ_FUA;
 		iter_flags = SG_MITER_TO_SG;
 	} else {
-		op = REQ_OP_READ;
+		opf = REQ_OP_READ;
 		iter_flags = SG_MITER_FROM_SG;
 	}
 
 	if (is_pci_p2pdma_page(sg_page(req->sg)))
-		op |= REQ_NOMERGE;
+		opf |= REQ_NOMERGE;
 
 	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 
 	if (nvmet_use_inline_bvec(req)) {
 		bio = &req->b.inline_bio;
 		bio_init(bio, req->ns->bdev, req->inline_bvec,
-			 ARRAY_SIZE(req->inline_bvec), op);
+			 ARRAY_SIZE(req->inline_bvec), opf);
 	} else {
-		bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt), op,
+		bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt), opf,
 				GFP_KERNEL);
 	}
 	bio->bi_iter.bi_sector = sector;
@@ -306,7 +307,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 			}
 
 			bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt),
-					op, GFP_KERNEL);
+					opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = sector;
 
 			bio_chain(bio, prev);
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index b233c0943fec..c7ef69f29fe4 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -525,7 +525,7 @@ static void nvmet_bdev_zone_append_bio_done(struct bio *bio)
 void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 {
 	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
-	const unsigned int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
+	const blk_opf_t opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
 	u16 status = NVME_SC_SUCCESS;
 	unsigned int total_len = 0;
 	struct scatterlist *sg;
@@ -556,9 +556,9 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	if (nvmet_use_inline_bvec(req)) {
 		bio = &req->z.inline_bio;
 		bio_init(bio, req->ns->bdev, req->inline_bvec,
-			 ARRAY_SIZE(req->inline_bvec), op);
+			 ARRAY_SIZE(req->inline_bvec), opf);
 	} else {
-		bio = bio_alloc(req->ns->bdev, req->sg_cnt, op, GFP_KERNEL);
+		bio = bio_alloc(req->ns->bdev, req->sg_cnt, opf, GFP_KERNEL);
 	}
 
 	bio->bi_end_io = nvmet_bdev_zone_append_bio_done;
