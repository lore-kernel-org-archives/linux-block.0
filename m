Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E506C47E48
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 04:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0829C6128B
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 04:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbhGOE6h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 00:58:37 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:53111 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238737AbhGOE6g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 00:58:36 -0400
Received: by mail-pj1-f41.google.com with SMTP id bt15so2990065pjb.2;
        Wed, 14 Jul 2021 21:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6oo98c6UbKQTMijd+O7s8Vz8iegr55iCRTENQPQsTlE=;
        b=MrKst64tmSoWHrAemNQQhMdez/5QoDZNnzoQhfcHCbfbL4/Z7Yv43sel1ED+8GLew5
         l68ZQqi1dGMAWn2H45vcOVZbgZwOCuzjXtH8KxAjTTqoRiPtpFcC723BvuFmJbJzG6Dk
         6SFHSPuZs7jOkuuoxCX/0JJWesHqZz1lAm3DTIaY4FlRepvsoeTuYhAUUlW392p5BEdD
         QyD4geks9fa5g4lP+ah+JlFbXDLf8heqRgrJmh51AOpOLrntHKeB0rLyZqsI0aQwA2Zy
         014PKL+Ow14UNx6JsL965BuNnv7Am+b1KbGptHVotaKnQyVZhLoeOaF7rZqUQjrqgiQ2
         h6Cg==
X-Gm-Message-State: AOAM531BxfvADCPSwmZd67lh1e5PPZnTflnYuWQuBcBY2yHWdBJqAAQZ
        D2PWWOKeZO+YDQLlEfmKhN0=
X-Google-Smtp-Source: ABdhPJwAvcBq2p3kJoCOdkLZfaE/p4uuhROOjDLOrUxpIx9yWz1XKNQ9o4drzfOFzPdXzBfOpcxl/g==
X-Received: by 2002:a17:90b:184:: with SMTP id t4mr8073637pjs.161.1626324942651;
        Wed, 14 Jul 2021 21:55:42 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id m34sm5295387pgb.85.2021.07.14.21.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 21:55:41 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 3/6] block: move disk invalidation from del_gendisk() into a helper
Date:   Wed, 14 Jul 2021 21:55:28 -0700
Message-Id: <20210715045531.420201-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715045531.420201-1-mcgrof@kernel.org>
References: <20210715045531.420201-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the disk / partition invalidation into a helper. This will make
reading del_gendisk easier to read, in preparation for adding support
to add error handling later on register_disk() and to later share more
code with del_gendisk.

This change has no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 520e23b25ed5..e5535879d629 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -399,6 +399,31 @@ static void disk_announce(struct gendisk *disk)
 	disk_uevent(disk, KOBJ_ADD);
 }
 
+static void disk_invalidate(struct gendisk *disk)
+{
+	if (!(disk->flags & GENHD_FL_HIDDEN)) {
+		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
+
+		/*
+		 * Unregister bdi before releasing device numbers (as they can
+		 * get reused and we'd get clashes in sysfs).
+		 */
+		bdi_unregister(disk->queue->backing_dev_info);
+	}
+
+	blk_unregister_queue(disk);
+
+	kobject_put(disk->part0->bd_holder_dir);
+	kobject_put(disk->slave_dir);
+
+	part_stat_set_all(disk->part0, 0);
+	disk->part0->bd_stamp = 0;
+	if (!sysfs_deprecated)
+		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
+	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
+	device_del(disk_to_dev(disk));
+}
+
 static void register_disk(struct device *parent, struct gendisk *disk,
 			  const struct attribute_group **groups)
 {
@@ -606,27 +631,7 @@ void del_gendisk(struct gendisk *disk)
 
 	set_capacity(disk, 0);
 
-	if (!(disk->flags & GENHD_FL_HIDDEN)) {
-		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
-
-		/*
-		 * Unregister bdi before releasing device numbers (as they can
-		 * get reused and we'd get clashes in sysfs).
-		 */
-		bdi_unregister(disk->queue->backing_dev_info);
-	}
-
-	blk_unregister_queue(disk);
-
-	kobject_put(disk->part0->bd_holder_dir);
-	kobject_put(disk->slave_dir);
-
-	part_stat_set_all(disk->part0, 0);
-	disk->part0->bd_stamp = 0;
-	if (!sysfs_deprecated)
-		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
-	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
-	device_del(disk_to_dev(disk));
+	disk_invalidate(disk);
 }
 EXPORT_SYMBOL(del_gendisk);
 
-- 
2.27.0

