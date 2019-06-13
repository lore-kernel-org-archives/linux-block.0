Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F4DC31E4B
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22B620B7C
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="htdhaWt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbfFMPFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:05:16 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51275 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732457AbfFMOQi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 10:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560435419; x=1591971419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HOOccSOH8pQ+2CS5KZoE/1M8aO0h/o7EbmwVy1XVg0Q=;
  b=htdhaWt701cT4A9SrNM27oCs/bwS9/huvWy8o9eKET1GvckBOCJfKUmy
   LGrNrXuXzygxjdnqEKfAPoMd5Z1jGAUhBMJj6m6g5D/UtlrTLmDOoP7OC
   uTfqoYTw3lBbcsq3OKojTwtrKlUrWw8YmjvaE6mpVFGhmD07WGfpyTkh/
   mf1NN0ScC3FWtc7+hnIZKqs26PWPhxpbqXx88cgiifF0jlcZNexkjmyfY
   pgohwwrs+xFm9rKqYOVOPUFSOmgYJcrvrUM0HoDnDKGYYh+Kp6vigCqQ0
   nLXWAnUYJmrtJBUaL+9JnwAjzDadekOHfwBv/U0nLfVKjUAq5R+ps+K2H
   A==;
X-IronPort-AV: E=Sophos;i="5.63,369,1557158400"; 
   d="scan'208";a="210177617"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2019 22:16:59 +0800
IronPort-SDR: 7DCfjMPET2lGbuUHkF23f4lq37bhB6mPbPktaPQA7FlVldECmqTW8BpjnxJWGUDUPe2ABLJnUL
 VIIvAJFthuPU0AU/yhA1q9vRjL0hZYPXnnLR+ndyO9toKyHdyRVdX/aJtNnRnekUXpQlUbZNpO
 iUyFYy5y8Lm5K1/L3IqzEXEFqDc/omZARgVYRi4FBbSJouaxbN+h/szblCQvBPC7MIbhJp5h0L
 nt7D50zXRUz6dxAqh1C+1zzevF1NPEnZO8O3bagkvjGZ7wuVi0zSgkbKNs7I4hjeIolv0nPBEk
 +cBZy1+AerCvcNgMWsMYepy8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 Jun 2019 07:16:22 -0700
IronPort-SDR: jC4e1gzs3EWUZbERYUfuLZioaP7gwgaX53abv7SmCBO1fy502Vc0uoWfWLGTOfvvG0U5jhai6O
 e5Vo0EAzzVMMAFesBvnw4+OvM3K1BAvP8beIdDQlx/YwXshjc+MtohZoMj1IuvMqwBr+zXqgSe
 OeE2hW4Y+2dJkMfX6VzRwWebfhqImG89rCOhh4ihCGWsRh6BNQEiybe3CSTOC+JjtNdJt2EtR0
 QiR5h+jbzAAGYuKybojkxDOeFB4fTdA8m14U7uXnVfixPedkYGQCEtWq0E+vrET9RKl8XgdeWq
 UDk=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Jun 2019 07:16:38 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, hare@suse.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/2] block: improve print_req_error
Date:   Thu, 13 Jun 2019 07:16:28 -0700
Message-Id: <20190613141629.2893-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190613141629.2893-1-chaitanya.kulkarni@wdc.com>
References: <20190613141629.2893-1-chaitanya.kulkarni@wdc.com>
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

