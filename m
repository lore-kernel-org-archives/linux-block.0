Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E6DC433E0
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED3E22D06
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbhALE2g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 23:28:36 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42623 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730406AbhALE2g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 23:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610425715; x=1641961715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mkVK7yH9lL1rJQMlF1XEDeT3WD/vS4iMg1KelSLXgKo=;
  b=R0EGhMKhW3P6cvw1JGyEOZEcec//OypYzSVTMcCccjdDU0ZXeDGrhM9F
   IbwYF7FhGYp5QAsZyd0fT7x7NsRniOZYx+ZhpDmS9anHw1GMVWVorgvwq
   +2dZJAVFjll7ktTPEhNQ+au6KN/hf+tsjqb32xEfpM+ZYzLTb6jAyl7ed
   nt57dSoK1z07Gy2X0rI3EGn9xKMQVJI5fNGqeVizyAGXCekMEpLYFDoM8
   GuJeZgpWtb49bY1ApLvUZ+7H+7h20C7vRUPhTFeObaMeb20DIT7g/90TM
   8raIZm1g+J5UBwibF+bBPjYj76JDrQJIWuFbMUXmYiIDci3vYVdWFky1N
   A==;
IronPort-SDR: 5b9MU5Q5q4rrz/a5qBsumGFuOsJnPkbMhtUq9d69WzXsEKW0DJLqCwRO/aMHWZerMnpNYcqIFe
 YCNlXyy62DLe1XIkSaqb4ghjZnccbuovWHEwLph9G31UoBz79/w1THCgiq5ISzXueoNBK2cIHz
 DTzVu2nCNfHJK5wAGJ5ouCeHvctpBtCEaMzPFwcbnzZsEdWlwcjdvfkgDnGvxel0s8l5dO2b+d
 W5ffLJ4g0KSwuVGuqxe7b4Pj/Ei7Wcb5uwAalunqw6aqAdWNMna+WB9Diy6j8btM3sB46a4rch
 dSQ=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="267504904"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:27:50 +0800
IronPort-SDR: ijmTf2tYNr+QorbWdBKDMdGmCEuUTIC1pRqsjZfCo4Vkt5x5cY6wXuKzMurQBTLEEcCKlNK+BB
 bX6PGo5KdIzaZ/jVnFosdsa8jD6S6D13B5pitIksrU+oopvfzJvrmihTCFfqoeuk0dAPGxoNwD
 May6qqtyWCdHJ3Co/EA7y34tVr4y0a5uQGpQLsP5cUNKjaqKqby/Xr+OTOrvIrp61CRbr/XfE7
 brNmYA7rUiz/XwCs8FF071veIuMrdPiJeSNm0aTnkuVu4J4t01UgJd41BskhT8ZFOQEKCV2DUy
 y1EBTGU0Q6h5Kiar8Im9fpqu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 20:10:44 -0800
IronPort-SDR: 7tCkuG4QOhKS272Hg88kxZohCM1ZnvsSJQI7gWspgz0AH+5wZl3u7NrxobRGnuMs04fmuGPvvU
 Segbqb1mC8uBV6gsLous42UXP4pdxVrse2TnqzuC203ErZ+gJrsLKPbs5JGkXultFjFrYfkOhn
 vejhVy8M6c0F7LiEa1V9VHr3YF9qPGsCo4XDuXD4Lderd3Xi7BUaSBvEGo2c3c4UKesnThw57q
 uGhDxWSWqNetmDy6ZBG8hH4tS83izbk1HT00rhjFrIddDWIYFoAzxLz9XE65s8HuB4NKXfLFR1
 EEs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:27:50 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V9 8/9] nvmet: add common I/O length check helper
Date:   Mon, 11 Jan 2021 20:26:22 -0800
Message-Id: <20210112042623.6316-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the addition of zns backend now we have three different backends
with which checks for the nvmet request's transfer len and nvmet
request's sg_cnt. That leads to having duplicate code in for three
backends: generic bdev, file and generic zns.

Add a helper function to avoid the duplicate code and update the
respective backends.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  8 +-------
 drivers/nvme/target/io-cmd-file.c |  7 +------
 drivers/nvme/target/nvmet.h       | 14 ++++++++++++++
 drivers/nvme/target/zns.c         |  7 +------
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 562c2dd9c08c..c23a719513b0 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -240,16 +240,10 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	int op, i, rc;
 	struct sg_mapping_iter prot_miter;
 	unsigned int iter_flags;
-	unsigned int total_len = nvmet_rw_data_len(req) + req->metadata_len;
 
-	if (!nvmet_check_transfer_len(req, total_len))
+	if (!nvmet_continue_io(req, nvmet_rw_data_len(req) + req->metadata_len))
 		return;
 
-	if (!req->sg_cnt) {
-		nvmet_req_complete(req, 0);
-		return;
-	}
-
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
 		op = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0abbefd9925e..e7caff221b7b 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -241,14 +241,9 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 {
 	ssize_t nr_bvec = req->sg_cnt;
 
-	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
+	if (!nvmet_continue_io(req, nvmet_rw_data_len(req)))
 		return;
 
-	if (!req->sg_cnt || !nr_bvec) {
-		nvmet_req_complete(req, 0);
-		return;
-	}
-
 	if (nr_bvec > NVMET_MAX_INLINE_BIOVEC)
 		req->f.bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
 				GFP_KERNEL);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 93ebc9ae3fe4..f4f9d622df0d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -685,4 +685,18 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 		bio_put(bio);
 }
 
+static inline bool nvmet_continue_io(struct nvmet_req *req,
+				     unsigned int total_len)
+{
+	if (!nvmet_check_transfer_len(req, total_len))
+		return false;
+
+	if (!req->sg_cnt) {
+		nvmet_req_complete(req, 0);
+		return false;
+	}
+
+	return true;
+}
+
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index bba1d6957b6a..149bc8ce7010 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -289,14 +289,9 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	int ret = 0, sg_cnt;
 	struct bio *bio;
 
-	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
+	if (!nvmet_continue_io(req, nvmet_rw_data_len(req)))
 		return;
 
-	if (!req->sg_cnt) {
-		nvmet_req_complete(req, 0);
-		return;
-	}
-
 	bio = nvmet_req_bio_get(req, NULL);
 	nvmet_bio_init(bio, req->ns->bdev, op, sect, NULL, NULL);
 
-- 
2.22.1

