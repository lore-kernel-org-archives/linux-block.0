Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C496C48BCF
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 01:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E5B61406
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 01:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFJBfU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 21:35:20 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44301 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJBfU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 21:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623288805; x=1654824805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K2a3BW/K2scus12syH9yEOlFhAjm9xMwk1rT7lOToj0=;
  b=HSDDPJYXlE72NLRlgv/YYi63KDEwzQ1+YSwnq/czYQJS0lfjZAneQaUT
   HEeisyrhC6Dbu+bfmvENsQGlcSCNZ2aiN2yGrQymrZGy68F+pGh9xVmRd
   cQOjbN+Jh4ip2NxMsBecUaBxURsEurbJW5O0Os9o6VTQXVBwGrgxcfDV8
   u4aXkb3VBVagRk908cpy8fWqIMCv9cQqg+AK/5iRzyE1dB4PUT3vULy+/
   DolTDMEvFZ2sKRsam0u+aBsBNJYAZpWITzIsu4z0PluKD4XLQ6tpuNNz4
   3tlv3ny2io6Oirl6VlqgQSqTVCzv4YjKGuQ2IcX24aNGx3sK8RPMJlz7g
   w==;
IronPort-SDR: TyHOewjL1mbyZOT1HVk2W952Us+EnZW0q9FLahpCeV2TpnGR9gU+9Xgi4J3JYaT0R+E3zxj/TW
 d4wo855EjZrAaCIqpxeYIwmOgz6eaX2DPnewgKePhozHZ4sDYHr8xAcVtXWssJz3LnzdLZ5vcL
 mM1k/EzAkk0k9BqMJ+E8Rm6C9FMJn+HYZyk+cNDfiY/t5kZvmHX6PiX5FvEsySI8a9z3xe45fJ
 yDPVVikh27XtXlBV+QnNeXmfGmHu6Yu94Tb8qf/in4BrqfsqzPyqpsiITI+P5zW1/kRWtXYsNr
 owA=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="171930206"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 09:33:25 +0800
IronPort-SDR: d4YtXc5ET23w5IydbUGnRzGgEkbEsS+nbnG4Pa0L5txzQAKdYkyPL4AxITDA90RubehP4zhWc/
 M548gq55WuD6zyLQvBV7BdOoJ1TUbxSqcOJHiMlw/BKfw1MobqpjeE4yVoNMhk90utny+Wg4ql
 MQaS1qAUjxZxVfL6cbuGL7pTm5G5dBwdc5zGwFyJcJAiJgupKahfkLh7Qnmrn/CYkmbZheXV9G
 U+wv/iw4oSrRDPDT+bpcbpF/nYMAl4VWUTwXW5uaF0zrRyjZmUBkIRFbLKH91Lhk0FxG3xBc1K
 o6LxKIoRmOf7h7iGLpXAfZGi
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 18:11:03 -0700
IronPort-SDR: ISIKHpV7gJma7HPfnYGRhc5fWeBVXQDbFSHOsi+2MRV0CRNGbD2t2pgAzP4z7Pc5Ylvb+FNIfb
 X94ySPBcArLQan5MAbj87GvPYSJNGaN/FR81PW7U95ztAksJB1aopD1zp3DPSiK9Jinhk4KaKY
 LKJ3d7psb4l+J4L9AVDVL96oNk9kz9avwYk/XtRKRayWCmKI8KqROUVZuR+rkOa9ppnS6ynDSJ
 ulpbHF6n7dGyWGnEKjjM8V6dwa4zWBTfdh/XQME4H9ehPi1zjCEHgu91fhgmhxHTKVMydiJXag
 2bY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jun 2021 18:33:25 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     axboe@kernel.dk, sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH V15 3/5] nvmet: add nvmet_req_bio put helper for backends
Date:   Wed,  9 Jun 2021 18:32:50 -0700
Message-Id: <20210610013252.53874-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
References: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In current code there exists two backends which are using inline bio
optimization, that adds a duplicate code for freeing the bio.

For Zoned Block Device backend we also use the same optimzation and it
will lead to having duplicate code in the three backends: generic
bdev, passsthru, and generic zns.

Add a helper function to avoid duplicate code and update the respective
backends.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 drivers/nvme/target/nvmet.h       | 6 ++++++
 drivers/nvme/target/passthru.c    | 3 +--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f673679d258a..40534d9a86d1 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -164,8 +164,7 @@ static void nvmet_bio_done(struct bio *bio)
 	struct nvmet_req *req = bio->bi_private;
 
 	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
-	if (bio != &req->b.inline_bio)
-		bio_put(bio);
+	nvmet_req_bio_put(req, bio);
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f53ce96df498..d4bcfeb570e5 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -632,4 +632,10 @@ static inline void nvmet_req_cns_error_complete(struct nvmet_req *req)
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
 }
 
+static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
+{
+	if (bio != &req->b.inline_bio)
+		bio_put(bio);
+}
+
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 39b1473f7204..fced52de33ce 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -206,8 +206,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
 				    sg->offset) < sg->length) {
-			if (bio != &req->p.inline_bio)
-				bio_put(bio);
+			nvmet_req_bio_put(req, bio);
 			return -EINVAL;
 		}
 	}
-- 
2.22.1

