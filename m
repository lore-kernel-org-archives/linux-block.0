Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B9DC433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AA860F6F
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhITMhv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhITMhv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:37:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D39C061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 05:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Pq8TzkfO68sGwwOLcrZgH+6sW3OsWKyY3BBe3E8oxzo=; b=YKHjM8XbZrTng7rFqyYHqUbWau
        OkUzmjbltSC7/Nt9StQAhNYujEh0xC3YsgO9rB+V4GdbwTI82zcB/4QztYJzjiCSbDK8kMjoW1ECx
        coFIgKveAy3bhZUJuedcGZxue6UDUOH5NBDxr1so4BW/zG+3ZK0mBhMlFuNykcVoKOzrU0/OG2QR4
        maJykPxcCP3wYPvUR2lR5rXlH/DzHTKfV+jnYH4gaYImNEEv1082iXDhvJIBLzJWENIGlUcS0BTcl
        rgYiqAB+rpnet4+vM28/gt8IVWIE8hvzrMsMmZXdL+srn6Gq3Ov+dMplcuMZ+icGBPKpp62VmPMxw
        QXknxPJg==;
Received: from [2001:4bb8:184:72db:7ad9:14d9:8599:3025] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSIWg-002f25-1V; Mon, 20 Sep 2021 12:36:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 06/17] kernel: remove spurious blkdev.h includes
Date:   Mon, 20 Sep 2021 14:33:17 +0200
Message-Id: <20210920123328.1399408-7-hch@lst.de>
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

