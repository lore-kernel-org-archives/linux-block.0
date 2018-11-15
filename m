Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D462FC43610
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C46121780
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Z0vv1NFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C46121780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeKPGBK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:01:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42847 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeKPGBK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 01:01:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id x21-v6so7241864pln.9
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 11:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UjKFPPY66VB4W6EBmXfarxZuGQQ5lRuC6yiN12FUde8=;
        b=Z0vv1NFk8YfS0Xj6QE28UswnkjV973Br90CAQ8O6HCiICvXWAb2OMXpKOdgRDrBShq
         fgMc2QH/gu3UkcxH+WvZrgDYGOLdtNmC5l0EAQ5fXWhZuWomVrx7CsErgwbt9qAmV5C4
         M/6nu6f3UUyH2l7xf7V379Fi7Xqdhb8AKlj9AvgG4+Znb3jgydg6C4aygysDhK2bfrPt
         u5PZSHe3R/v2lC7i4Qsv2SnHMnvG8JD+EM8DQ1epe6p3e0BZIRkPQ8OhNy/7XjPOPZZn
         wHT/zU7XLGd29fw0nT6BwF8k4DyOpw16oY0qXaIcY84JgOouOVXlHK+phoGypW3eOBKA
         Z5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UjKFPPY66VB4W6EBmXfarxZuGQQ5lRuC6yiN12FUde8=;
        b=Irj5Rmnrp19Uh1XjlD5BexmZRWsIyuEymoCH3KeyeqdARjc+8vF+AzpzCZY1UU283E
         /U7KNgZzf6QTAZVMHGYe2xQlfDn3lQoOcdpBCk6805NPr1sBWdpaWuQkSgpeoE12RWKB
         7PB9oMH0clt7Sr3YotfGKQOea7SwjgZKrOak+dpwIgWQB+N0qGVPWLyGtBWSEFpI6tCa
         Fab8n7N2E2u01ljI0SRdMs1pANerkXYgNpopQGRM+lnC8haAiyCSopjgJIhPkMxd+j4g
         j5D1lkI4/w3aertiV+4YMrCL6AqBGxLXU8FHvJAoiRtBWhzV9sXZTxATSezyjGk5lhF1
         OqgQ==
X-Gm-Message-State: AGRZ1gKdwbhYm61roqqMw3a0hboFjMMevWSGNEAIQqoAFWABH0OJebLv
        CPOF8ia1JfdZoYSs7/uq4JYprSvdUf4=
X-Google-Smtp-Source: AJdET5dKp4SIOsgjibHOjeqebQ2SYxZIXGybbY6STVljeN5N95MW/QlKZJ4X5Fo3mV6Q2iCkh+gJwQ==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63-v6mr7681411plb.241.1542311517808;
        Thu, 15 Nov 2018 11:51:57 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id d68-v6sm30670766pfa.80.2018.11.15.11.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:51:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/11] blk-mq: ensure mq_ops ->poll() is entered at least once
Date:   Thu, 15 Nov 2018 12:51:33 -0700
Message-Id: <20181115195135.22812-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115195135.22812-1-axboe@kernel.dk>
References: <20181115195135.22812-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we immediately bail if need_resched() is true, but
we need to do at least one loop in case we have entries waiting.
So just invert the need_resched() check, putting it at the
bottom of the loop.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 695aa9363a6e..0ff70dfc8c0e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3336,7 +3336,7 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, bool spin)
 	hctx->poll_considered++;
 
 	state = current->state;
-	while (!need_resched()) {
+	do {
 		int ret;
 
 		hctx->poll_invoked++;
@@ -3356,7 +3356,7 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, bool spin)
 		if (ret < 0 || !spin)
 			break;
 		cpu_relax();
-	}
+	} while (!need_resched());
 
 	__set_current_state(TASK_RUNNING);
 	return 0;
-- 
2.17.1

