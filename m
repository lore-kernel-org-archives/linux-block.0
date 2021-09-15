Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3251C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7CC60EB2
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhIOGrw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 02:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhIOGrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 02:47:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C314C061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 23:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Pq8TzkfO68sGwwOLcrZgH+6sW3OsWKyY3BBe3E8oxzo=; b=oqmayU/X6y6ZH797kdbVPITtwI
        HW3iRyZko5HpUoEhC5I22Kq7UkOBFvaEFdKP9/EN2si1qDa4gUUyoLCrbRrm0IYOjr9MXdCXdZTkF
        n1eNSrdBa353puyBG5IOWrO+RrxUIdeSv7fx7DXgv/b603PXSORXu8Fu99lfq83TIDYXdsdSu/un+
        TWQNhgG+fuU8caqgL1FGYRtWbmlei74JRsNIWj2CJefqkQm6g4ZY1QOTtoolUy2uhuiE6aBJjWVoP
        TjUBqAS75YQASZBjscXPIyt7OJPetXQpMV5v9NxEsFji5Lh/Oncvao7vWr3BPdcaW3xl6joo42zil
        U/DD97Ww==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOg2-00FQnd-Do; Wed, 15 Sep 2021 06:46:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 06/17] kernel: remove spurious blkdev.h includes
Date:   Wed, 15 Sep 2021 08:40:33 +0200
Message-Id: <20210915064044.950534-7-hch@lst.de>
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
 kernel/acct.c | 1 -
 kernel/exit.c | 1 -
 kernel/fork.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 23a7ab8e6cbc8..3df53cf1dcd5e 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -60,7 +60,6 @@
 #include <linux/sched/cputime.h>
 
 #include <asm/div64.h>
-#include <linux/blkdev.h> /* sector_div */
 #include <linux/pid_namespace.h>
 #include <linux/fs_pin.h>
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 91a43e57a32eb..a53863dafb3d7 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -48,7 +48,6 @@
 #include <linux/pipe_fs_i.h>
 #include <linux/audit.h> /* for audit_free() */
 #include <linux/resource.h>
-#include <linux/blkdev.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/tracehook.h>
 #include <linux/fs_struct.h>
diff --git a/kernel/fork.c b/kernel/fork.c
index 38681ad44c76b..67679e3933f2f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -76,7 +76,6 @@
 #include <linux/taskstats_kern.h>
 #include <linux/random.h>
 #include <linux/tty.h>
-#include <linux/blkdev.h>
 #include <linux/fs_struct.h>
 #include <linux/magic.h>
 #include <linux/perf_event.h>
-- 
2.30.2

