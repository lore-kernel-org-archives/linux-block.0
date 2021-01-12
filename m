Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6726AC433E6
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CC7022D06
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbhALE20 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 23:28:26 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18350 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbhALE2Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 23:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610425704; x=1641961704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1y14BfiDYeW2GPW7aJ8piMTbIb+XExWNPhFvc+apnpU=;
  b=EsemmD+EL/cb3O4sYJ/eB7LGSir2IoiUZDN/IJbIcPFp8nwZHNXdAex+
   O/JAcrVv+0DIKGPoX5r9v0Sr1yDK5EEnYZ/5KoEZ2BSxNFOlPwZwSj0f3
   ZExb0y9pMYM/5SUJoBXOs5nza8Nn6wSs51IGpo4xNq8HiiajKv3vDqveu
   0aEVIGTPkTMVvU5eITE0I8jm1ycklBq+MywM4HyleAXmkWeEiuhfJECsa
   IVjgsBGRwOxhvelbfHzOrk+/6KgCAZwv1N6xc3/MPbBpt3IzBYZVYJBzU
   N0Hp08kBWAGPK1H0rsEIuBDc89bypnU/K/2OQBSD4dQ29xtYc+gFUJPRM
   A==;
IronPort-SDR: ro0uy/f9cOAfv5y/wUFXDk1fTeD79HRDdQYSUgq3YRbZtXh5tmuIKxZle/JYdwOabrGwqdDkUl
 Sue1JT0fXxqV30JuC2hdqdfzON1mM5ApnMH222OeoL6jxfHDRBpaW6lSl+NHY3IIyCYLRh59Bc
 jdsBuRxLPXbDwts0S8oDWI/ie5VwMDlyEtbnPFtIsnrQ+GQGPunWoLn92oiQ+dOODKGQF8CmOj
 luXkNg13kppHvSGaOirji31OGojioXIzgBt6TwpNPDWo3hmv03lTgFvdUQUvWUfShvo25Ihqq+
 39E=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="161648574"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:27:19 +0800
IronPort-SDR: DU35T9zezmQ6fqL6cD3zNE5w2fV8vuZ63JsmKIQzFwcag5BY2DoC0zxDnsRLCO1CAbVL46Dr8Z
 +jtDudTr3ZQPC+pUUN3gV0JuV3799VUvMou+9TVC61EFQKPTce97pyl3pdaOtH8Bblxhcvdahe
 YLRyBdZhyk34I3zMTGqO6D7dCvP6iME782n2OHGad9QibvNdSfOba5B2+njrwOHyNVU6w+i/zL
 u8nPHTa07JoKv+1RuSkxV2wNhTjqwS7RwM/cjvuAfKl2faCpH3jFY/XZjJb1gm+d5nWhD9VMIk
 CKByPJkmhAd7gd/zeKVDyjz3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 20:12:04 -0800
IronPort-SDR: /flRgfgEnclXEjUnsPCzykTMB6SVPr/WHeUP13AUvcf13rGSctTSMm8CVb3LrJHcjTiCxZMChp
 aLs0bHvbCsCPSITm4RaSKZIB+XEOsehGNeRTrMr94C3wG8ou9stLPSJjBfUKuCcJTG5AbqvNgr
 Ek0ynMeqcljeX8fgt8QhviT1d+tY/M9xdPvDZnLjHBKc96Qbg0kv+3IJPntmiFHIZ7iI9PZt9y
 gicBp66ZLpO9hIfq3htvt9H1yS3JynCsnLQmY9pHILIBU+AgEl1k3RwrNE7SLyqLCQv+/1bJMG
 7jE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:27:19 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V9 5/9] nvmet: add bio get helper for different backends
Date:   Mon, 11 Jan 2021 20:26:19 -0800
Message-Id: <20210112042623.6316-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the addition of the zns backend now we have three different
backends with inline bio optimization. That leads to having duplicate
code for allocating or initializing the bio in all three backends:
generic bdev, passsthru, and generic zns.

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
index 2a71f56e568d..c32e93a3c7e1 100644
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

