Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDF5C433DF
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 07:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2737206DC
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 07:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HKFS/PsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgFDHNk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:13:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7555 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgFDHNk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 03:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591254820; x=1622790820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s9sdczADB9/Dx/4in2C97//1RLCTHZ80z68kbrq7KPw=;
  b=HKFS/PsDa5YtL1NSNiT0r2L1Pf/4ts6zn3PIee/iZ1TZYngcMNEbwzwC
   dnf6qediLIh/xA2ZklpEWprbmRdauzA8nxvHIryyJ9DSvq5Yqi4aQSaAP
   kzeLoMQ5JYLjRaxakRbeqRZRKQaS4qShuanN1CHNvbLN5C06dzXg8yR8t
   0qUjJD0i9y0sY4hQEKbn4DTObEblxdCdxy73OrsoB/uzyvIgwJCSuShzb
   PYIvDTOEplE2Ix9tZ9em9CJSNHkQeerWWWewJ5JuJ8BrDeD7FtO7iPGlb
   p1yBa8YZnpjSvWlCY2REnGYT2hGFuml3tmNX4IBXW2WNu2Eqd9dqvB4ih
   w==;
IronPort-SDR: cetzZip2z/n0SwvcRAbLG0uqkQWcH2qwiuksAJpEm9DHgIsfQYTR/ARwJPCgMmNLFHPsx9LCLs
 Vr7UvxXG+qXiEVAJ4fuEbYhEs0icihYG35DcX419i9UEmQvZOdtO4L9l08RT3eQpcEhHw1s7nZ
 5ksIXYZOXngYGafXa3WBbO9K6HHgoJ3SwQJ62x8eYL15atFz95tlw95gBqjKwdF+/SPlJZ8/zN
 Kudyce/s7QJ+UynOCGYJZptfx9gMfsJSmgvCMWpRvZd7D8vGLyuVeeNBq1AVZCdCdpVAP24Sjq
 idM=
X-IronPort-AV: E=Sophos;i="5.73,471,1583164800"; 
   d="scan'208";a="139494861"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 15:13:40 +0800
IronPort-SDR: KGartIt6c7/ZQ1Mkb+P5t6iHp4hFOECFerWMGsd3xD9VIndHa5Do+LCHJGBOREoU5WpuJn43T3
 BfV0l8UrqlsIbmyirTKwB5FI1C3Feq4BA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 00:03:16 -0700
IronPort-SDR: 5zCvu40Zx3y9viMfW/0U9p+AZ/CE4ZQZdCxEgVYO18GiDY1W+nlHOMXAYjyhmUBRIh6sHaHmyf
 ZAxIN0zkujNQ==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Jun 2020 00:13:39 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 1/3] blktrace: use errno instead of bi_status
Date:   Thu,  4 Jun 2020 00:13:28 -0700
Message-Id: <20200604071330.5086-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200604071330.5086-1-chaitanya.kulkarni@wdc.com>
References: <20200604071330.5086-1-chaitanya.kulkarni@wdc.com>
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
index ea47f2084087..f6f4fe6ea5d8 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -995,8 +995,10 @@ static void blk_add_trace_split(void *ignore,
 
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
@@ -1033,7 +1035,8 @@ static void blk_add_trace_bio_remap(void *ignore,
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

