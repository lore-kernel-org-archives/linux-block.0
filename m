Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDE2C55179
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD072245D
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 01:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KjDSVdvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894555AbgJVBD3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Oct 2020 21:03:29 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15516 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440469AbgJVBD3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Oct 2020 21:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603328608; x=1634864608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y+hmrbRo5JQNhnhjQXfoPvp530DmB5g2Qp7dpvys4W0=;
  b=KjDSVdvFJu4ZV82yw/LPl9sWXjTISIbehxAGEZq1cmZ0jg657VfDOAHM
   x/uoXIx4TMesiJnmxyT8vdUkDrawhxIOGKHWQdo1kvkEKMmBEkO48g4GF
   ZD7bNvGKvvy0+YWlMqfrihb5VOi/Xg8WqfHa7itvg5o8/fuA10noPYFoL
   Bwnp5Kk6C0R8W0EvwIaruXNakbF4OJE4FVNtAsmACW8aP9iI9VAAYba/x
   r2fm3gpqPc1hDrdpk8hsRYGdAHqQM06Z5QvGR13kpws54Bq/dqSsPwnx9
   q7qmWXMIf2o6rZqxYXSp6RLynwt+xfHUVokcpJ31oqsoTxjqomZITrO1D
   w==;
IronPort-SDR: s/5bgYRFwwwvDUEcY22upekmL47Z3oxc2Xt/e8TAI8hqw0ON3c85bbIw6KRLXD0G8SvyHA02Kl
 XcZMXjOrNmHd3BFcKy5I2UMgvhhGX/vCqes+36Oa05LyZHoHQVH01+nesV0QbBXMloP+9cTzVC
 NuySp25FFpxE3Oa2JiRItt3sQeama7P/vgIWvjcIhp5ECeuoo13DHBssZFnppcer4HN9wEOV/U
 ynnB8CqFm2kpBkGdfCd6DT2UTX1ISccvQPY4RzsNVCPaXmiG1Zjw0h3uW0rAm9SR3IjAVJP5tT
 w6E=
X-IronPort-AV: E=Sophos;i="5.77,402,1596470400"; 
   d="scan'208";a="260463136"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 09:03:28 +0800
IronPort-SDR: rIrZN4lAQB8G/4CoGsG1NhA0t4dcms6pY7lbETr4l8DjR3WkOc5JZdaxzFzsUwegB3muNFMv2F
 1lHHJJAUhvVdIgHYsQgQFd7NzEpQsyxjCWG1VvJ/1SzlVuOj4Hxr+0vdoRE53ADtQublZCWiCG
 piQEj+10wy42xyQHfXkEt4usM/YfZor+3SV8YyjErXjOHlrELvQYX5VmWr20XAfOZScwl0A27A
 yYCOaTbuOP3EbFnjWgW3JFY2DVhQKyVCaqy8axhZJIh664j++nq2cfS/Z36Bx46JLmF/AgEMwK
 xSY2tPKK02Uw1Zonwf9WhFyu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 17:49:52 -0700
IronPort-SDR: KJa3ahp/xsHYGqmeHzjSY7mOl6UdUWE+WcWU7cmfHYmIPtTOHbscpC9l9IZ4qummNULL3RURns
 1UFw8FwrrzZ2JzD2HXIR/yuyOzZLVruLJrzGDaF7temfUDF2o6A2t6guOW2Rtb/DYB8plpWRcX
 DCa8LGZJm+NGpPuB/x88DadWQmccBf/5ehus7oWEUxKRtNEeVz4pXKofc8WqmgTmEa1C2rg8Jd
 vApZvQwPe9oofya9sjmDMMsGqaE+UAf8m9s12X8qtr1kCbaWr8mcfiJQH9kGEFL72v4d2BYftJ
 MGs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Oct 2020 18:03:28 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
        logang@deltatee.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 6/6] nvmet: use inline bio for passthru fast path
Date:   Wed, 21 Oct 2020 18:02:34 -0700
Message-Id: <20201022010234.8304-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In nvmet_passthru_execute_cmd() which is a high frequency function
it uses bio_alloc() which leads to memory allocation from the fs pool
for each I/O.

For NVMeoF nvmet_req we already have inline_bvec allocated as a part of
request allocation that can be used with preallocated bio when we
already know the size of request before bio allocation with bio_alloc(),
which we already do.

Introduce a bio member for the nvmet_req passthru anon union. In the
fast path, check if we can get away with inline bvec and bio from
nvmet_req with bio_init() call before actually allocating from the
bio_alloc().

This will be useful to avoid any new memory allocation under high
memory pressure situation and get rid of any extra work of
allocation (bio_alloc()) vs initialization (bio_init()) when
transfer len is < NVMET_MAX_INLINE_DATA_LEN that user can configure at
compile time.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 559a15ccc322..408a13084fb4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -330,6 +330,7 @@ struct nvmet_req {
 			struct work_struct      work;
 		} f;
 		struct {
+			struct bio		inline_bio;
 			struct request		*rq;
 			struct work_struct      work;
 			bool			use_workqueue;
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 496ffedb77dc..32498b4302cc 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -178,6 +178,14 @@ static void nvmet_passthru_req_done(struct request *rq,
 	blk_mq_free_request(rq);
 }
 
+static void nvmet_passthru_bio_done(struct bio *bio)
+{
+	struct nvmet_req *req = bio->bi_private;
+
+	if (bio != &req->p.inline_bio)
+		bio_put(bio);
+}
+
 static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 {
 	int sg_cnt = req->sg_cnt;
@@ -186,13 +194,21 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	int i;
 
 	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
-	bio->bi_end_io = bio_put;
+	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
+		bio = &req->p.inline_bio;
+		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+	} else {
+		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
+	}
+
+	bio->bi_end_io = nvmet_passthru_bio_done;
 	bio->bi_opf = req_op(rq);
+	bio->bi_private = req;
 
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
 				    sg->offset) < sg->length) {
-			bio_put(bio);
+			nvmet_passthru_bio_done(bio);
 			return -EINVAL;
 		}
 		sg_cnt--;
-- 
2.22.1

