Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E0EC43461
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 22:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 883556115B
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 22:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbhDPWHL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 18:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbhDPWHJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 18:07:09 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7349EC061756
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 15:06:43 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q136so9526612qka.7
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 15:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bMR2VTLj6F901p54R7TJJG701KH0qEMwjYWby2WBJ1k=;
        b=mDbIrcwHFRy36PxLRjINn8KBeQK2Ja/TGUbAGVEyEBT37K1rvaRAlkrDNeJq/H3FZZ
         cqqFrzkh9T9aBaM0RJ1UtGCc/jYEa82z2twH0NyE1CWV5hijRzXptVHlq3Hv6G3g7Ozb
         AKvmml+Zn2DR4xbG4k4pu9aYBgvbr0jJWoiNtwGjphQfr4Z1KxKXnlHMwyBbpwSRzzBa
         6yDUJOsJ4AOGUWhkUvDkGml3yGr8IrGqo07FHzOug43DugUS+N9qWNfke0iDL2o/8ONi
         cTF+LUdYsZ39xgjDEt0IC2jdjJ97Q7aNOMU0SlXTWjwuvWOZwH9hjj/3O4eu9gdXoYVi
         mhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=bMR2VTLj6F901p54R7TJJG701KH0qEMwjYWby2WBJ1k=;
        b=NhRVATg0pWe1B1wTZpzkx8tgn5jKM62PCVVcMwsD7i+kOxWqZygedKZrF+OGp8lXLJ
         WTeH/AM6LmJieQiPcj2ssRtxEfQn0VTmh7Do8C63IopkVy89yezI3ibdlmyDFvpguWGL
         q/dXvSIWUseGR9ZbcoVRhzZsPNjQnmD09OZggrylP9Y3a6iTZL/gKAR7Zbr/IAzkS0VD
         CidMtfhBkzhC87ZRoJLfGfXqbQ+H00ZDhUDfLieElQyRTOcFCbhvXuU9oZwWkBSxXH3d
         cNCCkLLwqI3unR0V9sTyUJ0piA/tNtQGkPUScAekffxLufZ/CTKgR4ZrOurYyX/p2iMT
         R9dw==
X-Gm-Message-State: AOAM532rdKKLQut0F0SrN+wT81YIhvvm/t7uTz1ASqk102qMzmiHRADC
        4mXNmY9uu35dm6p7OVE/D5Q=
X-Google-Smtp-Source: ABdhPJwWCSOVGVoMxgIJwBSWNNpF9FwTIxmOZvPSZ8Rmi8aNJ381/s9+9qabM8hKroVd8ED9vuQBtw==
X-Received: by 2002:a37:7006:: with SMTP id l6mr1394793qkc.137.1618610802681;
        Fri, 16 Apr 2021 15:06:42 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d62sm5173006qkg.55.2021.04.16.15.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:06:42 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH v3 3/4] nvme: introduce FAILUP handling for REQ_FAILFAST_TRANSPORT
Date:   Fri, 16 Apr 2021 18:06:36 -0400
Message-Id: <20210416220637.41111-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210416220637.41111-1-snitzer@redhat.com>
References: <20210416220637.41111-1-snitzer@redhat.com>
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

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4134cf3c7e48..605ffba6835f 100644
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
@@ -343,6 +345,25 @@ static inline void nvme_end_req(struct request *req)
 	blk_mq_end_request(req, status);
 }
 
+static void nvme_failup_req(struct request *req)
+{
+	blk_status_t status = nvme_error_status(nvme_req(req)->status);
+
+	/* Ensure a retryable path error is returned */
+	if (WARN_ON_ONCE(!blk_path_error(status))) {
+		/*
+		 * If here, nvme_is_path_error() returned true.
+		 * So nvme_error_status() translation needs updating
+		 * relative to blk_path_error(), or vice versa.
+		 */
+		pr_debug("Request meant for failover but blk_status_t (errno=%d) was not retryable.\n",
+			 blk_status_to_errno(status));
+		nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
+	}
+
+	nvme_end_req(req);
+}
+
 void nvme_complete_rq(struct request *req)
 {
 	trace_nvme_complete_rq(req);
@@ -361,6 +382,9 @@ void nvme_complete_rq(struct request *req)
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

