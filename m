Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1CAC433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419EF6109E
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbhITMjk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbhITMjk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:39:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6555C061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 05:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bQi9ZQFdXjVwKH+MQOYPxGMUArFPwRgqU+pxtXHUe3w=; b=q6Y311ZBiCYcDkpBo8PHI2tegl
        kdJFhvsyMetthKqRNEvwoQ0L0gFmMHLNUqhAphG1MzlXkq6F8D4wmvbww8Ydx+66sDGT6lImoupBU
        QjHr3Jl2VnNJMPEdnkCGt8WiJNB8sClUWQM5rDrVslc+ArudSssI1AIMDCKZ0SBgksiPDoGJ9iELM
        KGxXH6rDGcoU2asw6us3ABgbckk49n2TfCcETq21/IxV0Zy6YSoqvnWS49JSmuNfor0uGgiX/RT8m
        37CH0ZkWIVoukFK+bVAS0hG4kf2RATb08jnrYqisbxaBS4xOIJa86M0RMsZ0T22wC4KS4Dm6uA4Mf
        i8mTnj8Q==;
Received: from [2001:4bb8:184:72db:7ad9:14d9:8599:3025] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSIX2-002f3R-E2; Mon, 20 Sep 2021 12:37:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 07/17] sched: move the <linux/blkdev.h> include out of kernel/sched/sched.h
Date:   Mon, 20 Sep 2021 14:33:18 +0200
Message-Id: <20210920123328.1399408-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920123328.1399408-1-hch@lst.de>
References: <20210920123328.1399408-1-hch@lst.de>
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

