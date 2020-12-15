Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D627BC4361B
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 06:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965E9207A0
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 06:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgLOGFG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 01:05:06 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8974 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgLOGFF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 01:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608012306; x=1639548306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2WRsibq+qDho+pjgl/Wk32oPiBilraCut4aAJwCYJ8M=;
  b=YLyHiQkLzj15NHIOSFwZZ7WQCp12YL0x7coTZqdKd2JgVW6YeXI4PfXa
   5Ni38TXZqyirwMFN0rnjrbHFgrmLTrRa6ymQ7JZJ7jND/uDvCqjwPiQjd
   IynVNza7dal1Yg3KD3MqNg6X1PfK1tHJzotU+/kbsSczLRoU8sYFz3QSZ
   1Aex4Zb8IsOqCAQDmQILTqqcX6duJADzEXDLx4SFWFbn27dtcSbwBz1KZ
   U9cRevvasyU6Gjvhi+wq2QLPHg0BKMtbYqRNOoCn8vlOU974ylfmJbrff
   grSvP+zfvXyvzpbNpOCzfrMsTKK6JLka8BDbaUVw3I+Ywe72QfMi0Zg4a
   A==;
IronPort-SDR: qN17aQFn6ktNPyPPhHY0hvt2GEi4KeLFKCRnMqfrlSpI88WVzo/DX5BVwtZ5HxASO8x9Qwcl7x
 Bcs3DSkpqUZhlb8YFlXeaB/8rbRr6YqlcDauwPdsR0ER/8crtq/NCQg8jpaweGMEMBoug9h72I
 kxYwxkJBUxNWVoDJ55GP98QI1I4q/JKNHoBruBq9jFrUWCSWIoEzXKqE5hAZGSsJ4AN4rEVI/1
 TF92jMj9h3kRtishaRtnE6BMRaQHDRZWSeaCwXGxQnr/shuXegWVQ9ZfVVXhtmRHI1X6TtKCtj
 mEI=
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; 
   d="scan'208";a="156369767"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2020 14:04:12 +0800
IronPort-SDR: CLKYEQkdRf4dqr48CEP2AR3lRlEbxHBvr0LW/J3fshG0AoIlarm7tHlOJRMXsW1E3vaS56c/jd
 G78wYIwf0OWo0f9s6Fhw1pi76jxWH7AY5cpwkiNa56NAOwuMGLHfb/Je9POjedcJoKFpYUaVoh
 +830KlX3exYSqivGLbGC+w9SHdWDn/aBK9vp71F46HQbd2IXAo/Rt/BLccHZdVDbqzs5hqi5Zy
 G/I6qJfX2zY1JbOPR3sA6QWOVE4zy0rlr54pSv8jCCL42wYNnfFDNj+5Hd3T7LxcHH7hS/vSZX
 4DFVCCzUBaLHsOeBihNo0XVr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 21:47:54 -0800
IronPort-SDR: BmMmOzY6yL12xaJFftEGsBKcBk4EVNmQVzbyJSa/WgM6aQgDS0z+Iw+cakoRcTkhjwpU9+KZNo
 s9FFwWwtH6dXYa5Ll4QyvRdRNgdC4tGz6daHVEmfp1H2M7PTlUSJfiuRaaCYB4n4PhcUrBCyWS
 NCWSu4uXj3P5atQSlKS/bqKc2ZDw0de8zKi32uxl1h8eRmurwkhE3aaWydcNH7TMcS+pB9DUVL
 lmujSaEu8TedQ+Z1Rz+hWJewdC/feyQOb3rsbh3UQF5ARL6UBbOlvUaYdDV/+l2fPfsBiIqs2W
 Bak=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Dec 2020 22:04:12 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V7 6/6] nvmet: add bio put helper for different backends
Date:   Mon, 14 Dec 2020 22:03:05 -0800
Message-Id: <20201215060305.28141-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
References: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the addition of zns backend now we have three different
backends with inline bio optimization. That leads to having duplicate
code in for freeing the bio in all three backends: generic bdev,
passsthru and generic zns.

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
index 72746e29cb0d..6ffd84a620e7 100644
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
index 3fc84f79cce1..e770086b5890 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -668,4 +668,10 @@ static inline struct bio *nvmet_req_bio_get(struct nvmet_req *req,
 	return bio;
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
index 8bafab98d076..d6a8310cf672 100644
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

