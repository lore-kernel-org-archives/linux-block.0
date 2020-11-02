Return-Path: <SRS0=t87n=EI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208F0C388F2
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 13:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E8C22268
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 13:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="QP4W/54J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgKBNWV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Nov 2020 08:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbgKBNWU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Nov 2020 08:22:20 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9ABC061A04
        for <linux-block@vger.kernel.org>; Mon,  2 Nov 2020 05:22:20 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id w13so5382699eju.13
        for <linux-block@vger.kernel.org>; Mon, 02 Nov 2020 05:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SZfYKuWyGtGDZXasrB6Z2RY6XZT3LCwmZmxJmGz2Pi0=;
        b=QP4W/54JLYBQ92owzx2ntg7wuLWGJIVQ2fGXic40efQdaUFhG8YgRxKHvtbZ/XFSEz
         NL2V2/dExjPd5XZ7hzEfTiCVNmB42Jj6kYRqOv59SLQQR6Gsku8+nJAqD7QVnWt8ejBQ
         n/q3vmyvXbcA7o+BTFIkzleUrNyO0kEl9VfOBVGbz12T93JdNXnvjXJXZ87JTWRBLeNA
         j49zjDQT+msZazVWArouH0Y6WPODhFTtptBhpvvC7ZQFWslSl2DnqEcTbduP+SXY7m/9
         Ve3y9Wmk+YJrRNn961ejqUT9NgyYAHUo3CgtXDDqOEVPyrD0OCake4GBN2u7645v62Ck
         seDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SZfYKuWyGtGDZXasrB6Z2RY6XZT3LCwmZmxJmGz2Pi0=;
        b=p0b3MdoifB9OvQM/bDXmvzwITWNOQxxVBnazh6TevJQDV/3XaGr/K4HrUM1nxPnE2j
         9fi81pFG78asTp+PYn2JPGraiw4RrZiLZDwK9NKiyZycYY4nRYkv+5bOJqkmHzdZTxCa
         5RV8xUINm04QmBf0rmZ7AMQPCf/7UN10Bu+RW2bAYDuDLlgNdm8O+6JW5MqxsY9HW+BR
         +sQsiotWk0/p51PhapmDfVfF7e1vs93dzkQDRoz03rGVnovD6NQXx3BW+uWujQfBkS7P
         YmcKRNImA0i3WDiX/zRynEPXeiz2X2Qw+HBEzmG9oei+1sUvKQ0VwtmRrV6baytTf4+L
         +mPw==
X-Gm-Message-State: AOAM531vb5hQvEfziMj++kcDZxqZ9dI0SerJXlK3bIR70Xt9Hv9D1DWi
        VdXxwvM73Nxl8DqANXa9CojSLQ==
X-Google-Smtp-Source: ABdhPJx0yppHNtt0XHA0SJNFeSI8HPFi3fKLHfYSgOdgSiPmBj9pUoCGMWJVYvFVA3130WLxrltL7A==
X-Received: by 2002:a17:906:a1d8:: with SMTP id bx24mr14886341ejb.161.1604323339082;
        Mon, 02 Nov 2020 05:22:19 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.126.247.cgn.fibianet.dk. [5.186.126.247])
        by smtp.gmail.com with ESMTPSA id y12sm7294412ejj.95.2020.11.02.05.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 05:22:18 -0800 (PST)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
        k.jensen@samsung.com, Niklas.Cassel@wdc.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
Date:   Mon,  2 Nov 2020 14:22:14 +0100
Message-Id: <20201102132214.22164-1-javier.gonz@samsung.com>
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

Changes since V1:
   - Apply feedback from Niklas:
	- Use IS_ENABLED() for checking config option
	- Use local variable
	- Use different variable names

Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c |  3 +++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/zns.c  | 26 ++++++++++++++------------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c190c56bf702..638997b6f5cd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2026,6 +2026,9 @@ static void nvme_update_disk_info(struct gendisk *disk,
 			capacity = 0;
 	}
 
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && !ns->zoned_ns_supp)
+		capacity = 0;
+
 	set_capacity_revalidate_and_notify(disk, capacity, false);
 
 	nvme_config_discard(disk, ns);
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
index 57cfd78731fb..1ae039f9c20c 100644
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
@@ -78,23 +81,22 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
 	 * operation characteristics.
 	 */
 	if (id->zoc) {
+		zoned_ns_supp = false;
 		dev_warn(ns->ctrl->device,
 			"zone operations:%x not supported for namespace:%u\n",
 			le16_to_cpu(id->zoc), ns->head->ns_id);
-		status = -EINVAL;
-		goto free_data;
 	}
 
 	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
 	if (!is_power_of_2(ns->zsze)) {
+		zoned_ns_supp = false;
 		dev_warn(ns->ctrl->device,
 			"invalid zone size:%llu for namespace:%u\n",
 			ns->zsze, ns->head->ns_id);
-		status = -EINVAL;
-		goto free_data;
 	}
 
 	q->limits.zoned = BLK_ZONED_HM;
+	ns->zoned_ns_supp = zoned_ns_supp;
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
 	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
-- 
2.17.1

