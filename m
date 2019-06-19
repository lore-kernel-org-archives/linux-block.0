Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEAFC31E5E
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677DD20657
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lgBd+t9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfFSRNw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:13:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10796 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbfFSRNw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 13:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560964433; x=1592500433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mrjiBfA8h8qDNTOQO7p0HkeGNBRUV8HORopCFjU75pY=;
  b=lgBd+t9usNyoACa9C7sSIQnZBY4Jr/qD6BvG1BxG0WIaX2upLr7WWstS
   NkeG3qNp249G4C0vhxZ5fMt0rlGZoFH1Y9oc5PGU3/BR8/iPHYSyPbkbI
   M61jMFbSKXb/jJtqK7VjkhDVoHhrJh/0bymXeQDAGzf8XObgu87Lw8IcL
   8I6ZZ86hY1S88LN1HEDONL01qJUGI21SH4jT9LMvushGxZ3WO8UGIAf3x
   eTPvq7gcz9RPk4nzQIw4bKFA56QiD21c7F6hnpqWijbY4kV9JYzkitu3q
   b+s4YGZ5lVsxG/tgPiGHXEmUfNnn2sOfu9pNvbzb0ew4f1QTdfbG/G/I0
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,393,1557158400"; 
   d="scan'208";a="115883801"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2019 01:13:53 +0800
IronPort-SDR: faDUmELcQo74+mT05T9Om93sYNDHrQNVtUvuxiubcRnq5bu9EmXLSri8Z/azptpCwZs3U+rqDb
 Gp8csOdmlijLmPdQ3MSau8+p93yeKrkYidRpUJkxHq1KSpZmfT8MbOW3T80KyVZk+XAUrmrwXx
 j0fd8O4vhlG4Tw3SRxbQ6/o3cXkFIW4uYV2Kg2fW6dWLOFF4j+F2n/q41mBd2PuCuIcUkyRMPB
 KxScKXYn9ABLipwItM3Yeag5ord+J8WVM8l+PLqhDxmFvQ8oYcWfuq38u1URHOcxjXGNdWhJQx
 TwNeOJpkDfAPHcaTBVYu4ZGv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Jun 2019 10:13:18 -0700
IronPort-SDR: QJJqovorEo/Vw9i4WQcnLbYMtDfCZpnK7RdzWdJfILBTXo7BuxW81kzHOrKc/2GzEkDcqxvIIi
 oD8NfDHsmss5KNjcfTPs85Qd1QxZ+7VbJ8+eKErQQErPNpT33Z/RX9/bhIcCUG7sQoWjJN8uaj
 CQs7B8hf3iUnsXAw0/S5TQSWXZ80N6Fp/2BMoIPf0P7LOJsOWNcsbWfykSLKUgsWXPaQeZN0qo
 pc0HA/rtfstHLvGDVKgimPUUA/6ThrZlDaaztuXyz9K/4HtS/4YsiFrXfrkkvHJFPUB+USY2Kl
 jdw=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jun 2019 10:13:52 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 1/5] block: improve print_req_error
Date:   Wed, 19 Jun 2019 10:12:58 -0700
Message-Id: <20190619171302.10146-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
References: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Print the calling function instead of print_req_error as a prefix, and
print the operation and op_flags separately instead of the whole field.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8340f69670d8..6753231b529b 100644
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

