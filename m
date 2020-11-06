Return-Path: <SRS0=ZSeo=EM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9968DC2D0A3
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 12:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3194220735
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 12:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="kBOQDam2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgKFM0m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Nov 2020 07:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFM0l (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Nov 2020 07:26:41 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63470C0613CF
        for <linux-block@vger.kernel.org>; Fri,  6 Nov 2020 04:26:41 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id cw8so1636184ejb.8
        for <linux-block@vger.kernel.org>; Fri, 06 Nov 2020 04:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YIGJ8K38G0NcFaq9vrbXPNVjJZE6jTk755NCJrgov6k=;
        b=kBOQDam2SDeTp5A57yul8Lcj+br9Me3BkS/bOb0XoeeHyw51YOiJ/o+OTBpAX5WcDK
         v19lNbDIpkNk8m5J23wDwmensyG39lqD5oJ1HMJBkDY2OgAP4gW/1DtZ6uwiSM5AOcny
         HQvEldNONAMqnAT9Z1lDACNFB3Ug9ql2JTDMUfs3dhqozTZsLOUt1axcF89kXIOjHqEG
         0K9VFQUaKIsytV4r8BuscG9jwQOz0SlSrpOA/eTX86h29RcnFQfEhYbsqnYsXLFMCT1o
         HJe3E9hOUhZtkEo0679K881daHSn7e37HtiuuYf66uR7CerOhv3vDGXoDTLElKCcHYQ8
         IlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YIGJ8K38G0NcFaq9vrbXPNVjJZE6jTk755NCJrgov6k=;
        b=c0brKR2LCdxOE24RtegSZhMTecRT8nc41s3EdRQmzu6Q6pi/HGG+vKu1I2C2jBnt+s
         AnAkEP+VXtMwrfpBEMNMXqBC8tX4KNZUq5Nss401dpSjOcY1wBnYDHh+24xJZod44Qi7
         rZCPNafdeQdBWnrwBuBqbfdAapfxw6Nt5XG/X6S2O3jQzBgYt5L5U0QZi3qz8UdcSiu6
         NooukQMPgFqU69EXZAODeWbprDBmyp216xPCcPv9qp5oeQZhCu3e0qvL99E+mpGZ8Xwf
         yR4UVWF3ND4tRjTGFqW5dEFu8FyDYsRGVcmN4fiXiEscgezRvcxr2x6oAXdbTFxDE1ki
         gSHw==
X-Gm-Message-State: AOAM532OvKVEx8tVSwPby76S8up8FePxotfRicIoyeY1bz9J+7XtCir6
        3JIpDi00beqel/4lpOVa29WHbw==
X-Google-Smtp-Source: ABdhPJwJwfBl+eOyT7n2doy7RET7Fo0993F+2mOmqD7XoNIWZw0Vmx9j4258IZnJda5tbT2Cbyx5YQ==
X-Received: by 2002:a17:906:66c9:: with SMTP id k9mr1880683ejp.204.1604665599978;
        Fri, 06 Nov 2020 04:26:39 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.126.247.cgn.fibianet.dk. [5.186.126.247])
        by smtp.gmail.com with ESMTPSA id dn16sm936224edb.19.2020.11.06.04.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 04:26:39 -0800 (PST)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
        k.jensen@samsung.com, Niklas.Cassel@wdc.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH] nvme: enable ro namespace for ZNS without append
Date:   Fri,  6 Nov 2020 13:26:37 +0100
Message-Id: <20201106122637.14490-1-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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

Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c |  5 +++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/zns.c  | 20 ++++++++++++--------
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c190c56bf702..8967ab9089b3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2036,6 +2036,11 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	else
 		set_disk_ro(disk, false);
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (blk_queue_is_zoned(disk->queue) && !ns->zoned_ns_supp)
+		set_disk_ro(disk, true);
+#endif
+
 	blk_mq_unfreeze_queue(disk->queue);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 87737fa32360..ff4fe645ab9b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -443,6 +443,7 @@ struct nvme_ns {
 	u8 pi_type;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64 zsze;
+	bool zoned_ns_supp;
 #endif
 	unsigned long features;
 	unsigned long flags;
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 57cfd78731fb..4d005132ab95 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -42,22 +42,25 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
 	struct request_queue *q = disk->queue;
 	struct nvme_command c = { };
 	struct nvme_id_ns_zns *id;
+	bool zoned_ns_supp = true;
 	int status;
 
 	/* Driver requires zone append support */
 	if (!(le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
 			NVME_CMD_EFFECTS_CSUPP)) {
+		zoned_ns_supp = false;
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
@@ -95,6 +98,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
 	}
 
 	q->limits.zoned = BLK_ZONED_HM;
+	ns->zoned_ns_supp = zoned_ns_supp;
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
 	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
-- 
2.17.1

