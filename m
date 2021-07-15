Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E03C636CA
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C434613D0
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhGOU0y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:26:54 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:37762 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhGOU0u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 16:26:50 -0400
Received: by mail-pf1-f171.google.com with SMTP id 17so6601827pfz.4;
        Thu, 15 Jul 2021 13:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AyipTER8+MUyDw0S6on3+IcPgIrBC+XyYSkS/4kV8BU=;
        b=WJPGvhS9dCBDrrVt1O9SPrH31nAMX0CctwEtPBG4dWs+3C35irFQEkUGT9PCDcMoBU
         JqXYTksjcDLhieST77WCiU9cZJXWkeGuFCpEGza9tnvkugPU4CyRjhleRPQKFCEbfRMC
         PN7/9vevWyHN9KMURfyEL5zg8RtyQQ1N4b6MOgf1YG+GcZPLjNb5aHfPZ8e0rPMLrqfq
         gBnkRWmcpfm0HRDvRTFkIUHin1XXbYhPYjCsMMMmTqvBJ5U2eJzvj2P/+gkRcbPqIVXO
         HNxqI4rLFdZ//5IFiJKwsTzEiuXZrt9CumOiZRA4esq83Ew4zhFgLt5gFGFLBfcm5K4K
         MlGQ==
X-Gm-Message-State: AOAM5302+e4XiDeZyvInmhB/i8fjdzc5c7vHI50ZGpMEUbeuzBf+/xNt
        QDbZ8RqG1fbNqTBthUIagC7jCd4goQ9lug==
X-Google-Smtp-Source: ABdhPJy+XMP4yXA7/QDXbZCPlj28Krn0rvHC16kW6wR3+D/sEO6QuDYz7ooLeyyw3xQXoCwdRSJF7Q==
X-Received: by 2002:a62:7545:0:b029:327:90e9:d4b4 with SMTP id q66-20020a6275450000b029032790e9d4b4mr6152006pfc.39.1626380636533;
        Thu, 15 Jul 2021 13:23:56 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id o91sm10068930pjo.15.2021.07.15.13.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:23:55 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 5/6] nvme: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
Date:   Thu, 15 Jul 2021 13:23:40 -0700
Message-Id: <20210715202341.2016612-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715202341.2016612-1-mcgrof@kernel.org>
References: <20210715202341.2016612-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The GENHD_FL_DISK_ADDED flag is what we really want, as the
flag GENHD_FL_UP could be set on a semi-initialized device.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/nvme/host/core.c      | 4 ++--
 drivers/nvme/host/multipath.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 11779be42186..3848353fba11 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1819,7 +1819,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 static inline bool nvme_first_scan(struct gendisk *disk)
 {
 	/* nvme_alloc_ns() scans the disk prior to adding it */
-	return !(disk->flags & GENHD_FL_UP);
+	return !(disk->flags & GENHD_FL_DISK_ADDED);
 }
 
 static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
@@ -3823,7 +3823,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	nvme_mpath_clear_current_path(ns);
 	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
 
-	if (ns->disk->flags & GENHD_FL_UP) {
+	if (ns->disk->flags & GENHD_FL_DISK_ADDED) {
 		if (!nvme_ns_head_multipath(ns->head))
 			nvme_cdev_del(&ns->cdev, &ns->cdev_device);
 		del_gendisk(ns->disk);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0ea5298469c3..8048678969ba 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -764,7 +764,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
-	if (head->disk->flags & GENHD_FL_UP) {
+	if (head->disk->flags & GENHD_FL_DISK_ADDED) {
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
 		del_gendisk(head->disk);
 	}
-- 
2.27.0

