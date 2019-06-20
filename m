Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CC7C48BE1
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 17:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26E020B1F
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 17:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dB8g6H8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFTR7k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:59:40 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35454 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfFTR7j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 13:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561053579; x=1592589579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OrB3YKVsrL+G1BGsVU/QjCU+rmzvRnTbUqTJjO4JYIw=;
  b=dB8g6H8gSHHy9RLrdH+xXs1hLD7mDQrRtFtXQ4tKXwWaqwqW3uFxfMoB
   FUdYX2uRl4/1QM7Wti/Ufex8I1xsmgl/BibqFEZQx9GSLGbHrdo/uiDRw
   c+7zv6ZRfipp9uBNP7dsz53gfmV9ahno/UaWTcEDnwjFA0cFT8MnAxJmj
   Qfc4g4iywYHgb9yMJAfWaLA21V1OirmeHgmlIOutSXWK0MHvCn30Dy/md
   EwBns93JN96TzST+e8k5Y8ceUkguYBar1GH8deXebPdlZeH/VkezTjmR6
   vxorsfuPBvCtW7GcNFxHHNrwjhWO5R5VKknbsw5JDtX69niTzAci5Sj1z
   A==;
X-IronPort-AV: E=Sophos;i="5.63,397,1557158400"; 
   d="scan'208";a="217443480"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2019 01:59:38 +0800
IronPort-SDR: 5t5b4NUF9T9HCw8ZKnkKLGoi4NGQVjn7AcztR+GMii3mc6+uv8vWy2SLGImutixnrF9wz+ohOn
 GVNuok/iJqRjP3/72ZxC9XyjGrc9mDSUVeCdHdqfiUDY2m8BLWwdQEBq6ft+Qy7J0DGbLBCfwp
 Na8cxXUUVEwCbvUyoRIX1pH6NU/t/NwH6hCJj4NnoujCyoSzQIlpDoiLajZwRH9qpELdJwZpn6
 a8ggPOf6b7bRU7inlD8spefhX9JLBM52oi54hs+StUmoVeG4F2pksNV2Th04i4lcnQ8Q2leV45
 h2RNgSMdNCZEcQVBuhy7l9It
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 20 Jun 2019 10:58:57 -0700
IronPort-SDR: WwES0NvG1XRHFGCm+XhXp4gtzggHobHl/+azZvypmQNbabtP2HIE1cQyOc5bTgzSMIigTFpgmR
 spHy7GKQRDSfxx2RJkWV/LQwZSCaV7YAtsQ9Dk1kAKi3witXs6JARMI/4/njpwEoFnO95340Ci
 g1T25aJ7Idh4Fa3tvS2B3/SkPQlGrDyjraWqaiNi7vJrQ9HZW8LWF3qHjxttEClJbypcoyMz4L
 lPPCajoa92ZYU9DY09HZSNgPENd7UJjWzl6yJPVagNGpmg3nHJnPNZevF/plt1bmgsoaxqLX4X
 Ew0=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Jun 2019 10:59:38 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V5 1/5] block: improve print_req_error
Date:   Thu, 20 Jun 2019 10:59:15 -0700
Message-Id: <20190620175919.3273-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190620175919.3273-1-chaitanya.kulkarni@wdc.com>
References: <20190620175919.3273-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Print the calling function instead of print_req_error as a prefix, and
print the operation and op_flags separately instead of the whole field.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 94c6520bc786..77623cdf2e5a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -167,18 +167,20 @@ int blk_status_to_errno(blk_status_t status)
 }
 EXPORT_SYMBOL_GPL(blk_status_to_errno);
 
-static void print_req_error(struct request *req, blk_status_t status)
+static void print_req_error(struct request *req, blk_status_t status,
+		const char *caller)
 {
 	int idx = (__force int)status;
 
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
 		return;
 
-	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %x\n",
-				__func__, blk_errors[idx].name,
-				req->rq_disk ?  req->rq_disk->disk_name : "?",
-				(unsigned long long)blk_rq_pos(req),
-				req->cmd_flags);
+	printk_ratelimited(KERN_ERR
+		"%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x\n",
+		caller, blk_errors[idx].name,
+		req->rq_disk ?  req->rq_disk->disk_name : "?",
+		blk_rq_pos(req), req_op(req),
+		req->cmd_flags & ~REQ_OP_MASK);
 }
 
 static void req_bio_endio(struct request *rq, struct bio *bio,
@@ -1373,7 +1375,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
 
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
 		     !(req->rq_flags & RQF_QUIET)))
-		print_req_error(req, error);
+		print_req_error(req, error, __func__);
 
 	blk_account_io_completion(req, nr_bytes);
 
-- 
2.19.1

