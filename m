Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74D1C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C775360FD9
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhJRMzP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 08:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhJRMzP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 08:55:15 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E84C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 05:53:04 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id j8so14706340ila.11
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LZ6uikSw+HJSKoT2XOXxqOhzMqQVouLTIlfVkn3BOis=;
        b=4CESz5QZX/P4UMGhLnxGVAsQXSCU67J9UIr8+gwtdqGRT4RXLPPB2wY803tvTj9L58
         xZ0VfOcmjGjz8Me2cmEUGy3gzaC6d3mrYaWy0bmaV+Wq4iHtW2mUSxzq6Bar+quQE3+d
         SRkYLNFnmYb42fvlcqD58u40XXm+0Xo2mLkGRgX0a4qfbxW20UE4rQl+fgFWlXqzrk+v
         /QhHGB3tMzokXcRGK/cHGg+/4Ot2sAcGrJIxkSChKJulaEoxp9kVS1yMSYsrwCskWXxf
         jbj6TxBA28yb53qD6WjE6Tu9Ew8lqU0FR8Td4LKUecaBXFoviHk/IH7dMJqbocxhi9Gr
         LeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LZ6uikSw+HJSKoT2XOXxqOhzMqQVouLTIlfVkn3BOis=;
        b=ZroZk0KqqdfYgD9dxemmsCr2xgec/qXBv8TzdLTLejPWiYAXZrPvc5ev8OKRDn/hBi
         DDI+y3i2W7iT9fSGoO9OvKKy1E1YNd9taxQltAh8SuVx6zqItiecaJq/xooeWAXdS+ES
         cl7ZU5xYnnxPmAOlhIg8ov1KBXUDSVe/6IOqbxZY4GGJ4GSc3gHfDMWhijbe5xRrK8d3
         3YmMv2iZ9Rv+cnb2kvwFzJiT9Bg5EsURU9vIM9q6xn2Kr6fwqhXFtjNsE9h3vSdZb47G
         wz+0NUtq4WGdn8fHJZ5nZTgZS9NpqfbuUEm1uiF2MpOe3SzsmNLLp6pIhl/b9/a2dnkY
         0YPQ==
X-Gm-Message-State: AOAM531fY6lac+6KEOfEr3bhZAvLlHdTWWTpqy601Pf8obHgYmb+qrIg
        e+Bq2tk8vgPK6qe8G7EFazEOOygxC36ApQ==
X-Google-Smtp-Source: ABdhPJyY8v3ax5xmxgXpV6MlKnTQxPrDjAdcpOLpOVX6t42LQls3QKTtDE432vJpKWCAcSKojYB2vg==
X-Received: by 2002:a92:c206:: with SMTP id j6mr6810875ilo.71.1634561583621;
        Mon, 18 Oct 2021 05:53:03 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id z11sm6986332ilb.11.2021.10.18.05.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 05:53:03 -0700 (PDT)
Subject: [PATCH v2 1/2] nvme: move command clear into the various setup
 helpers
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de
References: <20211018124934.235658-1-axboe@kernel.dk>
 <20211018124934.235658-2-axboe@kernel.dk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f90f4e83-52d2-4d92-126a-9f65f384f8a4@kernel.dk>
Date:   Mon, 18 Oct 2021 06:53:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211018124934.235658-2-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 6:49 AM, Jens Axboe wrote:
> We don't have to worry about doing extra memsets by moving it outside
> the protection of RQF_DONTPREP, as nvme doesn't do partial completions.
> 
> This is in preparation for making the read/write fast path not do a full
> memset of the command.

Gah, v2 of this one below, it send out an older one.

commit fb4e29f648e320c94f210c54692c754ad69fb6f6
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Oct 18 06:45:06 2021 -0600

    nvme: move command clear into the various setup helpers
    
    We don't have to worry about doing extra memsets by moving it outside
    the protection of RQF_DONTPREP, as nvme doesn't do partial completions.
    
    This is in preparation for making the read/write fast path not do a full
    memset of the command.
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ae15cb714596..de2250c5b057 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -823,6 +823,7 @@ static void nvme_assign_write_stream(struct nvme_ctrl *ctrl,
 static inline void nvme_setup_flush(struct nvme_ns *ns,
 		struct nvme_command *cmnd)
 {
+	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->common.opcode = nvme_cmd_flush;
 	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
 }
@@ -874,6 +875,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		return BLK_STS_IOERR;
 	}
 
+	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->dsm.opcode = nvme_cmd_dsm;
 	cmnd->dsm.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->dsm.nr = cpu_to_le32(segments - 1);
@@ -890,6 +892,8 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd)
 {
+	memset(cmnd, 0, sizeof(*cmnd));
+
 	if (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
 		return nvme_setup_discard(ns, req, cmnd);
 
@@ -914,6 +918,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	u16 control = 0;
 	u32 dsmgmt = 0;
 
+	memset(cmnd, 0, sizeof(*cmnd));
+
 	if (req->cmd_flags & REQ_FUA)
 		control |= NVME_RW_FUA;
 	if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_RAHEAD))
@@ -982,10 +988,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 	blk_status_t ret = BLK_STS_OK;
 
-	if (!(req->rq_flags & RQF_DONTPREP)) {
+	if (!(req->rq_flags & RQF_DONTPREP))
 		nvme_clear_nvme_request(req);
-		memset(cmd, 0, sizeof(*cmd));
-	}
 
 	switch (req_op(req)) {
 	case REQ_OP_DRV_IN:
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
Jens Axboe

