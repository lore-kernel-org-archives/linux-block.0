Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD1CC43461
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 01:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA5A961452
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 01:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbhDWBLx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 21:11:53 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:35768 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240081AbhDWBLu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 21:11:50 -0400
Received: by mail-pj1-f44.google.com with SMTP id j14-20020a17090a694eb0290152d92c205dso351459pjm.0;
        Thu, 22 Apr 2021 18:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9LeJMxuTv2FInuFWpcglqfZXx99esYoti6U+jDOAmQo=;
        b=EqNA14PoyZrdZaaBudBiO1pSr4trMJaViOeCFkXzytJmzyq+PiQdGAuoJo8dWXKcz3
         M22qprTLdzNOkQe4KR+DYjZxk/LTN2xrYqAmPTfAuciXpvySm9GZ1n22V+9pHKwb3AQH
         pPlDW3ZzO3mQ6tuxgUGqTUvjcvmWLdQWhFWu20EBfBO5sFVaawgXMmmbjuFvC2FjJG3R
         MOopNUOYXfKbzmvlzQVFAmgkuoYB9GKBS3gqrsiem3wt3hQr0jdHmUfgxP/Gc7jCpL/4
         0r71+bcpq3pa3+RFZMi8GJWi67O4tlDEUQuBpzV1zvJHc7zW8fw01bdJ17+MN0UPoh21
         Ickw==
X-Gm-Message-State: AOAM5335wUlR6H6j/V7vRk9qc0wqmtpnBponTG8wVZkmKkLH1gdbo0JV
        cvDPA6Ui680GMx+bNOVgK3M=
X-Google-Smtp-Source: ABdhPJyeu9ew6G7uXeSCGgPSfWA2jerFHmHAq8CfkhfqixTt9YUf14TFbnxHlv+IMworlBwCtwf/rw==
X-Received: by 2002:a17:903:1ca:b029:ea:fc69:b6ed with SMTP id e10-20020a17090301cab02900eafc69b6edmr1552165plh.80.1619140274749;
        Thu, 22 Apr 2021 18:11:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t23sm3184654pju.15.2021.04.22.18.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 18:11:10 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 630F541D25; Fri, 23 Apr 2021 01:11:09 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     mcgrof@kernel.org, axboe@kernel.dk, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] zram: fix deadlock with sysfs attribute usage and driver removal
Date:   Fri, 23 Apr 2021 01:11:07 +0000
Message-Id: <20210423011108.11988-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210423011108.11988-1-mcgrof@kernel.org>
References: <20210423011108.11988-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When sysfs attributes use a lock also used on driver removal we can
potentially deadlock. This happens when for instance a sysfs file on
a driver is used, then at the same time we have driver removal trigger.
The driver removal code holds a lock, and then the sysfs file entry waits
for the same lock. While holding the lock the driver removal tries to
remove the sysfs entries, but these cannot be removed yet as one is
waiting for a lock. This won't complete as the lock is already held.
Likewise module removal cannot complete, and so we deadlock.

To fix this we just *try* to get a refcount to the module when a shared
lock is used, prior to mucking with a sysfs attribute. If this fails we
just give up right away.

We use a try method as a full lock means we'd then make our sysfs attributes
busy us out from possible module removal. A try lock on the module removal
ensures we give priority to module removal and interacting with sysfs
attributes only comes second. Using a full lock could mean for instance
that if you don't stop poking at sysfs files you cannot remove a module.

Demo of a deadlock with the zram driver:

CPU A                              CPU B
                                   whatever_store()
module_unload
  mutex_lock(foo)
                                   mutex_lock(foo)
   del_gendisk(zram->disk);
     device_del()
       device_remove_groups()

In this situation whatever_store() is waiting for the mutex foo to
become unlocked, but that won't happen until module removal is complete.
But module removal won't complete until the syfs file being poked completes
which is waiting for a lock already held.

This is a generic kernel issue with sysfs files which use any lock also
used on module removal. A generic solution has been proposed [0] however
there is no interest in having this upstream at this point, so we must
open code this on drivers which have this pattern of shared locks.

This issue can be reproduced easily on the zram driver as follows:

Loop 1 on one terminal:

while true;
	do modprobe zram;
	modprobe -r zram;
done

