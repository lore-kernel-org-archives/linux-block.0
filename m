Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC9C433E2
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 10:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0025B2074B
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 10:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KXZy++Vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgGPKJm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:09:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13542 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgGPKJl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 06:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594894181; x=1626430181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZIi359ebW7uPGrJ68pzzl8ui7Nlsr3y11fUvBks/AeA=;
  b=KXZy++VzZQvRBP4a9XKsuN70aB/4RopyCq+KuWquZcVEOHEnswdBcD3S
   novYkbZDgNQsPoHPjtmyk5b/Wp/iQhP9WEBt3NhK+MGBjsz6ZNWOvLo2w
   G44BFZ22H419rgZ/GtoKe7v2fDhfEAkqqu43VQiUHE7O7sN+uhGjbO5rM
   8mkBH/INe5ZGdltyxrVTGHtKhhahcxbecEkRp+9eBf1YdeOw4cE+CRbHG
   QO53VT5tC3Zt5BEGDHm+MPEdFOaHXu1Vy66LATVasTErQLZ/4UGoBPEYi
   NsoY1huziKkzd+B+nkngltf/h3V6KpiRcsTeXIMPZCAZJGXC8E5gGq4jY
   w==;
IronPort-SDR: yv7l+827DTK8WBdt5tIH0XHyqDylQK+HLSmfrjucTUwaya1CRjA156DU472OpXls1iPK+9ygbJ
 0VGlJxS2AhiztKiD3L7ICM9V9jrBbWVkGBlJDGcL3BBzyFjyft40JkunTmu8UXTijWt6tDTTbq
 +yT22E8tLf0LDiC38oSTGN1pElZGNkEy9gVTeOLqKQxkKRAmubeXHDWNqnySzSxS8BynUbLrfN
 EhI+1bZp57+axWCKTtKa/NUhXkJu6xjWamuBKSDhbZYzapmkJicIRdFuD6Cg4ns/TcveCSfa13
 r0c=
X-IronPort-AV: E=Sophos;i="5.75,358,1589212800"; 
   d="scan'208";a="251863386"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 18:09:41 +0800
IronPort-SDR: E+VMSafaz05neEepYDM9/wYO6++sx2qkQbBlYl5N5rHJR/B0zfIg9WVYg9bFTDFacx+9Bx/Tkl
 QRfGAVURNsQSxacAAg/IXLmSaAabjXn4I=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 02:57:32 -0700
IronPort-SDR: JMpE1XygSjEUDv+E9rCs63wsgce2Tu8SlDVU1mS1l4LMQ0U05jfvAT4QaBOajMJRv8kp9YhyOj
 KCJvaCXmXR0A==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2020 03:09:41 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] block: align max append sectors to physical block size
Date:   Thu, 16 Jul 2020 19:09:33 +0900
Message-Id: <20200716100933.3132-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Max append sectors needs to be aligned to physical block size, otherwise
we can end up in a situation where it's off by 1-3 sectors which would
cause short writes with asynchronous zone append submissions from an FS.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-settings.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9a2c23cd9700..d75c4cc34a7a 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -231,6 +231,7 @@ EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
 void blk_queue_max_zone_append_sectors(struct request_queue *q,
 		unsigned int max_zone_append_sectors)
 {
+	unsigned int phys = queue_physical_block_size(q);
 	unsigned int max_sectors;
 
 	if (WARN_ON(!blk_queue_is_zoned(q)))
@@ -246,6 +247,13 @@ void blk_queue_max_zone_append_sectors(struct request_queue *q,
 	 */
 	WARN_ON(!max_sectors);
 
+	/*
+	 * Max append sectors needs to be aligned to physical block size,
+	 * otherwise we can end up in a situation where it's off by 1-3 sectors
+	 * which would cause short writes with asynchronous zone append
+	 * submissions from an FS.
+	 */
+	max_sectors = ALIGN_DOWN(max_sectors << 9, phys) >> 9;
 	q->limits.max_zone_append_sectors = max_sectors;
 }
 EXPORT_SYMBOL_GPL(blk_queue_max_zone_append_sectors);
-- 
2.26.2

