Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4F4C48BE1
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 17:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A58621479
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 17:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h1YzAmyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfFTR7x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:59:53 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35454 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfFTR7w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 13:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561053592; x=1592589592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LzGOF2hHrmdE4Fm9O/m8R9d5DTCybctfUkNgYUB0sz0=;
  b=h1YzAmyWVlsMcrfYGysBMfyiXR2CWCHu6jYhjqSt3WWlbpzJ9gWgVjCc
   N6V3kWYnoLI//ph1Tl2fGPtpPO8nrYdBn4iW2BAlpxi7VWVpUpg68m1vn
   jmGG1bccaVAyvlFHz03L1eHIZ43wwqMahGMfajz9Nu6uw5XIPQx82ezg/
   /CtENVFZNewax5+QUzB53w14ZuYvD2rXojVnEMIHyVa2qJq2dh+ltitIE
   QuUf1OZLGEv6TVaW0pOMW5OZ4dOAKpBg1n9i6qmQwTQv6/mLB7ILdydpI
   luUzVDWvf1O69k/hVH3q7yYYK1zi0xNzFKLUkkbTP5DoD4HLpuMuMMaOu
   w==;
X-IronPort-AV: E=Sophos;i="5.63,397,1557158400"; 
   d="scan'208";a="217443494"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2019 01:59:51 +0800
IronPort-SDR: vTV0pjortiEvxihMM/f8VsNMFk+ssFBx9xxEAaCinD8CnSXG9jCkpFP02G5al2J9jqU+b0wL9n
 Fybqba2BcvNiBVgDKUawtxYDgzBq7gU0YbP2b+vaPDQY0Qu8nTcYJxol5esWjbmljInRWEz5QO
 /G+Ljty10hm8T/VEeSacyxbt/h7QcQ2k+rMyGTRvagj4eMt0NNZsuR/j/q4xxNVYdBwavJ5cDU
 /rn5Ka5Cms/h/znxJ+PJHgIti/iO3SYawTXqkrcAQ/05Q/2zQcHpnZ68W7QFiH/Zd45YtMAC3z
 2DXmAircUfnISc7EJ16lRMYy
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 20 Jun 2019 10:59:11 -0700
IronPort-SDR: JPZCdUNbL6QrcMTJAfhtMrR5zBamamicgH4WSqgED3jPiAd2PKt7bMr642hnz4zQ0LPmIx01qg
 uJoUrXVkMeYntFMKT0AJSupg7M/VUaWQ7EKp3THXfJNkMSki6ZzsXITTrLMeltOR2W3wKF1zEj
 w1JQ4bAzolKBYl8QNCxA/vlviHnAGKq+IN7t5X6Bmj3g6yB1WoMlihXldMIcfYwVLgBYts75rM
 /QVHpZRFBAAhD8L21pF2jYeez6VX19K86baB5xRO55mYzeylSH8FYv2JtozQ619RUWHZ6G8G7X
 5s4=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Jun 2019 10:59:51 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V5 4/5] block: update print_req_error()
Date:   Thu, 20 Jun 2019 10:59:18 -0700
Message-Id: <20190620175919.3273-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190620175919.3273-1-chaitanya.kulkarni@wdc.com>
References: <20190620175919.3273-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve the print_req_error with additional request fields which are
helpful for debugging. Use newly introduced blk_op_str() to print the
REQ_OP_XXX in the string format.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 190aba04da3e..9ec86c111920 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -212,11 +212,14 @@ static void print_req_error(struct request *req, blk_status_t status,
 		return;
 
 	printk_ratelimited(KERN_ERR
-		"%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x\n",
+		"%s: %s error, dev %s, sector %llu op 0x%x:(%s) flags 0x%x "
+		"phys_seg %u prio class %u\n",
 		caller, blk_errors[idx].name,
-		req->rq_disk ?  req->rq_disk->disk_name : "?",
-		blk_rq_pos(req), req_op(req),
-		req->cmd_flags & ~REQ_OP_MASK);
+		req->rq_disk ? req->rq_disk->disk_name : "?",
+		blk_rq_pos(req), req_op(req), blk_op_str(req_op(req)),
+		req->cmd_flags & ~REQ_OP_MASK,
+		req->nr_phys_segments,
+		IOPRIO_PRIO_CLASS(req->ioprio));
 }
 
 static void req_bio_endio(struct request *rq, struct bio *bio,
-- 
2.19.1

