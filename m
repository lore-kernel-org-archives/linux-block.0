Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DCDC433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B066860F4B
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhITMh3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbhITMh3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:37:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74556C061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=esCvS8KkboRctvtNjwOokTImLNSC3a449bPc6S4EtuA=; b=Efc5T/4e5UF7ch/D1i3qDLODup
        FGyho7MHgVVzWOXZic3Wc3qsGM9RnxCIW5b2Drr6NV+/uJaiy/zrmHgBALW3odr+hq5td5Scz8eSS
        SX1QcCfIojmVAU8WZ+mVTck5m5NJ6rFeyhQ1jSFBjdJGgwZTUJIhx5eyNC4N0Q+LYUJyr5zbkX8Gv
        Fcvd0X7YH8QRobE6CEAVcqmnONxaXFhUbVJ9cL7nthME2e0z+/gd5LZGK69wp1Mf4IiSXIeINa/LU
        kNaYkR+hTUQqJ8ZNoO0TDDZl7Ks+F91HQ8L+Sw+a6v0j38rbw172REzi/MgXuFi8VNIZ7by6VKWFl
        PCbCnjGg==;
Received: from [2001:4bb8:184:72db:7ad9:14d9:8599:3025] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSIWK-002f0Z-Vp; Mon, 20 Sep 2021 12:35:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 05/17] arch: remove spurious blkdev.h includes
Date:   Mon, 20 Sep 2021 14:33:16 +0200
Message-Id: <20210920123328.1399408-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920123328.1399408-1-hch@lst.de>
References: <20210920123328.1399408-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Various files have acquired spurious includes of <linux/blkdev.h> over
time.  Remove them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/rb532/prom.c         | 1 -
 arch/mips/sibyte/common/cfe.c  | 1 -
 arch/mips/sibyte/swarm/setup.c | 1 -
 arch/openrisc/mm/init.c        | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/mips/rb532/prom.c b/arch/mips/rb532/prom.c
index 23ad8dd9aa5e0..b116937155474 100644
--- a/arch/mips/rb532/prom.c
+++ b/arch/mips/rb532/prom.c
@@ -16,7 +16,6 @@
 #include <linux/console.h>
 #include <linux/memblock.h>
 #include <linux/ioport.h>
-#include <linux/blkdev.h>
 
 #include <asm/bootinfo.h>
 #include <asm/mach-rc32434/ddr.h>
diff --git a/arch/mips/sibyte/common/cfe.c b/arch/mips/sibyte/common/cfe.c
index a3323f8dcc1b8..1a504294d85f8 100644
--- a/arch/mips/sibyte/common/cfe.c
+++ b/arch/mips/sibyte/common/cfe.c
@@ -7,7 +7,6 @@
 #include <linux/kernel.h>
 #include <linux/linkage.h>
 #include <linux/mm.h>
-#include <linux/blkdev.h>
 #include <linux/memblock.h>
 #include <linux/pm.h>
 #include <linux/smp.h>
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 538a2791b48ca..f07b15dd1c1a3 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -11,7 +11,6 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/memblock.h>
-#include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/screen_info.h>
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index cfef61a7b6c2a..97305bde1b169 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -25,7 +25,6 @@
 #include <linux/memblock.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/blkdev.h>	/* for initrd_* */
 #include <linux/pagemap.h>
 
 #include <asm/pgalloc.h>
-- 
2.30.2

