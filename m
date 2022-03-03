Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BBFC433F5
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 17:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiCCRyn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 12:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiCCRyn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 12:54:43 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E5614A6DA
        for <linux-block@vger.kernel.org>; Thu,  3 Mar 2022 09:53:57 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id z2so5233429plg.8
        for <linux-block@vger.kernel.org>; Thu, 03 Mar 2022 09:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukAldR+ukgRttWBpBd8hdEbeenBcuBAVne6c5rEIhug=;
        b=GF7l8jQnQfIwFDOlbPf7aX27vvTO2lWAWaMM1jH4UYLrfO/7VePE4veahTJKQUBqwz
         G4sgi5sk4SXGKYYx/AxXR1FBvxQ8VtkDevktzdDS2dyZuw/t3V5CHu3E/sHrNJpMsVSO
         wJdR32yr21vc+HUggZSDwx8htFHy0CQHzqIeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukAldR+ukgRttWBpBd8hdEbeenBcuBAVne6c5rEIhug=;
        b=j6Zu0uWXGR5UdKj2TasTMPOgmLAXJPET5Ww/JrzsBID1F07zd8Z+nHDi3PB97eNtNO
         cW4Zo0Jdjt8+P3Q2MlypfXHXBTsiZnxpVJsZT5unpYlvK0edHjTbtMxcR1jSMeawteww
         jOCMT/ZhRaHrCxocLS7Fizqy97kX/b9Byjsa+AkrA20lgdvOcVf03V0bfd25pVpTiKq0
         vYVhYpY1kiPDB8GTwJXlnCv+YXugIgDHBWvCqpkYK4Kb6K+tdGlUA29TiR2+/FhDmRzs
         VqJMIyvPJeRo9sKQUORMSCjzZQmSLu5cj4gqbyVKS3+RE2b3Xotn0oMWFu/iRYNMpadq
         8u3A==
X-Gm-Message-State: AOAM530oA343nbxWRxZEInoOijlhQAe42Ps01lmUdRgS1KxzPsK+SCbD
        p5LmwR0KBoRFTER4dgzj9lOHyKSpEBzMnJdOEbwDfmiXCGrmRhAUA7wVSeS40AwWN+ty43kWdrZ
        A0VrMmnvPIcrhwn33JWLq3ZPp2Iu6TzdptSSkRkX7X6kLHXkwZrzDb1WgBS+9aYNDhAnQez+kdM
        Fj9ZNvtQ==
X-Google-Smtp-Source: ABdhPJwcAPP9cEPydyWJPKuezxmmzpv0szsQUx9xEneSiYPJnR2mUbgz1dscsyHtz0TtqZzIIiBMkA==
X-Received: by 2002:a17:902:9045:b0:14d:6829:f460 with SMTP id w5-20020a170902904500b0014d6829f460mr37585529plz.89.1646330036225;
        Thu, 03 Mar 2022 09:53:56 -0800 (PST)
Received: from localhost ([192.30.188.252])
        by smtp.gmail.com with ESMTPSA id p34-20020a056a000a2200b004cd49fc15e5sm3214484pfh.59.2022.03.03.09.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 09:53:55 -0800 (PST)
From:   Uday Shankar <ushankar@purestorage.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH] block: emit disk ro uevent in device_add_disk()
Date:   Thu,  3 Mar 2022 10:52:20 -0700
Message-Id: <20220303175219.272938-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Userspace learns of disk ro state via the change event emitted by
set_disk_ro_uevent. This function has cyclic dependency with
device_add_disk: the latter performs kobject initialization that is
necessary for uevents to go through, but we want to set up properties
like ro state before exposing the disk to userspace via device_add_disk.

The usual workaround is to call set_disk_ro both before and after
device_add_disk; the purpose of the "after" call is just to emit the
uevent. Moreover, because set_disk_ro only emits a uevent when the ro
state changes, set_disk_ro needs to be called twice in the "after"
position to ensure that the ro state flips. See drivers/scsi/sd.c for an
example of this pattern.

The nvme driver does not implement this pattern. It only calls
set_disk_ro before device_add_disk, and so the ro uevent is never
emitted. This breaks applications such as dm-multipath. To avoid
introducing the messy pattern above into the nvme driver, emit the disk
ro uevent immediately after announcing addition of the disk.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 block/genhd.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 11c761afd64f..89a110f0b002 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -394,6 +394,16 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
 	return 0;
 }
 
+static void set_disk_ro_uevent(struct gendisk *gd, int ro)
+{
+	char event[] = "DISK_RO=1";
+	char *envp[] = { event, NULL };
+
+	if (!ro)
+		event[8] = '0';
+	kobject_uevent_env(&disk_to_dev(gd)->kobj, KOBJ_CHANGE, envp);
+}
+
 /**
  * device_add_disk - add disk information to kernel list
  * @parent: parent device for the disk
@@ -522,6 +532,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		 */
 		dev_set_uevent_suppress(ddev, 0);
 		disk_uevent(disk, KOBJ_ADD);
+		set_disk_ro_uevent(disk, get_disk_ro(disk));
 	}
 
 	disk_update_readahead(disk);
@@ -1419,16 +1430,6 @@ void blk_cleanup_disk(struct gendisk *disk)
 }
 EXPORT_SYMBOL(blk_cleanup_disk);
 
-static void set_disk_ro_uevent(struct gendisk *gd, int ro)
-{
-	char event[] = "DISK_RO=1";
-	char *envp[] = { event, NULL };
-
-	if (!ro)
-		event[8] = '0';
-	kobject_uevent_env(&disk_to_dev(gd)->kobj, KOBJ_CHANGE, envp);
-}
-
 /**
  * set_disk_ro - set a gendisk read-only
  * @disk:	gendisk to operate on
-- 
2.25.1

