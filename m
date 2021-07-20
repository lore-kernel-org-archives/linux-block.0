Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD86C07E9B
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 18:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CB4610A0
	for <linux-block@archiver.kernel.org>; Tue, 20 Jul 2021 18:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhGTRlB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jul 2021 13:41:01 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:37714 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbhGTRkZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jul 2021 13:40:25 -0400
Received: by mail-pf1-f170.google.com with SMTP id d9so234417pfv.4;
        Tue, 20 Jul 2021 11:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpKLw7+0Lhz7KAYo4FAV7zcYwJINash4BCWZ5c+Ll+o=;
        b=NRVIb85OkNYzPmQ4vCooZdL78Pz8+1dYBCJ/gSigw7MvBWa1K2DFtb5gmRXqnhQz3I
         EfmWEZnGg/xFUbISMJuu0E58gCZSnY86w7xDNVmeVhxIqB/2WWOWEYhwjyxdBJXkJz08
         cxDAs+v412BAP3NbyZxuGnANTgITuyAT/xUNl0GBM0AV4nw3ThAccy9z+3x+c3vJ8vbg
         Pn8oU1RUX9EP+v3IK0ZgL18KOFbioiJ2Mku+NaW5KEfZDoGoqXR/FgPRCULBVf5+CyRs
         TUd1ckGm99e/9sIPiUbK0BSw5lsTL1iET8NS9Q9HnNNNoPe2EVzrvR9fNiI/2KBsmMdU
         7QlA==
X-Gm-Message-State: AOAM533dCERU4KBRAxCP336mW187skZwOnGTfQE4+4w2jKOtOJBDeKVQ
        wXbc07/mkFkp1hIMFpoT28w=
X-Google-Smtp-Source: ABdhPJwW90aYHIG5Bf4P7pRI3YsNTvt03tWMoDop9Up97LRPnp03s2aIrcmLhY/J70hkh7m0VzLA6A==
X-Received: by 2002:a62:ed06:0:b029:32c:a800:ba47 with SMTP id u6-20020a62ed060000b029032ca800ba47mr32106180pfh.56.1626805261868;
        Tue, 20 Jul 2021 11:21:01 -0700 (PDT)
Received: from localhost ([191.96.121.239])
        by smtp.gmail.com with ESMTPSA id ie13sm3439116pjb.45.2021.07.20.11.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 11:21:00 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 4/5] nvme: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
Date:   Tue, 20 Jul 2021 11:20:47 -0700
Message-Id: <20210720182048.1906526-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720182048.1906526-1-mcgrof@kernel.org>
References: <20210720182048.1906526-1-mcgrof@kernel.org>
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
index 11779be42186..7be78491c838 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1819,7 +1819,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 static inline bool nvme_first_scan(struct gendisk *disk)
 {
 	/* nvme_alloc_ns() scans the disk prior to adding it */
-	return !(disk->flags & GENHD_FL_UP);
+	return !(blk_disk_added(disk));
 }
 
 static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
@@ -3823,7 +3823,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	nvme_mpath_clear_current_path(ns);
 	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
 
-	if (ns->disk->flags & GENHD_FL_UP) {
+	if (blk_disk_added(ns->disk)) {
 		if (!nvme_ns_head_multipath(ns->head))
 			nvme_cdev_del(&ns->cdev, &ns->cdev_device);
 		del_gendisk(ns->disk);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0ea5298469c3..f77bd2d5c1a9 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -764,7 +764,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
-	if (head->disk->flags & GENHD_FL_UP) {
+	if (blk_disk_added(head->disk)) {
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
 		del_gendisk(head->disk);
 	}
-- 
2.27.0

