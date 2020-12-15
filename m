Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD24C4361B
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 06:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A2320791
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 06:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgLOGEl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 01:04:41 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10533 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgLOGEc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 01:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608012272; x=1639548272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOc8tZLY9aTLtJqoqcpsKtJ8jkH3U8ob/P06alAcQUU=;
  b=OZW5JKv/NmHbxukgIxe5+9bBJpf7MRth7mVgqeFryWLpPGvFLSMC9+5R
   g8Pdf2hINlvhWkeHFN0xvoBR9vw/us2QfzBQWJlnbozgO4Dp0htxTdEEi
   ccYBiVH2Eq8UCwPcwcEIhP2IXWr31GI0EPx4Dc5Gb9n5FDUppZe/es1eQ
   uhZndZ7l0QJSBo60liqHuKKxmyUXn8m+bh6w20ACYC+ABJrT+oRMlJQYF
   wm7rseNe7v7SXwtjQyAFrMLqlCIKLX1ZMjBtyoiubnHOizBLCx3cqNME8
   TcUDAGHz5TAYeljyHqlGhn6YDVo5rjUeTrew14Fd/ckvUjWy46Ca3qNfk
   w==;
IronPort-SDR: DZ+VTKcgpZ0bqMt/5JrZGZu7A0RTYfT/3r91/RB5++alrr93zG7nNNDsqDhQXJpGH8bvTxN0gh
 zK/li4l+NMTmZIHvbzUxekjJIo0Q6sobb20mhHU+A56Saty0B7vpUSQC1Z15wH0zKthHApCB60
 7GoRTXIlH1p9ygpkjt/Q/sZsr0wN6/Cz2vTVwecaBxSuNI2o2iAuB12l3tsVYg+y+AwKSfkRtW
 V+SRKkNXusoiy2Ythnt6QUgHcZQ8GEUKKCNfqNhAAHZiy/1+pxmrmLPQjzB13ThKb5/+LDuCrk
 R8k=
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; 
   d="scan'208";a="265354129"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2020 14:03:24 +0800
IronPort-SDR: JuYb/aLzja3WOnOLj3+O4q9/46B7/ahvrHh8/sswV+3slwXCWZVQ1FOsZvX6ikcC9bZje8zrrA
 /joQgIqXMh2jrr5aa4yQObIshCxAEZU9A4jI/3Ggt8xz9RV12PmhtVv365FyVeQosCAa5kJ7Vo
 YWt7aJkhBts9iFMLh4acOU78VGPcQZ9Ic0Kaj7NxdzsVsDEyKQtkHQ0e2x0nIui50KB/UXwP2E
 3iBP3z1j+utjgRl2V6pouJA6MFYnKHMIdS1mKu9zGfRFU8uDQDFefs8gAzI+400Ur5XKW+AubH
 UGAeblr0+OK5IfArzawAimlz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 21:47:06 -0800
IronPort-SDR: PBELf+KjLLZ/jBGYF6IGuZ2KKABaMegiWW4MIiDv6nEAu6GYKOUBan1d7bS95Jq2GzkLR8GUlF
 jUtlR0IlY3kHJmEMwSaOuD6DMC7W90v5t7MDGGGiT0tWi+WszaoSj1f31JAxsPPCI4NQPFAcGY
 DG7SZB7NXdJGSkkSfNj3AmwISLU3/36GSYCAgVplAX+pWhxTHIRDYN10cWQTYbUJX91YpiFBUx
 2rp3rr5wNinfYsrvfNtxA0rt/225/XYvtGEwAhtMwwnmTWHFF8lHgWfWTyBhBwqkFmu6hcLIfW
 qas=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Dec 2020 22:03:24 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V7 2/6] nvmet: add lba to sect conversion helpers
Date:   Mon, 14 Dec 2020 22:03:01 -0800
Message-Id: <20201215060305.28141-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
References: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
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
index 592763732065..8776dd1a0490 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -603,4 +603,14 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
 	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
 }
 
+static inline __le64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)
+{
+	return cpu_to_le64(sect >> (ns->blksize_shift - SECTOR_SHIFT));
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

