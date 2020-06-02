Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41C4C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 01:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FCAF206A4
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 01:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VinNRjFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgFBBc3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 21:32:29 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:17815 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgFBBc2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 21:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591061548; x=1622597548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2rev2lubp18j9iAaweNQ/2EK4fagwYwFLzMIMtj1Rzo=;
  b=VinNRjFmw7koDXpXrFHIWRbakdihX97+jErsqjb+wegE662W3tfn78+V
   FnQy5f9UeySUqpGZldlxlDsoMZP3xxQhMeiISz5RCx8Trvf20SehRnhEc
   ofLp1TgBb58uvwJsQdtyLoErnTxPNIc4dJ5FxyEO7yqHpUydm1muwSVUr
   W8CThj8W5kKbbVgjwgr9IK4gUcX7749s7uX1Zp6U+OAuVhPiEjmmV+AVQ
   iNgjvUcnIWBCnzZwzpEE+pdEqMc8Dfq9S4rUoqSNLneB41vGbaboVWo6U
   1WuezyevhVNvofrH+mzEzGd5JVjZ3IjyfmaBadrOOjRqPRfuRkcolz81f
   g==;
IronPort-SDR: fdMjnkXTO135e8JZRETx9X9Q0/PcXXG22Gti2lnZe7fbf21Mrg94o2gFr59/xFrxXViKWM3Q98
 2xWdyXRMvulmT+Yfzr2soRnEh5RDj0g2xsGcEu590cdbEvmB+u2DiJB846WEaCvX8Q2LHdep+j
 Nh+naE0mq5mev7/aiqYLVH0iiHgX23oHgTtgJKFkNGdescR663QiG+34ZNQiFnO/jTeb8yx3Z9
 WqI4FYpObKQVRv4W4ovSnkdM5UA/WGzt2iebGCMugQ35DKfmR/nY+v7QXHCfJp39Q1DWO/LzhL
 Z08=
X-IronPort-AV: E=Sophos;i="5.73,462,1583164800"; 
   d="scan'208";a="140411685"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 09:32:28 +0800
IronPort-SDR: 6vMFFB61/csOBtmDSvm42lkH43EwIhtrw/vDO4Sjn3WTNGCeaIOnhjdSJL+ZzJENSBd+PSJe6d
 qBb4KFMpGkSAEUzYDQNhU0bUyok4oAy+I=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 18:21:36 -0700
IronPort-SDR: EenE78uCC4g9oOjdode9DQnVBxZ7NiHEzD7ZMzUTUSugu0tQOTiQkBUDzRmpgt6Vxj24pKCO5d
 JDKFqztsHpUw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Jun 2020 18:32:27 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/4] blktrace: use errno instead of bi_status
Date:   Mon,  1 Jun 2020 18:32:06 -0700
Message-Id: <20200602013208.4325-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200602013208.4325-1-chaitanya.kulkarni@wdc.com>
References: <20200602013208.4325-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In blk_add_trace_spliti() blk_add_trace_bio_remap() use
blk_status_to_errno() to pass the error instead of pasing the bi_status.
This fixes the sparse warning.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 27c19db01ba4..44a2678b8f44 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1000,8 +1000,10 @@ static void blk_add_trace_split(void *ignore,
 
 		__blk_add_trace(bt, bio->bi_iter.bi_sector,
 				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
-				BLK_TA_SPLIT, bio->bi_status, sizeof(rpdu),
-				&rpdu, blk_trace_bio_get_cgid(q, bio));
+				BLK_TA_SPLIT,
+				blk_status_to_errno(bio->bi_status),
+				sizeof(rpdu), &rpdu,
+				blk_trace_bio_get_cgid(q, bio));
 	}
 	rcu_read_unlock();
 }
@@ -1038,7 +1040,8 @@ static void blk_add_trace_bio_remap(void *ignore,
 	r.sector_from = cpu_to_be64(from);
 
 	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
-			bio_op(bio), bio->bi_opf, BLK_TA_REMAP, bio->bi_status,
+			bio_op(bio), bio->bi_opf, BLK_TA_REMAP,
+			blk_status_to_errno(bio->bi_status),
 			sizeof(r), &r, blk_trace_bio_get_cgid(q, bio));
 	rcu_read_unlock();
 }
-- 
2.22.1

