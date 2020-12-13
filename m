Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4FFC4361B
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 05:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9480222D71
	for <linux-block@archiver.kernel.org>; Sun, 13 Dec 2020 05:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgLMFwH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Dec 2020 00:52:07 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:4942 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgLMFwF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Dec 2020 00:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607838724; x=1639374724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOc8tZLY9aTLtJqoqcpsKtJ8jkH3U8ob/P06alAcQUU=;
  b=EqbPYqkBjPVToZ+rJMCvZUwU8uDxYOBDxcQ7AtMi6bNeGWgDW1NfnVyL
   +rDSwCah4v65POFnUehF4doXQycScYvXpYNYTHrrwxpjGYpodnkORHCh7
   4Ta6yLoOkdbFEd9Dch4Viym3csDXyTIsSRPi3g5prRLq7mFRmx6my/6V2
   g0Atcew/FT1Lctw7XnqsQgMnA2WmgXZMbRyTtCH6PjLhyWKx6TxHQaXKI
   6YBmQ7dFzLnTkuWgG6wTCWfQN6keE56nuKX8QUpOBORst6xpFRHNSY0oB
   zAMCnjKnspiLxLk4E08MfAQ/7qsuRSpn7wmaHUODBypAJl9elgn/d6Rry
   Q==;
IronPort-SDR: AF+lkTVvMAtZnKskUK1m6UPtNOPbzIJlRRZDgO2hG0yVNAB4yUTVxcIdYRQqnDA72eebiIPVMC
 W+NaUlfIYlsSRvyX8+LgETS/9rpOHfcKLvip8csIuLH7ff1zCgNO9E89xdWIkT15mJ9jJMvbJY
 vneftO1Uz5ys5E8VQZM3mj5JoxfIr2XL8I9lZnXGucRfnRwxvo9AhbYkl7snVUSQTm5XslOw5v
 r+MfEZRWIfHvyKmNfbzcA0SkVfQjcnqu8vOHSoijc6V5kpsJ/tc6SeXQRUw8k5tX2wod9dGL32
 Spk=
X-IronPort-AV: E=Sophos;i="5.78,415,1599494400"; 
   d="scan'208";a="265203443"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2020 13:50:38 +0800
IronPort-SDR: IPQ1U8AuYrCBtcfC/mpT4WB2BGkNTPKKZ3ktyXM1igGqxUArWKlUBnJq0y1I5QKqHwmOcon1mI
 ahcaT6dxFq3z4Ypz0iQ377QXcBddtTtVlU3TV/FikxOavPLRUDc/sF5uSW6YNCnTBNRuS/ZV8Z
 DHTLE1T00vQd7DmPQaorVBDiA7+mJZDY3Hl9yvgsRn1BMXbVDgVlbIF8CLA7pugm+h4TX8pzRR
 IK8oHb/jXfOlL4ZlC9jwtOgEMJTUSmWzOKX9fWw1vXpDGcBDU5NTWjjRHDx86YjM1C6Gj1D0NA
 Hw8FbV/bu7mqkzLlEIr8FWzT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 21:34:27 -0800
IronPort-SDR: Rq29Z41v6bhT35mkqiAaWLroxMzffXCIvBTBplW7hOo6BhlFdgz7wfw9pUWdkPUTc2MckfGmkq
 m/dR0pek1JebsG0jZk0X6+Hx7WgJT65J7jweF8mwZGAbHlGG2uI3eYTBDAqDvzlmBSnFFJClCU
 fP5v5WVPhPAwDSQDMfZS5Kk5AGBGqm+CsfgZGTFLrH60xbC8YJxar08aPaS0fyy1dI0TfDZec7
 PPYIeWq2UliJ3u48O1934O5pY0a1SbxET7irQNB3VKNuwHmyrkQ0k8CP4E8PGPmJK0sr6SStXR
 Cbc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2020 21:50:38 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V6 2/6] nvmet: add lba to sect conversion helpers
Date:   Sat, 12 Dec 2020 21:50:13 -0800
Message-Id: <20201213055017.7141-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
References: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
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

