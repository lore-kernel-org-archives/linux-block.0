Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249B7C06508
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 20:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDF920883
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 20:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YQm4cFGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406414AbfFKUC3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 16:02:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61749 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406376AbfFKUC3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 16:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560283349; x=1591819349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UE5quU+yrnaZNy1mFLSgOmIVZCbxJ4y+FIX0MCJepmI=;
  b=YQm4cFGPXai9k/SKkg9iN0k3OBsW+P0hNryEevzyt+2CH2KB1Zg8nqUm
   7kPksVjU0R1TNm47/w9KZ1S/rDDAmU8MubtR63/wqrql7caLL3kbHuviR
   N+VtVQCvMGGLzwU7prOY1GqXo4ePfFA6YvXGJ7fjgKpACCEUn3ypJjvKD
   sxRlPpFTppRgfeRweBId8KCP2DrLTRvwMEp3R1ekcJkjFmIIwRGR0AIrq
   n5hVTndd1vLDJ9p01L1ds4/sUo87NfptuJQSMWk1HX+F+Iu1p6lgcuD0s
   JzOiAU+9nmpp9XtUUFt6l5IjytfvyPcFtmMQ0msZtc4YqoGScOL+X9EhQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,362,1557158400"; 
   d="scan'208";a="115255372"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2019 04:02:16 +0800
IronPort-SDR: zAKMMVRuYQzNofwMrxjaRV3ROAOSCkOm7b5bmiVMW9RuOmM7bxR1XcPbc3TiwtIUM4cGETMh1Y
 8tZYrSl6hZ5QdthD+Tu055pUmPoUuInDCpVb2YcQYQB/Q3lU33izAKWYS6TciIiPjIfEz2Cgte
 SKdzz/a87YZa5OeyBwBdzQU7qe1ft9a+ugxb5oPYNtnYR6aZnwA0n/mO60zlpWfAQS2zYWxHcG
 5pOXj4vV0fjP7T3nwEOntxkBgCPbr6i5EvV6z7jqfC51PSHE7pK6FAnRcedR18kpXjK8oaQKjL
 3u0h7cu0FvZLmtDuSIl+b1NM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 11 Jun 2019 12:39:24 -0700
IronPort-SDR: Fs3Xjs7dLJwsPO/QlW4wNRueA94dn+TyQ0mfD+lzS/32RRmtraGQgtg9hjjPe09B2XEVqj6ku8
 l6AOaa3tEVURhFXFA+DRiF67lSLP8d3QXeGBuRl9vTuDn2+PumsHqTUHqRPCTIGa2qlRVKXL8D
 T8LPjJ4Epy1CzxMcjuhDx7UFCpdmWL+PDrX+HuYOAqhgEXasNObukGa6+9MKnrUy0NDUe0ImDF
 8mPJL/IiiWpkpBsAVbMSNl4bY4tl2b8GjAGzNO/urUWVQqPdRsx9szBX05a8krxQDFzWE2vEP1
 XDk=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jun 2019 13:02:16 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, hare@suse.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/2] block: improve print_req_error
Date:   Tue, 11 Jun 2019 13:02:09 -0700
Message-Id: <20190611200210.4819-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190611200210.4819-1-chaitanya.kulkarni@wdc.com>
References: <20190611200210.4819-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Print the calling function instead of print_req_error as a prefix, and
print the operation and op_flags separately instead of the whole field.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ee1b35fe8572..d1a227cfb72e 100644
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
@@ -1360,7 +1362,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
 
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
 		     !(req->rq_flags & RQF_QUIET)))
-		print_req_error(req, error);
+		print_req_error(req, error, __func__);
 
 	blk_account_io_completion(req, nr_bytes);
 
-- 
2.19.1

