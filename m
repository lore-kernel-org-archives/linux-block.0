Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39D4C433FE
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 21:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383258AbhLCVtU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbhLCVtU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 16:49:20 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E36C061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 13:45:55 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g18so4083507pfk.5
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 13:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jIRFGxrYQlPRm7z5eZ4R3P7jhnosq67mPO1H2y/DpmQ=;
        b=BpzKmP9l5WsKjZFs9SR9AjohNSkKzMg1wMi/L5sVHQlrqA8/vyWQkHbZhrqJ2ZG9nK
         kH4pRL3yClleD1r1eHKwPggfzl82OqELyv2hjMxGO6u6EZ1E5Ez2Nk+UHH88fkEdvzNQ
         gjXOxZyMJ0zpgj1LHvMBUiqvaH4NpTJHqXyYdn208/SyDspY3gIGI9odg+I+HaPcyttQ
         DwqpphZ/G1L14WFUXiOPiOrLHDKSyuBFUGLd7befto1KpBRq9y345ET19MQ+fNdUHp9L
         H/QJhojsf0kAMrM4W1a9VIZ8B+j3lcSOgB5tB0mtvpjTRieJVsyyce10ia0Jq63W9f5U
         cI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jIRFGxrYQlPRm7z5eZ4R3P7jhnosq67mPO1H2y/DpmQ=;
        b=ILxJTqWQvQoRuvDZHao0qgjvQUte8R+prHTSPy2b2ArORDB1lQKVA/MAUxRFUtNbz8
         eNmK9Z+KV+ASpZCOakAeu7b5/v8549mIUYel7xrhnN3mQqjnvIurUfQKCRdJwgR5cd3/
         /nbxn9bJrS4lBcJ7SxHIIdL84LGkANdGwwTsuHrpi4bwKQyU/VTwOnvOnTtuNS3YDGU/
         z4CSslaTtdglVoaq/GfBOds+1Qej9M+w/iVUfpO9lzPiAQJ6xvgA0+ytI80v7TDlJYOg
         uAz66fnVKoIJqtblscy/MHBUeGiqnAItNyonlC77CR/47vv4P1Z/g3VIsTT7t6uZwTTu
         M1jg==
X-Gm-Message-State: AOAM533uSLawRokz7nNeCrbm1gcqqchC8yu8SM+Np9Tu/9fx/cN9AQ0T
        mUmltq8khslcz3+jhUHE0tWOJeOFCfBndVs9
X-Google-Smtp-Source: ABdhPJzaqYWCIttA1Pb1xjDkmPu7X7KOjQ/HgtCzoSMTmd0qdLZ1UopuyI3bQqiuAMWNUyY2D3hiug==
X-Received: by 2002:a65:464e:: with SMTP id k14mr6392693pgr.493.1638567955191;
        Fri, 03 Dec 2021 13:45:55 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id f4sm4436225pfj.61.2021.12.03.13.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:45:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/4] nvme: split command copy into a helper
Date:   Fri,  3 Dec 2021 14:45:42 -0700
Message-Id: <20211203214544.343460-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203214544.343460-1-axboe@kernel.dk>
References: <20211203214544.343460-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We'll need it for batched submit as well.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8637538f3fd5..09ea21f75439 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -500,6 +500,15 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
 
+static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
+				    struct nvme_command *cmd)
+{
+	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes), cmd,
+		sizeof(*cmd));
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+}
+
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -510,10 +519,7 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 			    bool write_sq)
 {
 	spin_lock(&nvmeq->sq_lock);
-	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
-	       cmd, sizeof(*cmd));
-	if (++nvmeq->sq_tail == nvmeq->q_depth)
-		nvmeq->sq_tail = 0;
+	nvme_sq_copy_cmd(nvmeq, cmd);
 	nvme_write_sq_db(nvmeq, write_sq);
 	spin_unlock(&nvmeq->sq_lock);
 }
-- 
2.34.1

