Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73935C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 21:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B1561027
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 21:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFVVWL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 17:22:11 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:52012 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFVVWI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 17:22:08 -0400
Received: by mail-pj1-f52.google.com with SMTP id k5so207935pjj.1;
        Tue, 22 Jun 2021 14:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2frTypS8jzvE25E/JhRac4sAEWhy0zXFylo5BFcTuxo=;
        b=CwhGOnn9rosg2aUrZpzwEgG37YJ3nQ9P/1jwdgXmwl4DsANcXx0hAAubYAv/bO939p
         wlcIEp58LSthJo/Js3AhraHJ34DVXvlR2n9CAYWD3qtcSkeVC6VSOo3ghnrz+QqV3ffS
         ue66JDlB2eI32/26NYJctyqfbs+yCfQR5eBThxCu3pUW9ClPjGH4tY9dwjOQ6pQlb+GG
         gyfFfqeiFj0jTREthVFdJwWZY99wkZKw/6vE1OyJWfAApQhvU+9jvmWxCVVEEqAZWHPu
         NpzyWJT9n55uY3OngkFuKqsXUexOdOb0luS3Y5+StTXMYeyWmm5fghpRnbg3HGahxgx5
         41nw==
X-Gm-Message-State: AOAM531q3YIWC9xws1JIMtGZN1y9WNMJ32+ZSKxDoAHmB8uCg/47CNC2
        jJ2Z4OpFiek2rpmBYK+tl9E=
X-Google-Smtp-Source: ABdhPJyD/D8PR7mf2QmJkcAZFu94EfujXUthIYvO+iWgz731ik1kBPEH3CjEhsQdjVY4l+wn4xcaxA==
X-Received: by 2002:a17:902:eac2:b029:107:b14c:423d with SMTP id p2-20020a170902eac2b0290107b14c423dmr9410852pld.77.1624396791079;
        Tue, 22 Jun 2021 14:19:51 -0700 (PDT)
Received: from localhost ([173.239.198.97])
        by smtp.gmail.com with ESMTPSA id o8sm239198pfp.48.2021.06.22.14.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 14:19:50 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     minchan@kernel.org, gregkh@linuxfoundation.org, jeyu@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        rafael@kernel.org
Cc:     mcgrof@kernel.org, axboe@kernel.dk, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] zram: fix deadlock with sysfs attribute usage and module removal
Date:   Tue, 22 Jun 2021 14:19:41 -0700
Message-Id: <20210622211941.3754857-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210622211941.3754857-1-mcgrof@kernel.org>
References: <20210622211941.3754857-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When sysfs attributes use a lock also used on module removal we can
potentially deadlock. This happens when for instance a sysfs file on
a driver is used, then at the same time we have module removal call trigger.
The module removal call code holds a lock, and then the sysfs file entry waits
for the same lock. While holding the lock the module removal tries to
remove the sysfs entries, but these cannot be removed yet as one is
waiting for a lock. This won't complete as the lock is already held.
Likewise module removal cannot complete, and so we deadlock.

To fix this we just *try* to get a refcount to the module when a shared
lock is used, prior to mucking with a sysfs attribute. If this fails we
just give up right away.

We use a try method as a full lock means we'd then make our sysfs attributes
busy us out from possible module removal, and so userspace could force denying
module removal, a silly form of "DOS" against module removal. A try lock on
the module removal ensures we give priority to module removal and interacting
with sysfs attributes only comes second. Using a full lock could mean for
instance that if you don't stop poking at sysfs files you cannot remove a
module.

This deadlock was first reported with the zram driver, a sketch of how
this can happen follows:

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
used on module removal. Different generic solutions have been proposed.
One approach proposed is by directly by augmenting attributes with module
information [0]. This patch implements a solution by adding macros with
the prefix MODULE_DEVICE_ATTR_*() which accomplish the same. Until we
don't have a generic agreed upon solution for this shared between drivers,
we must implement a fix for this on each driver.

We make zram use the new MODULE_DEVICE_ATTR_*() helpers, and completely
open code the solution for class attributes as there are only a few of
those.

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
 drivers/block/zram/zram_drv.c | 80 ++++++++++++++++++++---------------
 drivers/block/zram/zram_drv.h | 40 ++++++++++++++++++
 2 files changed, 85 insertions(+), 35 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 27caef0d6b4d..d2e61abdd1b9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1134,12 +1134,12 @@ static ssize_t debug_stat_show(struct device *dev,
 	return ret;
 }
 
-static DEVICE_ATTR_RO(io_stat);
-static DEVICE_ATTR_RO(mm_stat);
+MODULE_DEVICE_ATTR_RO(io_stat);
+MODULE_DEVICE_ATTR_RO(mm_stat);
 #ifdef CONFIG_ZRAM_WRITEBACK
-static DEVICE_ATTR_RO(bd_stat);
+MODULE_DEVICE_ATTR_RO(bd_stat);
 #endif
