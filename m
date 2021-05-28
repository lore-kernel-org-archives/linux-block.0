Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F2FC2B9F7
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 18:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3524613DD
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 18:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhE1Szk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 May 2021 14:55:40 -0400
Received: from condef-10.nifty.com ([202.248.20.75]:53429 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhE1Szj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 May 2021 14:55:39 -0400
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 May 2021 14:55:39 EDT
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-10.nifty.com with ESMTP id 14SIjopH017734
        for <linux-block@vger.kernel.org>; Sat, 29 May 2021 03:45:50 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 14SIibCn014551;
        Sat, 29 May 2021 03:44:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 14SIibCn014551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622227479;
        bh=jaxdsqU7j4qXYB8W7T2mX99WHAg3Osh1zu5S6gjlbZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8qcGC9CNy/bvxlAYsRJhlT2YZ0iCsi9TmrPkuf4zib+OULyrJA8cL22Be5xc1sI4
         paBTPZjpzqcNAyjaEy5kGZRpwqq0SS3gWWfiV0wrVjShqJXSDLrTA+wVkFz/H1i/TI
         8ZKF9qls0wKW1iVUfbVf5pDv+tZdgZLjwTnD7qVWMbCy4kb3BhEwLPD2QcRfcTyYzn
         3IXIUoU/zoagHz82n8+pEg/oB9JcwW4L0/e2x6gw83UBJUAPWM7G2xvyUFBIhKjiIp
         YQQUOVKboKcoWu+j6j6mnO8uGJmWBORYtz8Rq+Ucz2VqGWnvG1HP61Ej38qqzZrjzw
         4XqNd03lzOdiQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] block: move menu "Partition type" to block/partitions/Kconfig
Date:   Sat, 29 May 2021 03:44:34 +0900
Message-Id: <20210528184435.252924-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528184435.252924-1-masahiroy@kernel.org>
References: <20210528184435.252924-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the menu to the relevant place.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 block/Kconfig            | 4 ----
 block/partitions/Kconfig | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 932596dbe4b4..412a6e11d0cc 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -202,12 +202,8 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
-menu "Partition Types"
-
 source "block/partitions/Kconfig"
 
-endmenu
-
 config BLOCK_COMPAT
 	def_bool COMPAT
 
diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
index 6e2a649669e5..edc2d0779814 100644
--- a/block/partitions/Kconfig
+++ b/block/partitions/Kconfig
@@ -2,6 +2,8 @@
 #
 # Partition configuration
 #
+menu "Partition Types"
+
 config PARTITION_ADVANCED
 	bool "Advanced partition selection"
 	help
@@ -268,3 +270,5 @@ config CMDLINE_PARTITION
 	help
 	  Say Y here if you want to read the partition table from bootargs.
 	  The format for the command line is just like mtdparts.
+
+endmenu
-- 
2.27.0

