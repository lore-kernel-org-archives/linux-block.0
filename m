Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936E5C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631A123C43
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 06:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733261AbgLJG22 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 01:28:28 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49857 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgLJG22 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 01:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607582660; x=1639118660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kbD12zBzctjxO9RwwcaW7bNd0XMBbypoSxCzWKSeYbQ=;
  b=F9MnbhA/brcisS+0mcVf5GQQX6r32a9jMX7PpX4gwpg54nDMR/scAvUf
   8/n7YKoHcs8g5wisCvRlSFOMGe+zsP509/0aDOA3LLADERmcAbZds1Dqf
   7h4sh4gDq9eljVIjxx4eoLyPp9uZP9d92zuDhauku4xZLs4AmgL+uRenk
   U7Ama9et0KNmb7jOOIN/bEaJ1w6Qyf0aT/ikMkP/UrBWby6JA7eDl8/+D
   GEhrKbQji7ermnIQ6x3urzqaqNIWT452crr+jXcAOKl2MQ2izIdk4p2xA
   VCZejmSHcNoJNCSmbVDR3zCLjNM+8zvlojaDa+8fLYn5LIW8cUiZ/BVKW
   g==;
IronPort-SDR: 4nbe4q7OD2puXh4oixaKr7qOgE5h4p9L15ZBQC2WgY2Wyqrt/TF9rFVFrBsQTMvV7ACpgX9ZwH
 SLN/CvjEl7RN4SaKbe81buMZk52fmaY2PrFPe2xZXCI23tAfq/XN1613TXp56uN7mxZjjH//cE
 MNvpk3cYJbFvOvaxzl1VSH4WXUY6YYOEyuwttIWjaKA9GN5tVASVnQdkZ5yQ6GRp/NwBaDZJ/S
 ZvRSroUVigA7/eJRZzXrSAKf6bcAJG9Aqr9PHKFY8p6Vty/RP0e4R1vGiycf28Czo3Qln4aY5t
 BeI=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; 
   d="scan'208";a="258559141"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 14:42:00 +0800
IronPort-SDR: aKVydV59l4uhUc+WCqVck5AprEZ9peyygEzyFTtdYqnOVFr+/32qX2RQgHl9kqnoDKe4RcYoQa
 Zp0JQ6pM0nawhlK0BBDE+VpRc0KVet+YY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 22:12:20 -0800
IronPort-SDR: WQGmA6JiphSJf2xEAHGsFsG4Ge+fvDHu0b5dqlFsXlcGLPu3Fc2CodM7BiPMD92Kb6BKnnnlA0
 25Fx54q15ehw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2020 22:26:56 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V5 2/6] nvmet: add lba to sect coversion helpers
Date:   Wed,  9 Dec 2020 22:26:18 -0800
Message-Id: <20201210062622.62053-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
References: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In this preparation patch we add helpers to convert lbas to sectors and
sectors to lba. This is needed to eliminate code duplication in the ZBD
backend.

Use these helpers in the block device backennd.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  8 +++-----
 drivers/nvme/target/nvmet.h       | 10 ++++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 125dde3f410e..23095bdfce06 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -256,8 +256,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	if (is_pci_p2pdma_page(sg_page(req->sg)))
 		op |= REQ_NOMERGE;
 
-	sector = le64_to_cpu(req->cmd->rw.slba);
-	sector <<= (req->ns->blksize_shift - 9);
+	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
 
 	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
 		bio = &req->b.inline_bio;
@@ -345,7 +344,7 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
 	int ret;
 
 	ret = __blkdev_issue_discard(ns->bdev,
-			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),
+			nvmet_lba_to_sect(ns, range->slba),
 			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
 			GFP_KERNEL, 0, bio);
 	if (ret && ret != -EOPNOTSUPP) {
@@ -414,8 +413,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
-	sector = le64_to_cpu(write_zeroes->slba) <<
-		(req->ns->blksize_shift - 9);
+	sector = nvmet_lba_to_sect(req->ns, write_zeroes->slba);
 	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
 		(req->ns->blksize_shift - 9));
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 592763732065..4cb4cdae858c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -603,4 +603,14 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
 	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
 }
 
+static inline u64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)
+{
+	return sect >> (ns->blksize_shift - SECTOR_SHIFT);
+}
+
+static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
+{
+	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
+}
+
 #endif /* _NVMET_H */
-- 
2.22.1

