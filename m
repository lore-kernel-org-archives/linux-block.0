Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EF3C55ABD
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 12:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE65520709
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 12:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="SXuNXDjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgKKMqp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgKKMqp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 07:46:45 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D47C0613D4
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 04:46:44 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id me8so2556168ejb.10
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 04:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdPu3wHy0Sjco3BqLc5dTo6hzwsxW20yC+RscSgk9UE=;
        b=SXuNXDjID1+sMS4dZqpn8SrnOQh+zlMFAWEKpByieNYcMtjBQo/90K/CxF8WFkTxZf
         Ct5tNdJCGbA/ML8xXLUS/smBtWqGoRoqQOSJsN0Q53ZO9W5c2GNHoGa/Nf8242Fnl1zl
         AqllXApdPkAtK3Trso/NnXOC4tQAHDewFUh5OWsGhmaK/BvXZRghOZ3OivyBrrZWeG3W
         Hll+7dW7+jKEBy0+TQXpoNCF9VuqzL4tcLlfN/lTl83/hV8hi3QKctAlp7H3BJ1EweBT
         kRyIAPrNWCiH4T69GHdYzH5qo4KT1pY0uFbxDJpfh8NhDu5lGlPMPbU+AH2G+vzy1c6g
         hFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdPu3wHy0Sjco3BqLc5dTo6hzwsxW20yC+RscSgk9UE=;
        b=R06+DXTpyu9cK3vSs3UgHmZl8vYOFgPEReK6X6+BBAbalYvNftIYbe5Jvkh683WYiD
         MI+sSjwl2WZU1SPfBsMZPeZtGO3qfOhhSEYoXgCkxbt+F1lqJQDsMDHFKIahAvW9BHg7
         v8PdFCcJhUWDFbboksCrsf3ry6PyHhiVaaNjaR74FV8CHno/IPwx/AOj+viWSjztQhoe
         CqTr4mSFRESQXbNO7rv16n4kgMGEg7A6MaFrJvt01UTP3LPvjIYEAZ1ZlMZM6q6P+AHO
         XMoJZDmgyWEHedp1YgljKoW8B6Bk/j60cJ4SSyBtpnLpdgG8emnFP2SdT/5CpESWmcL9
         ieyQ==
X-Gm-Message-State: AOAM531XNVrnezgf4mmNKWIg+dREu++HAeQ6DWH2QeJAK4TsoVKs7N3d
        /nmgZctzRGMFkNxAozqKD4+vYA==
X-Google-Smtp-Source: ABdhPJw30G0e6ETGZk6X7FHrSK0BHdFJiQQ/cA/U79TsEW2BzUPRAfQ1w9yZxM8v8Ls91RT2rzMffA==
X-Received: by 2002:a17:906:12cf:: with SMTP id l15mr26493252ejb.540.1605098803560;
        Wed, 11 Nov 2020 04:46:43 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id h22sm840290ejt.21.2020.11.11.04.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 04:46:42 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
        k.jensen@samsung.com, Niklas.Cassel@wdc.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH 2/2] nvme: enable ro namespace for ZNS without append
Date:   Wed, 11 Nov 2020 13:46:39 +0100
Message-Id: <20201111124639.11305-2-javier@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111124639.11305-1-javier@samsung.com>
References: <20201111124639.11305-1-javier@samsung.com>
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

Changes since V3:
  - Force re-reading effects log page (from Keith)
  - Pending proper refresh of RO flag - dependency on patch from Christoph

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
index e4c79f1d2e96..170745d4a34b 100644
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
 
-static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi, struct nvme_effects_log **log,
-				bool force)
+int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi, struct nvme_effects_log **log, bool force)
 {
 	struct nvme_cel *cel = xa_load(&ctrl->cels, csi);
 	int ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 83fb30e317e0..cdfce7250da0 100644
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
+int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi, struct nvme_effects_log **log, bool force);
 struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
 		struct nvme_ns_head **head, int *srcu_idx);
 void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 67e87e9f306f..dfd1c38b95d4 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -54,13 +54,22 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	struct nvme_id_ns_zns *id;
 	int status;
 
+	/* Refresh effects log page to check for changes on append support */
+	status = nvme_get_effects_log(ns->ctrl, ns->head->ids.csi, &ns->head->effects, true);
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

