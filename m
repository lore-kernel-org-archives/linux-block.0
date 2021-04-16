Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DE5C433ED
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 22:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B2861107
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 22:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhDPWHL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbhDPWHJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 18:07:09 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CAFC061574
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 15:06:42 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id i6so12318677qti.10
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T/JS0tPFuGx026nisaFi9hJiA3/ZXWO6l+YekczmOw4=;
        b=A5OY46EW0Bi2mszyQA/M6FH31LsD9a02pRqwcxcfjKCMFnRgWnOWR5QFY7iHAy16zF
         mrcEm/1grade7bnJ1u01dFs4y6Zq8pY1cdA8ILzMDrVnd6Gu35NYl0GQeJw5wkAl42sj
         QX7eo8m30g/d80fPahymTwZgbIZ7eNGjhDslt75qhi2bvq00qh+cCzjFDx7Fh1FeJK64
         iqkc2yH+FPOGqptvoB0JfBA9ZF7/84N193cRbCnFTDr6vH33hQuys4QSq5hlMhm3/YmX
         fEyDAAXY2CWCMrwLrmyt8UHpsAAawgck9LQFdt5rQZfjqtyyjftlyDr3zCVTUIozni1D
         PqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=T/JS0tPFuGx026nisaFi9hJiA3/ZXWO6l+YekczmOw4=;
        b=YdMugY7Q3vdyf42gmX7IgYE1iZJ1bgf2dtcblwEimBJCFDBOK3pPpOjr6jD2Hfgelg
         CnxDQOTZJ0DXg30MmUMrD5DTVbfkD56Vq7rP2Ig70d3GbSwGkWFRICFtXqEfI4hJpAx0
         ChkGW1XjnIXl1HD7ZT/bddVj2sT/4GPeBHc2ocf/lnOu8bVW/vRsK+JdLlYiUNwPVM8H
         lERsXDfBjSr07I1vG6/ZZzDTm5OP/xXsSeCfhYRxNGlrZiVZd8WaHDXgJBmi8K4oBK+H
         MQt36AcxhNPoct0iPKahLSNwJ0RydegRdFxTdebM6M+ggxutJ/EJzLPcX0FQzyXF88s/
         jrrQ==
X-Gm-Message-State: AOAM532jrWOJeV9oZD38m+nIeFKldlUdBFXjSjzOC5OfdmzjZ+5G1pJE
        NxRyo7HWjdKJxx9mdkxt4+I=
X-Google-Smtp-Source: ABdhPJxyJrj306zuvVTg3nzFruQmMJ8VK2i/9VkWSo3aiQx5V9FJ+qx4C2zKZCnzibF9TMCU9sAExA==
X-Received: by 2002:a05:622a:52:: with SMTP id y18mr1219038qtw.216.1618610801550;
        Fri, 16 Apr 2021 15:06:41 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id o62sm5165833qkd.81.2021.04.16.15.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:06:41 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>
Subject: [PATCH v3 2/4] nvme: allow local retry for requests with REQ_FAILFAST_TRANSPORT set
Date:   Fri, 16 Apr 2021 18:06:35 -0400
Message-Id: <20210416220637.41111-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210416220637.41111-1-snitzer@redhat.com>
References: <20210416220637.41111-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chao Leng <lengchao@huawei.com>

REQ_FAILFAST_TRANSPORT was designed for SCSI, because the SCSI protocol
does not define the local retry mechanism. SCSI implements a fuzzy
local retry mechanism, so REQ_FAILFAST_TRANSPORT is needed to allow
higher-level multipathing software to perform failover/retry.

NVMe is different with SCSI about this. It defines a local retry
mechanism and path error codes, so NVMe should retry local for non
path error. If path related error, whether to retry and how to retry
is still determined by higher-level multipathing's failover.

Unlike SCSI, NVMe shouldn't prevent retry if REQ_FAILFAST_TRANSPORT
because NVMe's local retry is needed -- as is NVMe specific logic to
categorize whether an error is path related.

In this way, the mechanism of NVMe multipath or other multipath are
now equivalent. The mechanism is: non path related error will be
retried locally, path related error is handled by multipath.

Signed-off-by: Chao Leng <lengchao@huawei.com>
[snitzer: edited header for grammar and clarity, also added code comment]
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 540d6fd8ffef..4134cf3c7e48 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -306,7 +306,14 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
-	if (blk_noretry_request(req) ||
+	/*
+	 * REQ_FAILFAST_TRANSPORT is set by upper layer software that
+	 * handles multipathing. Unlike SCSI, NVMe's error handling was
+	 * specifically designed to handle local retry for non-path errors.
+	 * As such, allow NVMe's local retry mechanism to be used for
+	 * requests marked with REQ_FAILFAST_TRANSPORT.
+	 */
+	if ((req->cmd_flags & (REQ_FAILFAST_DEV | REQ_FAILFAST_DRIVER)) ||
 	    (nvme_req(req)->status & NVME_SC_DNR) ||
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
-- 
2.15.0

