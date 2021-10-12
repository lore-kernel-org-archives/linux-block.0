Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C67C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9447460ED4
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhJLST4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhJLSTx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:19:53 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E93C061749
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:50 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h196so11952111iof.2
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=asLPVvaI6oCPe8wORJN6EjuFtRgJYqm63DZu+cx8JsQ=;
        b=CmfEc9mQB9lO29JPwofIa11Kas2KU5iu8SUhbohb4VSoVmZThidxv7WrmW9wMBYrZ5
         2ovXZs50WzQXM9a300stHamMPsMBaANPbsN4QnYm3xpfKk3ZWdwNJ7YAdPzRljHewmvc
         QiPsVNbBbP3OhbMpRt18Lf9Fp2mckYet1aRZHx3JiytcFV7PdYbd+lIIErp/LpLxLzdr
         02m+Y/KSVrJA/hoe5ZGU5GD1jMHxiKlLUytfVw/ALlGXjzUWzIgyXKbhgkL7t6y4kV12
         VfFIyzK+GNX3XtJR8d0qmpWqoKrekTX3D5tos0MI/kqyrtaqunJa6exPX/QINsCP5v0i
         50Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=asLPVvaI6oCPe8wORJN6EjuFtRgJYqm63DZu+cx8JsQ=;
        b=LNVy8tBbqLrRoTO6OLRgqqUaaiMaCwqckKcRB97w8ClMojMmEf7DxRnmN1BCOPpeca
         Yv0TSWxR2wlk/3JEvuD/eqDmjFj7wrImMzPfl9pyFCX5z6ZYTBGd7w7v8bJSOBvxqVXn
         saOSfvWebNd5ioCic3cFxvb07LGgImV6VzeL3S9Hlk1VqBn5endNYxDfBdVwH62+Djq2
         OzMS0JgdAaMtSDlpiO9m6HOv+A1jFneTcumXbljiHXMzEOacsr5pyNJAAMHwQuIYU5Ol
         t3kLI1q21qddEWB/d3R5Eh67RZUz7ZRqWvzp0tSN6CpQI7/LaJEb4RQnKxq+PW1oj+ZP
         7Zcg==
X-Gm-Message-State: AOAM5326WFb+q0aikdYCegfBw6jTpvJR8KYxdXb2wFooI36GzF6FvgEG
        ZJW71QNoJCeIs1jiAP2hDH/ot74ZKgrCug==
X-Google-Smtp-Source: ABdhPJwkE3dxr/0rq0VrRSE68PL1+EAMN/pQspwllaSGJWl/eYWlW2ZK4LHYccQBKKjnL7pSKfMP0g==
X-Received: by 2002:a05:6602:15d3:: with SMTP id f19mr12148167iow.161.1634062668482;
        Tue, 12 Oct 2021 11:17:48 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x5sm2242476ioh.23.2021.10.12.11.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:17:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/9] nvme: move the fast path nvme error and disposition helpers
Date:   Tue, 12 Oct 2021 12:17:38 -0600
Message-Id: <20211012181742.672391-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012181742.672391-1-axboe@kernel.dk>
References: <20211012181742.672391-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These are called for every IO completion, move them inline in the nvme
private header rather than have them be a function call out of the PCI
part of the nvme drivers.

We also need them for batched handling, hence the patch also serves as a
preparation for that.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/core.c | 73 ++--------------------------------------
 drivers/nvme/host/nvme.h | 72 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 71 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4b7c009fccfe..ec7fa6f31e68 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -44,9 +44,10 @@ static unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
 
-static u8 nvme_max_retries = 5;
+u8 nvme_max_retries = 5;
 module_param_named(max_retries, nvme_max_retries, byte, 0644);
 MODULE_PARM_DESC(max_retries, "max number of retries a command may have");
+EXPORT_SYMBOL_GPL(nvme_max_retries);
 
 static unsigned long default_ps_max_latency_us = 100000;
 module_param(default_ps_max_latency_us, ulong, 0644);
@@ -261,48 +262,6 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 	nvme_put_ctrl(ctrl);
 }
 