Loop 2 on a second terminal:
while true; do
	echo 1024 >  /sys/block/zram0/disksize;
	echo 1 > /sys/block/zram0/reset;
done

Without this patch we end up in a deadlock, and the following
stack trace is produced which hints to us what the issue was:

INFO: task bash:888 blocked for more than 120 seconds.
      Tainted: G            E 5.12.0-rc1-next-20210304+ #4
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:bash            state:D stack:    0 pid:  888 ppid: 887 flags:0x00000004
Call Trace:
 __schedule+0x2e4/0x900
 schedule+0x46/0xb0
 schedule_preempt_disabled+0xa/0x10
 __mutex_lock.constprop.0+0x2c3/0x490
 ? _kstrtoull+0x35/0xd0
 reset_store+0x6c/0x160 [zram]
 kernfs_fop_write_iter+0x124/0x1b0
 new_sync_write+0x11c/0x1b0
 vfs_write+0x1c2/0x260
 ksys_write+0x5f/0xe0
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f34f2c3df33
RSP: 002b:00007ffe751df6e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f34f2c3df33
RDX: 0000000000000002 RSI: 0000561ccb06ec10 RDI: 0000000000000001
RBP: 0000561ccb06ec10 R08: 000000000000000a R09: 0000000000000001
R10: 0000561ccb157590 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f34f2d0e6a0 R14: 0000000000000002 R15: 00007f34f2d0e8a0
INFO: task modprobe:1104 can't die for more than 120 seconds.
task:modprobe        state:D stack:    0 pid: 1104 ppid: 916 flags:0x00004004
Call Trace:
 __schedule+0x2e4/0x900
 schedule+0x46/0xb0
 __kernfs_remove.part.0+0x228/0x2b0
 ? finish_wait+0x80/0x80
 kernfs_remove_by_name_ns+0x50/0x90
 remove_files+0x2b/0x60
 sysfs_remove_group+0x38/0x80
 sysfs_remove_groups+0x29/0x40
 device_remove_attrs+0x4a/0x80
 device_del+0x183/0x3e0
 ? mutex_lock+0xe/0x30
 del_gendisk+0x27a/0x2d0
 zram_remove+0x8a/0xb0 [zram]
 ? hot_remove_store+0xf0/0xf0 [zram]
 zram_remove_cb+0xd/0x10 [zram]
 idr_for_each+0x5e/0xd0
 destroy_devices+0x39/0x6f [zram]
 __do_sys_delete_module+0x190/0x2a0
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f32adf727d7
RSP: 002b:00007ffc08bb38a8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
RAX: ffffffffffffffda RBX: 000055eea23cbb10 RCX: 00007f32adf727d7
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055eea23cbb78
RBP: 000055eea23cbb10 R08: 0000000000000000 R09: 0000000000000000
R10: 00007f32adfe5ac0 R11: 0000000000000206 R12: 000055eea23cbb78
R13: 0000000000000000 R14: 0000000000000000 R15: 000055eea23cbc20

[0] https://lkml.kernel.org/r/20210401235925.GR4332@42.do-not-panic.com

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/zram/zram_drv.c | 158 ++++++++++++++++++++++++++++++----
 1 file changed, 139 insertions(+), 19 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6051d20b88c3..701ed28da125 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -239,10 +239,15 @@ static ssize_t initstate_show(struct device *dev,
 	u32 val;
 	struct zram *zram = dev_to_zram(dev);
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	down_read(&zram->init_lock);
 	val = init_done(zram);
 	up_read(&zram->init_lock);
 
+	module_put(THIS_MODULE);
+
 	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
 }
 
