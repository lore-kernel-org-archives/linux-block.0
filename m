Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C602C2BB48
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 06:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B60207A0
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 06:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgLOGFH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 01:05:07 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:56472 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgLOGFH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 01:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608012307; x=1639548307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PPDiSY5mJQRDmFoGvUppmX0kTxns+mXyQ/4JveVI9hc=;
  b=aBOrbAiq4o59gwNwF85zF07X/7bpELZ7hiJl72V6PgdGbCdWu7H8gWD7
   qrlG7z1FIj2v4UAex2tSCVdgt7LAzxE9tFvqsrejRNlM8+7VKblYI202W
   X4Beof7nc5pivRTvax4c9JwRSr/1URT208OiHcSEnOeBrEf/0CzmCEUQV
   9NYPg9Av2CZpQeN/ZGuqgR8cAKr6CC/KGZEsixgj13tz19oL4Yp47nx5s
   JqZt3H2FY/lCK0jn9KyjVYG8DZ8ZWMyfMHX4p5A4XD3AZ5do9sbXMziuK
   rJkmf8ER2NBiIM+VXw3BQ3qktnAUiH2VroWStAK2zm/S9v5g2KAhbleJp
   A==;
IronPort-SDR: rlAKkcxywMvgl0NqTFFi7ZQu/K/SD7scigacfqxPrwhMbBW1nePhNzfgOP97Rb7EjVidMbA7eX
 HYhZ2KmWy6T6UGNqgsZpxAfFMFbE8tdSZ3OQeAWLz5OSW/cbSbzWECwgqqBkUHwOrtkXD0EFcP
 Er0VId5ZEA3PKSB59g60f9t2HGW9Un7WLYV/HfV4jrdKP9SoafjMEzT3rlUP74iREmdtlcuZ8C
 PyxYGykM8b0FWD+Hau8OxQyqqO4qr+LcH8NK8vczP+BwBvPErpIIQhm3awwTXQ3h2b3HK1hfg8
 aVY=
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; 
   d="scan'208";a="265354160"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2020 14:04:02 +0800
IronPort-SDR: C4h2nAMyfewVKQ/CIhe+MRsUj+ypfO9dKnvDISMs0GmKLOPkNmOmRbBq56R+UB6hFFkCRTCoci
 A3wwdmp2qin8pVbU1Ysqyb5BA5s+8nHXo8c9R1RX0QAbWh0sCflziYVg3lTL46e14Bx83FTFpt
 7tv5FRMcWZCsWXpSV6Ima56yvGgKJ1ryp7nlDzgIULfst9eTI0STWOIsZFkN7X0oNfYo0wSDfl
 JoymQm69ZUV9OiWIy0MV9UpKvmsJ3V08YZXaEtnAZoUI6eeAgTIDsSufhneLAcMSwXqVqVK3c8
 qU3ccpZ496c9JrtoBFP7iqR0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 21:47:44 -0800
IronPort-SDR: 0c8iRz3GQa4vDOc4N59zYYpKgspvZNwyXG4IMFQcaWcm8DPFzJz1SVYOekcQYbcLUzUCWl9aXW
 +9LW4IDEJ5LIUlV0U9JXSBa84iTK1YcVKkycDyoRhVrpiJ4/vm+4VquezoSrd1JxHNHEqy0Dpg
 nmGvzE6MEGFvo+DEMsesuVVDB6yb51Asto6v8upPNELiOxce+iVDwEEq09Y2JEB78ulL7RMN7G
 dSRM19/SkqVygfy1nsUEvqOKxA/aaTh8+CvblqSjnxFqzo16CU9mxai6D8iKppbGjQe66+siWs
 7qk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Dec 2020 22:04:02 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V7 5/6] nvmet: add bio get helper for different backends
Date:   Mon, 14 Dec 2020 22:03:04 -0800
Message-Id: <20201215060305.28141-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
References: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
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
index 3981baa647b2..8bafab98d076 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -296,13 +296,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
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

