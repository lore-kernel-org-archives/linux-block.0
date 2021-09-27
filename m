Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D07C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 14:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4DA16108E
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 14:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbhI0OMd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 10:12:33 -0400
Received: from condef-08.nifty.com ([202.248.20.73]:34220 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbhI0OMc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 10:12:32 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-08.nifty.com with ESMTP id 18RE18L6028468
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 23:01:08 +0900
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 18RE07Fx028280;
        Mon, 27 Sep 2021 23:00:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 18RE07Fx028280
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1632751209;
        bh=KxbFoC0Lpctbe3+9vWMEemrZDfcQA9Rb6dRZ6EUnmN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w2uoKVUTSU6/9ZgiEyItEKglzN9eATvYKW++xnVmz7Ez2/OrrcovgQgaPv/BcXCgC
         1Z8FS6Q3PqP16lOq1SC/UfNCn8O+/SnighzVhNhpI/xvq+wldKLGpgimwqt5AHPshh
         M0ET1ejypJExn+qmHWdyJu+PpRVmc48SZ8GWLzHnjTabfbbMLVYfe2+kyNAiUtB9yy
         YbGirCrO9prEl5ZnVtJRAOMwbp2JMwfqVa5IhQsr6k1GqtXCFWneB8IQr7PPl1G47z
         O6v6LhEiWb2egUvdSeEjXp468iPh2/CoCE285fHrz2b+WcN5IJAbtSS4iulaUkehrx
         z3m9vi7irYnbg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [RESEND PATCH 2/4] block: simplify Kconfig files
Date:   Mon, 27 Sep 2021 22:59:58 +0900
Message-Id: <20210927140000.866249-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927140000.866249-1-masahiroy@kernel.org>
References: <20210927140000.866249-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Everything under block/ depends on BLOCK. BLOCK_HOLDER_DEPRECATED is
selected from drivers/md/Kconfig, which is entirely dependent on BLOCK.

Extend the 'if BLOCK' ... 'endif' so it covers the whole block/Kconfig.

Also, clean up the definition of BLOCK_COMPAT and BLK_MQ_PCI because
COMPAT and PCI are boolean.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 block/Kconfig         | 18 +++++++-----------
 block/Kconfig.iosched |  4 ----
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 1d83504749e7..c4d35829ea4f 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -196,33 +196,29 @@ source "block/partitions/Kconfig"
 
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
 
 # do not use in new code
 config BLOCK_HOLDER_DEPRECATED
 	bool
 
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
2.30.2

