Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A087AC4361B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7132D23C44
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbgLJG2w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 01:28:52 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45693 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgLJG2v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 01:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607581730; x=1639117730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YrepnEU+9E1QsZlnFlnVsVTqhlODTy9EkUh+6u1821Q=;
  b=YbD6MLdPE6iv614dciqRD7XB0ZKRoa5Lm9/6/vI7qr4Z78ZJ3O0lWN+5
   2W2LvCNISBuyNM5MyLfTsbDqQFexNmQudFE++LjEsrCwWnSLTn+P6jTHD
   DfvwkR1BmbwlyEfHvtI871HdKJWN7cPXO1qXO0zx5uFuDpiSJvcp7z1a4
   yd8dhB5YKn/CwRJLKOYXpq1e+3PC7jwRC4Yl8huGHvD9krp/ZUpcblEDq
   z1moiTxleJLkuRxASEfNfjHrcPa8KY3f/pilhxxMAbQHCL4POPt+B7y86
   Hid20sfmpZPnygp2Klu+IBz4wKovMS1XPBZ4+M9XzeYE5eN/TePozYC3c
   g==;
IronPort-SDR: PVvxOqQuMp4j7/snJH0PzSavJ8j27cm2sskBUBFLfIggsEwnYRjd2z9xmgDgJOl0EuLsXKp6L5
 fKUXfDSu+n82zApTZ+cgbVBBYUDp0R0kvjB+7ig/zOzyE7N8zcSkiYyRgWIaf+U2zUgqONfIkg
 gIk/99rZdGitnDlIZqPg/AIs/69Tgc6NJon3ClnYO1mrO9J4yAcJzYoLnC/i5BmvbBzgVxidEZ
 0/y/TB4qCM1FpO4xaeOL+yB/9JEcZ5J7bbxARjWKMgXA5ObGmrn2ljOD/0p8S7go3FSdOWI6R7
 Akc=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; 
   d="scan'208";a="154820886"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 14:27:45 +0800
IronPort-SDR: O1mXgC62D2lx4X9sSuXGS8EZvqhKwzcq+LNe6W+0DAwrKuzFOdmxvLEdd4/HdFwOjzDLvjlaJ0
 jGEWiLr0soFoUTQKKIEQOmY7n9TcnglZU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 22:13:10 -0800
IronPort-SDR: HmqZoYxzvof/ag7lL5BkZvGgcovkJVzTbGcDCyeQXgkH2sicheS5eSXy9SP1Rfh+b4R3CYRUGG
 8eaqt0XfpO2A==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2020 22:27:46 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V5 6/6] nvmet: add bio get helper for different backends
Date:   Wed,  9 Dec 2020 22:26:22 -0800
Message-Id: <20201210062622.62053-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
References: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the addition of the zns backend now we have three different
backends with inline bio optimization. That leads to having
duplicate code in for allocating or initializing the bio in all
three backends: generic bdev, passsthru, and generic zns.

Add a helper function to reduce the duplicate code such that helper
function accepts the bi_end_io callback which gets initialize for the
non-inline bio_alloc() case. This is due to the special case needed for
the passthru backend non-inline bio allocation bio_alloc() where we set
the bio->bi_end_io = bio_put. For rest of the backends, we set the same
bi_end_io callback for inline and non-inline cases, that is for generic
bdev we set to nvmet_bio_done() and for generic zns we set to NULL.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  7 +------
 drivers/nvme/target/nvmet.h       | 16 ++++++++++++++++
 drivers/nvme/target/passthru.c    |  8 +-------
 drivers/nvme/target/zns.c         |  8 +-------
 4 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0ce6d165dc4f..6ffd84a620e7 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -265,12 +265,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 
 	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 
-	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
-		bio = &req->b.inline_bio;
-		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
-	} else {
-		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
-	}
+	bio = nvmet_req_bio_get(req, NULL);
 	bio_set_dev(bio, req->ns->bdev);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7ef416de4f6f..5d187642a3fa 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -618,6 +618,22 @@ static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
 	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
 }
 
+static inline struct bio *nvmet_req_bio_get(struct nvmet_req *req,
+					    bio_end_io_t *bi_end_io)
+{
+	struct bio *bio;
+
+	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
+		bio = &req->b.inline_bio;
+		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+		return bio;
+	}
+
+	bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
+	bio->bi_end_io = bi_end_io;
+	return bio;
+}
+
 static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 {
 	if (bio != &req->b.inline_bio)
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index c2858ea8cabc..a4a73d64c603 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -194,13 +194,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	if (req->sg_cnt > BIO_MAX_PAGES)
 		return -EINVAL;
 
-	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
-		bio = &req->p.inline_bio;
-		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
-	} else {
-		bio = bio_alloc(GFP_KERNEL, min(req->sg_cnt, BIO_MAX_PAGES));
-		bio->bi_end_io = bio_put;
-	}
+	bio = nvmet_req_bio_get(req, bio_put);
 	bio->bi_opf = req_op(rq);
 
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index d2d1538f92d4..dc841f8ae7b3 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -279,13 +279,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 		return;
 	}
 
-	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
-		bio = &req->b.inline_bio;
-		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
-	} else {
-		bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
-	}
-
+	bio = nvmet_req_bio_get(req, NULL);
 	bio_set_dev(bio, req->ns->bdev);
 	bio->bi_iter.bi_sector = sect;
 	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
-- 
2.22.1

