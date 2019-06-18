Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDB8C31E5E
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FD020665
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VOWz7yew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfFRHEL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:04:11 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7915 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfFRHEL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 03:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560841451; x=1592377451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=437NbzGWjNTmwxRY1Fdvft+RTI2X8/BOyqds1LngC2Y=;
  b=VOWz7yewQVPS50CMPNk7GeD/wROqmrwQt1oP8EQiTvaAuo4WEKMYSWcG
   psAkE05ntERLd4TSM4W4Dv1buKpdjU7CesUpXmgiSDuY7IKVNpEOFBUmo
   WkcB/v/AybyXHmtH0KMHI00FmZ7qAcNIpRBlKth0qHQctZHBaIC5YLXHF
   Hg+JKo5+LI8p8U4c+UQnDqbch4Bhx6svYb+QnKTFnS3LBp0Ye0bNn5VDT
   U/YOW/fAn8fZ+HeepgbdMv2ZfYUHvb/oNfGDEQMhMu296EAKC881cgGMW
   EhqKw4nUmNk5hgUfzdQcI6yEiTR6dolhVV75VSDqV6jvmLppdOcoM4A3R
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="115733426"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 13:42:31 +0800
IronPort-SDR: qsZG/6YfoPQmDZnZ/ON+gr1Tjs57F95bBy089efIigxT5vxUZ5E/4A3/nMsvbAnzcxddFfaX+R
 f2DDB4qIRemnEGdqYLP7FcusEDskuv6rCNg3udRaLCauHUUItnd1kwEF2O7eW0UT2gqJjVGQcW
 +ClHdE8jkocJ0uXYyS3M431yE/GH/aTXgDwfiqQIBAQ83DF/lojhhRJ7WHQwWsoB4yVr7AFlBD
 t7SsCavDDpnOyCuKdxYpODZzcnT0bF/+wBwJOvP0mlSE/J5HCP42BDkThQ4EAHaalzcEjxczy2
 H0BiBaOm7j0qakoY2G3BRkwR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 17 Jun 2019 22:42:00 -0700
IronPort-SDR: KVk8FCHx8bEFX7vuVKzIfcmpZTJh/nOotSwEXnCdLtYOrSG4LmUohUqPZPweAgzqJNnCRKe6uH
 btNGye4DTpe9zys6XJYfjhLBQ/cVDeEX44kVM9+/c0md4rhPhgR9QA+zZE5SVA09R7KSyabRyY
 9Gcp3pSZwHEntdwL3v3NexaAV7fN5yMRDXJNECgGNXlcJCjjnMxGsjgHF5sX6iaFDtB/nk6SZZ
 RgBpIQndT13iAQIoUFaFK5+f+h3YBJt9IzNRktAkG2dgVOO5+SvM/LmzZnKhkqEA22zXLnRu1h
 Owg=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2019 22:42:30 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 1/6] block: improve print_req_error
Date:   Mon, 17 Jun 2019 22:42:19 -0700
Message-Id: <20190618054224.25985-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
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
Signed-off-by: Christoph Hellwig <hch@lst.de>
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

