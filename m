Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F27DC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 09:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23373218A2
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 09:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="haVj91Fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbfAXJUR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:20:17 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11671 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfAXJUR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 04:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548321643; x=1579857643;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=73Bu1mb4hFLLrVPQMvw/H5Df/LXUPF9jzSo8IbE9Aoo=;
  b=haVj91FqiGWBEkqCYo4dQkDz2Gsa/coOuAbvlmB4k/jfNHMUdUmKVoHx
   H0Syhsh7hmfevCS7//DfLgOHjkb0eI5a6kDiGMfrO7TfocUNLlO2dtiRv
   izWH+Q66Nu4zgwyWCrDJuZRzaD/22AZ/U5QjIfMbEOYyDxFz/LaYu2+BG
   Uax14+XLzu0QE5KJ0FOBz/Ggfh8eDOLfYktwg68a3+VuPFp7yUnkTyr9d
   4D/2Z5ma2s2olLFFVRfhh2eTJuPsmO7FWLSFhqe72l1KQDkBVDg3+66Nt
   JB8+WqkFEN2MYMt4ZqJI8GZdw9cHGy9SlFfTK3RmB4BsziXQaZH+kWlrc
   g==;
X-IronPort-AV: E=Sophos;i="5.56,515,1539619200"; 
   d="scan'208";a="197760771"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2019 17:20:43 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 24 Jan 2019 01:01:24 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Jan 2019 01:20:16 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] uapi: fix ioctl documentation
Date:   Thu, 24 Jan 2019 18:20:13 +0900
Message-Id: <20190124092014.28656-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The description of the BLKGETNRZONES zoned block device ioctl was not
added as a comment together with this ioctl definition in commit
65e4e3eee83d7 ("block: Introduce BLKGETNRZONES ioctl"). Add its
description here.

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

