Return-Path: <SRS0=+JuZ=IE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653D1C433E0
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 02:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3024664FF0
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 02:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCFCUy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 21:20:54 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:45328 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCFCUl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 21:20:41 -0500
Received: by mail-pf1-f172.google.com with SMTP id j12so3298307pfj.12;
        Fri, 05 Mar 2021 18:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sH3OkCvCOBYt79tZW/C4X89IagBOPX3UHnmVepERPXk=;
        b=KykEVRV/axRG18e/mVbGueqP/h3ZwzZgDSJVbm90+E66PAbosvUZcBpHuI2JUHp4PD
         SiwKs8QjfA4zloEPkU0ypR9DpFzDAcowNli9yqKJKPlpXyesUoixbUYsMudVdG+0Mkyt
         QRwiVhEltTE/V7a+bXFfoYZGmHxdpdo8UDEIVnoAi/LIaNx5dVK+Vqn7cTDrFGw2qQeV
         g67yJ2JDg1eMQyQUEtDCPYrr1zZ3029/xdyzf6hUb4SXEb7vRXU3cBAV4Je+Z18iekEB
         4fDvFVWy/uw3znX5VGzK7c+kjGT631D8fPG7IIXOQPejJs0A3CLrmwk9lbaABWNUpZnc
         RG3Q==
X-Gm-Message-State: AOAM532slLcciZyP9HXgPYkE6qorzFcijY/aRn+kvn0LmoR1/sEqB6/K
        1GD7bX50uc2LrsAQ+x8ve84=
X-Google-Smtp-Source: ABdhPJw/TP9vazlfiwjqnc2l8n9ra1Xm8G6cfoPVHppcpU5wH6Fj7rRbbeT/SR2P94Kx5ntffks6Bw==
X-Received: by 2002:a62:1558:0:b029:1ef:19ac:2b00 with SMTP id 85-20020a6215580000b02901ef19ac2b00mr10915165pfv.67.1614997240827;
        Fri, 05 Mar 2021 18:20:40 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d14sm3214566pji.22.2021.03.05.18.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 18:20:37 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C3925419AC; Sat,  6 Mar 2021 02:20:36 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     axboe@kernel.dk, mbenes@suse.com, mcgrof@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] zram: fix races of sysfs attribute removal and usage
Date:   Sat,  6 Mar 2021 02:20:35 +0000
Message-Id: <20210306022035.11266-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210306022035.11266-1-mcgrof@kernel.org>
References: <20210306022035.11266-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we have sysfs attributes which muck with the driver
heavily we me end up with situations where the core
kernel driver removal call races with usage of a sysfs
attribute. The can happen when for instance a lock is
used on the sysfs attribute which is also used for
driver removal.

To fix this we just *try* to get a refcount to the
module prior to mucking with a sysfs attribute. If this
fails we just give up right away. Ideally we'd want
a generic solution, however this requires a bit more
work. If we tried to generalize this on the block layer
the closest we get is the disk->fops->owner, however
zram is an example driver where the disk->fops is
actually even changed *after* module load, and so the
original disk->fops->owner can be dynamic. In zram's
case the fops->owner is the same, however we have no
semantics to ensure this is the case for all block
drivers.

Using these two lines in two separate terminals can easily
reproduce this hang:

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

The splat which follows is comes up without this patch.

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

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/zram/zram_drv.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 63b6119cee93..ce54f4bf5a5b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1722,6 +1722,9 @@ static ssize_t disksize_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	int err;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	mutex_lock(&zram_index_mutex);
 
 	if (!zram_up) {
@@ -1762,6 +1765,7 @@ static ssize_t disksize_store(struct device *dev,
 	up_write(&zram->init_lock);
 
 	mutex_unlock(&zram_index_mutex);
+	module_put(THIS_MODULE);
 
 	return len;
 
@@ -1771,6 +1775,7 @@ static ssize_t disksize_store(struct device *dev,
 	up_write(&zram->init_lock);
 out:
 	mutex_unlock(&zram_index_mutex);
+	module_put(THIS_MODULE);
 	return err;
 }
 
@@ -1786,6 +1791,9 @@ static ssize_t reset_store(struct device *dev,
 	if (ret)
 		return ret;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	mutex_lock(&zram_index_mutex);
 
 	if (!zram_up) {
@@ -1823,6 +1831,7 @@ static ssize_t reset_store(struct device *dev,
 
 out:
 	mutex_unlock(&zram_index_mutex);
+	module_put(THIS_MODULE);
 	return len;
 }
 
@@ -2043,13 +2052,19 @@ static ssize_t hot_add_show(struct class *class,
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
@@ -2073,6 +2088,9 @@ static ssize_t hot_remove_store(struct class *class,
 	if (dev_id < 0)
 		return -EINVAL;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
 	mutex_lock(&zram_index_mutex);
 
 	if (!zram_up) {
@@ -2091,6 +2109,7 @@ static ssize_t hot_remove_store(struct class *class,
 
 out:
 	mutex_unlock(&zram_index_mutex);
+	module_put(THIS_MODULE);
 	return ret ? ret : count;
 }
 static CLASS_ATTR_WO(hot_remove);
-- 
2.30.1

