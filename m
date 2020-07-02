Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B376FC433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B2920771
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="yA+ecdF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgGBJZW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgGBJZV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 05:25:21 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92D0C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 02:25:20 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ga4so28414529ejb.11
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cAmJ/Zf7T+fcjgZyRga2M0NL/BcX+6gWE28VkxPctQQ=;
        b=yA+ecdF0MKqvSnlvD1xL45nrJ0zLStVUHAckg2WybnGxj6SK7eut+56N5TLtxONncM
         tC59Wy7XLrR4nZcbixSk7gwMOSCXgSGNIXeH0Ap9Ul2YtON7PR2ye1uGVh9Vzt8F195H
         CM4jmbj5QdGMF1mxEuy/ovR6A9M/if8SKdZDoq94m+HbzX4iPNMCJObH68yQa32kezce
         moJsn4/We7du7fghrkIu1+aeMt4n90zFI1JrnAIQLdaaXUDkmwfUEgLjFSrMzNj1Bo7/
         dlWuh3LAOCcbwdO+5RpGwWY6puQHiVduqW3qiJv+6dElekvuHLZTLYjK2eqV2BuXfQa4
         0G3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cAmJ/Zf7T+fcjgZyRga2M0NL/BcX+6gWE28VkxPctQQ=;
        b=GaMqnUO1J0jn92i2TH088vTMwCOT3fNFzCBFuGYH/QQBxrE+uLnqQi2RIdXI7DKdaZ
         O1kFC1MHXftgpw1krUULa51XjpXEYoJHB/AO1g525Mwwp5S3TICueyObtJudSO+zgDrS
         UWDum13k7ii7bmVRjLy27J3ZcqQQKIbSX9VgfH1ZT7RNNvl+lvn8qGbqN1lT6vgiFLQY
         8XKKHVb6v4GNTfrzYGNZnRE8u1PwNcMZtPvC8XMuNCoT4p707GjqPs2MDWlJQ7AviUmc
         o0LE9/P6cRu1HBFK/XSKkqUwpYCLzcHo1WM8lauKwni3ceJ3z/bBoiQQ3M+EiQLTvjgU
         49tw==
X-Gm-Message-State: AOAM530GH+mPKKk5CgeH9kl93YdJxCd/pYZRgaeX/qMphYOtpSNF9xSm
        rjMPQffkmPYIXlPgA9MTxEke/Q==
X-Google-Smtp-Source: ABdhPJzJ5uSLlUU5QX1Eokd0XUUtn7xhOsOpkXZMNG7F65sNWszBNng61gY8N/jOiGyrGyQvMJTi1w==
X-Received: by 2002:a17:907:41dc:: with SMTP id og20mr2553300ejb.183.1593681919699;
        Thu, 02 Jul 2020 02:25:19 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id b18sm6569464ejl.52.2020.07.02.02.25.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 02:25:19 -0700 (PDT)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, Damien.LeMoal@wdc.com,
        mb@lightnvm.io, Johannes.Thumshirn@wdc.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH v3 3/4] nvme: Add consistency check for zone count
Date:   Thu,  2 Jul 2020 11:24:37 +0200
Message-Id: <20200702092438.63717-4-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702092438.63717-1-javier@javigon.com>
References: <20200702092438.63717-1-javier@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

Since the number of zones is calculated through the reported device
capacity and the ZNS specification allows to report the total number of
zones in the device, add an extra check to guarantee consistency between
the device and the kernel.

Also, fix a checkpatch warning: unsigned -> unsigned int in the process

Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/nvme/host/core.c |  2 +-
 drivers/nvme/host/nvme.h |  6 ++++--
 drivers/nvme/host/zns.c  | 39 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1f5c7fc3d2c9..8b9c69172931 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1994,7 +1994,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	case NVME_CSI_NVM:
 		break;
 	case NVME_CSI_ZNS:
-		ret = nvme_update_zone_info(disk, ns, lbaf);
+		ret = nvme_update_zone_info(disk, ns, lbaf, le64_to_cpu(id->nsze));
 		if (ret)
 			return ret;
 		break;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 662f95fbd909..0c208f6cd335 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -407,6 +407,7 @@ struct nvme_ns {
 	u32 sws;
 	u8 pi_type;
 #ifdef CONFIG_BLK_DEV_ZONED
+	u64 nr_zones;
 	u64 zsze;
 #endif
 	unsigned long features;
@@ -700,7 +701,7 @@ static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 
 #ifdef CONFIG_BLK_DEV_ZONED
 int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
-			  unsigned lbaf);
+			  unsigned int lbaf, sector_t nsze);
 
 int nvme_report_zones(struct gendisk *disk, sector_t sector,
 		      unsigned int nr_zones, report_zones_cb cb, void *data);
@@ -720,7 +721,8 @@ static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,
 
 static inline int nvme_update_zone_info(struct gendisk *disk,
 					struct nvme_ns *ns,
-					unsigned lbaf)
+					unsigned int lbaf,
+					sector_t nsze)
 {
 	dev_warn(ns->ctrl->device,
 		 "Please enable CONFIG_BLK_DEV_ZONED to support ZNS devices\n");
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index bb6a33f52d53..daf0d91bcdf6 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -32,13 +32,36 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
 	return 0;
 }
 
+static u64 nvme_zns_nr_zones(struct nvme_ns *ns)
+{
+	struct nvme_command c = { };
+	struct nvme_zone_report report;
+	int buflen = sizeof(struct nvme_zone_report);
+	int ret;
+
+	c.zmr.opcode = nvme_cmd_zone_mgmt_recv;
+	c.zmr.nsid = cpu_to_le32(ns->head->ns_id);
+	c.zmr.slba = cpu_to_le64(0);
+	c.zmr.numd = cpu_to_le32(nvme_bytes_to_numd(buflen));
+	c.zmr.zra = NVME_ZRA_ZONE_REPORT;
+	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
+	c.zmr.pr = 0;
+
+	ret = nvme_submit_sync_cmd(ns->queue, &c, &report, buflen);
+	if (ret)
+		return ret;
+
+	return le64_to_cpu(report.nr_zones);
+}
+
 int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
-			  unsigned lbaf)
+			  unsigned int lbaf, sector_t nsze)
 {
 	struct nvme_effects_log *log = ns->head->effects;
 	struct request_queue *q = disk->queue;
 	struct nvme_command c = { };
 	struct nvme_id_ns_zns *id;
+	sector_t cap_nr_zones;
 	int status;
 
 	/* Driver requires zone append support */
@@ -80,6 +103,20 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
 		goto free_data;
 	}
 
+	ns->nr_zones = nvme_zns_nr_zones(ns);
+	if (!ns->nr_zones) {
+		status = -EINVAL;
+		goto free_data;
+	}
+
+	cap_nr_zones = nvme_lba_to_sect(ns, le64_to_cpu(nsze)) >> ilog2(ns->zsze);
+	if (ns->nr_zones != cap_nr_zones) {
+		dev_err(ns->ctrl->device, "inconsistent zone count: %llu/%llu\n",
+			ns->nr_zones, cap_nr_zones);
+		status = -EINVAL;
+		goto free_data;
+	}
+
 	q->limits.zoned = BLK_ZONED_HM;
 	q->zone_flags = BLK_ZONE_REP_CAPACITY | BLK_ZONE_SUP_OFFLINE;
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
-- 
2.17.1

