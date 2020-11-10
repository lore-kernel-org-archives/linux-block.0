Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DDDC388F7
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 09:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862A220797
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 09:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ilIIetMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgKJJjq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Nov 2020 04:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJJjp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Nov 2020 04:39:45 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F04C0613CF
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 01:39:45 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id o20so11971272eds.3
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 01:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NGC8UHUSWpvH5SIBX91yvBkFsjsQSnbCUrNFDTpaJfY=;
        b=ilIIetMJVASZ2CjUBlpYVv5epCMIE0scmhVtWr/IhhibOareIYg/jqO+zq96nSRazJ
         BSSkgqBVSsVzRoqOHH9sM1He9JWlT3lJipAcc/50OkE6S5PTfw+FdWBp4LVWLma7XL4g
         7k/PPiAd1xCaDxVNqQMpN5xibQeYKUeHg0zV7ZNo87v6dw5TEqzGj7Af+IIYcET1M/JR
         8YgCyslUySIdjM/hdu4bxtKbjDrI4hbH8MN5pJ20fGaEYERO2EOsmSvdogVY2FsRqmkU
         2Xq3JZffKveWk5hpU7pPrt5F26sUiztIyEd7dn+vDvvJcZQkRFNCq36XrHrCJ/5N/SdZ
         iNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NGC8UHUSWpvH5SIBX91yvBkFsjsQSnbCUrNFDTpaJfY=;
        b=CldauPFyAWGZPs/jrEjrS4ymHqDlTsawM5WKjHYfwxwdSfmGyl3+15Rw2bLkg+4aQI
         9nmPhQ56WiRkCIgJPBy+n4PjQH9ts8NOkc/P1wsyQfpOlw9doR0dnzx6bXUXHi/eAJJ+
         s//XAPVynzi774at6+UKeV0VQpwPi+7H+2chLIVRTpcg9WiD6BisvOGK9hLs42BrV61g
         CjmmzGQrnjhsd7yzwgXjrG72gn8L+HDTBI9OMeNCOSztVo+7QruAvK8I1JiGTjeTQPSx
         0OKS5KyisKakB4AO4ESny+llNnCGqkRYQ48h+hz3oJQJQGjMqvBE12GbjlKVjA1MI2zm
         c6Aw==
X-Gm-Message-State: AOAM5300kYGaFzWFEueln1RZGktjsOHGwkhCjepL0CAtzAf8pKFMweAA
        nGodP1yhx6tNq6PuOW78RU1mZQ==
X-Google-Smtp-Source: ABdhPJx9jMhSI9/pAO8n4wsT1z0Fz92RcU9WurS0rtO41pg5rI6aMIH85K1ZOnWe7/rAUVgxRBZZ7w==
X-Received: by 2002:a50:cf45:: with SMTP id d5mr19709676edk.225.1605001183960;
        Tue, 10 Nov 2020 01:39:43 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id s25sm10065845ejc.29.2020.11.10.01.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 01:39:43 -0800 (PST)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
        k.jensen@samsung.com, Niklas.Cassel@wdc.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH V2] nvme: enable ro namespace for ZNS without append
Date:   Tue, 10 Nov 2020 10:39:38 +0100
Message-Id: <20201110093938.25386-1-javier.gonz@samsung.com>
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

Changes since V1:
  - Change logic to use NVME_NS_ATTR_RO (from Christoph)
  - Set max_zone_append egen in RO. This allows the device to be properly
    revalidated and enables user-space tools such as blkzone to be used when
    interacting with this zoned device.

Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 1 +
 drivers/nvme/host/zns.c  | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40ca71b29bb9..4fcaec0b330b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2058,7 +2058,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
 
-	if (id->nsattr & NVME_NS_ATTR_RO)
+	if (id->nsattr & NVME_NS_ATTR_RO ||
+			test_bit(NVME_NS_FORCE_RO, &ns->flags))
 		set_disk_ro(disk, true);
 	else
 		set_disk_ro(disk, false);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bc330bf0d3bd..3a985e98ca27 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -448,6 +448,7 @@ struct nvme_ns {
 #define NVME_NS_REMOVING	0
 #define NVME_NS_DEAD     	1
 #define NVME_NS_ANA_PENDING	2
+#define NVME_NS_FORCE_RO	3
 
 	struct nvme_fault_inject fault_inject;
 
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 67e87e9f306f..8f3632c4db05 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -57,10 +57,10 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	/* Driver requires zone append support */
 	if (!(le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
 			NVME_CMD_EFFECTS_CSUPP)) {
+		set_bit(NVME_NS_FORCE_RO, &ns->flags);
 		dev_warn(ns->ctrl->device,
-			"append not supported for zoned namespace:%d\n",
+			"append not supported for zoned namespace:%d. Forcing to read-only mode\n",
 			ns->head->ns_id);
-		return -EINVAL;
 	}
 
 	/* Lazily query controller append limit for the first zoned namespace */
-- 
2.17.1

