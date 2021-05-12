Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213F8C433ED
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F5161927
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhELHDK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 03:03:10 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:35396 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhELHDJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 03:03:09 -0400
Received: by mail-pl1-f182.google.com with SMTP id t21so12048118plo.2;
        Wed, 12 May 2021 00:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kvl/e3jQZBH+Hezey5cigUvg3Mz+1vyT6hVjyuG2ZqE=;
        b=mDqZCgaSp9+8k7swWvrm5q2m1RHj1TDIA/iEwoJVDHFCCxa+ZKF6QagTbnGvSTW7e9
         pWyX60vpfBGUI4tvWsh1cDkNrhywKAVDEe2MUGj79yVzGUBdamPrq654eI40e2Od47wR
         qhbZjzAjzol4YKNsAKmb51OrKqNgAnzJ4OQOzy0hCFKZxVDI4mE3uRE8mzytlAS5YakZ
         NOFakrB82y3RGc1OmDPWOAtq/NjhGCphn1B4ppYYerMdll3A0/2nimQ94EbyMF9a2n7N
         UkltgM1JO2e+MLKT6Fql+ZdPxSP5hAQtEcuIiJhcdyZimCX4y/GMsHmVNX8ck8UV4If2
         0wBQ==
X-Gm-Message-State: AOAM533DA11Wxrt6owGy9NrX/bSC7Op6xr2z4A3QOiRAGqa+NobeLsGm
        8ABFPe4LgjSPWvwB83nA7dM=
X-Google-Smtp-Source: ABdhPJy922jIcBfmK2YZ0erkKtc8H3wOs9ndZ/IAggHRjG0vLrQWDnBLg8/QKg80JPL+kJRlN8vHwQ==
X-Received: by 2002:a17:90a:2ec6:: with SMTP id h6mr9342512pjs.103.1620802922105;
        Wed, 12 May 2021 00:02:02 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q27sm15160768pfl.41.2021.05.12.00.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:01:58 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5FC8A4243B; Wed, 12 May 2021 06:46:35 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v1 8/8] block: add add_disk() failure injection support
Date:   Wed, 12 May 2021 06:46:29 +0000
Message-Id: <20210512064629.13899-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210512064629.13899-1-mcgrof@kernel.org>
References: <20210512064629.13899-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For a long time we have lived without any error handling
on the add_disk() error path. Now that we have some initial
error handling, add error injection support for its path so
that we can test it and ensure we don't regress this path
moving forward.

This only adds runtime code *iff* the new bool CONFIG_FAIL_ADD_DISK is
enabled in your kernel. If you don't have this enabled this provides
no new functional. When CONFIG_FAIL_ADD_DISK is disabled the new routine
blk_should_fail_add_disk() ends up being transformed to if (false), and
so the compiler should optimize these out as dead code producing no
new effective binary changes.

Failure injection lets us configure at boot how often we want a failure
to take place by specifying the interval, the probability, and when needed
a size constraint. We don't need to test for size constraints for
add_disk() and so ignore that part of error injection. Although testing
early boot failures with add_disk() failures might be useful we don't
to make add_disk() fail every time as otherwise we wouldn't be able to
boot. So enabling add_disk() error injection requires a second post
boot step where you specify where in the add_disk() code path you want
to enable failure injection for. This lets us verify correctness of
the different error handling parts of add_disk(), while also allowing
a respective blktests test to grow dynamically in case the add_disk()
paths grows.

We currently enable 11 code paths on add_disk() which can fail
and we can test for:

	# ls -1 /sys/kernel/debug/block/config_fail_add_disk/
	alloc_devt
	alloc_events
	bdi_register
	device_add
	disk_add_events
	get_queue
	integrity_add
	register_disk
	register_queue
	sysfs_bdi_link
	sysfs_depr_link

If you want to modify the configuration of fail_add_disk dynamically
at boot, you can enable CONFIG_FAULT_INJECTION_DEBUG_FS. If you've
enabled CONFIG_FAIL_ADD_DISK you will see these knobs:

	# ls -1 /sys/kernel/debug/block/fail_add_disk/
	interval
	probability
	space
	task-filter
	times
	verbose
	verbose_ratelimit_burst
	verbose_ratelimit_interval_ms

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 .../fault-injection/fault-injection.rst       | 23 ++++++++
 block/Makefile                                |  1 +
 block/blk-core.c                              |  1 +
 block/blk.h                                   | 55 ++++++++++++++++++
 block/failure-injection.c                     | 54 ++++++++++++++++++
 block/genhd.c                                 | 57 +++++++++++++++++++
 lib/Kconfig.debug                             | 13 +++++
 7 files changed, 204 insertions(+)
 create mode 100644 block/failure-injection.c

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 31ecfe44e5b4..129f41b9a581 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -24,6 +24,29 @@ Available fault injection capabilities
 
   injects futex deadlock and uaddr fault errors.
 
