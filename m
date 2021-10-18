Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5343EC433FE
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395C5610A1
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhJRMvu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 08:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhJRMvt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 08:51:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC082C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 05:49:38 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r134so16052441iod.11
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X/I+4ccwjP8RhmzCWaXlqxXJNfMZ+0DfyIWdXDVqb7Q=;
        b=ixk2v9cfH0i6p+4pK9mFnlLN9NdX1fR3HHLd1KB7nXoeQQ0c7kU3o6Aw9dhQuB/cr1
         /nx03bFSRwPhloUc+LUvzTfuL23lOvkEBWTXdA3k5y0YvQGob9Tj+IRdh3wZSHMwlQKf
         IjyWlKHYx9jsa7ZCirpNnORa8s8OOqp7kv4UYwYTjvsdTVXeGRn0Ru7kw5fKLJIc7zIq
         roQEpIv4nGQ8NY0We7iKpXi6kcQLuP4yj8Ai6AZoTww5fM5CnVlfVaBNWBmR6fXly3t3
         VmbmvwwhWu44I6MAJnbssMMck6h0WcbU1sJZ9xkrj/9ufejw0U1mepdLmz9IN8YrJncI
         SrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/I+4ccwjP8RhmzCWaXlqxXJNfMZ+0DfyIWdXDVqb7Q=;
        b=XhvDgpSJ6Sz8WJJ3RF+47CCraXu7yS8HV8q8enjcVgmMR1CFVgam1ZtfGTQ+6tdOr6
         Ux8EQvWJIHo7X7n18t3AFKt973dDLG9FmRaVej7mTeTf+Ahgm2+3p81+GtBm/PM8nxA4
         kRvoQAFtrdEGUklMY5L7TruAEOmcPFUQTEGd4S+CV21m8Su1ZZrqt9r1beXYP58xz87A
         pGJfnnXIqDFss5GmAgzkRjZnnXYHjXUPlAf4Mc22xn0tlqmpiY0eQP6em/9W5Ax0kWYu
         qnrrbLLw9YEI/sAcIQ+mytz4F3I+2ZNNOFLDMhV9hbTgpqTDKdlM3rn6V2rdUTyOyA1d
         J7Tw==
X-Gm-Message-State: AOAM531tDj9wvlPMfQWSdxb0jqTpa2GUkdEFzUJ/BFtZ/a/tkMUHLOtP
        0iHzOpLgaZ8ewLNea650qml2C9mnjHsK2g==
X-Google-Smtp-Source: ABdhPJxX3v0BcpqIEype8haPnxUHNoiCHzqVNcjO/sOY9lSlwFejDGGV/Rq8HWUdXxaDamn/5nOryw==
X-Received: by 2002:a6b:ee0d:: with SMTP id i13mr14062191ioh.166.1634561378245;
        Mon, 18 Oct 2021 05:49:38 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id z26sm6780081ioe.9.2021.10.18.05.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 05:49:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] nvme: move command clear into the various setup helpers
Date:   Mon, 18 Oct 2021 06:49:33 -0600
Message-Id: <20211018124934.235658-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018124934.235658-1-axboe@kernel.dk>
References: <20211018124934.235658-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We don't have to worry about doing extra memsets by moving it outside
the protection of RQF_DONTPREP, as nvme doesn't do partial completions.

This is in preparation for making the read/write fast path not do a full
memset of the command.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/core.c | 11 ++++++++---
 drivers/nvme/host/zns.c  |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ae15cb714596..7944ad52f213 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -874,6 +874,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		return BLK_STS_IOERR;
 	}
 
+	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->dsm.opcode = nvme_cmd_dsm;
 	cmnd->dsm.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->dsm.nr = cpu_to_le32(segments - 1);
@@ -890,6 +891,8 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd)
 {
+	memset(cmnd, 0, sizeof(*cmnd));
+
 	if (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
 		return nvme_setup_discard(ns, req, cmnd);
 
@@ -914,6 +917,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	u16 control = 0;
 	u32 dsmgmt = 0;
 
+	memset(cmnd, 0, sizeof(*cmnd));
+
 	if (req->cmd_flags & REQ_FUA)
 		control |= NVME_RW_FUA;
 	if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_RAHEAD))
@@ -982,17 +987,17 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 	blk_status_t ret = BLK_STS_OK;
 
-	if (!(req->rq_flags & RQF_DONTPREP)) {
+	if (!(req->rq_flags & RQF_DONTPREP))
 		nvme_clear_nvme_request(req);
-		memset(cmd, 0, sizeof(*cmd));
-	}
 
 	switch (req_op(req)) {
 	case REQ_OP_DRV_IN:
 	case REQ_OP_DRV_OUT:
 		/* these are setup prior to execution in nvme_init_request() */
+		memset(cmd, 0, sizeof(*cmd));
 		break;
 	case REQ_OP_FLUSH:
+		memset(cmd, 0, sizeof(*cmd));
 		nvme_setup_flush(ns, cmd);
 		break;
 	case REQ_OP_ZONE_RESET_ALL:
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index d95010481fce..bfc259e0d7b8 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -233,6 +233,8 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *c, enum nvme_zone_mgmt_action action)
 {
+	memset(c, 0, sizeof(*c));
+
 	c->zms.opcode = nvme_cmd_zone_mgmt_send;
 	c->zms.nsid = cpu_to_le32(ns->head->ns_id);
 	c->zms.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
-- 
2.33.1

