Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A05C433FE
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 05:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952E22312D
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 05:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgLMFwe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Dec 2020 00:52:34 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4890 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgLMFwd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Dec 2020 00:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607838753; x=1639374753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fsUzpqMK2kJ7sFLk1LyyNvbRs9Aq1ZwOj7Q3hAK3fLU=;
  b=QIKrC5d+xDdrK0vrNSv7R4BavB2Yfo6xmv6vPcH43F8+8RgLDn1KVl3P
   WiWdtzkgLGp56IWAZOH9q1GLY1uWC/X/NwYyNeD9VVYgBhLQdz58Bu9Di
   vYUWLAxrk25+6QzUCwNFQrX6x3T7yTXLuAgB8vhCGIz5bx4C88z0a/vSp
   e/SayDeE+U2p8px4/9qoWcuxr0Y8WXb311eqYd/R+Toxx0M6Kfw+DiHiO
   siHrMgcZwTBjEfFOTVBX2HLsd7t/gw12M6Z7piH1C/Eb6pq5EK/5BZjjZ
   TaHvPcXB8MytEjti4zFaqjrNihcbN6X9BRL0TDsnRgyoqBBGuh7U6o0iU
   Q==;
IronPort-SDR: sUWvVvrjR3vvNmbhDN01UNDjEuLPFNsp7J2sulNN6ITS0cOZXNtEhPsK0B9OQ03ZwgdeCqT+nb
 qVarX5XS8nu5CpO3RY0kfvJbbJ3PGGtDbWRTgLbLuwYyjKYp7Dqhqoo0wdxTnxte2KFKvMOI86
 xySD+EA4SNJBc3mVRP02gzSoW6PDOnxMGNSlb8kRq9+51uPWXOcOl8eyoRBoNtsfW/szHTi1j+
 5APS9B11O4Y59HWeu8PPpLvECWzIszfl6s1pzWNzNwWqpbUf/s/bP0eui13iZqHdocvfNUVu9p
 7jE=
X-IronPort-AV: E=Sophos;i="5.78,415,1599494400"; 
   d="scan'208";a="155065886"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2020 13:51:07 +0800
IronPort-SDR: CxD4XTMYC2UhUZKe+R6BeZ3E4nrRhC2QAFAeMsN7M9tKhzMaUa+vuOIN4IKm8YVZYtqPxhCett
 LukQQxn62L8th++744D/O2MmZnBq86rHGWj+dJREcD4WPoEjpuE9fBrcuWFBToK+xJoSmwBU36
 BmMpEzkqtAaB+5wVpWr/Gyhlg3r3sE62A4Rpcc4XGlg2d7dFz/TgikXBjWpr5cYz8t4Sp+jq86
 XEi2zKR7vV0yRqbm1jbVHjjc+kaPw0paUvzyrwBg0JcNGWdHF3jYtvFuye7O7px2OVa9rMA3gq
 n1j3/AmRNV8H/uhdCggvAdZO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 21:36:29 -0800
IronPort-SDR: ujqV4VBBz1EWImNreZgSTJiWSprCOP+Edif9CfLHtcOSpf/lkC0VY4gpgsR+BklaywtFXinufH
 C7XaopUMiRHb95T44V1JKjEbJ5amRFj9oA/XfpYZ41sq/+eObPMAa9xBBF22Hi9u46/PC8DWBk
 V9wiVP58es5CW/cl4BXwd6reVk9a13JDotxoAzcqPjZZrT7J+GWNDSdTinCcoWIlNEG63nT6QF
 ry8H8TZnpEXM0a5uUA0Wxk6T/5NIWaKT4cBtMca7vOVGEE0U785sxdWY0FWRW92UTH9b5Bd6Lh
 u3o=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2020 21:51:07 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V6 5/6] nvmet: add bio get helper for different backends
Date:   Sat, 12 Dec 2020 21:50:16 -0800
Message-Id: <20201213055017.7141-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
References: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
the bio->bi_end_io = bio_put, having this parameter avoids the extra
branch in the passthru fast path. For rest of the backends, we set the
same bi_end_io callback for inline and non-inline cases, that is for
generic bdev we set to nvmet_bio_done() and for generic zns we set to
NULL.                            

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  7 +------
 drivers/nvme/target/nvmet.h       | 16 ++++++++++++++++
 drivers/nvme/target/passthru.c    |  8 +-------
 drivers/nvme/target/zns.c         |  8 +-------
 4 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 6178ef643962..72746e29cb0d 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -266,12 +266,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 
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
index 7361665585a2..3fc84f79cce1 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -652,4 +652,20 @@ nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 }
 #endif /* CONFIG_BLK_DEV_ZONED */
 
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
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b9776fc8f08f..54f765b566ee 100644
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
index 3f9a5ac6a6c5..058da4a2012b 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -309,13 +309,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
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