+- fail_add_disk
+
+  allows error injection to the block layer's add_disk() call path. Enabling
+  this at boot doesn't immediately force errors, you have to then select post
+  boot where in the add_disk() code path you want a failure to be triggered.
+  The following code paths are supported:
+
+  # ls -1 /sys/kernel/debug/block/config_fail_add_disk/
+  alloc_devt
+  alloc_events
+  bdi_register
+  device_add
+  disk_add_events
+  get_queue
+  integrity_add
+  register_disk
+  register_queue
+  sysfs_bdi_link
+  sysfs_depr_link
+
+  If you enable CONFIG_FAULT_INJECTION_DEBUG_FS the fail_add_disk failure
+  injection parameters are placed under /sys/kernel/debug/block/fail_add_disk/
+
 - fail_make_request
 
   injects disk IO errors on devices permitted by setting
diff --git a/block/Makefile b/block/Makefile
index 8d841f5f986f..1589bffe2528 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o
 
+obj-$(CONFIG_FAIL_ADD_DISK)	+= failure-injection.o
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o
 obj-$(CONFIG_BLK_DEV_BSG)	+= bsg.o
diff --git a/block/blk-core.c b/block/blk-core.c
index 9bcdae93f6d4..657da4ae7d35 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1797,6 +1797,7 @@ int __init blk_dev_init(void)
 			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
 
 	blk_debugfs_root = debugfs_create_dir("block", NULL);
+	blk_init_add_disk_fail();
 
 	return 0;
 }
diff --git a/block/blk.h b/block/blk.h
index 01ec7aba8d70..b92972433f86 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -344,6 +344,61 @@ static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
 static inline void blk_queue_clear_zone_settings(struct request_queue *q) {}
 #endif
 
+#ifdef CONFIG_FAIL_ADD_DISK
+
+/**
+ * struct blk_add_disk_fail - configuration for add disk failure injection
+ *
+ * You can enable add_disk() failure injection on boot, but the add_disk()
+ * path is quite large. In order to support allowing configuration of where
+ * exactly on that add_disk() we want to fail, we use a debugfs directory.
+
+ * By default enabling add_disk() failure on boot won't produce any failures,
+ * after boot you must enable at least one of the debugfs knobs. Kernel warnings
+ * which would typically happen on the block layer are supressed when using
+ * error injection.
+ *
+ * @get_queue: mimics a failure on the first blk_get_queue() at the beginning of
+ *	the add_disk() call chain.
+ * @alloc_devt: mimics a failure as if blk_alloc_devt() had failed
+ * @alloc_events: mimics failure as if disk_alloc_events() had failed
+ * @bdi_register: mimics failure as if bdi_register() had failed
+ * @register_disk: mimics failure as if register_disk() had failed
+ * @device_add: mimics failure as if the core device_add() call had failed
+ * @sysfs_depr_link: mimics failure as if creating the now deprecated sysfs
+ *	device link with sysfs_create_link() had failed.
+ * @sysfs_bdi_link: mimics failure as if creating the bdi link with
+ *	sysfs_create_link() had failed
+ * @register_queue: mimics failure on blk_register_queue()
+ * @disk_add_events: mimics failure on disk_add_events()
+ * @integrity_add: mimics failure on blk_integrity_add() at the very end
+ *	of the add_disk() call chain.
+ */
+struct blk_config_add_disk_fail {
+	bool get_queue;
+	bool alloc_devt;
+	bool alloc_events;
+	bool bdi_register;
+	bool register_disk;
+	bool device_add;
+	bool sysfs_depr_link;
+	bool sysfs_bdi_link;
+	bool register_queue;
+	bool disk_add_events;
+	bool integrity_add;
+};
+
+extern struct blk_config_add_disk_fail blk_config_add_disk_fail;
+
+void blk_init_add_disk_fail(void);
+#define blk_should_fail_add_disk(path_name) \
+	__blk_should_fail_add_disk(blk_config_add_disk_fail.path_name)
+int __blk_should_fail_add_disk(bool evaluate);
+#else
+static inline void blk_init_add_disk_fail(void) {}
+#define blk_should_fail_add_disk(path_name) (false)
+#endif
+
 int blk_alloc_devt(struct block_device *part, dev_t *devt);
 void blk_free_devt(dev_t devt);
 char *disk_name(struct gendisk *hd, int partno, char *buf);
