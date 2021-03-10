Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB18FC433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 09:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A67D64FF7
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 09:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhCJJJt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 04:09:49 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38066 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhCJJJW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 04:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615367369; x=1646903369;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IV4G2JNbhUnsKghKh6+JtwEd+Ovzkixl0wVXDkH2mOo=;
  b=Xd8U+d3qGXjaam+MYS3vcrRJVRsxAmtZMJ3XhCysVZydanVqigNjJvNG
   o+dMmsOF3o2NSPkDTQuN2G6K5OF8s1NgPwBRtANR4mi/JsGbwSi54O6HL
   ptJVO/6Zn0weyTXDiMismHm0gYWBwLRblZOAnpoLTp6u/9SF0qoSy7Fxg
   RujitDYs82Y8KxgeEPia9IIproX7inqYnzuG91GE5an7ZnARkx/BJuTIK
   iynyYobkenH43OEyKhyIrc1+6cQ/6/3dg+ZF6JcyZ1vc1jvHM/dZBEPIK
   9ZQ6P3AurFveyy+AbirvCo1LInnlYSCbBKRTgwlsgJJR8Qio2FEn2A82H
   Q==;
IronPort-SDR: LPwQowyh53u9aN4ST0oiHbTK58mj6CCe8KnPQvyufF4Z4zHY5oT5c8ULcZhsxOdAHtxvB0XQVQ
 i/8eeU/ZitZcHTPYmeo90kFehU1ZFcCCXNeQCbmH7C1UGVqlh8oBPCDWiA6fhu2OjdcWzDf5W2
 qQ+IeZPADheW3X0l8vTJ+NEQW/VJ0wo39IiJa5lgwRyITUo0W+cWZYLW1IuQOYVVttpN6kAZgi
 2t3kktMRvlN5SlUf3eoSBOM8GXDhjOZLkl9L2GA7Q7iMMGQEpltwHbCa8sPauQr6ZuQpwDlo6P
 CQU=
X-IronPort-AV: E=Sophos;i="5.81,237,1610380800"; 
   d="scan'208";a="266140951"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 17:09:26 +0800
IronPort-SDR: l+XK982ZBf++UuchwjS10Dq3qYcqJle2sa220IKA5ZQbZ08TXcEVAO/cnTMTjEuwbey8gzphrP
 v60vK0SkJ7BmHQUTmuEMXfvwdyOMGSEx5kExOuvHcIzhx+d8emV3PEUgylx2Cit0g/tUk6okqP
 HQ6TxfIj8GkXp6zwYSKt9sb0FqwovMe5fOp2IldisJgWCqC3dV6V7ZkGJUfcg/Dcpy/cjIGOvU
 6OMtOelpqfhCks8L3FRR72FnjgzU9HiRbfaUw9hbcZCjmWSbnytbkuId1oIcqySnTR0QD3DGHB
 7AKLzDH0BzG0RWxb218ZWaeR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 00:50:17 -0800
IronPort-SDR: GAPpY614gjdeRbQLdCvd25wybKGX5xKwygM26uCAjbkp2WjACJ00XNx1wD+MvKJ6d040ha74Zt
 eNBNXY8m2QRtsny/8gE1dWcjiii/h86DhrdPTak4OPMKH1d0Wi1rgxiUcKAyv1XtMjWImFWcmJ
 l91gLg0OX4o8faGgudbPfLTOWn1NLjVLBCD38BSSEj8KFxHbB/IUCBVGGqKjLCXg4v4fEcO5UB
 YkOe59mjC2UY4bTAPeOFyeZZ9dnOoH5TxY5WTuQMloZQytUfe6TXIhloenQjginzRWgpFJxrD7
 lfw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Mar 2021 01:09:21 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: Fix REQ_OP_ZONE_RESET_ALL handling
Date:   Wed, 10 Mar 2021 18:09:19 +0900
Message-Id: <20210310090919.123511-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Similarly to a single zone reset operation (REQ_OP_ZONE_RESET), execute
REQ_OP_ZONE_RESET_ALL operations with REQ_SYNC set.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 833978c02e60..8b9f3fc5a690 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -240,7 +240,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 		 */
 		if (op == REQ_OP_ZONE_RESET &&
 		    blkdev_allow_reset_all_zones(bdev, sector, nr_sectors)) {
-			bio->bi_opf = REQ_OP_ZONE_RESET_ALL;
+			bio->bi_opf = REQ_OP_ZONE_RESET_ALL | REQ_SYNC;
 			break;
 		}
 
-- 
2.29.2

