Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04683C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF1CE60C4B
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhJLSP4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhJLSP4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:15:56 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F97FC061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:13:54 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id d11so6365ilc.8
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=pxy+IeGZ/2+54IAu8W6w9clBCil/FCpsfF0lDbMIXCM=;
        b=15JGGpPisUgXmSpRfMDkSc2wu9TqKTrelJbK+ddOJ1kqT63Hqek5QW3gF1FZuqJ4LX
         B/3eOKLySvYrCQxGTaoP5nqVB+uJu03+JkuvikBnA6ilE8swj5djFnnJ/tPruRh+qFMn
         TYMZ4pfONJlyABcU6xFheQQZqUiC1JPckow0VFeGUX7tgxqH7nZ5uL8tTGMmQqY49wa3
         STasQfAY3sofgcrnBk+ZTw+JGQFrNijanrgrY10/68CeG9xiY1+S6FXUAHkFw9S13Lql
         K0cSHQuawfgcNsvbYaTB7/DF8/Bwsd0sPHfRJI9XKEWwV9UAWXwk1dpEixECCe9aFDbP
         xtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=pxy+IeGZ/2+54IAu8W6w9clBCil/FCpsfF0lDbMIXCM=;
        b=NVRBzFQ5XNDjYAD8NFpjVZok8XJDLSsXtCS0rBmGiP1s6DbCgQJ/9Bm/G21cQ2XtpV
         dowactgQjFGubqB9lrZCtnEzCOWJQrhTiVchaJnXDp+0hCDqjbl7CJClxHeoCF0PyRoK
         fkAszTKp9YiG3WrfvokgDeTGu+q05eILimDOgjSfpJJLaxwDVqX6kscwJiOMSPaRIZOk
         uH9CliczahnNctWZ5DrDM/xwdYK+ZRskZz0kJ1y5FCSzPTv7YjlIe5W/mFfC9sXzVzs6
         52nG6yTD2QDBhpPm8Mwn0/i4TxV+xritPiCOZujzRwmqTqMzLYKOnOrjLWhfEjPBxsxU
         HYYA==
X-Gm-Message-State: AOAM530RxZpjdS9ZP2WQtodiHI+lVllvH7WqB0G6HyYGU/hr2wWhR7QH
        XYj7SVVglB6FiXatPfB2eexn7g==
X-Google-Smtp-Source: ABdhPJxNGvskmVxwBBb41nDyftCeAEQHIMmpFpmbx9gpT+cycBZMBGF1t/Nu28R+aKc9oTwZbBDANA==
X-Received: by 2002:a05:6e02:1747:: with SMTP id y7mr24665149ill.95.1634062433107;
        Tue, 12 Oct 2021 11:13:53 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v63sm5754851ioe.17.2021.10.12.11.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 11:13:52 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] nvme: don't memset() the normal read/write command
Message-ID: <b38d0d5c-191a-68cd-f6fb-5662706dc366@kernel.dk>
Date:   Tue, 12 Oct 2021 12:13:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This memset in the fast path costs a lot of cycles on my setup. Here's a
top-of-profile of doing ~6.7M IOPS:

+    5.90%  io_uring  [nvme]            [k] nvme_queue_rq
+    5.32%  io_uring  [nvme_core]       [k] nvme_setup_cmd
+    5.17%  io_uring  [kernel.vmlinux]  [k] io_submit_sqes
+    4.97%  io_uring  [kernel.vmlinux]  [k] blkdev_direct_IO

and a perf diff with this patch:

     0.92%     +4.40%  [nvme_core]       [k] nvme_setup_cmd

reducing it from 5.3% to only 0.9%. This takes it from the 2nd most
cycle consumer to something that's mostly irrelevant.

Retain the full clear for the other commands to avoid doing any audits
there, and just clear the fields in the rw command manually that we
don't already fill.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ec7fa6f31e68..c1b19fd69503 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -854,9 +854,16 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
 
 	cmnd->rw.opcode = op;
+	cmnd->rw.flags = 0;
+	cmnd->rw.command_id = 0;
 	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
+	cmnd->rw.rsvd2 = 0;
+	cmnd->rw.metadata = 0;
 	cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+	cmnd->rw.reftag = 0;
+	cmnd->rw.apptag = 0;
+	cmnd->rw.appmask = 0;
 
 	if (req_op(req) == REQ_OP_WRITE && ctrl->nr_streams)
 		nvme_assign_write_stream(ctrl, req, &control, &dsmgmt);
@@ -907,51 +914,64 @@ void nvme_cleanup_cmd(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
 
+static void nvme_clear_cmd(struct request *req)
+{
+	if (!(req->rq_flags & RQF_DONTPREP)) {
+		nvme_clear_nvme_request(req);
+		memset(nvme_req(req)->cmd, 0, sizeof(struct nvme_command));
+	}
+}
+
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 {
 	struct nvme_command *cmd = nvme_req(req)->cmd;
 	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 	blk_status_t ret = BLK_STS_OK;
 
-	if (!(req->rq_flags & RQF_DONTPREP)) {
-		nvme_clear_nvme_request(req);
-		memset(cmd, 0, sizeof(*cmd));
-	}
-
 	switch (req_op(req)) {
 	case REQ_OP_DRV_IN:
 	case REQ_OP_DRV_OUT:
 		/* these are setup prior to execution in nvme_init_request() */
 		break;
 	case REQ_OP_FLUSH:
+		nvme_clear_cmd(req);
 		nvme_setup_flush(ns, cmd);
 		break;
 	case REQ_OP_ZONE_RESET_ALL:
 	case REQ_OP_ZONE_RESET:
+		nvme_clear_cmd(req);
 		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_RESET);
 		break;
 	case REQ_OP_ZONE_OPEN:
+		nvme_clear_cmd(req);
 		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OPEN);
 		break;
 	case REQ_OP_ZONE_CLOSE:
+		nvme_clear_cmd(req);
 		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_CLOSE);
 		break;
 	case REQ_OP_ZONE_FINISH:
+		nvme_clear_cmd(req);
 		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
 		break;
 	case REQ_OP_WRITE_ZEROES:
+		nvme_clear_cmd(req);
 		ret = nvme_setup_write_zeroes(ns, req, cmd);
 		break;
 	case REQ_OP_DISCARD:
+		nvme_clear_cmd(req);
 		ret = nvme_setup_discard(ns, req, cmd);
 		break;
 	case REQ_OP_READ:
+		nvme_clear_nvme_request(req);
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
 		break;
 	case REQ_OP_WRITE:
+		nvme_clear_nvme_request(req);
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
 		break;
 	case REQ_OP_ZONE_APPEND:
+		nvme_clear_nvme_request(req);
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
 		break;
 	default:

-- 
Jens Axboe

