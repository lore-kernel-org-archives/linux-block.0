Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E8CC433FE
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 05:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9309D2312D
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 05:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgLMFwP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Dec 2020 00:52:15 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51958 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgLMFwO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Dec 2020 00:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607839558; x=1639375558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6iQxxapLrqBA7SoY0rjMc7pwZ2Vn0eqmBYQq+bt9gtU=;
  b=pauQCJ+xrfHqXF1RH6QKaq3JHSSXm3S2wQptH/bBBRvsh9nimwlP7kgZ
   WoOSKLaUCJSBgCoioJWKHCC4vrmiop+4ElVK42WsT+tY0VwmUuSWWMA23
   XghbQZCigvdW11rcKIANMqMcWmV6U4k7REUMRhuGoqe/Us5edoog2aN3i
   Y3dzmQZtLw4pBhuQycWgVe9YPPUbUEMihwtzCmtzUGL0vjBJ+E88KD0cL
   Ni2IJT3AVq2rBQEuH1SWls8K5CjdNDMaoECynFwelIszL3p021tkiC4vM
   KpjKw3+MKIoQkKwo7GmWzjykCvKaNZoxXj8BRqp7suEdaC8uVfEihULZA
   g==;
IronPort-SDR: MN1o6Ean7u276msvD665gcw1QGBx8BQVOPSgBiIY6qpMH6u9YhfGuNvwlWOLveUZLDNpLTizlF
 0hthM0F1pczILqNb6xx6LIZPQUUTv4SaoG180lJ0I3U6Y1vPhtO+MG0xNYn6hST9rgWxjN3oL0
 DfHctIz+lTaC+6tRVEderOnhdIUa3CoO3tjpbIA8sdvdZX8loBsXtpjXVHhKfIBNEG5APUf9XF
 Pp7xCvHIgi+KrU35L6tb+sw7zlQRTO7Ia/Ikjcj++S5E5zxEb9DCblgJ3MuGWabHy5u8QLfYf7
 9Cw=
X-IronPort-AV: E=Sophos;i="5.78,415,1599494400"; 
   d="scan'208";a="258770362"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2020 14:04:31 +0800
IronPort-SDR: oS4tXCd272kFwUdQZtfsvjVUN68CTyl6JeOS4z0s2eC64hP1exxdVtis45OCvcWzg3fS0Dh5/p
 ILira0nxLAlYt8oHsbFwG/7dFBDlVLTVohA+2lkl3Bz/tEiG0jPbJ6pGsuNJcGdkKzMV+8CNFg
 KZvadzgwy1zOolpuiH6K0XfK7kb8qHOqSDOEarOgnKa/LxkxfSJO22/pSzHglJshMjchVQz/hH
 qh0ju/Rq17DCJJGvacqv0lAtG+dgGNA9LnKwClQ4tH2YQOieEgpL+uM9RLahUHot14wGzSl+am
 T0Sv5TOQlCI2aNUzDLgI3cEK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 21:35:06 -0800
IronPort-SDR: blFYTv0Uo9gZGR0KtydYgcZBR6w+VIk2TS6ks+xbU0VwGquUjtHt6fIfuAXnIEwYueV91yJCEp
 IMnErq9Zoq0VypRFL87A/VvN0NH9DMJw80lrlPiLAPLOHh7O9mDPVIDqaSzqIOYofxW6VNawBF
 9hPqX3eDBSB/VPrNCwXpZLz8zg4OG+jFH/iskXV7O25gnzKKny6HcE4pFv0NJ+fWMuE2rBkIbZ
 wXqh9qQKd/p/sAlK0nzoqecSOVfh6wjnSEPcZXu4ikkpmo+hvEZo7eXMIYYlCL1Lw7gmivLZxY
 joo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2020 21:51:17 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V6 6/6] nvmet: add bio put helper for different backends
Date:   Sat, 12 Dec 2020 21:50:17 -0800
Message-Id: <20201213055017.7141-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
References: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
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
index 058da4a2012b..2b5c04e56097 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -345,7 +345,6 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 						 bio->bi_iter.bi_sector);
 
 out_bio_put:
-	if (bio != &req->b.inline_bio)
-		bio_put(bio);
+	nvmet_req_bio_put(req, bio);
 	nvmet_req_complete(req, status);
 }
-- 
2.22.1

