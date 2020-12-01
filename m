Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F52AC64E7B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 12:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEED72080A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 12:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="jtYjvh+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgLAMDL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbgLAMDL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 07:03:11 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD9DC0613CF
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 04:02:30 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id x16so3562030ejj.7
        for <linux-block@vger.kernel.org>; Tue, 01 Dec 2020 04:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EbprAHFEFknQH4Iq10/TiEWO6fTer6yZcPxsleBmY2s=;
        b=jtYjvh+X/Ag+OJbXIIsb6JUhMJ2y1Cla7SkJSpuj4bffaZo0bKNFbA7lJUvZzT6Z/E
         8VK94GfSJb91fW+McTCWvZJvP5slAEzC+KGVfal+yuj5DD1XPlVEEaF2cCKCq1o/rc8N
         51hVaXK/ZzwTSyEeLZhua+XKI+BadxyMhyITSAWmyzo+LYIbsEjVime/uQNphZjbvuCL
         rguNAxWn4R94H4Xa1iI5zivWGgDUh4bzDtwHEFDY7xDxqpyFCXLSqn7ROVBSGmXuJscL
         tkX1y9hep9wnx4fTCT6vQJchIgHMGq8iAN7FwCbwpk+xzybnXeZBlHAMIGCSXjvYNS0+
         sGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EbprAHFEFknQH4Iq10/TiEWO6fTer6yZcPxsleBmY2s=;
        b=jXaJBexlsgmE8pdXcRMa8FBfEVHHMj2pMgUsFVD0OXfyBcE7qCw5TjMM4+QBpZO+cx
         pfhgddkCq9NKboUPcd210X8jRlqZI5QdLgfCaDketk5O/MAH+gKPyZ6CkEGAyGV/9VP3
         hkWSbDh44+84V2woZhf0uL7WxycGKh0rUYcl+b1TTkb2Ok+zFl1/5gzHmwYK9dEBcHET
         nrdQnpK1kzM6rrC04w/BbPNhxmwHMZ7gn/BBswwazz0QQwh4em7QqN++LG7daNI+Jz4P
         Tl7ygvkdG+ZuE+SRmy69x4i5+SXMbJ2LXH/lHwxe7xS8qcfolfr0+dUDk3k/mslF3ShZ
         sVOg==
X-Gm-Message-State: AOAM533dHvGGUToKy5KbM3+e9YhhnhQZySMB7F4y+A13Td/R5sl0n91n
        Vvu1kw9BuRfu9ukhzluMDyOULNDNqZY212J9ijk=
X-Google-Smtp-Source: ABdhPJwI4S8ymod1OhWiHTBf1ZYrl9NH1LNDNe/YmIOe+SEfOAizYwtAjLv9uOPn7ZjSYGGqcimHVw==
X-Received: by 2002:a17:907:d01:: with SMTP id gn1mr2666119ejc.357.1606824149084;
        Tue, 01 Dec 2020 04:02:29 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id u1sm709040edf.65.2020.12.01.04.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:02:27 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
        k.jensen@samsung.com, Niklas.Cassel@wdc.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [V5] nvme: enable ro namespace for ZNS without append
Date:   Tue,  1 Dec 2020 13:02:21 +0100
Message-Id: <20201201120221.29279-1-javier.gonz@samsung.com>
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

Changes since V4:
  - Revert re-reading effects to page. Wait for patches from Christoph
    on RO flag refactoring that allow to clear the flags.

Changes since V3:
  - Force re-reading effects log page (from Keith)
  - Pending proper refresh of RO flag - dependency on patch from
    Christoph

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
 drivers/nvme/host/core.c |  2 +-
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/zns.c  | 14 +++++++++-----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f42ed266bd7f..49ba21e89467 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2113,7 +2113,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
 
-	if (id->nsattr & NVME_NS_ATTR_RO)
+	if (id->nsattr & NVME_NS_ATTR_RO || test_bit(NVME_NS_FORCE_RO, &ns->flags))
 		set_disk_ro(disk, true);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ae017f727798..bfcedfa4b057 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -452,6 +452,7 @@ struct nvme_ns {
 #define NVME_NS_REMOVING	0
 #define NVME_NS_DEAD     	1
 #define NVME_NS_ANA_PENDING	2
+#define NVME_NS_FORCE_RO	3
 
 	struct nvme_fault_inject fault_inject;
 
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 67e87e9f306f..c2b557452483 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -55,12 +55,16 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	int status;
 
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

