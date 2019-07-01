Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE543C06510
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3ACD206E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JL8GBMnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfGAV5p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:57:45 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:61227 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGAV5p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 17:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562018264; x=1593554264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=OqaUD3tyvurJZF4iy8UPTGJAVxI+8vvw75Zn9sBYYZc=;
  b=JL8GBMnD50HsHxgTVbE/yudd7jbD/7ZzaeJ1kmcC2u4H3RKLDFj0uAoH
   FMfGIutJ2q9Sq765r8PJg40eiIySg1OIlYLypuBCBDKKXUu4pyzxI2QgA
   vX/hVCmuz+5SK8d8mHdsT0kQnJtb9sw1zIrWw4zOHs86b662iDiqgUmoT
   z8luDl6zCzrqtxVpoiL6jPwKL8cfvgV1ljVoxA6A57LJ3IxhtAgQCkVcI
   ANQDD9KsExm3ERXg3kOf5GVI0UhsegHo4Dff5XIOaFbqmoKu41PMowi44
   KxFELNp6a29fN7h/r9EMRWk/z7aPwGlL0JAx5u+flxrH/nu95YSvUFZTb
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,440,1557158400"; 
   d="scan'208";a="113190420"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 05:57:44 +0800
IronPort-SDR: HYLL+WjNhsxeRYljgq/T35Urm3a2KyIalpfV93Hdu6Rmwg6/bqPsnj1uDEOxgeWjAcUTNCBbGH
 ZYXNT9qt2nSD2WAIEhxRZYhhYxpddih7Or/L12Sp6cEd5lKMI97jBxdUFM92svfrN06osAv5SS
 +brvNezWetGgDMHmuMMYD5jLM2b1Mkfx1O2fDN1VEoY46wNsB69dWZU0iW53raJ8kA8bAfnd8J
 bysbvfrX2j5ciEK9Xr6g0823rtUEn+Cm4TcUzyhtWhzDxPLE5Vq7p+HE8b4MwtYxyMVUnxgb9h
 tYTZZZl4ehp85Ru/7f9kuKtl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 01 Jul 2019 14:56:44 -0700
IronPort-SDR: wxv1jtI14V0dynykEUh694Gd+y7cQjWb6GNJY2Fh1io9Yv2yWDaMNS0U/JIdWHAae8H+x4yL1W
 N8sJUPfXtNew4R3FGvi5vtEkUUuC+o/5h7G8ONNS4DBhdnjyj/KMZDZp04wpV/yvF7Z8u/99sA
 uBVwShEzK5Us0emedzyRYuwUbykkGHGjaXjaDb5eWT8VBIRhR7ziI9lLDS6iqG/8fpLe8oLFHM
 NE+ShJ7xGWHPzrWAT26BbsgntAdjRye8w3WoQUUyGZwqC1uRL8WOE9kirSgjy8CNKNo5LagRUC
 I1I=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Jul 2019 14:57:44 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-mm@kvack.org, linux-block@vger.kernel.org
Cc:     bvanassche@acm.org, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/5] block: update error message for bio_check_ro()
Date:   Mon,  1 Jul 2019 14:57:22 -0700
Message-Id: <20190701215726.27601-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
References: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The existing code in the bio_check_ro() relies on the op_is_write().
op_is_write() checks for the last bit in the bio_op(). Now that we have
multiple REQ_OP_XXX with last bit set to 1 such as, (from blk_types.h):

	/* write sectors to the device */
	REQ_OP_WRITE		= 1,
	/* flush the volatile write cache */
	REQ_OP_DISCARD		= 3,
	/* securely erase sectors */
	REQ_OP_SECURE_ERASE	= 5,
	/* write the same sector many times */
	REQ_OP_WRITE_SAME	= 7,
	/* write the zero filled sector many times */
	REQ_OP_WRITE_ZEROES	= 9,

it is hard to understand which bio op failed in the bio_check_ro().

Modify the error message in bio_check_ro() to print correct REQ_OP_XXX
with the help of blk_op_str().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5d1fc8e17dd1..47c8b9c48a57 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -786,9 +786,9 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 			return false;
 
 		WARN_ONCE(1,
-		       "generic_make_request: Trying to write "
-			"to read-only block-device %s (partno %d)\n",
-			bio_devname(bio, b), part->partno);
+			"generic_make_request: Trying op %s on the "
+			"read-only block-device %s (partno %d)\n",
+			blk_op_str(op), bio_devname(bio, b), part->partno);
 		/* Older lvm-tools actually trigger this */
 		return false;
 	}
-- 
2.21.0

