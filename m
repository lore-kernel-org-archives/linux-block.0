Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701CCC433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 14:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D74E60F94
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 14:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhI0OLU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 10:11:20 -0400
Received: from condef-04.nifty.com ([202.248.20.69]:56192 "EHLO
        condef-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbhI0OLT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 10:11:19 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-04.nifty.com with ESMTP id 18RE1AYs023449
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 23:01:10 +0900
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 18RE07G1028280;
        Mon, 27 Sep 2021 23:00:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 18RE07G1028280
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1632751210;
        bh=zWeVVrMdOBNr2TwWOoBOYkVjaBDcD5y8SZG9+hIZpO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzPo6CiE3OUAdAvhYYiY7Rre3j3t1NjOWn0YHQzpTbEHsHAJKBfB3NfvyzdNhmqD3
         XumuBqkAg1/V0VxZTtyq1AFcbR59mJKHgww3OvrbPs8WrRRzYvKQYTwm5GR+j11qCE
         bRc7PRbcLOLj04JGs+Y+ci8VV/KVK1rUjn66B+dZDGOnmbnqSLhXSgC3SgQL0DTKoh
         RFHwDXwMYmAIc7cKnpc7wZGj4O+E1vQOKnkQLrcR/+P/w1AN378apItyEV9dbG5k1P
         OVqHXn3d4xiTe+QmXDhdjMjCbdskm6oseCF4v8fa8bG0UCId9U320xg75U4BV88jt6
         TaV6jwLHLeOoQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [RESEND PATCH 4/4] block: move CONFIG_BLOCK guard to top Makefile
Date:   Mon, 27 Sep 2021 23:00:00 +0900
Message-Id: <20210927140000.866249-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927140000.866249-1-masahiroy@kernel.org>
References: <20210927140000.866249-1-masahiroy@kernel.org>
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
index 60923c2f41d5..0bcaa9e30fdf 100644
--- a/Makefile
+++ b/Makefile
@@ -1115,7 +1115,8 @@ export MODORDER := $(extmod_prefix)modules.order
 export MODULES_NSDEPS := $(extmod_prefix)modules.nsdeps
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y			+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/
+core-$(CONFIG_BLOCK)	+= block/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
diff --git a/block/Makefile b/block/Makefile
index 41aa1ba69c90..74df168729ec 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the kernel block layer
 #
 
-obj-$(CONFIG_BLOCK) := bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
+obj-y		:= bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
 			blk-exec.o blk-merge.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
-- 
2.30.2

