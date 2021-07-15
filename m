Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7A9C47E48
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 04:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0FD6136E
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 04:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbhGOE6l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 00:58:41 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:36585 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbhGOE6i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 00:58:38 -0400
Received: by mail-pl1-f181.google.com with SMTP id x16so2566288plg.3;
        Wed, 14 Jul 2021 21:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzAKa7kt8ZT7pS8b4C7kOkEXTr3fcPAutgO6swoD5sI=;
        b=fXQiy1FVsndr9c4fb3DoxsLQmkXLa5XT/ECGdn/Y043US4w1qGljD/u3oclD/wq2CN
         rk9QmUbHNDWBs1ytg5wNSWHIbbMpRsyhOtvaHNDuvkyVu4ycbEFZLbS/K5IvQQqMWRyH
         8vfMcu7f2RZNLAZtsu2QUWayrP5GFpiPG7+hFB43hTO4fjUt2uO5l7vhmuyjDjqLGqb+
         Z7DObXnw6ck67J4EVv3Gvl4uhU0pXSjB1VuKK5V+HCN5652BnauC1yg8CWq4kj4H01A1
         ZDBiTs7PRH4w9LZDbWzwbGln525fO6DdBWvjNFH+QtkYpcQMEtL5l7EoreevO97EdvhS
         365g==
X-Gm-Message-State: AOAM532QNL3pxZh1ifhC/9jz1sI1Sfm9xWT2dN3YcKFCOqe4WoG5ii2s
        PIC0Lhpmf0iKa+nEI6PSEIA=
X-Google-Smtp-Source: ABdhPJwfCObClM2Tb2jRMyLjkFno0TcPw/O3hx89udETKxN8IwYQB2MvcT4kuWNJGWZPHZqZ+HlT7w==
X-Received: by 2002:a17:902:b409:b029:129:a9a6:fc76 with SMTP id x9-20020a170902b409b0290129a9a6fc76mr1828699plr.68.1626324945195;
        Wed, 14 Jul 2021 21:55:45 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id u37sm4702796pfg.140.2021.07.14.21.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 21:55:44 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 4/6] block: move disk unregistration work from del_gendisk() to a helper
Date:   Wed, 14 Jul 2021 21:55:29 -0700
Message-Id: <20210715045531.420201-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715045531.420201-1-mcgrof@kernel.org>
References: <20210715045531.420201-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is quite a bit of code on del_gendisk() which relates to
unregistering the disk, using register_disk() as an counter.
Move all this code into a helper instead of re-writing our own,
which we'll need later to handle errors on add_disk().

Since disk unregistrationa also deals with partition unregistration,
provide a halper for that as well, as we'll later need this when
adding error handling for add_disk().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index e5535879d629..b84ba22eed39 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -399,6 +399,25 @@ static void disk_announce(struct gendisk *disk)
 	disk_uevent(disk, KOBJ_ADD);
 }
 
+static void unregister_disk_partitions(struct gendisk *disk)
+{
+	mutex_lock(&disk->open_mutex);
+	disk->flags &= ~GENHD_FL_UP;
+	blk_drop_partitions(disk);
+	mutex_unlock(&disk->open_mutex);
+
+	fsync_bdev(disk->part0);
+	__invalidate_device(disk->part0, true);
+
+	/*
+	 * Unhash the bdev inode for this device so that it can't be looked
+	 * up any more even if openers still hold references to it.
+	 */
+	remove_inode_hash(disk->part0->bd_inode);
+
+	set_capacity(disk, 0);
+}
+
 static void disk_invalidate(struct gendisk *disk)
 {
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
@@ -424,6 +443,12 @@ static void disk_invalidate(struct gendisk *disk)
 	device_del(disk_to_dev(disk));
 }
 
+static void unregister_disk(struct gendisk *disk)
+{
+	unregister_disk_partitions(disk);
+	disk_invalidate(disk);
+}
+
 static void register_disk(struct device *parent, struct gendisk *disk,
 			  const struct attribute_group **groups)
 {
@@ -614,24 +639,7 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_integrity_del(disk);
 	disk_del_events(disk);
-
-	mutex_lock(&disk->open_mutex);
-	disk->flags &= ~GENHD_FL_UP;
-	blk_drop_partitions(disk);
-	mutex_unlock(&disk->open_mutex);
-
-	fsync_bdev(disk->part0);
-	__invalidate_device(disk->part0, true);
-
-	/*
-	 * Unhash the bdev inode for this device so that it can't be looked
-	 * up any more even if openers still hold references to it.
-	 */
-	remove_inode_hash(disk->part0->bd_inode);
-
-	set_capacity(disk, 0);
-
-	disk_invalidate(disk);
+	unregister_disk(disk);
 }
 EXPORT_SYMBOL(del_gendisk);
 
-- 
2.27.0

