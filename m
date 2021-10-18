Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3BCC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BFF610A1
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhJRMvv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 08:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhJRMvu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 08:51:50 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE22C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 05:49:39 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y67so16028293iof.10
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yml7Ptd8JydBCH2SbrqO9bF1kUkIRHbJ+XeaaVED5To=;
        b=4VIvy5swV+y4YUcs/tqI50vjVuCtOnsrvby3VbHcH/lg7iQkEOFhV4Js1j40BSKG5n
         ACLv0jmBNWw6rfvvmrWqyzvi7+FF7E5yuGdgp9RUvAbclh0ODJVu/QKy+BocFYpT0dXV
         RP5xWts9hb+kpYQN52LfvfzRujH2lAD5uRLKJSZcTv8hfEKcaisxV4RRWbjH0Cak7NEH
         LXk/xyR8h15PyrDSf0iNuzNphBNgwTSV10BQR8BFn0H36jKoL4WBRgKj2Q2j+aNJ14vL
         q8PC37KV7wtw1koL5iNkpF2KzgDs0qob003VPtaxD4eU3Wuz5koyiqgf9YLayZ1RdlSB
         JZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yml7Ptd8JydBCH2SbrqO9bF1kUkIRHbJ+XeaaVED5To=;
        b=VaFVF0bwU+2eDVqr8s+v+W7Poty41JhiDGcgWEM88+s2DaROEm8kK/9UCJcM9/HbXx
         OiMttKOdtcLKGKxWaQNBvWPCW6lKJxkhkk1CutFmmJKN85q3k6Dsg4pqxMXU/rNPDe2S
         Dte0YfG77vKKLcp1VmRDAxzOZaLcMPV1VcXyz31NOJH3bNAvED9MTkEyiN7eHI26WkI4
         7q0t6sxFoAdmTNelbv1V9H3kq8RzT7rjbTOxP4ZOCo8NFNuQBCk01Lp61Qwam99AO2Eg
         +fuAjhG0HjjhVBVmM20O/H5noq2xLlyj9/Wr3FpJlYMxoGOFL388yuo8F+7OBx847QK5
         +ziQ==
X-Gm-Message-State: AOAM531ctbmCrPV0yS8JLC1j3EmzqyqRFhPVlMWsTC8KlOo/0J1ojlN/
        tC7uof7q4pJ1olQnYhgWrcYFF63F+aPMUQ==
X-Google-Smtp-Source: ABdhPJzl2oC6JWYUugXRX9NCp32xwd+TjJejvJrKCNTIXW1QMY7ZTJTYx9zdDLzzoVF71XauagSUrw==
X-Received: by 2002:a05:6602:1343:: with SMTP id i3mr14189514iov.58.1634561379101;
        Mon, 18 Oct 2021 05:49:39 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id z26sm6780081ioe.9.2021.10.18.05.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 05:49:38 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme: don't memset() the normal read/write command
Date:   Mon, 18 Oct 2021 06:49:34 -0600
Message-Id: <20211018124934.235658-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018124934.235658-1-axboe@kernel.dk>
References: <20211018124934.235658-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Acked-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7944ad52f213..3e691354598c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -917,8 +917,6 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	u16 control = 0;
 	u32 dsmgmt = 0;
 
-	memset(cmnd, 0, sizeof(*cmnd));
-
 	if (req->cmd_flags & REQ_FUA)
 		control |= NVME_RW_FUA;
 	if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_RAHEAD))
@@ -928,9 +926,15 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
 
 	cmnd->rw.opcode = op;
+	cmnd->rw.flags = 0;
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
-- 
2.33.1

