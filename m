Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35EDC07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 04:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D352B61360
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 04:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbhGOE6e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 00:58:34 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:43906 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhGOE6d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 00:58:33 -0400
Received: by mail-pl1-f172.google.com with SMTP id b12so2551727plh.10;
        Wed, 14 Jul 2021 21:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gIg7Rqg1ikL9rnJkxSzC8R1IAU7njxjl/m0vF2ydy4Y=;
        b=Q/gZQ88tzFhaF4ILY1aXAv1em4+MdYwrsbSontgP6FBOwMZQ3Wlw4EtPIuUI3jWeIS
         pI+QfdJ0S+SLXolJEQNTWFq1nq0gZiWsI22BGpYZMl/dHvv99Y9oV6/9z11lvZA9Idsn
         G/J8b+xywXuJc8kLVu6qj5IKYo18W3viNg9mu/Sz/IvRveKXZMe/jik3dVQCzaK6H3/0
         AxaeC4lgqxtg+RkWaeBpNzfODrE9NokIaCZWbK8907/E0ogdjgzuQdULGiCbIkcojq5K
         nVX+PS4B6A6F91wDrLDjFyQE31ELRYEpeu90WyWW04fTlyq1q+oGDfPkvFqq2be6swSb
         twKw==
X-Gm-Message-State: AOAM532fhYyTT2hcj+KtqmMhQZIHkOnDatcpCs3QSpOQMzabs3++H3+0
        rqIlND6ugWYcbFPduPLvSMU=
X-Google-Smtp-Source: ABdhPJw6MFxckQzjbD1qYvV+wBpK+PLhMIPHurJS2V6jWS20oCazLNxm8pppX+3o4ebJaZHlRZ9N1Q==
X-Received: by 2002:a17:90b:234e:: with SMTP id ms14mr6659096pjb.118.1626324940237;
        Wed, 14 Jul 2021 21:55:40 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id e21sm4576192pfc.172.2021.07.14.21.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 21:55:39 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 2/6] block: move disk announce work from register_disk() to a helper
Date:   Wed, 14 Jul 2021 21:55:27 -0700
Message-Id: <20210715045531.420201-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715045531.420201-1-mcgrof@kernel.org>
References: <20210715045531.420201-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This moves quite a bit of code which does one thing into a helper.
We currently do not check for errors but we may decide that might
be desirable later.

This also makes the code easier to read.

This change has no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 4dd6db3618f2..520e23b25ed5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -390,6 +390,15 @@ static void disk_scan_partitions(struct gendisk *disk)
 		blkdev_put(bdev, FMODE_READ);
 }
 
+static void disk_announce(struct gendisk *disk)
+{
+	struct device *ddev = disk_to_dev(disk);
+
+	/* announce the disk and partitions after all partitions are created */
+	dev_set_uevent_suppress(ddev, 0);
+	disk_uevent(disk, KOBJ_ADD);
+}
+
 static void register_disk(struct device *parent, struct gendisk *disk,
 			  const struct attribute_group **groups)
 {
@@ -433,10 +442,7 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 		return;
 
 	disk_scan_partitions(disk);
-
-	/* announce the disk and partitions after all partitions are created */
-	dev_set_uevent_suppress(ddev, 0);
-	disk_uevent(disk, KOBJ_ADD);
+	disk_announce(disk);
 
 	if (disk->queue->backing_dev_info->dev) {
 		err = sysfs_create_link(&ddev->kobj,
-- 
2.27.0