-static DEVICE_ATTR_RO(debug_stat);
+MODULE_DEVICE_ATTR_RO(debug_stat);
 
 static void zram_meta_free(struct zram *zram, u64 disksize)
 {
@@ -1861,44 +1861,44 @@ static const struct block_device_operations zram_wb_devops = {
 	.owner = THIS_MODULE
 };
 
-static DEVICE_ATTR_WO(compact);
-static DEVICE_ATTR_RW(disksize);
-static DEVICE_ATTR_RO(initstate);
-static DEVICE_ATTR_WO(reset);
-static DEVICE_ATTR_WO(mem_limit);
-static DEVICE_ATTR_WO(mem_used_max);
-static DEVICE_ATTR_WO(idle);
-static DEVICE_ATTR_RW(max_comp_streams);
-static DEVICE_ATTR_RW(comp_algorithm);
+MODULE_DEVICE_ATTR_WO(compact);
+MODULE_DEVICE_ATTR_RW(disksize);
+MODULE_DEVICE_ATTR_RO(initstate);
+MODULE_DEVICE_ATTR_WO(reset);
+MODULE_DEVICE_ATTR_WO(mem_limit);
+MODULE_DEVICE_ATTR_WO(mem_used_max);
+MODULE_DEVICE_ATTR_WO(idle);
+MODULE_DEVICE_ATTR_RW(max_comp_streams);
+MODULE_DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
-static DEVICE_ATTR_RW(backing_dev);
-static DEVICE_ATTR_WO(writeback);
-static DEVICE_ATTR_RW(writeback_limit);
-static DEVICE_ATTR_RW(writeback_limit_enable);
+MODULE_DEVICE_ATTR_RW(backing_dev);
+MODULE_DEVICE_ATTR_WO(writeback);
+MODULE_DEVICE_ATTR_RW(writeback_limit);
+MODULE_DEVICE_ATTR_RW(writeback_limit_enable);
 #endif
 
 static struct attribute *zram_disk_attrs[] = {
-	&dev_attr_disksize.attr,
-	&dev_attr_initstate.attr,
-	&dev_attr_reset.attr,
-	&dev_attr_compact.attr,
-	&dev_attr_mem_limit.attr,
-	&dev_attr_mem_used_max.attr,
-	&dev_attr_idle.attr,
-	&dev_attr_max_comp_streams.attr,
-	&dev_attr_comp_algorithm.attr,
+	&dev_attr_module_disksize.attr,
+	&dev_attr_module_initstate.attr,
+	&dev_attr_module_reset.attr,
+	&dev_attr_module_compact.attr,
+	&dev_attr_module_mem_limit.attr,
+	&dev_attr_module_mem_used_max.attr,
+	&dev_attr_module_idle.attr,
+	&dev_attr_module_max_comp_streams.attr,
+	&dev_attr_module_comp_algorithm.attr,
 #ifdef CONFIG_ZRAM_WRITEBACK
-	&dev_attr_backing_dev.attr,
-	&dev_attr_writeback.attr,
-	&dev_attr_writeback_limit.attr,
-	&dev_attr_writeback_limit_enable.attr,
+	&dev_attr_module_backing_dev.attr,
+	&dev_attr_module_writeback.attr,
+	&dev_attr_module_writeback_limit.attr,
+	&dev_attr_module_writeback_limit_enable.attr,
 #endif
-	&dev_attr_io_stat.attr,
-	&dev_attr_mm_stat.attr,
+	&dev_attr_module_io_stat.attr,
+	&dev_attr_module_mm_stat.attr,
 #ifdef CONFIG_ZRAM_WRITEBACK
-	&dev_attr_bd_stat.attr,
+	&dev_attr_module_bd_stat.attr,
 #endif
-	&dev_attr_debug_stat.attr,
+	&dev_attr_module_debug_stat.attr,
 	NULL,
 };
 
@@ -2048,13 +2048,19 @@ static ssize_t hot_add_show(struct class *class,
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
@@ -2078,6 +2084,9 @@ static ssize_t hot_remove_store(struct class *class,
 	if (dev_id < 0)
 		return -EINVAL;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	mutex_lock(&zram_index_mutex);
 
 	if (!zram_up) {
@@ -2096,6 +2105,7 @@ static ssize_t hot_remove_store(struct class *class,
 
 out:
 	mutex_unlock(&zram_index_mutex);
+	module_put(THIS_MODULE);
 	return ret ? ret : count;
 }
 static CLASS_ATTR_WO(hot_remove);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 419a7e8281ee..026eb8d41327 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -126,4 +126,44 @@ struct zram {
 	struct dentry *debugfs_dir;
 #endif
 };
+
+#define MODULE_DEVICE_ATTR_FUNC_STORE(_name) \
+static ssize_t module_ ## _name ## _store(struct device *dev, \
+				   struct device_attribute *attr, \
+				   const char *buf, size_t len) \
+{ \
+	ssize_t __ret; \
+	if (!try_module_get(THIS_MODULE)) \
+		return -ENODEV; \
+	__ret = _name ## _store(dev, attr, buf, len); \
+	module_put(THIS_MODULE); \
+	return __ret; \
+}
+
+#define MODULE_DEVICE_ATTR_FUNC_SHOW(_name) \
+static ssize_t module_ ## _name ## _show(struct device *dev, \
+					 struct device_attribute *attr, \
+					 char *buf) \
+{ \
+	ssize_t __ret; \
+	if (!try_module_get(THIS_MODULE)) \
+		return -ENODEV; \
+	__ret = _name ## _show(dev, attr, buf); \
+	module_put(THIS_MODULE); \
+	return __ret; \
+}
+
+#define MODULE_DEVICE_ATTR_WO(_name) \
+MODULE_DEVICE_ATTR_FUNC_STORE(_name); \
+static DEVICE_ATTR_WO(module_ ## _name)
+
+#define MODULE_DEVICE_ATTR_RW(_name) \
+MODULE_DEVICE_ATTR_FUNC_STORE(_name); \
+MODULE_DEVICE_ATTR_FUNC_SHOW(_name); \
+static DEVICE_ATTR_RW(module_ ## _name)
+
+#define MODULE_DEVICE_ATTR_RO(_name) \
+MODULE_DEVICE_ATTR_FUNC_SHOW(_name); \
+static DEVICE_ATTR_RO(module_ ## _name)
+
 #endif
-- 
2.27.0

