Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDDDC31E5B
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A4B20665
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J4iaOaZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfFSROU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:14:20 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54057 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfFSROT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 13:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560964460; x=1592500460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bgxxsw+aFjGTScDcN8vsmnNC5VW5TuLIHgjRPRtB3ws=;
  b=J4iaOaZuhUHjHmmYVdwsfF/fo5vAXXYwTNVh6xfMTIk4Gf/nW4c0k9Wf
   RekREBoovYd0l1pVbn/FLtHxgjlAQ4+4AiCTI5aUyaYr/uz+KyB5EEIAz
   0KHLlX8KsLFlTj+1thKLqd6EBKKbB9cmuBJZZlPZFAxx5y7dsO6bjPH5R
   YLcngVPLNw6t02WKB1WoSaZej/Gt0WU2tSNUakszms7o1EDtrBy8k53q5
   lzK1JYmXCyCyyXx3wujwfMLrDDjVnA/p/gd+RZcjDtFoGylytSfmKp596
   /4pN2bXxWDuqU2WNVdDYwj0kGY8l00jbcHmYnBD+8inG4t3Zyz/ekbNoX
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,393,1557158400"; 
   d="scan'208";a="112626239"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2019 01:14:11 +0800
IronPort-SDR: ZqjiRYSJDsrosT+vQ3FXuX71jIgY8DLlBS6M3dJErAM77wsTkt3WkXhuZyeTHUa5gX9grpBXfM
 d9bETiSc1+Va+MZBqghxCLvVGTkCqtjnyCLS7skk3rK8gKApFOl2g2DC2atIrzoIWbFVCt0dNk
 p8kjWPTjUZLKc2+OlX8+81gDuhlE4uqHeVXwMaxZ/r6gWZNrTrtbpoVSh+9wTivgmQxOZvJG+o
 ypUQMtcttwCQ5rk6Q9f9nRbv0L7l6lhVVgP5GYaCG6IsO3sT63ndHqG90/WqNEUSKSDB7bJeoc
 jNArhPJCALn+ZdWdCJ2oRgKM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 19 Jun 2019 10:13:37 -0700
IronPort-SDR: IELUmEi5mJN/v/Lfw+gFwLw2/E+xFkfc0jGIr32gFGknQ+PkTC045pLO2LoD6E+2z8NZqjjdz3
 U18fcEjJzDpewQ8JJ2rUJ54XRxVkB0rviMMVMlMiHkLFCfr2CCMt8iP76IkqLYr6G36AAVwVrA
 5tQFl3a3ECQd5J1cDmJ4uQU0eLhRejfy9i0C+p9YTxhqWILilXboLeoecsb+iQT7x2i1k52NJR
 WsXNMbIyz9NMCK7LVeUmskhKjigsWDboNOpPmcV7UrErM6Y3GZf20P87vjUXdjkeGY3Wwda28D
 lUA=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Jun 2019 10:14:10 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 4/5] block: update print_req_error()
Date:   Wed, 19 Jun 2019 10:13:01 -0700
Message-Id: <20190619171302.10146-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
References: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve the print_req_error with additional request fields which are
helpful for debugging. Use newly introduced blk_op_str() to print the
REQ_OP_XXX in the string format.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c92b5a16a27a..88a716c3dc56 100644
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