diff --git a/block/failure-injection.c b/block/failure-injection.c
new file mode 100644
index 000000000000..ba7717192eaa
--- /dev/null
+++ b/block/failure-injection.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/fault-inject.h>
+
+#include "blk.h"
+
+static DECLARE_FAULT_ATTR(fail_add_disk);
+struct blk_config_add_disk_fail blk_config_add_disk_fail;
+
+static int __init setup_fail_add_disk(char *str)
+{
+	return setup_fault_attr(&fail_add_disk, str);
+}
+
+__setup("fail_blk_add_disk=", setup_fail_add_disk);
+
+struct dentry *config_fail_add_disk;
+
+void blk_init_add_disk_fail(void)
+{
+	fault_create_debugfs_attr("fail_add_disk", blk_debugfs_root, &fail_add_disk);
+	config_fail_add_disk = debugfs_create_dir("config_fail_add_disk", blk_debugfs_root);
+
+	debugfs_create_bool("get_queue", 0600, config_fail_add_disk,
+			    &blk_config_add_disk_fail.get_queue);
+	debugfs_create_bool("alloc_devt", 0600, config_fail_add_disk,
+			    &blk_config_add_disk_fail.alloc_devt);
+	debugfs_create_bool("alloc_events", 0600, config_fail_add_disk,
+			    &blk_config_add_disk_fail.alloc_events);
+	debugfs_create_bool("bdi_register", 0600, config_fail_add_disk,
+			    &blk_config_add_disk_fail.bdi_register);
+	debugfs_create_bool("register_disk", 0600, config_fail_add_disk,
+			    &blk_config_add_disk_fail.register_disk);
+	debugfs_create_bool("device_add", 0600, config_fail_add_disk,
+			    &blk_config_add_disk_fail.device_add);
+	debugfs_create_bool("sysfs_depr_link", 0600, config_fail_add_disk,
+			    &blk_config_add_disk_fail.sysfs_depr_link);
+	debugfs_create_bool("sysfs_bdi_link", 0600, config_fail_add_disk,
+			    &blk_config_add_disk_fail.sysfs_bdi_link);
+	debugfs_create_bool("register_queue", 0600, config_fail_add_disk,
+			    &blk_config_add_disk_fail.register_queue);
+	debugfs_create_bool("disk_add_events", 0600, config_fail_add_disk,
+			    &blk_config_add_disk_fail.disk_add_events);
+	debugfs_create_bool("integrity_add", 0600, config_fail_add_disk,
+			    &blk_config_add_disk_fail.integrity_add);
+}
+
+int __blk_should_fail_add_disk(bool evaluate)
+{
+	if (!evaluate)
+		return 0;
+
+	return should_fail(&fail_add_disk, 0);
+}
diff --git a/block/genhd.c b/block/genhd.c
index eafcd256fc6f..27b4b446cf3e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -24,6 +24,7 @@
 #include <linux/log2.h>
 #include <linux/pm_runtime.h>
 #include <linux/badblocks.h>
+#include <linux/fault-inject.h>
 
 #include "blk.h"
 
@@ -512,6 +513,10 @@ static int __must_check register_disk(struct device *parent,
 		WARN_ON(ddev->groups);
 		ddev->groups = groups;
 	}
+
+	if (blk_should_fail_add_disk(device_add))
+		return -ENOMEM;
+
 	err = device_add(ddev);
 	if (err) {
 		/*
@@ -521,7 +526,14 @@ static int __must_check register_disk(struct device *parent,
 		 */
 		return err;
 	}
