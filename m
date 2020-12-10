Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1173C4361B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E8A23C43
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbgLJG2j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 01:28:39 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60995 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733266AbgLJG2i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 01:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607581718; x=1639117718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lOMLIaJDmIDD0WogVMYt9X+5GYen2N6/lQaazz+2jhs=;
  b=UYweqsbqHpycJ7Nqbu9cHG2aWBJR2pzHEUQ839HrNA/sPJDZw/HYM4Ui
   fB+e3g0VQlqfszG2AcQHGMoyWtKXvxhgUpbI6t0954Shyngi0q2XJI0yZ
   EbVfsUMt49/3NQ0DwxGDuX9/kP8VyjtOH/z5+UclA3z48xmzJ1/N85P4W
   +cZIrSj2gyEmM/eGZ+JzJaUe/5vul87rYdLR+rx/QrQliK+tmtKJCMfbI
   9v6nLJeR8jSLO9KF8wDanNlwhX8Cdtc/lFw+SnzHti9Qi62Ur5kaaL1a7
   8MfmOxY5aXlmNMR8F87Nr0hel/PHD95Adl8mDaCDMYcUdJ0Zb6zITpd7F
   Q==;
IronPort-SDR: uDnt8kT5YzbJ/31kpzD4kexeLq1en2E26GyON85kgmANChprmqMMp54tzKvyqsXqoe0o/jplOy
 rALlR6FySR9eAchaFqkMwpJK2eUVEP42j4nN15GJCULEp78Dt7HgqVYd/uj2K8YBRlKr6ks2cW
 mfpIYtOupBt8zi3wWwjhZkR/IK76r+q/RXe2XdQ55xTpDZV7tPWjCEqObZLj4YRiFV8yz645f4
 4hPfUOwKku4T9Kp/+nWfndaiK5kCZe8gCKaJOkm8DuQgRhsPZqLfWmEs/4y195JBtepQTFaI85
 uN0=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; 
   d="scan'208";a="159291317"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 14:27:33 +0800
IronPort-SDR: MCq/Lpjx7FtP8OQeII+eT5YOsduWMxFZplNpJJEtEjPl6pR7kxvK9JSEkVtSVE8kBrVlzOciQI
 H3dyAwCDeleGk1nZyeyRk8tn+39b3tKok=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 22:12:58 -0800
IronPort-SDR: F+ipM1tH8HcRaAAnfS9DyeWqO5AivvL0vFXA1Z5Xmf5lv4aX8GCdQuvbZ0KyFi39TQHALUxuOp
 AYWJqkC46MJA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2020 22:27:34 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V5 5/6] nvmet: add bio put helper for different backends
Date:   Wed,  9 Dec 2020 22:26:21 -0800
Message-Id: <20201210062622.62053-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
References: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the addition of the zns backend now we have three different
backends with inline bio optimization. That leads to having duplicate
code in for freeing the bio in all three backends: generic bdev,
passsthru and generic zns.

Add a helper function for the duplicate code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 drivers/nvme/target/nvmet.h       | 6 ++++++
 drivers/nvme/target/passthru.c    | 3 +--
 drivers/nvme/target/zns.c         | 3 +--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 6178ef643962..0ce6d165dc4f 100644
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
index dae6ecba6780..7ef416de4f6f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -618,6 +618,12 @@ static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
 	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
 }
 
+static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
+{
+	if (bio != &req->b.inline_bio)
+		bio_put(bio);
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
 void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b9776fc8f08f..c2858ea8cabc 100644
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
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index ae51bae996f9..d2d1538f92d4 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -321,7 +321,6 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	req->cqe->result.u64 = cpu_to_le64(nvmet_sect_to_lba(req->ns, sect));
 
 out_bio_put:
-	if (bio != &req->b.inline_bio)
-		bio_put(bio);
+	nvmet_req_bio_put(req, bio);
 	nvmet_req_complete(req, status);
 }
-- 
2.22.1

