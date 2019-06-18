Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF9AC31E5E
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5769320665
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 07:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UALdGP9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfFRHEM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:04:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7917 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfFRHEL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 03:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560841452; x=1592377452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bgxxsw+aFjGTScDcN8vsmnNC5VW5TuLIHgjRPRtB3ws=;
  b=UALdGP9uHepDtMzCR9zLETNWBl+A0nWLf/NImbDtkEV8oR+FlERQibno
   R47DWRhlBgt/2paJMz03bnB4L9/5FJy6fdRJW6vNo22fCEQlvnmT8Q1cG
   xPIYBg4ifQ2AZ/pouVU7+F9UY7CuR2I5H+ZHjXiwfFiKFQdK4QBUr5lDz
   f2UMv0dQI2zO4IJlv4FfUO7Fo74gRsTyhUmZyAp6x+kF2pUyjj9KjEESl
   zOB9F2KDtgqTIhRU8I+h4Q7YFudobVBlQdMSwQWyS5JOA/JKi6DiBbJBd
   HluWt8ZKvL4OmRDD2mUuUBD60uCUTmH8SNs4Af09oHUr5VUypcJQ2qhK9
   g==;
X-IronPort-AV: E=Sophos;i="5.63,388,1557158400"; 
   d="scan'208";a="115733434"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 13:42:44 +0800
IronPort-SDR: VJ4Y0mXP9GmuQ05NgiZgQoUdDgfw4OG29oWVhEPKEpOCEvxgsCSyT5qO/Sv1q3wpz0tsZOqW7F
 1wOQ/4rnVoAgX79TvN9r6W6wazsGSM9wGztJjShloqa5o+hpFUSUINLjRzRUDBs4qnX3JrZ3w2
 v0Tw/stEvq7lEoQVFzHyPlZwrx6WEYbHuB3RTEiC2OsriOKzVD65zLnXDUX/deVF2fwFSTumAa
 3f7pkWcA1tRRD482/w0dn57XzIri/Pid62xpWgO/COdRdu5C3y7R3jBKU7BxrORuA0weIjSjko
 N1htzbTxXwT6d9NQ/WgTsqPF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 17 Jun 2019 22:42:13 -0700
IronPort-SDR: bxbWO8GnNFEEE6QeHVKkvsy0/Op5viMOXOCZEaMXB9kCzI4FGkvFg30WVH0318T3iBTsqxf+WX
 zND16Ao+JX7XhwoCpRBh9tz8kwIk87PGub6Ypt/kBTUy4UTaDKd1aLRR3VB71gjVP0CHMrMT2G
 ZZBCPAnEw9LsDyKbn3IP6x/5UQ2XcbvCpAnF9qaNggbnus1Egj+zfwzkSSUQe3L1W48J6W9wlN
 WtRLLcjcUhxSgIJ+ekPd2a0Ohcu7ykK7rmLvcMkkN1FyyKTqZa7fAd4GuTKnsCRcNHTRenLDeI
 +Qo=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2019 22:42:43 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 4/6] block: update print_req_error()
Date:   Mon, 17 Jun 2019 22:42:22 -0700
Message-Id: <20190618054224.25985-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
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

