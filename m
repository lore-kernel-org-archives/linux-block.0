Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632CFC43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 08:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269982070B
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 08:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T0worCwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfAHIpb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:45:31 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5326 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfAHIpb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 03:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546937131; x=1578473131;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q1z31JYyUVDKv3AI6zzSXnafLy3w+HJC8zBptbm4HUo=;
  b=T0worCwiPd4oeRyeM1MbYV5P10mrCTGUD0xl5mVEIcqRi9XEMVOXgFTU
   Ms784Sf2seednMO3QmmPiYCnWeqzd37AMEN9cWb5B0bENL0eUycq0/GaE
   2D2yoXFA4kVp6nWsh9+3WzVoXLCJ3AAz/+N411mHhVEKx/mK8r7LPaO2K
   I0WG/etgqV7fIp+TFmPevbjZZVGzJl7tsqlFMjvQTDpMDv7kGJMp+UoSb
   4yNion71PpmBM9bCEeAhqvScCYsHTS4hCviwRjhotk7StDzDTj0j3Dx3l
   7GxnH8NulfG7q5Wi3cCNfXqmJD0GgLb+0Xp415XGKgK+8T3rkGFySRCCL
   w==;
X-IronPort-AV: E=Sophos;i="5.56,453,1539619200"; 
   d="scan'208";a="99452884"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2019 16:45:30 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 08 Jan 2019 00:27:05 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Jan 2019 00:45:29 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] uapi: fix ioctl documentation
Date:   Tue,  8 Jan 2019 17:45:28 +0900
Message-Id: <20190108084528.21051-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The description of the BLKGETNRZONES zoned block device ioctl was not
added as a comment together with this ioctl definition. Add its
description here.

Fixes: 65e4e3eee83d7 ("block: Introduce BLKGETNRZONES ioctl")
Cc: stable@kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/uapi/linux/blkzoned.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index 6fa38d001d84..498eec813494 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -138,6 +138,7 @@ struct blk_zone_range {
  * @BLKRESETZONE: Reset the write pointer of the zones in the specified
  *                sector range. The sector range must be zone aligned.
  * @BLKGETZONESZ: Get the device zone size in number of 512 B sectors.
+ * @BLKGETNRZONES: Get the total number of zones of the device.
  */
 #define BLKREPORTZONE	_IOWR(0x12, 130, struct blk_zone_report)
 #define BLKRESETZONE	_IOW(0x12, 131, struct blk_zone_range)
-- 
2.20.1