@@ -250,8 +255,16 @@ static ssize_t disksize_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct zram *zram = dev_to_zram(dev);
+	u64 disksize;
+
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", zram->disksize);
+	disksize = zram->disksize;
+
+	module_put(THIS_MODULE);
+
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", disksize);
 }
 
 static ssize_t mem_limit_store(struct device *dev,
@@ -261,14 +274,23 @@ static ssize_t mem_limit_store(struct device *dev,
 	char *tmp;
 	struct zram *zram = dev_to_zram(dev);
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	limit = memparse(buf, &tmp);
-	if (buf == tmp) /* no chars parsed, invalid input */
-		return -EINVAL;
+
+	/* no chars parsed, invalid input */
+	if (buf == tmp) {
+		len = -EINVAL;
+		goto out;
+	}
 
 	down_write(&zram->init_lock);
 	zram->limit_pages = PAGE_ALIGN(limit) >> PAGE_SHIFT;
 	up_write(&zram->init_lock);
 
+out:
+	module_put(THIS_MODULE);
 	return len;
 }
 
@@ -283,6 +305,9 @@ static ssize_t mem_used_max_store(struct device *dev,
 	if (err || val != 0)
 		return -EINVAL;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	down_read(&zram->init_lock);
 	if (init_done(zram)) {
 		atomic_long_set(&zram->stats.max_used_pages,
@@ -290,6 +315,8 @@ static ssize_t mem_used_max_store(struct device *dev,
 	}
 	up_read(&zram->init_lock);
 
+	module_put(THIS_MODULE);
+
 	return len;
 }
 
@@ -303,10 +330,13 @@ static ssize_t idle_store(struct device *dev,
 	if (!sysfs_streq(buf, "all"))
 		return -EINVAL;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	down_read(&zram->init_lock);
 	if (!init_done(zram)) {
-		up_read(&zram->init_lock);
-		return -EINVAL;
+		len = -EINVAL;
+		goto out;
 	}
 
 	for (index = 0; index < nr_pages; index++) {
@@ -321,8 +351,9 @@ static ssize_t idle_store(struct device *dev,
 		zram_slot_unlock(zram, index);
 	}
 
+out:
 	up_read(&zram->init_lock);
-
+	module_put(THIS_MODULE);
 	return len;
 }
 
@@ -337,6 +368,9 @@ static ssize_t writeback_limit_enable_store(struct device *dev,
 	if (kstrtoull(buf, 10, &val))
 		return ret;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	down_read(&zram->init_lock);
 	spin_lock(&zram->wb_limit_lock);
 	zram->wb_limit_enable = val;
@@ -344,6 +378,8 @@ static ssize_t writeback_limit_enable_store(struct device *dev,
 	up_read(&zram->init_lock);
 	ret = len;
 
+	module_put(THIS_MODULE);
+
 	return ret;
 }
 
@@ -353,12 +389,17 @@ static ssize_t writeback_limit_enable_show(struct device *dev,
 	bool val;
 	struct zram *zram = dev_to_zram(dev);
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	down_read(&zram->init_lock);
 	spin_lock(&zram->wb_limit_lock);
 	val = zram->wb_limit_enable;
 	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);
 
+	module_put(THIS_MODULE);
+
 	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
@@ -372,6 +413,9 @@ static ssize_t writeback_limit_store(struct device *dev,
 	if (kstrtoull(buf, 10, &val))
 		return ret;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	down_read(&zram->init_lock);
 	spin_lock(&zram->wb_limit_lock);
 	zram->bd_wb_limit = val;
@@ -379,6 +423,8 @@ static ssize_t writeback_limit_store(struct device *dev,
 	up_read(&zram->init_lock);
 	ret = len;
 
+	module_put(THIS_MODULE);
+
 	return ret;
 }
 
@@ -388,12 +434,17 @@ static ssize_t writeback_limit_show(struct device *dev,
 	u64 val;
 	struct zram *zram = dev_to_zram(dev);
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	down_read(&zram->init_lock);
 	spin_lock(&zram->wb_limit_lock);
 	val = zram->bd_wb_limit;
 	spin_unlock(&zram->wb_limit_lock);
 	up_read(&zram->init_lock);
 
+	module_put(THIS_MODULE);
+
 	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
 }
 
@@ -423,12 +474,15 @@ static ssize_t backing_dev_show(struct device *dev,
 	char *p;
 	ssize_t ret;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	down_read(&zram->init_lock);
 	file = zram->backing_dev;
 	if (!file) {
 		memcpy(buf, "none\n", 5);
-		up_read(&zram->init_lock);
-		return 5;
+		ret = 5;
+		goto out;
 	}
 
 	p = file_path(file, buf, PAGE_SIZE - 1);
@@ -442,6 +496,7 @@ static ssize_t backing_dev_show(struct device *dev,
 	buf[ret++] = '\n';
 out:
 	up_read(&zram->init_lock);
+	module_put(THIS_MODULE);
 	return ret;
 }
 
@@ -459,9 +514,14 @@ static ssize_t backing_dev_store(struct device *dev,
 	int err;
 	struct zram *zram = dev_to_zram(dev);
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	file_name = kmalloc(PATH_MAX, GFP_KERNEL);
-	if (!file_name)
-		return -ENOMEM;
+	if (!file_name) {
+		err = -ENOMEM;
+		goto out_module;
+	}
 
 	down_write(&zram->init_lock);
 	if (init_done(zram)) {
@@ -529,6 +589,7 @@ static ssize_t backing_dev_store(struct device *dev,
 
 	pr_info("setup backing device %s\n", file_name);
 	kfree(file_name);
+	module_put(THIS_MODULE);
 
 	return len;
 out:
@@ -543,7 +604,8 @@ static ssize_t backing_dev_store(struct device *dev,
 	up_write(&zram->init_lock);
 
 	kfree(file_name);
-
+out_module:
+	module_put(THIS_MODULE);
 	return err;
 }
 
@@ -628,26 +690,31 @@ static ssize_t writeback_store(struct device *dev,
 	struct bio bio;
 	struct bio_vec bio_vec;
 	struct page *page;
-	ssize_t ret = len;
+	ssize_t ret = -EINVAL;
 	int mode, err;
 	unsigned long blk_idx = 0;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	if (sysfs_streq(buf, "idle"))
 		mode = IDLE_WRITEBACK;
 	else if (sysfs_streq(buf, "huge"))
 		mode = HUGE_WRITEBACK;
 	else {
 		if (strncmp(buf, PAGE_WB_SIG, sizeof(PAGE_WB_SIG) - 1))
-			return -EINVAL;
+			goto out;
 
 		if (kstrtol(buf + sizeof(PAGE_WB_SIG) - 1, 10, &index) ||
 				index >= nr_pages)
-			return -EINVAL;
+			goto out;
 
 		nr_pages = 1;
 		mode = PAGE_WRITEBACK;
 	}
 
+	ret = len;
+
 	down_read(&zram->init_lock);
 	if (!init_done(zram)) {
 		ret = -EINVAL;
@@ -781,6 +848,8 @@ static ssize_t writeback_store(struct device *dev,
 	__free_page(page);
 release_init_lock:
 	up_read(&zram->init_lock);
+out:
+	module_put(THIS_MODULE);
 
 	return ret;
 }
@@ -990,10 +1059,15 @@ static ssize_t comp_algorithm_show(struct device *dev,
 	size_t sz;
 	struct zram *zram = dev_to_zram(dev);
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	down_read(&zram->init_lock);
 	sz = zcomp_available_show(zram->compressor, buf);
 	up_read(&zram->init_lock);
 
+	module_put(THIS_MODULE);
+
 	return sz;
 }
 
@@ -1013,15 +1087,20 @@ static ssize_t comp_algorithm_store(struct device *dev,
 	if (!zcomp_available_algorithm(compressor))
 		return -EINVAL;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	down_write(&zram->init_lock);
 	if (init_done(zram)) {
-		up_write(&zram->init_lock);
 		pr_info("Can't change algorithm for initialized device\n");
-		return -EBUSY;
+		len = -EBUSY;
+		goto out;
 	}
 
 	strcpy(zram->compressor, compressor);
+out:
 	up_write(&zram->init_lock);
+	module_put(THIS_MODULE);
 	return len;
 }
 
@@ -1030,14 +1109,19 @@ static ssize_t compact_store(struct device *dev,
 {
 	struct zram *zram = dev_to_zram(dev);
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	down_read(&zram->init_lock);
 	if (!init_done(zram)) {
-		up_read(&zram->init_lock);
-		return -EINVAL;
+		len = -EINVAL;
+		goto out;
 	}
 
 	zs_compact(zram->mem_pool);
+out:
 	up_read(&zram->init_lock);
+	module_put(THIS_MODULE);
 
 	return len;
 }
@@ -1048,6 +1132,9 @@ static ssize_t io_stat_show(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	ssize_t ret;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	down_read(&zram->init_lock);
 	ret = scnprintf(buf, PAGE_SIZE,
 			"%8llu %8llu %8llu %8llu\n",
@@ -1056,6 +1143,7 @@ static ssize_t io_stat_show(struct device *dev,
 			(u64)atomic64_read(&zram->stats.invalid_io),
 			(u64)atomic64_read(&zram->stats.notify_free));
 	up_read(&zram->init_lock);
+	module_put(THIS_MODULE);
 
 	return ret;
 }
@@ -1071,6 +1159,9 @@ static ssize_t mm_stat_show(struct device *dev,
 
 	memset(&pool_stats, 0x00, sizeof(struct zs_pool_stats));
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	down_read(&zram->init_lock);
 	if (init_done(zram)) {
 		mem_used = zs_get_total_pages(zram->mem_pool);
@@ -1092,6 +1183,7 @@ static ssize_t mm_stat_show(struct device *dev,
 			(u64)atomic64_read(&zram->stats.huge_pages),
 			(u64)atomic64_read(&zram->stats.huge_pages_since));
 	up_read(&zram->init_lock);
+	module_put(THIS_MODULE);
 
 	return ret;
 }
@@ -1104,6 +1196,9 @@ static ssize_t bd_stat_show(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	ssize_t ret;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	down_read(&zram->init_lock);
 	ret = scnprintf(buf, PAGE_SIZE,
 		"%8llu %8llu %8llu\n",
@@ -1112,6 +1207,7 @@ static ssize_t bd_stat_show(struct device *dev,
 			FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
 	up_read(&zram->init_lock);
 
+	module_put(THIS_MODULE);
 	return ret;
 }
 #endif
@@ -1123,6 +1219,9 @@ static ssize_t debug_stat_show(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	ssize_t ret;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	down_read(&zram->init_lock);
 	ret = scnprintf(buf, PAGE_SIZE,
 			"version: %d\n%8llu %8llu\n",
@@ -1131,6 +1230,8 @@ static ssize_t debug_stat_show(struct device *dev,
 			(u64)atomic64_read(&zram->stats.miss_free));
 	up_read(&zram->init_lock);
 
+	module_put(THIS_MODULE);
+
 	return ret;
 }
 
@@ -1727,6 +1828,9 @@ static ssize_t disksize_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	int err;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	mutex_lock(&zram_index_mutex);
 
 	if (!zram_up || zram->claim) {
@@ -1767,6 +1871,7 @@ static ssize_t disksize_store(struct device *dev,
 	up_write(&zram->init_lock);
 
 	mutex_unlock(&zram_index_mutex);
+	module_put(THIS_MODULE);
 
 	return len;
 
@@ -1776,6 +1881,7 @@ static ssize_t disksize_store(struct device *dev,
 	up_write(&zram->init_lock);
 out:
 	mutex_unlock(&zram_index_mutex);
+	module_put(THIS_MODULE);
 	return err;
 }
 
@@ -1791,6 +1897,9 @@ static ssize_t reset_store(struct device *dev,
 	if (ret)
 		return ret;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	mutex_lock(&zram_index_mutex);
 
 	if (!zram_up) {
@@ -1828,6 +1937,7 @@ static ssize_t reset_store(struct device *dev,
 
 out:
 	mutex_unlock(&zram_index_mutex);
+	module_put(THIS_MODULE);
 	return len;
 }
 
@@ -2048,13 +2158,19 @@ static ssize_t hot_add_show(struct class *class,
 {
 	int ret;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	mutex_lock(&zram_index_mutex);
 	if (!zram_up) {
 		mutex_unlock(&zram_index_mutex);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 	ret = zram_add();
+out:
 	mutex_unlock(&zram_index_mutex);
+	module_put(THIS_MODULE);
 
 	if (ret < 0)
 		return ret;
@@ -2078,6 +2194,9 @@ static ssize_t hot_remove_store(struct class *class,
 	if (dev_id < 0)
 		return -EINVAL;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	mutex_lock(&zram_index_mutex);
 
 	if (!zram_up) {
@@ -2096,6 +2215,7 @@ static ssize_t hot_remove_store(struct class *class,
 
 out:
 	mutex_unlock(&zram_index_mutex);
+	module_put(THIS_MODULE);
 	return ret ? ret : count;
 }
 static CLASS_ATTR_WO(hot_remove);
-- 
2.27.0

