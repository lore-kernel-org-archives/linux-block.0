Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559FEC433ED
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 23:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E58B61166
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 23:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhDPXyC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDPXyB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 19:54:01 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455C9C061756
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 16:53:34 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id z15so14005128qtj.7
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 16:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a1nvUyKb7Km0hekKdxHGyN60tpfHzRrsEqFGAZI+ni4=;
        b=BdMJCnbct5KBJPP5KqyCcBSekxteAlGsUyEUCoGq/aas7H8lj1zNY/JEg1Dr1ksZ+f
         Tihi06XP8wDuWWI4N01bDBKOwW6/3yYFyIfyZwb3kCCZmtq3Y04pS/wgFVkLb+kpdlke
         KHtZ7wzFAHPhexb0v4g6UHVVyAallv45CkVa1a7BeT7iPBek05P/JGiwUxWyqUkJdDFf
         7pdnQbVFf9eRE546Tcw4okY6RSuEaQbDRcx+J9t75+DjKYZmS6Ea9a6RZXoqHxPC/dPC
         HQ95CTmz03mie15e/yUsmUkFLWqvQz7jkjlAF8szQudy4vVy/sL8gc3P5MQh4Jwi0C3d
         wtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=a1nvUyKb7Km0hekKdxHGyN60tpfHzRrsEqFGAZI+ni4=;
        b=m9GY4lAhNpnPOI+oTJ6yjMl5ZqsODNZbgiN38OSK/8+jRW6sO9SkEhQxyL+fOFCdqR
         tk/6e9TX+VOTi5F0+KrWLIlydQH65KMnkxbiqrTLQmLpJwEU2GKFkKQaZhbfFh5jVyTf
         oRTVEZo7ipR5jbAuMe9ahFHQJdzQ70Qd4ZSEH3bWjNyHVwVsiudgkEUwVah+DXLJyoFo
         j5X4X2a2OGTfv8YdB14AXIfYxOT1aZtTpmtZYicvuJcFZRFH2r/L5S+sc7CXzPuETjFU
         J2NsLBpC7MF+QYrLd+k5zQMrI9PgjF3Xt8biyYIxoTH6EE+9nQICTThgTXVVpHsP3Lj5
         KxDA==
X-Gm-Message-State: AOAM532Yah/CBw2jMDZTdg75AGeFD8NBYk31PR2pKpoKykCRR4zdeBWI
        TMpScsAFdukNTm12x1b9mGw=
X-Google-Smtp-Source: ABdhPJxYYCrNVTkBMHh7ujpabmWkrGvRS/5k9AOlVSsGCZug6eBYSy3tgv0ntn47DVL2D4MVf0kk9A==
X-Received: by 2002:ac8:6b46:: with SMTP id x6mr1598672qts.150.1618617213544;
        Fri, 16 Apr 2021 16:53:33 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id a66sm1377452qkc.74.2021.04.16.16.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 16:53:33 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH v4 2/3] nvme: allow local retry and proper failover for REQ_FAILFAST_TRANSPORT
Date:   Fri, 16 Apr 2021 19:53:28 -0400
Message-Id: <20210416235329.49234-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210416235329.49234-1-snitzer@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

REQ_FAILFAST_TRANSPORT is set by upper layer software that handles
multipathing. Unlike SCSI, NVMe's error handling was specifically
designed to handle local retry for non-path errors. As such, allow
NVMe's local retry mechanism to be used for requests marked with
REQ_FAILFAST_TRANSPORT.

In this way, the mechanism of NVMe multipath or other multipath are
now equivalent. The mechanism is: non path related error will be
retried locally, path related error is handled by multipath.

Also, introduce FAILUP handling for REQ_FAILFAST_TRANSPORT. Update
NVMe to allow failover of requests marked with either REQ_NVME_MPATH
or REQ_FAILFAST_TRANSPORT. This allows such requests to be given a
disposition of either FAILOVER or FAILUP respectively.

nvme_complete_rq() is updated to call nvme_failup_req() if
nvme_decide_disposition() returns FAILUP. nvme_failup_req() ensures
the request is completed with a retryable path error.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 540d6fd8ffef..a12b10a1383c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -299,6 +299,7 @@ enum nvme_disposition {
 	COMPLETE,
 	RETRY,
 	FAILOVER,
+	FAILUP,
 };
 
 static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
@@ -306,15 +307,16 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
-	if (blk_noretry_request(req) ||
+	if ((req->cmd_flags & (REQ_FAILFAST_DEV | REQ_FAILFAST_DRIVER)) ||
 	    (nvme_req(req)->status & NVME_SC_DNR) ||
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
 
-	if (req->cmd_flags & REQ_NVME_MPATH) {
+	if (req->cmd_flags & (REQ_NVME_MPATH | REQ_FAILFAST_TRANSPORT)) {
 		if (nvme_is_path_error(nvme_req(req)->status) ||
 		    blk_queue_dying(req->q))
-			return FAILOVER;
+			return (req->cmd_flags & REQ_NVME_MPATH) ?
+				FAILOVER : FAILUP;
 	} else {
 		if (blk_queue_dying(req->q))
 			return COMPLETE;
@@ -336,6 +338,12 @@ static inline void nvme_end_req(struct request *req)
 	blk_mq_end_request(req, status);
 }
 
+static inline void nvme_failup_req(struct request *req)
+{
+	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
+	nvme_end_req(req);
+}
+
 void nvme_complete_rq(struct request *req)
 {
 	trace_nvme_complete_rq(req);
@@ -354,6 +362,9 @@ void nvme_complete_rq(struct request *req)
 	case FAILOVER:
 		nvme_failover_req(req);
 		return;
+	case FAILUP:
+		nvme_failup_req(req);
+		return;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
-- 
2.15.0

