Return-Path: <SRS0=USsu=2Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A906C2D0DA
	for <linux-block@archiver.kernel.org>; Thu, 26 Dec 2019 06:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5991A2075E
	for <linux-block@archiver.kernel.org>; Thu, 26 Dec 2019 06:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jPUKNTp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfLZGy1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Dec 2019 01:54:27 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42207 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfLZGy1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Dec 2019 01:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1577343267; x=1608879267;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XIWcTY32tENsm0Nd5vCpMX4YiopVbW0PgUWAj4srz5o=;
  b=jPUKNTp59mSSvTch1pwt8uIS/wnNt4avweUGgwT2Gb2KP0IqA0E3qGyU
   +mhJN6uaTTI6MVexf8evFIbUuPvFSy3wQKt7KgJ5Vwuupgkxesrkvov4a
   hBCQZH2+/ai+23aWg40n/OBPGQojOxYEtQiSbcqRXIl8NAKkImh6gNR4w
   967v3K9KjEo6W+mg6crXM3M6CY/tJEMoscH08Qs2aMpTT5uc4FprMiVaM
   OYfZQEYiAvA669gZPCFGVPGaxcvEJ3R0lbaYMH3pmIABipZQxPhI8u/5y
   l5ayQNB4gJ/f1DQUCdHtCOfXJChbx1jZ2RT2XOoSLKUteeoswWGmchqRy
   A==;
IronPort-SDR: OPiiskAKyahkLQy5Mb5M6bf9QmRWf+0JymicL6yk6dDGSGN2utbxSyYWEtSNx4eGp1vapIPA6x
 q+8LLdqkLqLGkGYRzkP/5q7VdfSVXr9y9g6AxPj8nUET+PwTi2aLB0Tz+Ww0och7B65CEgTGZN
 xGFPKighHNVcYSmkeuOy4mXTMBbHV2adL27eiLjVZtdo79a63lUL6a4G941z4TgpmlTqEq4yOP
 2HM/eRFo7px81trlSvqKYtI8vP8sQpc4pBtAS4/YZq+qADe+xrO3Vfqp2jhDNg3pOKZ+d8s2gr
 4B8=
X-IronPort-AV: E=Sophos;i="5.69,358,1571673600"; 
   d="scan'208";a="127736791"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Dec 2019 14:54:27 +0800
IronPort-SDR: 3vfOP68vDr1zhf9RBphBzic2mqkVxHDyqb7ufOWajnipfj+hdDeJa+ZfqwMQIi2VzqeKZClMlH
 Ja+U4sklkLVmnp9lEBp/WM7z0+WC4koXhFTtSaTe+ytCV1gKLFpSzSWtPOscId/qwtTtehu1zf
 i+OPnRPL6SjP3HA6q1wzZ294eqbVzZlw1SaFwd8e6L6farsideDKaNENXwpkEftafdqjDwu5G8
 fgEEnuf0tyDhyKS3+fjHb5ufZB4L20VYn9dddjhIZjKN6TkYT36XO377jPabR9rgN7BmnNtK3I
 ShX40ByDDL6nUerJYK85pwb3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2019 22:48:37 -0800
IronPort-SDR: 5ZD1b4A4JZawKX3q91owzS2ORwgvWwqxLS+U1lMFASSRIf+UAMvik6jGJcyso2MXH1J4/C2hn+
 F+xtLOI+810TFwjouwVCMit6yj9W/PA4Imo6+F5Lf49MS6Sljm016yEZmhbs+ML4wyPurpEshV
 qQXq8xpsemllXUhmfYSkmQ5eofzfppqXuJ3ilWtC2rgCw7URgAY9DUL5va07IzyKrcdBxOPDSh
 k1G5yO/y2drmWNc4NX8J0mt3ZnoflW0aTaBdfVy61tfyomIloKXjWBR85P880YnzUfr0FrvFzg
 U3c=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Dec 2019 22:54:26 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] null_blk: Fix REQ_OP_ZONE_CLOSE handling
Date:   Thu, 26 Dec 2019 15:54:25 +0900
Message-Id: <20191226065425.490122-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In order to match ZBC defined behavior, closing an empty zone must
result in the "empty" zone condition instead of the "closed" condition.

Fixes: da644b2cc1a4 ("null_blk: add zone open, close, and finish support")
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk_zoned.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index d4d88b581822..5cf49d9db95e 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -186,7 +186,10 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 		if (zone->cond == BLK_ZONE_COND_FULL)
 			return BLK_STS_IOERR;
 
-		zone->cond = BLK_ZONE_COND_CLOSED;
+		if (zone->wp == zone->start)
+			zone->cond = BLK_ZONE_COND_EMPTY;
+		else
+			zone->cond = BLK_ZONE_COND_CLOSED;
 		break;
 	case REQ_OP_ZONE_FINISH:
 		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-- 
2.24.1

