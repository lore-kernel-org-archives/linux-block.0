Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFFAC07E95
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 23:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A71E61422
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 23:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhGBXPY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jul 2021 19:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhGBXPY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jul 2021 19:15:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B14C061762;
        Fri,  2 Jul 2021 16:12:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i13so6554177plb.10;
        Fri, 02 Jul 2021 16:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jY+Z2YyKhtF3PNCdzDFu/6GyliQKTIVwJ/BKyrLM32U=;
        b=Ir+c3bJBWlhZgHglJGD0HMWxwrLHYSkAOAcbHoE4b3ITnO0prn0Zr64LJp0rb/idY7
         Z1Kjqq/LG+cgIa17iEyjiVPOldj+d/TMVXj0pe0beTLUQsP28SsOQRJePI9UBWlgurrQ
         xM7VXU+xVPDjNkri4DBbEKhfMdizv+cQMpn3kl2vl/myeaRxYO7H8o8DbzabOf5jE7De
         pm3QriMjKfgrdECxWMII9d6vdLDRYWewTHEKyjxFz5NLAVy5NRPjYVo0Ejcbjjrn/KI8
         5LGrQG0iPCv0BI+V5ITlKmFrwQ14lWp5aVY/ZtTr6GXihArEd4B0MmgMpCuIenkKC0v3
         VIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jY+Z2YyKhtF3PNCdzDFu/6GyliQKTIVwJ/BKyrLM32U=;
        b=mgAIbvmOqWs4EbMOVJpB5j7nC2Bjks9C+7p30PUZQ0ufGWB8P0gpZcByKXaI4Qk9L5
         +CqsbfqLTqHz+yQzQI0vtBztzAmwTIdqwTzt8rA23BD7eqxfm1vTFYQbrXKrNacbGeoq
         Hc54avEf9wYP7vVoVfWrHq55FxRAb9XxSVr0mpEJ8lDglkAoiik7JXg9qgTBr9bpCez+
         jNJ7n7S7di2hhmi0FperfviSsSCCaA3DXhry5cru+Sah5UGLelfkzUTKPvEmFlzfYKzH
         OStQoaOu07nGNM3+B3UDy1rKAJlKtjywnutShRoZfVr3fl6XN/h7NLJLjw+uTCT2TLbz
         Ttog==
X-Gm-Message-State: AOAM532qPKHCS3pJorTV40Z2TTwG8UOmoW9VeGsUdy951ZZm5Mv8frvT
        vafN7+sVoTSDUEuY4aIaW0k=
X-Google-Smtp-Source: ABdhPJy0XV+iHxvy176r6zoC+htH6b1BUvuR/fZzRzC7Zgo9U72y8Q4+PIltQl7Krb+pradU6rZLNw==
X-Received: by 2002:a17:90a:66c9:: with SMTP id z9mr2020628pjl.122.1625267571554;
        Fri, 02 Jul 2021 16:12:51 -0700 (PDT)
Received: from novachrono.domain.name ([122.163.170.78])
        by smtp.gmail.com with ESMTPSA id w7sm4853645pgr.10.2021.07.02.16.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 16:12:50 -0700 (PDT)
From:   Rajat Asthana <rajatasthana4@gmail.com>
To:     axboe@kernel.dk, hare@suse.de, ming.lei@redhat.com,
        damien.lemoal@wdc.com, jack@suse.cz, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Rajat Asthana <rajatasthana4@gmail.com>,
        syzbot+7d6c5587ec9cff5be65c@syzkaller.appspotmail.com
Subject: [PATCH] block: Avoid accessing an already freed kobject in delete_partition
Date:   Sat,  3 Jul 2021 04:42:28 +0530
Message-Id: <20210702231228.261460-1-rajatasthana4@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When several processes, which interacts with block devices, are created
and killed continuously, a case happens when the kobject freed by a
process is accessed by another process in delete_partition.

This causes a use-after-free bug and is being reported by syzbot here:
https://syzkaller.appspot.com/bug?extid=7d6c5587ec9cff5be65c

Add a condition to check if the kobject for a device exists, if it
does, then go ahead and refer the kobject, else avoid referencing it.

In this scenario, when more than one processes are interacting with the
block device, one process might have deleted the device from the system
and the other process might try to delete an already deleted device,
which will result in several null pointer dereference errors. So, check
if device has a sysfs entry before calling functions to remove it from
sysfs. We should also check if the knode belongs to any list before
calling the function to remove it from the lists.

Reported-and-tested-by: syzbot+7d6c5587ec9cff5be65c@syzkaller.appspotmail.com
Signed-off-by: Rajat Asthana <rajatasthana4@gmail.com>
---
 block/partitions/core.c |  6 +++++-
 drivers/base/core.c     | 21 ++++++++++++++-------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 347c56a51d87..3fc0364c1c35 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -291,7 +291,11 @@ static void delete_partition(struct block_device *part)
 	__invalidate_device(part, true);
 
 	xa_erase(&part->bd_disk->part_tbl, part->bd_partno);
-	kobject_put(part->bd_holder_dir);
+
+	if (!part->bd_holder_dir) {
+		kobject_put(part->bd_holder_dir);
+	}
+
 	device_del(&part->bd_device);
 
 	/*
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2a61003ea2c1..d4f43fd0d0ae 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3486,16 +3486,20 @@ void device_del(struct device *dev)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DEL_DEVICE, dev);
 
-	dpm_sysfs_remove(dev);
-	if (parent)
+	if (dev->kobj.sd)
+		dpm_sysfs_remove(dev);
+	if (parent && klist_node_attached(&dev->p->knode_parent))
 		klist_del(&dev->p->knode_parent);
 	if (MAJOR(dev->devt)) {
 		devtmpfs_delete_node(dev);
 		device_remove_sys_dev_entry(dev);
-		device_remove_file(dev, &dev_attr_dev);
+
+		if (dev->kobj.sd)
+			device_remove_file(dev, &dev_attr_dev);
 	}
 	if (dev->class) {
-		device_remove_class_symlinks(dev);
+		if (dev->kobj.sd)
+			device_remove_class_symlinks(dev);
 
 		mutex_lock(&dev->class->p->mutex);
 		/* notify any interfaces that the device is now gone */
@@ -3504,11 +3508,14 @@ void device_del(struct device *dev)
 			if (class_intf->remove_dev)
 				class_intf->remove_dev(dev, class_intf);
 		/* remove the device from the class list */
-		klist_del(&dev->p->knode_class);
+		if (klist_node_attached(&dev->p->knode_class))
+			klist_del(&dev->p->knode_class);
 		mutex_unlock(&dev->class->p->mutex);
 	}
-	device_remove_file(dev, &dev_attr_uevent);
-	device_remove_attrs(dev);
+	if (dev->kobj.sd) {
+		device_remove_file(dev, &dev_attr_uevent);
+		device_remove_attrs(dev);
+	}
 	bus_remove_device(dev);
 	device_pm_remove(dev);
 	driver_deferred_probe_del(dev);
-- 
2.32.0

