Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16154C43462
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA38B61131
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhDOXQB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 19:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbhDOXQB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 19:16:01 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00FC061574
        for <linux-block@vger.kernel.org>; Thu, 15 Apr 2021 16:15:36 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 130so12882823qkm.4
        for <linux-block@vger.kernel.org>; Thu, 15 Apr 2021 16:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7RCfwAN4jL/DjugvaPSOGTsmpmXQlAF+zlH96pTjoMg=;
        b=HSjDkB47gFDJ40jIAgfKGOwisFzX5ppiQIpfjeawhJybyMhgCNcxjSqQmUoZcyiDyn
         aNlTbyf4LI0Ct4TP1bykmZBA9UNZy8Scaz7Nq440NfLOJOIP51+A8YcmbSWbT/PK12Zv
         +fPfnby7kQIvUGbn6kgzIWOYUwV6Edi//Cw2HO8BQFhBV/3ElwAQqI6LDP8pBGKVGHAG
         AaGS0JiEhoxfLD3Zn/Uh/AeIyPvxPSFNjGJb0gSFf8jKVwZZ0hBYYvC4ORI7mbZ3D9dM
         O3gsrE9a3TPX2n2MB89THPuJc+reClB+ZPZqzS/iUr10SuWZJ2yb4PretCEq4TL31I+I
         6Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=7RCfwAN4jL/DjugvaPSOGTsmpmXQlAF+zlH96pTjoMg=;
        b=f6SoO+/K4Zd1xtZesf54UKZ9PZOEnC1AkWjg82HzZIhyl5w/FViZiJSpuERRmpZiPe
         zvajd72Bg+6tPiuHKmBVu9+JWu45IAomW2Wu2nUoTw7LkCY7VCQ1VO4sBi4pS8GSdXXE
         YSMlPdNhiL3qW/4c+3AXv775aSID+byUoDNFmIp3T90oi40xamq8SHag1EtsdlNbSLHV
         pTuANVmJPRe4icju1jT3Mo37VC1FcZhF473ur/pjgoukshPY7mA1rYBPaGVdDrFq1sI2
         JqoZ9yFvEZ5cj9wO7XDOqrplnsHopHIWEv7ucwZn6paMlcCJbOwuhRbJvH4aT2Vxr+pq
         s3OA==
X-Gm-Message-State: AOAM5322HzvFR9FmoWR7HhD7Po/IkxUuJEEcto5t7SEFCrI4iTxEFPrc
        S8gKnMjjb5wK0wS0I07QYYk=
X-Google-Smtp-Source: ABdhPJwf8piMfDo08mpBT8UOsivPw4eYX8FyC0nqQZZ8gbPRXDke0svfzY8InnsN4GsOOspqnWEdpA==
X-Received: by 2002:a05:620a:70c:: with SMTP id 12mr336862qkc.377.1618528536145;
        Thu, 15 Apr 2021 16:15:36 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id c17sm2627690qtd.71.2021.04.15.16.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 16:15:35 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH v2 3/4] nvme: introduce FAILUP handling for REQ_FAILFAST_TRANSPORT
Date:   Thu, 15 Apr 2021 19:15:29 -0400
Message-Id: <20210415231530.95464-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210415231530.95464-1-snitzer@redhat.com>
References: <20210415231530.95464-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If REQ_FAILFAST_TRANSPORT is set it means the driver should not retry
IO that completed with transport errors. REQ_FAILFAST_TRANSPORT is
set by multipathing software (e.g. dm-multipath) before it issues IO.

Update NVMe to allow failover of requests marked with either
REQ_NVME_MPATH or REQ_FAILFAST_TRANSPORT. This allows such requests
to be given a disposition of either FAILOVER or FAILUP respectively.
FAILUP handling ensures a retryable error is returned up from NVMe.

Introduce nvme_failup_req() for use in nvme_complete_rq() if
nvme_decide_disposition() returns FAILUP. nvme_failup_req() ensures
the request is completed with a retryable IO error when appropriate.
__nvme_end_req() was factored out for use by both nvme_end_req() and
nvme_failup_req().

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4134cf3c7e48..10375197dd53 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -299,6 +299,7 @@ enum nvme_disposition {
 	COMPLETE,
 	RETRY,
 	FAILOVER,
+	FAILUP,
 };
 
 static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
@@ -318,10 +319,11 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
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
@@ -330,10 +332,8 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	return RETRY;
 }
 
-static inline void nvme_end_req(struct request *req)
+static inline void __nvme_end_req(struct request *req, blk_status_t status)
 {
-	blk_status_t status = nvme_error_status(nvme_req(req)->status);
-
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = nvme_lba_to_sect(req->q->queuedata,
@@ -343,6 +343,24 @@ static inline void nvme_end_req(struct request *req)
 	blk_mq_end_request(req, status);
 }
 
+static inline void nvme_end_req(struct request *req)
+{
+	__nvme_end_req(req, nvme_error_status(nvme_req(req)->status));
+}
+
+static void nvme_failup_req(struct request *req)
+{
+	blk_status_t status = nvme_error_status(nvme_req(req)->status);
+
+	if (WARN_ON_ONCE(!blk_path_error(status))) {
+		pr_debug("Request meant for failover but blk_status_t (errno=%d) was not retryable.\n",
+			 blk_status_to_errno(status));
+		status = BLK_STS_IOERR;
+	}
+
+	__nvme_end_req(req, status);
+}
+
 void nvme_complete_rq(struct request *req)
 {
 	trace_nvme_complete_rq(req);
@@ -361,6 +379,9 @@ void nvme_complete_rq(struct request *req)
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

