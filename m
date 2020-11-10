Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEB9C388F7
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 21:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6771D206D8
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 21:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="w1K69wG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgKJVHN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJVHN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Nov 2020 16:07:13 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38901C0613D1
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 13:07:13 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id w13so19620186eju.13
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 13:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fn70aGa64W5eIqqOUi1sTiBrlHo5x+oxYFL83gN5tjc=;
        b=w1K69wG9IVVBEM8aSvX8uZWph3zS0tJZMl0MkcG0BnndYwtGG9gjTFtt0g+aOEzbh8
         jbq5tuxWxBKb/GcCChcZYEGS2ph/eCNTCOWMJMUmUANAIqxiTtijn08Pdt1m+Ahx2+MP
         xR0Pqq7cNfsjOZ5m7l5QJmZlOPe1WskxhnRBr4AsQGZnD/Pyuc7TKgZnkljjvhlOEP6o
         r72u3pSnyS/itKtLEQl0oJxp2wmV5CaufLaali1PTNSaixa1cTUowr+7HuiiVOm1qs1+
         ZEQjCq9FEdeqOnOkAQDcLP6Mpg7bO8NcZ1qDC3WdPOhkRczT/0xZD3nsG3NsRbAU+Sgr
         QB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fn70aGa64W5eIqqOUi1sTiBrlHo5x+oxYFL83gN5tjc=;
        b=c8zZ+hYnF6axYw2meBWacCCS2VebwMUj/FZph4prnQT73/LvL4h/yRXiSl70+xilYM
         cFLrub97TX042PELuMhpvM6atlFzCeSFYWG+lQcgsAmyPmcNCRJr/B4dWsLNdLoENYTy
         SUHmz8T8vdkGakM1kditN1QNuu7emmvLUM9YOHtoNMokOtM3QLHdYMUiPtXng5ophX6m
         zxFU1TSGFYV1Yb2WKuiCYhk2q/v1Ehk683iFrTF8MBkoL/S7MoYGV2Z8rHf59ci6B0Tc
         jXbttIWBs4omjFbT0dWz4aH3G0QmZxX7JdAwigj0KP/+KxhVs3C1ekto8pntvi1ulB9m
         CuWw==
X-Gm-Message-State: AOAM530WwW+U36Alxgs0b6YRuqSZuXg9ov8WwG/jRb++66AhSIfZYsBH
        7DVSDx9S5Lv1wDwVlo6xGXmTQQ==
X-Google-Smtp-Source: ABdhPJwVznbucUTwxVD/UvOKjCsh+eveawzSlB2eFc+1RBJDOxynYX8FI0YjpDjVa9+Ca52k2kUcLQ==
X-Received: by 2002:a17:906:a4b:: with SMTP id x11mr22630420ejf.11.1605042431782;
        Tue, 10 Nov 2020 13:07:11 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id m16sm9653488eja.58.2020.11.10.13.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:07:10 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
        k.jensen@samsung.com, Niklas.Cassel@wdc.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH V3] nvme: enable ro namespace for ZNS without append
Date:   Tue, 10 Nov 2020 22:07:08 +0100
Message-Id: <20201110210708.5912-1-javier@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

Allow ZNS NVMe SSDs to present a read-only namespace when append is not
supported, instead of rejecting the namespace directly.

This allows (i) the namespace to be used in read-only mode, which is not
a problem as the append command only affects the write path, and (ii) to
use standard management tools such as nvme-cli to choose a different
format or firmware slot that is compatible with the Linux zoned block
device.

This patch includes comments from Christoph, Niklas and Keith that
applied to a different approach setting capacity to 0
  https://www.spinics.net/lists/linux-block/msg60747.html

The reminder of the original patch will be submitted separately.

Changes since V2:
  - Fix small conflict with a queued patch from Sagi (from Christoph)
  - Fix indentation (from Niklas)
  - Refresh effects log page to account for FW changes (from Keith)

Changes since V1:
  - Change logic to use NVME_NS_ATTR_RO (from Christoph)
  - Set max_zone_append egen in RO. This allows the device to be
    properly revalidated and enables user-space tools such as blkzone to
    be used when interacting with this zoned device.

Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c |  5 ++---
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/zns.c  | 19 ++++++++++++++-----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fff90200497c..8a224a6f2473 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2083,7 +2083,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
 
-	if (id->nsattr & NVME_NS_ATTR_RO)
+	if (id->nsattr & NVME_NS_ATTR_RO || test_bit(NVME_NS_FORCE_RO, &ns->flags))
 		set_disk_ro(disk, true);
 }
 
@@ -2951,8 +2951,7 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
 
-static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
-				struct nvme_effects_log **log)
+int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi, struct nvme_effects_log **log)
 {
 	struct nvme_cel *cel = xa_load(&ctrl->cels, csi);
 	int ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 83fb30e317e0..857fca95f016 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -449,6 +449,7 @@ struct nvme_ns {
 #define NVME_NS_REMOVING	0
 #define NVME_NS_DEAD     	1
 #define NVME_NS_ANA_PENDING	2
+#define NVME_NS_FORCE_RO	3
 
 	struct nvme_fault_inject fault_inject;
 
@@ -638,6 +639,7 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 		void *log, size_t size, u64 offset);
+int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi, struct nvme_effects_log **log);
 struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
 		struct nvme_ns_head **head, int *srcu_idx);
 void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 67e87e9f306f..47679a90795c 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -54,13 +54,22 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	struct nvme_id_ns_zns *id;
 	int status;
 
+	/* Refresh effects log page to check for changes on append support */
+	status = nvme_get_effects_log(ns->ctrl, ns->head->ids.csi, &ns->head->effects);
+	if (status)
+		return status;
+
 	/* Driver requires zone append support */
-	if (!(le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
-			NVME_CMD_EFFECTS_CSUPP)) {
+	if ((le32_to_cpu(log->iocs[nvme_cmd_zone_append]) & NVME_CMD_EFFECTS_CSUPP)) {
+		if (test_and_clear_bit(NVME_NS_FORCE_RO, &ns->flags))
+			dev_warn(ns->ctrl->device,
+				 "append supported for zoned namespace:%d. Remove read-only mode\n",
+				 ns->head->ns_id);
+	} else {
+		set_bit(NVME_NS_FORCE_RO, &ns->flags);
 		dev_warn(ns->ctrl->device,
-			"append not supported for zoned namespace:%d\n",
-			ns->head->ns_id);
-		return -EINVAL;
+			 "append not supported for zoned namespace:%d. Forcing to read-only mode\n",
+			 ns->head->ns_id);
 	}
 
 	/* Lazily query controller append limit for the first zoned namespace */
-- 
2.17.1

