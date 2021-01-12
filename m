Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24549C433E0
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90B222D05
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 04:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbhALE2q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 23:28:46 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45032 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730406AbhALE2q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 23:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610425725; x=1641961725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qwXyOBMpSjhNvMX3TuA4Swa6BZth8f79ppVgwTS1V1A=;
  b=adnrgVlULXIP860VcPmFeP4UWSRPFUswuFer37DzQYecX/AgADgPH9Zc
   XVXBC/4O083Ol754SHuJS9Klt4h448K5BruNuEEHJvRBdiH112z17Gy5c
   rD93scLscogWcmy7hmsfPBOihEUUAPygTRngAIcdJboXAZFJM7e1wv61M
   6lc14OUECqrbbvr4H4aw4k5w/ze/N9YlKoUHRT7TTiAyS9FS1MfOyfGCi
   wo1RfhfUi6tSU4WuG2oVPw37r8yDlfDZDXWKdlIPw/eFsoh+nzKhQ1FvW
   HSgufeHnsefBUUrdJmABDdyJ0OXZH/XX2xO3lRtASHJ5PcAET8cqcxUyW
   g==;
IronPort-SDR: kE/Vj64jz1TnDQQsxUqq1JJ40Gpme5Hjr2rhupmPjoQcbG4roWnDcYFWpUmwFI3mKsclS6XLYT
 ZXnSkqmu2koctNw0TxPXCJoZpm/W4TwLVsxtIgruxgYTRkPWupr/z5TDIX3f/U4CCyz4BnjifN
 SEWlRtEamu9vC6Ck5IuaA20S2kx6KIZLziWqe7sp9j+rOInMONeg+1yCjL1s+eA9PdNIuFgMkZ
 z4VEN3MoQaWgTdtX9OvLoUlBUH2LKJ8O0p+iaGiPy+odMxDK3zYN5e7AyCfty5/H1uN01Ppseh
 8u8=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="157206089"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:28:00 +0800
IronPort-SDR: O0QnDN7CPAX1A4glJWh3YMhLWNK9lBnxqtFs+4r4/qU8YLVABxZdaOvZd51PiM5QNPwtGFid9r
 dc3nNj+B8/XfDaxmL8/lct9nH1gXVoVq7YVZYt4g9hUh0qepEoQOjq0FJKHGSL5Ij9g9nFBLgF
 tNOAuu/Q0zYevR09CKOPz/dmrUGn18RjtwcnjtCJpsaXLLCmrlovxG5lbCkQg8rIfpPjO+/kY+
 k/VW94NLr/B72BGWrbA/YPCNdkP9c72z7XKGDi1OJ/DfuJvBZAGfVWBqvXY07CbEu7nnWN7eZf
 e9pqEk28TH8sxi02nB6irv85
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 20:10:53 -0800
IronPort-SDR: ENoUV6ViD+OhN4SyMyEOGFgI1dfOUK26uYgQuHPz0wjpqBXCXRofaWIQj9QJ1FEOdiBsp/jLbq
 dWvFH7tbkuwLeUOngPa6+3Irn8pa/s/qNgi2Y2McntxGmIeS/BLyrWeOjRQ3KI6gtx/4DUOlw3
 c10XoWgTBpgKuVT8DRRbvmh6ip62q/G3tQqoiBlZS+sLMzfWi3+IDg/be2kFeDtr5lDCcjM0rG
 cieMweCeSYmMbjjrNtYIxm5v6vb7pDPEKACiGlxSu1DXvAoQCI2TPlk3i05ornGsBMNF4jSOGT
 4mc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:28:00 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V9 9/9] nvmet: call nvmet_bio_done() for zone append
Date:   Mon, 11 Jan 2021 20:26:23 -0800
Message-Id: <20210112042623.6316-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function nvmet_bdev_execute_zone_append() does exactly same thing
for completion of the bio that is done in the nvmet_bio_done(),
completing the request & calling nvmet_bio_put()_to put non online bio.

Export the function nvmet_bio_done() and use that in the
nvmet_bdev_execute_zone_append() for the request completion and bio
processing. Set the bio->private after the call to submit_bio_wait() to
nvmet request. The call to nvmet_bio_done() also updates error log page
via call to blk_to_nvme_status() from nvmet_bio_done().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/nvme/target/nvmet.h       |  1 +
 drivers/nvme/target/zns.c         | 10 ++++------
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index c23a719513b0..72a22351da2a 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -167,7 +167,7 @@ static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 	return status;
 }
 
-static void nvmet_bio_done(struct bio *bio)
+void nvmet_bio_done(struct bio *bio)
 {
 	struct nvmet_req *req = bio->bi_private;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f4f9d622df0d..ab84ab75b952 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -535,6 +535,7 @@ void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
 int nvmet_file_ns_revalidate(struct nvmet_ns *ns);
 void nvmet_ns_revalidate(struct nvmet_ns *ns);
+void nvmet_bio_done(struct bio *bio);
 
 static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
 {
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 149bc8ce7010..da4be0231428 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -283,7 +283,6 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	struct request_queue *q = req->ns->bdev->bd_disk->queue;
 	unsigned int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
 	unsigned int max_sects = queue_max_zone_append_sectors(q);
-	u16 status = NVME_SC_SUCCESS;
 	unsigned int total_len = 0;
 	struct scatterlist *sg;
 	int ret = 0, sg_cnt;
@@ -306,7 +305,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 
 		ret = bio_add_hw_page(q, bio, p, l, o, max_sects, &same_page);
 		if (ret != sg->length) {
-			status = NVME_SC_INTERNAL;
+			bio->bi_status = BLK_STS_IOERR;
 			goto out_bio_put;
 		}
 		if (same_page)
@@ -316,15 +315,14 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	}
 
 	if (total_len != nvmet_rw_data_len(req)) {
-		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		bio->bi_status = BLK_STS_IOERR;
 		goto out_bio_put;
 	}
 
 	ret = submit_bio_wait(bio);
 	req->cqe->result.u64 = nvmet_sect_to_lba(req->ns,
 						 bio->bi_iter.bi_sector);
-
 out_bio_put:
-	nvmet_req_bio_put(req, bio);
-	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);
+	bio->bi_private = req;
+	nvmet_bio_done(bio);
 }
-- 
2.22.1

