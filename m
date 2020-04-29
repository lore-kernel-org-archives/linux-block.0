Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E262EC83003
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11D320787
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588146546;
	bh=VrX3if2aBWj2XpglE65OAhk0XyviMaU4vC03AyKdWN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OAC/QN4Wiu8/5KMwbQqbLOYRFjnw8kt6IyHeK3CL9vPy+9vVQJLr+574t0Cpy1VMr
	 FowtOQodCM/eHRmcqBEbAwEj/eWp7WNJlkIAVbQZ5A5PiWnjIoV1H2fALnlLHHZFmJ
	 VUew3b3riN4VwiKNaPq228tlFLRWPxvsChTXc0qI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgD2HtD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:49:03 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51808 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgD2Hsw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 03:48:52 -0400
Received: by mail-pj1-f66.google.com with SMTP id mq3so445699pjb.1;
        Wed, 29 Apr 2020 00:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VDQ/Gc2nfAeUdmOXsjIl0MCMGYVLmlhEqi8QvquPVhg=;
        b=GRWYdJovFC9mWIKlxZ69GUyN3SOdqT2dX/kXeHcDehyXfYieHu4FDDSLLRpWEWwVph
         4wvs3+HpMi+rx5gVm2/gLO+dKNucHEM3LFd6hb1ifJ7fdOPlOZAP0u0iDhN1MWUbo5Po
         G3R1u/JHMhPAmhw31QqGL/ObMhvZ7kzrT8y+BVW5s/7mEL2tCYoieS1BCKsmAdOFATKA
         guKmhJx71LdZh/qciH7PNy8uEtjhzEQZeG5cLr0lBzfGs7uZKGX6kOhad/+LawPMAmFk
         P4ErxtnH7hKa5NHfRy25slYOdUbtzkAguw2Rp6xMj8tCokzKwG8sgpnKUexDAUSqHSdZ
         m6cg==
X-Gm-Message-State: AGi0PuYdw8oyYHPDjEjI7yHseuPrHKGhtkWZzYVYSdGWN4Q50O+HO3ci
        DgY7/wWibXQ9d0367ZgvzQM=
X-Google-Smtp-Source: APiQypIKe06GYGkAL2vjcb0FV8IUNXJ8b1rsMrUfS2jLt7un504Y1YfAV7CyBe/kWaCiITjg2Eceyw==
X-Received: by 2002:a17:90a:e2d0:: with SMTP id fr16mr1667544pjb.146.1588146531502;
        Wed, 29 Apr 2020 00:48:51 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c59sm4089722pje.10.2020.04.29.00.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:48:49 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C8FDC41C6A; Wed, 29 Apr 2020 07:48:45 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com
Cc:     yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v1 4/6] block: move disk unregistration work from del_gendisk() to a helper
Date:   Wed, 29 Apr 2020 07:48:42 +0000
Message-Id: <20200429074844.6241-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200429074844.6241-1-mcgrof@kernel.org>
References: <20200429074844.6241-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is quite a bit of code on del_gendisk() which relates to
unregistering the disk, using register_disk() as an counter.
Move all this code into a helper instead of re-writing our own,
which we'll need later to handle errors on add_disk().

I note that register_disk() links the bdi at the end, but since
del_gendisk() deals with this before queue de-registration we'll
take a hint that's the right order that this should be done, and
we shouldn't instead strictly unwind register_disk() exactly.

We'll instead keep whatever lessons have been learned from
del_gendisk().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index b4d75a15fd31..ed2a0eaa4e7b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -762,6 +762,28 @@ static void disk_invalidate(struct gendisk *disk)
 	up_write(&disk->lookup_sem);
 }
 
+static void unregister_disk(struct gendisk *disk)
+{
+	/*
+	 * Remove gendisk pointer from idr so that it cannot be looked up
+	 * while RCU period before freeing gendisk is running to prevent
+	 * use-after-free issues. Note that the device number stays
+	 * "in-use" until we really free the gendisk.
+	 */
+	blk_invalidate_devt(disk_devt(disk));
+
+	kobject_put(disk->part0.holder_dir);
+	kobject_put(disk->slave_dir);
+
+	part_stat_set_all(&disk->part0, 0);
+	disk->part0.stamp = 0;
+	if (!sysfs_deprecated)
+		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
+
+	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
+	device_del(disk_to_dev(disk));
+}
+
 static void register_disk(struct device *parent, struct gendisk *disk,
 			  const struct attribute_group **groups)
 {
@@ -972,25 +994,10 @@ void del_gendisk(struct gendisk *disk)
 		WARN_ON(1);
 	}
 
+	unregister_disk(disk);
+
 	if (!(disk->flags & GENHD_FL_HIDDEN))
 		blk_unregister_region(disk_devt(disk), disk->minors);
-	/*
-	 * Remove gendisk pointer from idr so that it cannot be looked up
-	 * while RCU period before freeing gendisk is running to prevent
-	 * use-after-free issues. Note that the device number stays
-	 * "in-use" until we really free the gendisk.
-	 */
-	blk_invalidate_devt(disk_devt(disk));
-
-	kobject_put(disk->part0.holder_dir);
-	kobject_put(disk->slave_dir);
-
-	part_stat_set_all(&disk->part0, 0);
-	disk->part0.stamp = 0;
-	if (!sysfs_deprecated)
-		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
-	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
-	device_del(disk_to_dev(disk));
 }
 EXPORT_SYMBOL(del_gendisk);
 
-- 
2.25.1

