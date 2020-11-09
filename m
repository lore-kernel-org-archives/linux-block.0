Return-Path: <SRS0=Ui87=EP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFB9C2D0A3
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 12:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F8720657
	for <linux-block@archiver.kernel.org>; Mon,  9 Nov 2020 12:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XIQdILbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgKIMvg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:51:36 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43846 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbgKIMvc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 07:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604926292; x=1636462292;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=q8DjSz449Eh2eqGNWYjeij7/XMqlOG4JLg1vETD36aM=;
  b=XIQdILbXmAFUTymJCUKMz15XPNKPxn9JWKoq5LhzSPW1LliAuQnXXu6D
   6py2Va8NMRcpGoxInASbhM3guDzJVmJwfFqkUBpqidHCKnGDNnzL7iC1t
   JSUgS4Z9PcGIsj8OTvXxxcCH24njWyCj8Us+e/950261mtQ6vsPczAUvY
   6aOY+jnoJEfb7tONAWOQjimKwr9JXZIVrfQGek2iEcBR5BqkRFGAOcfRQ
   hu4q7fEI+pC4w39APubNTfJae+nyTl+8eM95HhWkU4MtTN+KgLa7KiePF
   oqRfVxYWHC8zpC2uDPNdjGWVJJwFJmey5Suuk4x2meEuVkrTm+tlgMyWl
   g==;
IronPort-SDR: SbUqUbWNANQUwk4Xg85Z7DdqSFJGETDjgXQet7rsS2w1l1KThsUXauLj/fze9LTDSdC+wHtZ3H
 A1DW5o0yPcWw1b30ljihhz6JwX7ibvpLkMWHpJQ2xLiJPvJcdrJ8pWa13SmpPn30zU/i7TyN/k
 WeM6qu/mACkELL2XWRzg3IHlsRMvLUwIqSkqvaI7t2mGRtIwGxu5WdJMocpVEXH5AaDOYpqQ8E
 ijUN3FGZMXA2mPOKbAQRyMPAO4ulq9MCvVc1RlgLkDAOq/mv86PWDO/2hS2M1+IHbzMEOEILo6
 LOk=
X-IronPort-AV: E=Sophos;i="5.77,463,1596470400"; 
   d="scan'208";a="156668406"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2020 20:51:13 +0800
IronPort-SDR: h/GjOC7HrkEdejFjV93mQEbHg2fruFA369XS5QrS5hZb/Qsto4j8xA2V76iuGIsW10kRNMDAjR
 Jje1ejpiqU6JFb5K11zUymHSIbB4GSrLeUp1T41fyEDjPY2Y8KSgZHHK85JlkYIpGN4R8Vk/ra
 c/2odUwO4S/pwY2SFVN2LUDukWPrWBzKFwbavR8Ogip0LaEMTvf9hVEJn4pyxer0tG42pDttCt
 CWKYJp3JKvkWzi7dnxZJuY5MCN95Hdp5Wcrhk+YRfAf+axW+jVYq2yuqGy63KQhDw/AGot/8nM
 y2iWnNUmJddswMllVoTwpP70
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 04:37:15 -0800
IronPort-SDR: oXnPxcYX6aTq9Kqd6RwveqpIm+vJ4a324ZYo5WH5XvjO1uj5sbOcslH+JMdHiRfZ7vuKuKKDZ8
 FlOuUCsNJe+X+rSzdx8MraX6/GsWZZemMoQfcYAqdiSMO7BeXt5aXEfiw0GiI1Izdc2grPJlo5
 8I7SJ4gjh9UBpukzbaLW+gNf1D+i+A+zWxutSKiqbWdj/CC1RLQAK9AE8G8L9xe2AAwCAPNVgm
 zCwvdbH2beBhKV3CTaajJNl5flXT0x1DAR/CWl3TwRmCNPi1FHQnbtvp3RIHQJ0H9uqUf7bo7m
 3G8=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 04:51:13 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] null_blk: Move driver into its own directory
Date:   Mon,  9 Nov 2020 21:51:05 +0900
Message-Id: <20201109125105.551734-7-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109125105.551734-1-damien.lemoal@wdc.com>
References: <20201109125105.551734-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move null_blk driver code into the new sub-directory
drivers/block/null_blk.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/Makefile                        |  7 +------
 drivers/block/null_blk/Makefile               | 11 +++++++++++
 drivers/block/{ => null_blk}/null_blk.h       |  0
 drivers/block/{ => null_blk}/null_blk_main.c  |  0
 drivers/block/{ => null_blk}/null_blk_trace.c |  0
 drivers/block/{ => null_blk}/null_blk_trace.h |  0
 drivers/block/{ => null_blk}/null_blk_zoned.c |  0
 7 files changed, 12 insertions(+), 6 deletions(-)
 create mode 100644 drivers/block/null_blk/Makefile
 rename drivers/block/{ => null_blk}/null_blk.h (100%)
 rename drivers/block/{ => null_blk}/null_blk_main.c (100%)
 rename drivers/block/{ => null_blk}/null_blk_trace.c (100%)
 rename drivers/block/{ => null_blk}/null_blk_trace.h (100%)
 rename drivers/block/{ => null_blk}/null_blk_zoned.c (100%)

diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index e1f63117ee94..a3170859e01d 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -41,12 +41,7 @@ obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
 obj-$(CONFIG_ZRAM) += zram/
 obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
 
-obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
-null_blk-objs	:= null_blk_main.o
-ifeq ($(CONFIG_BLK_DEV_ZONED), y)
-null_blk-$(CONFIG_TRACING) += null_blk_trace.o
-endif
-null_blk-$(CONFIG_BLK_DEV_ZONED) += null_blk_zoned.o
+obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 
 skd-y		:= skd_main.o
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/null_blk/Makefile b/drivers/block/null_blk/Makefile
new file mode 100644
index 000000000000..a0b7bd066fea
--- /dev/null
+++ b/drivers/block/null_blk/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# needed for trace events
+ccflags-y				+= -I$(src)
+
+obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
+null_blk-objs	:= null_blk_main.o
+ifeq ($(CONFIG_BLK_DEV_ZONED), y)
+null_blk-$(CONFIG_TRACING) += null_blk_trace.o
+endif
+null_blk-$(CONFIG_BLK_DEV_ZONED) += null_blk_zoned.o
diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk/null_blk.h
similarity index 100%
rename from drivers/block/null_blk.h
rename to drivers/block/null_blk/null_blk.h
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk/null_blk_main.c
similarity index 100%
rename from drivers/block/null_blk_main.c
rename to drivers/block/null_blk/null_blk_main.c
diff --git a/drivers/block/null_blk_trace.c b/drivers/block/null_blk/null_blk_trace.c
similarity index 100%
rename from drivers/block/null_blk_trace.c
rename to drivers/block/null_blk/null_blk_trace.c
diff --git a/drivers/block/null_blk_trace.h b/drivers/block/null_blk/null_blk_trace.h
similarity index 100%
rename from drivers/block/null_blk_trace.h
rename to drivers/block/null_blk/null_blk_trace.h
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk/null_blk_zoned.c
similarity index 100%
rename from drivers/block/null_blk_zoned.c
rename to drivers/block/null_blk/null_blk_zoned.c
-- 
2.26.2