-static blk_status_t nvme_error_status(u16 status)
-{
-	switch (status & 0x7ff) {
-	case NVME_SC_SUCCESS:
-		return BLK_STS_OK;
-	case NVME_SC_CAP_EXCEEDED:
-		return BLK_STS_NOSPC;
-	case NVME_SC_LBA_RANGE:
-	case NVME_SC_CMD_INTERRUPTED:
-	case NVME_SC_NS_NOT_READY:
-		return BLK_STS_TARGET;
-	case NVME_SC_BAD_ATTRIBUTES:
-	case NVME_SC_ONCS_NOT_SUPPORTED:
-	case NVME_SC_INVALID_OPCODE:
-	case NVME_SC_INVALID_FIELD:
-	case NVME_SC_INVALID_NS:
-		return BLK_STS_NOTSUPP;
-	case NVME_SC_WRITE_FAULT:
-	case NVME_SC_READ_ERROR:
-	case NVME_SC_UNWRITTEN_BLOCK:
-	case NVME_SC_ACCESS_DENIED:
-	case NVME_SC_READ_ONLY:
-	case NVME_SC_COMPARE_FAILED:
-		return BLK_STS_MEDIUM;
-	case NVME_SC_GUARD_CHECK:
-	case NVME_SC_APPTAG_CHECK:
-	case NVME_SC_REFTAG_CHECK:
-	case NVME_SC_INVALID_PI:
-		return BLK_STS_PROTECTION;
-	case NVME_SC_RESERVATION_CONFLICT:
-		return BLK_STS_NEXUS;
-	case NVME_SC_HOST_PATH_ERROR:
-		return BLK_STS_TRANSPORT;
-	case NVME_SC_ZONE_TOO_MANY_ACTIVE:
-		return BLK_STS_ZONE_ACTIVE_RESOURCE;
-	case NVME_SC_ZONE_TOO_MANY_OPEN:
-		return BLK_STS_ZONE_OPEN_RESOURCE;
-	default:
-		return BLK_STS_IOERR;
-	}
-}
-
 static void nvme_retry_req(struct request *req)
 {
 	unsigned long delay = 0;
@@ -318,34 +277,6 @@ static void nvme_retry_req(struct request *req)
 	blk_mq_delay_kick_requeue_list(req->q, delay);
 }
 
-enum nvme_disposition {
-	COMPLETE,
-	RETRY,
-	FAILOVER,
-};
-
-static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
-{
-	if (likely(nvme_req(req)->status == 0))
-		return COMPLETE;
-
-	if (blk_noretry_request(req) ||
-	    (nvme_req(req)->status & NVME_SC_DNR) ||
-	    nvme_req(req)->retries >= nvme_max_retries)
-		return COMPLETE;
-
-	if (req->cmd_flags & REQ_NVME_MPATH) {
-		if (nvme_is_path_error(nvme_req(req)->status) ||
-		    blk_queue_dying(req->q))
-			return FAILOVER;
-	} else {
-		if (blk_queue_dying(req->q))
-			return COMPLETE;
-	}
-
-	return RETRY;
-}
-
 static inline void nvme_end_req(struct request *req)
 {
 	blk_status_t status = nvme_error_status(nvme_req(req)->status);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ed79a6c7e804..3d11b5cb478d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -903,4 +903,76 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
 }
 
+static inline blk_status_t nvme_error_status(u16 status)
+{
+	switch (status & 0x7ff) {
+	case NVME_SC_SUCCESS:
+		return BLK_STS_OK;
+	case NVME_SC_CAP_EXCEEDED:
+		return BLK_STS_NOSPC;
+	case NVME_SC_LBA_RANGE:
+	case NVME_SC_CMD_INTERRUPTED:
+	case NVME_SC_NS_NOT_READY:
+		return BLK_STS_TARGET;
+	case NVME_SC_BAD_ATTRIBUTES:
+	case NVME_SC_ONCS_NOT_SUPPORTED:
+	case NVME_SC_INVALID_OPCODE:
+	case NVME_SC_INVALID_FIELD:
+	case NVME_SC_INVALID_NS:
+		return BLK_STS_NOTSUPP;
+	case NVME_SC_WRITE_FAULT:
+	case NVME_SC_READ_ERROR:
+	case NVME_SC_UNWRITTEN_BLOCK:
+	case NVME_SC_ACCESS_DENIED:
+	case NVME_SC_READ_ONLY:
+	case NVME_SC_COMPARE_FAILED:
+		return BLK_STS_MEDIUM;
+	case NVME_SC_GUARD_CHECK:
+	case NVME_SC_APPTAG_CHECK:
+	case NVME_SC_REFTAG_CHECK:
+	case NVME_SC_INVALID_PI:
+		return BLK_STS_PROTECTION;
+	case NVME_SC_RESERVATION_CONFLICT:
+		return BLK_STS_NEXUS;
+	case NVME_SC_HOST_PATH_ERROR:
+		return BLK_STS_TRANSPORT;
+	case NVME_SC_ZONE_TOO_MANY_ACTIVE:
+		return BLK_STS_ZONE_ACTIVE_RESOURCE;
+	case NVME_SC_ZONE_TOO_MANY_OPEN:
+		return BLK_STS_ZONE_OPEN_RESOURCE;
+	default:
+		return BLK_STS_IOERR;
+	}
+}
+
+enum nvme_disposition {
+	COMPLETE,
+	RETRY,
+	FAILOVER,
+};
+
+extern u8 nvme_max_retries;
+
+static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
+{
+	if (likely(nvme_req(req)->status == 0))
+		return COMPLETE;
+
+	if (blk_noretry_request(req) ||
+	    (nvme_req(req)->status & NVME_SC_DNR) ||
+	    nvme_req(req)->retries >= nvme_max_retries)
+		return COMPLETE;
+
+	if (req->cmd_flags & REQ_NVME_MPATH) {
+		if (nvme_is_path_error(nvme_req(req)->status) ||
+		    blk_queue_dying(req->q))
+			return FAILOVER;
+	} else {
+		if (blk_queue_dying(req->q))
+			return COMPLETE;
+	}
+
+	return RETRY;
+}
+
 #endif /* _NVME_H */
-- 
2.33.0

