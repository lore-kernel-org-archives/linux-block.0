Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E94C2B9F7
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 18:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B976610FC
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 18:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhE1S4Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 May 2021 14:56:16 -0400
Received: from condef-06.nifty.com ([202.248.20.71]:49702 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhE1S4Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 May 2021 14:56:16 -0400
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-06.nifty.com with ESMTP id 14SIjp4h028366
        for <linux-block@vger.kernel.org>; Sat, 29 May 2021 03:45:51 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 14SIibCm014551;
        Sat, 29 May 2021 03:44:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 14SIibCm014551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622227479;
        bh=ul+iPhomc5/a+3uLEWyWeoxx4HhhQyXAG63XvmcCJ6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMT/dT44wxADJT6ZvM0HAxA8Dqhc7dWDZTJkOE8pRODeYkQSGVal3i/Dj+wZI/ZTR
         cM/dREPsf13ucKUA7+Tj0YA43cojfBUNxOHoWbvctyj2zRFYUfvejqjjZ+QglskhWd
         xrv3EoeUPPaJBIVLQP6/t1Lht/rCYV/l3V6YuVr1j5qEcQyzz91wK2Z+OFCROBm3Lg
         A7RXwh83RYzF4KzNCuI2rXxS+sNe5wrUL0+2PO6NUQFQI5IK6c2ej6sQlzUVAHMHPn
         3oZ9XPW2hYGPOTe8zK9mbcZl0Bm0ptpw2TGwfqyV5oabGHBkxgm8NKqER32GWL8Alx
         1bbOG8HmzBQiQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] block: simplify Kconfig files
Date:   Sat, 29 May 2021 03:44:33 +0900
Message-Id: <20210528184435.252924-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528184435.252924-1-masahiroy@kernel.org>
References: <20210528184435.252924-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Everything under block/ depends on BLOCK. Extend the 'if BLOCK' ...
'endif' so it covers the whole block/Kconfig.

Also, clean up the definition of BLOCK_COMPAT and BLK_MQ_PCI because
COMPAT and PCI are boolean.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 block/Kconfig         | 18 +++++++-----------
 block/Kconfig.iosched |  4 ----
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index cb56f837a4e5..932596dbe4b4 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -208,29 +208,25 @@ source "block/partitions/Kconfig"
 
 endmenu
 
-endif # BLOCK
-
 config BLOCK_COMPAT
-	bool
-	depends on BLOCK && COMPAT
-	default y
+	def_bool COMPAT
 
 config BLK_MQ_PCI
-	bool
-	depends on BLOCK && PCI
-	default y
+	def_bool PCI
 
 config BLK_MQ_VIRTIO
 	bool
-	depends on BLOCK && VIRTIO
+	depends on VIRTIO
 	default y
 
 config BLK_MQ_RDMA
 	bool
-	depends on BLOCK && INFINIBAND
+	depends on INFINIBAND
 	default y
 
 config BLK_PM
-	def_bool BLOCK && PM
+	def_bool PM
 
 source "block/Kconfig.iosched"
+
+endif # BLOCK
diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 2f2158e05a91..885fee86dfca 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-if BLOCK
-
 menu "IO Schedulers"
 
 config MQ_IOSCHED_DEADLINE
@@ -45,5 +43,3 @@ config BFQ_CGROUP_DEBUG
 	files in a cgroup which can be useful for debugging.
 
 endmenu
-
-endif
-- 
2.27.0

