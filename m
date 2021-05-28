Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1380C2B9F7
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 18:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE0C613DD
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 18:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhE1S5K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 May 2021 14:57:10 -0400
Received: from condef-02.nifty.com ([202.248.20.67]:21179 "EHLO
        condef-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhE1S5K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 May 2021 14:57:10 -0400
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-02.nifty.com with ESMTP id 14SIjpQH018216
        for <linux-block@vger.kernel.org>; Sat, 29 May 2021 03:45:51 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 14SIibCo014551;
        Sat, 29 May 2021 03:44:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 14SIibCo014551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622227480;
        bh=ldEXN72R4ZQPqoN770mx5epfuTtmbUuSqubynOtJnH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jx3HmzBTmRuFXHwp2jTaBcC6mdAbK2SjbLdSEgG4jzFDVPH4iDPS/5F8jeEUVXMnx
         /nH5QBsXiR6E5egGiEx1kaW86fLnKPAJjEcGLbUEAxH5aAqbW5HrUoWicu0pTfh5i5
         drRCv1nS3H8jq7SyAM8n/bZABJOxTPSgPWwodypKHyt7Mc1KZXpya7QG79fjycr89i
         OwzQ/xQMYQt7VboM0zEtKQpzaNvsN/ow/YJZk+lNSW77h1cIDCph0IV4xZF71LIbIA
         ZCIKqCNhhZGIjBJSYYZMrksAH5+JrhQlIcoyUiX4IiBlr9HLpDL16YY49eMGZ4EtbC
         o7LX1tPTphmQQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] block: move CONFIG_BLOCK guard to top Makefile
Date:   Sat, 29 May 2021 03:44:35 +0900
Message-Id: <20210528184435.252924-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528184435.252924-1-masahiroy@kernel.org>
References: <20210528184435.252924-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Every object under block/ depends on CONFIG_BLOCK.

Move the guard to the top Makefile since there is no point to
descend into block/ if CONFIG_BLOCK=n.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile       | 3 ++-
 block/Makefile | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 88cb5b59109c..055dcf5a2704 100644
--- a/Makefile
+++ b/Makefile
@@ -1095,7 +1095,8 @@ export MODORDER := $(extmod_prefix)modules.order
 export MODULES_NSDEPS := $(extmod_prefix)modules.nsdeps
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y			+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/
+core-$(CONFIG_BLOCK)	+= block/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
diff --git a/block/Makefile b/block/Makefile
index 8d841f5f986f..99f0757a3aa5 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the kernel block layer
 #
 
-obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
+obj-y		:= bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
 			blk-exec.o blk-merge.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
-- 
2.27.0

