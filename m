Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC8DC433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A2822D06
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbhALE3Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 23:29:16 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:60620 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730695AbhALE3Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 23:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610425755; x=1641961755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R91N4OJCuometnQDJ1w4j46SwlbKLZn5XO72xfDzsGA=;
  b=RefBlu6yjzIJtQNzpKSpiP+s6vDZseSfEyiVY50OdhSFmHd1YQVvbpnR
   hegJYJhEdoMWpw3fvGxi07dbwqh+gVoMvnrrCzPEghyXszw6bEkLiwwCU
   4ccFCH7i6oH9dpDk8MeaKAKUE2OTCbZDdCrAVF361f2gVMivCdfhER/dr
   iJvX3P36GNqprygacHcdrLHZVyu1H1gx55tqFb34H1fKFGyTqTQA1s1Jr
   vRXhNBsNExi+l3vOmM8847zr31NJZAIzIvvfYRSkEWsw+p9pKGdLn3uEi
   X6nV7Ms1q92n1/RhLK89KJkpe0J3ui7dDitNooS13oZb7upITPy+uoBux
   g==;
IronPort-SDR: o6nLi8viqlLvWOWA5y9+W3dGK+ug3OpNTqPjEzWa/PIbpxL0NQiSsuE2Ah0oPa8kIFRLV80G+I
 bf8s0wsAm3lpx4Re6HHVwiN4ojQOXguLRby+4JGMTb8+p+a2NTpLJlFG0ccIlKD48dNKaEhRcb
 lDrLECC4Dao/H5LakRPC4DA5VKXcn2BZEimd+GeTLv8sHUowjUveZMyycMIE/MSv4s4zzVd6o7
 LxN0pJmNruhm8QZJQrCDrkBZOwZEt/HDsJsh+tnbsvX4jYVaDSdYvPQFsLPLeJUBC7rAdLY6nh
 HLU=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="158381165"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:27:40 +0800
IronPort-SDR: V+t/B5TQGMJgALLGoW7b44cmQmnFDbWh6vnicHXyWus0aml3m+xpd1sh4dWoE2Dl8McVQyQofX
 JQRbv2JNK/lAfCvLX11HGVLExj544H/zgeS0lnAfPAZnwG/hxyleLJSI9KWuTm5GgOsTgGRSJz
 OOWecvoBh06gBQEND73CB08eT+ki9nPNEUbbIwIHzzKBvtZ/BhrMq6uFZknqAlncSVMlQUB1vw
 +T/BuKCXM7F4lOGwEBgt0ZUWlyn9V+DhYU6MhGkQIwWFIqMrQqxYJtYezrYlHihmqkrpbizIQh
 e9BkssxBk15KA/IeF1zq2CbE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 20:12:25 -0800
IronPort-SDR: cxxBy+WvCfwIT1aN0fSwJRc2u0a0ZFgDTUxwy0EBRvjkwF5bLgRJxyGovX/xmoU5rD13K1GVW3
 bdxsbX9+S3UcDkMCpCGjBKXhrIFLsNudnpIbh02UZKb+rDNvC7X94PBTsTVMXU4IcTzEW2MnfD
 tMQTA/NR6PSxweczXJaZ4CuWvi3jCPUyPVqrWCAKzkWUwzWWBE2H7mhRd+UczzKAfmny0o7SUc
 DZGVO0+0N9KD5Y8dTLMYYtCGL12zKvk7hNnQFP2nqENoLuup5VbnhyugiO/z/cJ8vcXYCdyjMq
 NPc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:27:40 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V9 7/9] nvmet: add bio put helper for different backends
Date:   Mon, 11 Jan 2021 20:26:21 -0800
Message-Id: <20210112042623.6316-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the addition of zns backend now we have three different backends
with inline bio optimization. That leads to having duplicate code in for
freeing the bio in all three backends: generic bdev, passsthru and
generic zns.

Add a helper function to avoid the duplicate code and update the
respective backends.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 drivers/nvme/target/nvmet.h       | 6 ++++++
 drivers/nvme/target/passthru.c    | 3 +--
 drivers/nvme/target/zns.c         | 3 +--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index b1fb0bb1f39f..562c2dd9c08c 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -172,8 +172,7 @@ static void nvmet_bio_done(struct bio *bio)
 	struct nvmet_req *req = bio->bi_private;
 
 	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
-	if (bio != &req->b.inline_bio)
-		bio_put(bio);
+	nvmet_req_bio_put(req, bio);
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 1ec9e1b35c67..93ebc9ae3fe4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -679,4 +679,10 @@ static inline void nvmet_bio_init(struct bio *bio, struct block_device *bdev,
 	bio->bi_end_io = bi_end_io;
 }
 
+static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
+{
+	if (bio != &req->b.inline_bio)
+		bio_put(bio);
+}
+
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 54f765b566ee..a4a73d64c603 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -200,8 +200,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
 				    sg->offset) < sg->length) {
-			if (bio != &req->p.inline_bio)
-				bio_put(bio);
+			nvmet_req_bio_put(req, bio);
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 92213bed0006..bba1d6957b6a 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -330,7 +330,6 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 						 bio->bi_iter.bi_sector);
 
 out_bio_put:
-	if (bio != &req->b.inline_bio)
-		bio_put(bio);
+	nvmet_req_bio_put(req, bio);
 	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);
 }
-- 
2.22.1

