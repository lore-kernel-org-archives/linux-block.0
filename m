Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3265AC433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 128D76103C
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 06:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbhIOGs2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 02:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbhIOGs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 02:48:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F70C061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 23:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bQi9ZQFdXjVwKH+MQOYPxGMUArFPwRgqU+pxtXHUe3w=; b=lKJdsERpKwEPGGcS1e+GTv+LP1
        3PkpwLqK+C3srzFVIY27nTi1RrkwGz833lWWm5KhZ99Nrc/QPpK6nZ3rM54IzZABOYVh7PeT4xfQ1
        0+lE1Mq8daqDWNQm+IvTtO1LXcFJiC86OSxxurskUHVKZDpj84hU8so2U9XLS4wZYS7OiaofJz+oU
        sZn3P++0oP094aS3UId2qcx+3o5esbq0W2XmyFInz3PlVJa13DNu/5+R22lPvtHrdBr/DFoiGaquU
        aJs4EE0HEhtAVZcYRUwvczyqQ2R630g8Q1FoSCEfP4mMlIcTicVI5x/MAU6/9ioqluiy6R4a5Ckfh
        bI35tTeQ==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQOgc-00FQpU-Q4; Wed, 15 Sep 2021 06:46:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 07/17] sched: move the <linux/blkdev.h> include out of kernel/sched/sched.h
Date:   Wed, 15 Sep 2021 08:40:34 +0200
Message-Id: <20210915064044.950534-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915064044.950534-1-hch@lst.de>
References: <20210915064044.950534-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only core.c needs blkdev.h, so move the #include statement there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/sched.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1bba4128a3e68..92ef7b68198c4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -13,7 +13,7 @@
 #include "sched.h"
 
 #include <linux/nospec.h>
-
+#include <linux/blkdev.h>
 #include <linux/kcov.h>
 #include <linux/scs.h>
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3d3e5793e1172..66128dfc05fb3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -37,7 +37,6 @@
 
 #include <linux/binfmts.h>
 #include <linux/bitops.h>
-#include <linux/blkdev.h>
 #include <linux/compat.h>
 #include <linux/context_tracking.h>
 #include <linux/cpufreq.h>
-- 
2.30.2

