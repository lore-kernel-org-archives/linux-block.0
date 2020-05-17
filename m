Return-Path: <SRS0=r/dS=67=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8539C433DF
	for <linux-block@archiver.kernel.org>; Sun, 17 May 2020 11:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74802206F4
	for <linux-block@archiver.kernel.org>; Sun, 17 May 2020 11:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPK6UhYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgEQLuJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 May 2020 07:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgEQLuJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 07:50:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092BCC061A0C;
        Sun, 17 May 2020 04:50:09 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f15so2980279plr.3;
        Sun, 17 May 2020 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RQqCyR4bauMcLEGGbKHO9FQ26y1JMcu6L0Mz2chabH4=;
        b=TPK6UhYz1SmNZpLvbYJP2NFkB4VEnM1LAp3SFhb6dijjHxHPOVYj6mPJCuzeut/Ihd
         CdfrZacKNWM2ik+Z1ra2/zwMjcP1as1cGPQMnZRqA8x4/3lwqQB5wdHepYJynSn+7u7e
         bgDtKINcFBGn7wpsLvdT3iwn5VLR5hYjIx9BYTg2vD/4N2vCHWvR9vCL5qa0xXZELQ55
         rFZayqMTXCSRoE87RGCc1v7hvQJ6QXSctqeApFtHISQH3Dir/ZfDOIKM/LnYMQiXHrd2
         8CHb47vAyVcRcdImLO4QO2/ZX0JWuAF/ldMJSNAJpEUrxj1hNPXdvKrkWjvb7eGsn6mQ
         0ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RQqCyR4bauMcLEGGbKHO9FQ26y1JMcu6L0Mz2chabH4=;
        b=IaMBK4ICpDekRQcZXNx5nf5shavli7haCf57aam/CZouuhYJFv24SqdP54u9nMziab
         OSUw28wjxt9+/+UymL+2790Eo+3lXqxLVWR9dldQJLGzF1aI6pM9rryU0yVTHQWcZpTL
         3tAbETJVeKU+SRVj1XJsQrBm5SzuowUmcd+Wm3WTJfJSCvtrvg+jN2OUaYVf1nrI4r1+
         PVWkTW1lbVoOCDoCLudW7FEFoaS6BzX/Q0O0esMiXd9/batA0CV/D+FB+8J6P91uStY5
         9Ud1obY+t5AEReEJv+OupKEXv6zrN1JN4h9zKj/fgHhepYnUCIga0OFJyrg8VNAY4vc+
         Lc1g==
X-Gm-Message-State: AOAM531vO/6ECR3skm9O99U1myRAyHglrYMDdHMsEXSdxaA+1tsWR3RR
        10P+lcSdigC9uVNmC1SOiSg0oWIw
X-Google-Smtp-Source: ABdhPJxbrMBUtFQL05TFgNGN60nbsF7yRGsKFZzFSbjieqrezfN5QeSD8vdp7GegJlpcQMlCWDposQ==
X-Received: by 2002:a17:90a:2610:: with SMTP id l16mr13174341pje.219.1589716208483;
        Sun, 17 May 2020 04:50:08 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.16])
        by smtp.gmail.com with ESMTPSA id cc8sm5842593pjb.11.2020.05.17.04.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 04:50:07 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     axboe@kernel.dk
Cc:     baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: Remove unused flush_queue_delayed in struct blk_flush_queue
Date:   Sun, 17 May 2020 19:49:41 +0800
Message-Id: <d4104441539e9d8d2bc29a9c970713ba1ef2105d.1589715744.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The flush_queue_delayed was introdued to hold queue if flush is
running for non-queueable flush drive by commit 3ac0cc450870
("hold queue if flush is running for non-queueable flush drive"),
but the non mq parts of the flush code had been removed by
commit 7e992f847a08 ("block: remove non mq parts from the flush code"),
as well as removing the usage of the flush_queue_delayed flag.
Thus remove the unused flush_queue_delayed flag.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 block/blk-flush.c | 1 -
 block/blk.h       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index c7f396e3d5e2..b733f7ac75c7 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -258,7 +258,6 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 		blk_flush_complete_seq(rq, fq, seq, error);
 	}
 
-	fq->flush_queue_delayed = 0;
 	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 }
 
diff --git a/block/blk.h b/block/blk.h
index fc00537026a0..6cab33a11f90 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -19,7 +19,6 @@ extern struct dentry *blk_debugfs_root;
 #endif
 
 struct blk_flush_queue {
-	unsigned int		flush_queue_delayed:1;
 	unsigned int		flush_pending_idx:1;
 	unsigned int		flush_running_idx:1;
 	blk_status_t 		rq_status;
-- 
2.17.1

