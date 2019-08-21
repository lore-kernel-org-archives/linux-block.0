Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16053C3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB71B22D6D
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MVYTaY+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfHUGMM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:12:12 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46795 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfHUGMM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 02:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566367931; x=1597903931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IQBOi/8x2aPXJQodxMci9ho96QkK0SGrpMvvwAC0Yto=;
  b=MVYTaY+axZIwZq2Z5fN06ikEaYgy7nDfDynlxSbCunfTeO77hO/cvK4z
   UtyYQX+CQIEPcg1jJLo01zWCtAYCZkZTT5Ocm+/p2+Ynsdfy7ci4eHUBi
   Bh5koo1wogCVGzRB4JeCCh6ABWTBsQgkP+KkpiRNmRkJnDHiclMynPnP9
   fTAEK9/9nFq8zOmbD55gNVXYFF3yEwdRvE0d0hT7K+IdP+SFATdNrdlZp
   9RURLQBlsqEE7alxrb7qzzZ2pK7v6kn2JWNbIjbLP0Xc3eYoPMVhlN6LQ
   HoOELsXDpGz7i1kBp1r3V3gMD/WxJqIQoq7ZBAdEnfQSPMZSOLBaThdkV
   w==;
IronPort-SDR: l6h9q+UQNcygL/sw5ISEVwJuagVrFScnT0LcYS7/hlbcfe7D1vZc4suRg8bLLtY+duz94IaO7x
 TdalDAjisYYOPI72xRa6LfscQH2oDqWSV3IVDgVJ4Qt1heiPZyX7zOezoZIVJBT9tpHEHH9Z5D
 mwz6D+nyshQWoQc5PjdFeV/Awqs9pEdQe8PZKz+7BQRdGFIHhf85JREnQz55gSuutzUHIIZPIr
 2PIOY05cMHTQRTsnuQaOVGngGqEPJQkH1/PnH8twP2l7np7IIuYxX3DGPrjkzrw3uDDpOWRSt9
 pYk=
X-IronPort-AV: E=Sophos;i="5.64,411,1559491200"; 
   d="scan'208";a="222880648"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 14:12:10 +0800
IronPort-SDR: T2KdlgKrX1nPg/2Y3uANxYe3qPeIN/uJ2bS+HOZ7Rc1kCkHmSuXVrI0w830oWcKVSjs+tIPMkq
 ApRv02fIqcQRd0KTq7lJYj2g8DaXLPvMMUHiBZ0a3my+G78gYazo5wAV5ujSUahas07YjzIGuW
 2UmEFyV4/M4yUP2AuoU/GXBV1/a5g4akLJjgIOWML0abmdf4JWXACE/TN2QLKDI8acVZXyihhm
 Zeh1mcXPL5Lb1/dwBWw50+il/c0wItDNwJEGmrvE1HV0NPVJVRwJRTdTYcQxIsZqMxhLbmEYVZ
 3DhApw1f14UQ3+0RTJfz3+Tj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 23:09:32 -0700
IronPort-SDR: AIMcuy8tdm6xX8+Jt0W34QdH3QJwXPMUaMbGUq3eMZr7Uj83yeOf3a12DwieIpMVdntIIx4TFk
 8mWJOWbw2sxE0l1HQc8ALAHi0OHr51VwvYI9Y26CZXfy8lLsC28R4xRB11cPBA+hL3AdqMbzwT
 Rv3mvRirvY5N9IOgwlWwrKktBykOdcjL1EDGhSKQnzqrCBzpJQpBuBk4i1E452FD3c8yR5EXWo
 3Ij6CkvLZ09tkv1uX697Rfxtu/Kc6KZmDH98LuV3jAq8Ncp8T9UOiuSQr9RUXokpzjqqSDNqWM
 dHk=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Aug 2019 23:12:10 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 2/3] block: set ioprio for flush bio
Date:   Tue, 20 Aug 2019 23:11:55 -0700
Message-Id: <20190821061156.3127-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190821061156.3127-1-chaitanya.kulkarni@wdc.com>
References: <20190821061156.3127-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set the current process's iopriority for flush bio.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-flush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index aedd9320e605..642a01b72a8b 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -445,6 +445,7 @@ int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 	bio = bio_alloc(gfp_mask, 0);
 	bio_set_dev(bio, bdev);
 	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
+	bio_set_prio(bio, get_current_ioprio());
 
 	ret = submit_bio_wait(bio);
 
-- 
2.17.0

