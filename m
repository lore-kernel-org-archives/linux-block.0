Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C55EC4363A
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 18:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8B820756
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 18:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="a51t2eI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgJ2S6P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 14:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgJ2S6O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 14:58:14 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D00C0613CF
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2020 11:58:14 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g25so3327142edm.6
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2020 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89MgGJ2eLo/poQN08E10He93oDU/x3XhdHGWGtRSdCM=;
        b=a51t2eI/vR9CHjHzV2REhSPK/Vmz6ph8JXpIIUT+PMfFCzVwKOxNjdvXrVoVJ5jQFy
         kAjTIud/Db1ZhetL6W/9GdYwGECn53DEr38+d4OrAFocX6jREQUKl6Hgq3bkxt6q5SFX
         Plkdn8fSpw8Cc56XK/P3CpQSSr4EkbuQ/1ETqix4LUFQFNZdMVVqoaZa3SBU1MRKxve/
         IOKZy2NtVqf5baAHXUCUdlwaSSGr19/yeC2R/HMsQzMdtyIrXDR9XZYk/WAG7Hmy6VVJ
         YmPz25XOModxbznKLvbv3hVBvOQz43AD97htQ4QKY4hGjTn+3alwWGV4Yr0xFuSj2wQX
         N4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89MgGJ2eLo/poQN08E10He93oDU/x3XhdHGWGtRSdCM=;
        b=nLb+/TK8Cgwz8XsTNE68ZmaCdHD034MEabvdAQ6ckXXforcVyrqLNVfzfr5dRhMZ68
         XX+0FX3BbcorQdOVM42rwrHvylPllHt/aBmKYRXLV1w9BN3YBXzJ2YFi3XS5oc2ggk3e
         MSJCDR96myG8uWEIvMxcCDJOt+81nGDxfiFMhpQeZKe+OXPwPJn2voG4RKqawBdDBQ/h
         1+NNSSPwnc+SMdy1CWJeyzfmOhlU1PRMb6UNQZYY072A/1BOtsXI0lZ4wDqKjEGaNQJt
         briH/qGRSd9b9lkyuiW7g0hIzLrwvg7DZHM7/LUhbAenOzV9LfuwJhXpyVLi5XxSAJ7+
         ykEQ==
X-Gm-Message-State: AOAM532tqXTeEpbvr05iRcJZ48nOlomcO0Xe0M/DuZL7RCplnSYDOK8V
        uydjmHrcxr5WkYw5W3woMDngkA==
X-Google-Smtp-Source: ABdhPJzCKg8H/rV7NMAwOKOsmKObGB2b4LfWMi8r1jAoj+6+80WZx39v/Svl8CzLDRRXX6+hUcIfMg==
X-Received: by 2002:a50:8745:: with SMTP id 5mr5391983edv.49.1603997892755;
        Thu, 29 Oct 2020 11:58:12 -0700 (PDT)
Received: from ch-wrk-javier.localdomain (5.186.126.247.cgn.fibianet.dk. [5.186.126.247])
        by smtp.gmail.com with ESMTPSA id p3sm1974957edy.38.2020.10.29.11.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 11:58:12 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
        k.jensen@samsung.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH] nvme: report capacity 0 for non supported ZNS SSDs
Date:   Thu, 29 Oct 2020 19:57:53 +0100
Message-Id: <20201029185753.14368-1-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow ZNS SSDs to be presented to the host even when they implement
features that are not supported by the kernel zoned block device.

Instead of rejecting the SSD at the NVMe driver level, deal with this in
the block layer by setting capacity to 0, as we do with other things
such as unsupported PI configurations. This allows to use standard
management tools such as nvme-cli to choose a different format or
firmware slot that is compatible with the Linux zoned block device.

Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c |  5 +++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/zns.c  | 31 ++++++++++++++-----------------
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c190c56bf702..9ca4f0a6ff2c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2026,6 +2026,11 @@ static void nvme_update_disk_info(struct gendisk *disk,
 			capacity = 0;
 	}
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (!ns->zone_sup)
+		capacity = 0;
+#endif
+
 	set_capacity_revalidate_and_notify(disk, capacity, false);
 
 	nvme_config_discard(disk, ns);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 87737fa32360..42cbe5bbc518 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -443,6 +443,7 @@ struct nvme_ns {
 	u8 pi_type;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64 zsze;
+	bool zone_sup;
 #endif
 	unsigned long features;
 	unsigned long flags;
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 57cfd78731fb..77a7fed508ef 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -44,20 +44,23 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
 	struct nvme_id_ns_zns *id;
 	int status;
 
-	/* Driver requires zone append support */
+	ns->zone_sup = true;
+
 	if (!(le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
 			NVME_CMD_EFFECTS_CSUPP)) {
+		ns->zone_sup = false;
 		dev_warn(ns->ctrl->device,
 			"append not supported for zoned namespace:%d\n",
 			ns->head->ns_id);
-		return -EINVAL;
-	}
-
-	/* Lazily query controller append limit for the first zoned namespace */
-	if (!ns->ctrl->max_zone_append) {
-		status = nvme_set_max_append(ns->ctrl);
-		if (status)
-			return status;
+	} else {
+		/* Lazily query controller append limit for the first
+		 * zoned namespace
+		 */
+		if (!ns->ctrl->max_zone_append) {
+			status = nvme_set_max_append(ns->ctrl);
+			if (status)
+				return status;
+		}
 	}
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
@@ -73,25 +76,19 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
 	if (status)
 		goto free_data;
 
-	/*
-	 * We currently do not handle devices requiring any of the zoned
-	 * operation characteristics.
-	 */
 	if (id->zoc) {
+		ns->zone_sup = false;
 		dev_warn(ns->ctrl->device,
 			"zone operations:%x not supported for namespace:%u\n",
 			le16_to_cpu(id->zoc), ns->head->ns_id);
-		status = -EINVAL;
-		goto free_data;
 	}
 
 	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
 	if (!is_power_of_2(ns->zsze)) {
+		ns->zone_sup = false;
 		dev_warn(ns->ctrl->device,
 			"invalid zone size:%llu for namespace:%u\n",
 			ns->zsze, ns->head->ns_id);
-		status = -EINVAL;
-		goto free_data;
 	}
 
 	q->limits.zoned = BLK_ZONED_HM;
-- 
2.17.1

