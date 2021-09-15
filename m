Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0EBC433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154E061029
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhIOGrJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 02:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhIOGrJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 02:47:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D13C061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 23:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=esCvS8KkboRctvtNjwOokTImLNSC3a449bPc6S4EtuA=; b=mNETNg2ns6jVwyZfNATaqoVHz+
        0Ou5XQtN8XOZSz2sD7ez4ExKWNXWg0j8otBD/zUNF1payzVlKagLk9ft2/UbPlVc11LqkbWtQqEct
        /yu/alKUB05mTUk0KO1YJgz//HgptiDAJLVT4Iw+D5KMXhMlllQQ3aSMaZBA44QFtutSlWhoK2hJ0
        6UxOtSu6tDkdBHiAUQ3q1jYivcJTbrO06u+k9tecvp05BKbJ76WpaN95DmxHVcTS5/5L0nfavaDuc
        1CIbfI2LfD59t160gL3khjOrhXcXTuV+rWBqtBBHbsQ1tyYaXehXcA60bLvojdZXwX0z2aANI7G57
        UDrixS2A==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOfN-00FQm3-IK; Wed, 15 Sep 2021 06:45:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 05/17] arch: remove spurious blkdev.h includes
Date:   Wed, 15 Sep 2021 08:40:32 +0200
Message-Id: <20210915064044.950534-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915064044.950534-1-hch@lst.de>
References: <20210915064044.950534-1-hch@lst.de>
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