+
+
 	if (!sysfs_deprecated) {
+		if (blk_should_fail_add_disk(sysfs_depr_link)) {
+			err = -ENOMEM;
+			goto exit_del_device;
+		}
+
 		err = sysfs_create_link(block_depr, &ddev->kobj,
 					kobject_name(&ddev->kobj));
 		if (err)
@@ -546,6 +558,11 @@ static int __must_check register_disk(struct device *parent,
 	disk_announce(disk);
 
 	if (disk->queue->backing_dev_info->dev) {
+		if (blk_should_fail_add_disk(sysfs_bdi_link)) {
+			err = -ENOMEM;
+			goto exit_del_block_depr;
+		}
+
 		err = sysfs_create_link(&ddev->kobj,
 			  &disk->queue->backing_dev_info->dev->kobj,
 			  "bdi");
@@ -582,6 +599,11 @@ static int __device_add_disk(struct device *parent, struct gendisk *disk,
 	dev_t devt;
 	int retval;
 
+	if (blk_should_fail_add_disk(get_queue)) {
+		disk->queue = NULL;
+		return -ESHUTDOWN;
+	}
+
 	/*
 	 * Take an extra ref on queue which will be put on disk_release()
 	 * so that it sticks around as long as @disk is there. The driver
@@ -614,6 +636,9 @@ static int __device_add_disk(struct device *parent, struct gendisk *disk,
 
 	disk->flags |= GENHD_FL_UP;
 
+	if (blk_should_fail_add_disk(alloc_devt))
+		return -EINVAL;
+
 	retval = blk_alloc_devt(disk->part0, &devt);
 	if (WARN_ON(retval))
 		return retval;
@@ -621,6 +646,11 @@ static int __device_add_disk(struct device *parent, struct gendisk *disk,
 	disk->major = MAJOR(devt);
 	disk->first_minor = MINOR(devt);
 
+	if (blk_should_fail_add_disk(alloc_events)) {
+		retval = -ENOMEM;
+		goto exit_blk_free_devt;
+	}
+
 	retval = disk_alloc_events(disk);
 	if (retval)
 		goto exit_blk_free_devt;
@@ -638,26 +668,53 @@ static int __device_add_disk(struct device *parent, struct gendisk *disk,
 
 		/* Register BDI before referencing it from bdev */
 		dev->devt = devt;
+
+		if (blk_should_fail_add_disk(bdi_register)) {
+			retval = -ENOMEM;
+			goto exit_disk_release_events;
+		}
+
 		retval = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
 		if (WARN_ON(retval))
 			goto exit_disk_release_events;
 		bdi_set_owner(bdi, dev);
 		bdev_add(disk->part0, devt);
 	}
+
+	if (blk_should_fail_add_disk(register_disk)) {
+		retval = -ENOMEM;
+		goto exit_unregister_bdi;
+	}
+
 	retval = register_disk(parent, disk, groups);
 	if (retval)
 		goto exit_unregister_bdi;
 
+	if (blk_should_fail_add_disk(register_queue)) {
+		retval = -ENOMEM;
+		goto exit_unregister_disk;
+	}
+
 	if (register_queue) {
 		retval = blk_register_queue(disk);
 		if (retval)
 			goto exit_unregister_disk;
 	}
 
+	if (blk_should_fail_add_disk(disk_add_events)) {
+		retval = -ENOMEM;
+		goto exit_unregister_disk;
+	}
+
 	retval = disk_add_events(disk);
 	if (retval)
 		goto exit_unregister_disk;
 
+	if (blk_should_fail_add_disk(integrity_add)) {
+		retval = -ENOMEM;
+		goto exit_del_events;
+	}
+
 	retval = blk_integrity_add(disk);
 	if (retval)
 		goto exit_del_events;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d1467658361f..4fccc0fad190 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1917,6 +1917,19 @@ config FAULT_INJECTION_USERCOPY
 	  Provides fault-injection capability to inject failures
 	  in usercopy functions (copy_from_user(), get_user(), ...).
 
+config FAIL_ADD_DISK
+	bool "Fault-injection capability for add_disk() callers"
+	depends on FAULT_INJECTION && BLOCK
+	help
+	  Provide fault-injection capability for the add_disk() block layer
+	  call path. This allows the kernel to provide error injection when
+	  the add_disk() call is made. You would use something like blktests
+	  test against this or just load the null_blk driver. This only
+	  enables the error injection functionality. To use it you must
+	  configure which path you want to trigger on error on using debugfs
+	  under /sys/kernel/debug/block/config_fail_add_disk/. By default
+	  all of these are disabled.
+
 config FAIL_MAKE_REQUEST
 	bool "Fault-injection capability for disk IO"
 	depends on FAULT_INJECTION && BLOCK
-- 
2.30.2

