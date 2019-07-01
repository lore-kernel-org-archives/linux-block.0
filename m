Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515F3C5B578
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2387C20652
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZZIFA9HV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfGAV6E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:58:04 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:49978 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGAV6E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 17:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562018284; x=1593554284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=SM4vBhjIMuIjQIIkPMmNSjGDUMbO4rTKMZzMc8UskaU=;
  b=ZZIFA9HVeSYt9Y8HlXxKic9FrxKeWNYAzpDjhnh8guDtK9L7jXKwK6Wm
   w105ZKNaZzep5NMpbluGb1G7bojNk5D90MDLORDtaqMxz16dShWHpfPON
   THSSTYs7mCdkLDF9LxOpdZ5tWTpzwaP6fBLVAvRUjeKlYfh8FMhDmSXEE
   8Sz084LfWBifFBxlMbxMBv0Ox0PquI8W/UbS8Xalo+TYS2RBCRY+polIS
   t68MZQDLxytiaRyPN9TPjSYGcNVX0Cfzt6diGVhrp8NR2Jh8Bq8KeUzzg
   dUzY7QPNKoq7mvHYHrsn3koDjEwSu5eoF4qzAkFAuJKICs9uFek1/Yx7b
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,440,1557158400"; 
   d="scan'208";a="113614943"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 05:58:04 +0800
IronPort-SDR: t9a3E+gqKDrf65hKIG62GaXPU70B+9E1zVCG9p4NjiXFBgQmNiVIYc8DpmqnRNon0mXWL4/hpR
 LT0qxUMICaBnBMqUW+qb3Qi7X+pieonfX2MoevSqYiCDxVxMwhKvbeIBhhNRnqSs6cBTg3TV0e
 yTHKRSzUv8umB1Kq6zM87D00/qLHKJGF8WQ8Hn/UrQr3F1cKDCXP8OC/l7oWjZVd/jdxygxZ6o
 VTUD/bRiy+d53Z8/BUt/i/stnqXm0qIwSKsdxGSgyTuUMfbxVGM0FBZCs+WNaQ7gXDjVImyc1u
 n+3tpW5jBkAprvQgdwk3Qkcb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 01 Jul 2019 14:57:07 -0700
IronPort-SDR: e+BRmQAwH57/flmFvsQ6Pi8GWmwJl0oZ71gtjgNdmCq2EN3CldpqQ1InjNWVtGq0B1oBeOBsd+
 kFszZuOSH18RLPIwDQuKI4Xt94EU0l8vAv40wQPezVoRtOtGcS3DhfqFKo3eZoEEF7cqOlXdaL
 bv1kLKT8vZz+a1WGE8clxQDtDrXl/ApwMerjBGhUmCmmTEmTFNhoRp6K1sboM6C2xXyBHPjxmY
 h9eYIBUbtUcMBrxqcroJweQRK4ZibJt9YOvzlfmlJ5tyPVhAc+V2PrYsnrLymBfxnDADKmxVAS
 QQI=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Jul 2019 14:58:04 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-mm@kvack.org, linux-block@vger.kernel.org
Cc:     bvanassche@acm.org, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 4/5] mm: update block_dump comment
Date:   Mon,  1 Jul 2019 14:57:25 -0700
Message-Id: <20190701215726.27601-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
References: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With respect to the changes in the submit_bio() in the earlier patch
now we report all the REQ_OP_XXX associated with bio along with
REQ_OP_READ and REQ_OP_WRITE (READ/WRITE). Update the following
comment for block_dump variable to reflect the change.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index bdbe8b6b1225..ef299f95349f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -109,7 +109,7 @@ EXPORT_SYMBOL_GPL(dirty_writeback_interval);
 unsigned int dirty_expire_interval = 30 * 100; /* centiseconds */
 
 /*
- * Flag that makes the machine dump writes/reads and block dirtyings.
+ * Flag that makes the machine dump block layer requests and block dirtyings.
  */
 int block_dump;
 
-- 
2.21.0

