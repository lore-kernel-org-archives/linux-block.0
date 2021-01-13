Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BCEC433DB
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6405C233A2
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbhAML1a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:27:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:43624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbhAML1a (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 06:27:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1DC0AF0D;
        Wed, 13 Jan 2021 11:26:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3B78F1E0872; Wed, 13 Jan 2021 12:26:48 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] blkparse: Print time when trace was started
Date:   Wed, 13 Jan 2021 12:26:43 +0100
Message-Id: <20210113112643.12893-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For correlating blktrace data with other information, it is useful to
know when the trace has been captured. Since the absolute timestamp
is contained in the blktrace file, just output it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 blkparse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/blkparse.c b/blkparse.c
index 911309e26a15..dc518632ebf5 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -31,6 +31,7 @@
 #include <signal.h>
 #include <locale.h>
 #include <libgen.h>
+#include <time.h>
 
 #include "blktrace.h"
 #include "rbtree.h"
@@ -2797,6 +2798,7 @@ static void show_stats(void)
 
 	if (per_device_and_cpu_stats)
 		show_device_and_cpu_stats();
+	fprintf(ofp, "Trace started at %s\n", ctime(&abs_start_time.tv_sec));
 
 	fflush(ofp);
 }
-- 
2.26.2

