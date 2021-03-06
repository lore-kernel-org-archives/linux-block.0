Return-Path: <SRS0=+JuZ=IE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D39C433E6
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 02:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F35864FFD
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 02:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCFCUy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 21:20:54 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:42974 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhCFCUu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 21:20:50 -0500
Received: by mail-pj1-f50.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so112377pjv.1;
        Fri, 05 Mar 2021 18:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zGW5ass4mj+ZAyNE6F4phND74HXAz5QHRa5GYjeiy8s=;
        b=QFpkPiCW3VAfjOlBEH0cTo5elCvz7i/yXIVzc2xd9bpG8ZL2YuVZzP9bfltFY+KiWk
         28FcZpz4C7BM/J59ykha93Zl1yxaub6k5CdJuUptSs5zf9ansKRSeSUZy5Q2UyC5ZbAo
         EW5GsJDr5OR1tuViUhHPT58PStTvjnrptMofZtntXiyCBIcGqSKU78PEiJDvrhZ/Zj0X
         1K2wOhYpBxnCqcbYLZ5p9cFI3VxuwTcLcyMV+9KQE92U2lLN3dsShRJOxtDVhtP+ZRTy
         hupq5d1m4ywDA/1vR0c43T994lDSflt9rHZ0AOBcNJMMrig8+aoVKnDvUIDnfNFSWUgQ
         r4tQ==
X-Gm-Message-State: AOAM533eDY0wkyECawZisD9YMNt1aFyuzGd2wLbafwTa7GWYHEnO03YI
        4idIPQbqbRwUXfojMLBBg/Y=
X-Google-Smtp-Source: ABdhPJzNW5auzinvPjkCI6V3mge0FUJcM14U5ZZC3IG4yeYMjPBzoJ8eL+Ex2TYgXvqNeJdd7lX3sA==
X-Received: by 2002:a17:902:ecc3:b029:e5:d7cc:2a20 with SMTP id a3-20020a170902ecc3b02900e5d7cc2a20mr11227518plh.11.1614997239804;
        Fri, 05 Mar 2021 18:20:39 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x23sm3609675pff.133.2021.03.05.18.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 18:20:37 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BD5D9400CD; Sat,  6 Mar 2021 02:20:36 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     axboe@kernel.dk, mbenes@suse.com, mcgrof@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug multistate
Date:   Sat,  6 Mar 2021 02:20:34 +0000
Message-Id: <20210306022035.11266-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210306022035.11266-1-mcgrof@kernel.org>
References: <20210306022035.11266-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The zram driver makes use of cpu hotplug multistate support,
whereby it associates a zram compression stream per CPU. To
support CPU hotplug multistate a callback enabled to allow
the driver to do what it needs when a CPU hotplugs.

It is however currently possible to end up removing the
zram driver callback prior to removing the zram compression
streams per CPU. This would leave these compression streams
hanging.

We need to fix ordering for driver load / removal, zram
device additions, in light of the driver's use of cpu
hotplug multistate. Since the zram driver exposes many
sysfs attribute which can also muck with the comrpession
streams this also means we can hit page faults today easily.

Fix all this by providing an zram initialization boolean
protected the shared in the driver zram_index_mutex,
which we can use to annotate when sysfs attributes are
safe to use or not -- once the driver is properly initialized.
When the driver is going down we also are sure to not let
userspace muck with attributes which may affect zram cpu
compression streams.

This also fixes a series of possible memory leaks. The
crashes and memory leaks can easily be caused by issuing
the zram02.sh script from the LTP project [0] in a loop
in two separate windows:

  cd testcases/kernel/device-drivers/zram
  while true; do PATH=$PATH:$PWD:$PWD/../../../lib/ ./zram02.sh; done

You end up with a splat as follows:

kernel: zram: Removed device: zram0
kernel: zram: Added device: zram0
kernel: zram0: detected capacity change from 0 to 209715200
kernel: Adding 104857596k swap on /dev/zram0. Priority:-2 extents:1 across:104857596k SSFS
kernel: zram0: detected capacitky change from 209715200 to 0
kernel: zram0: detected capacity change from 0 to 209715200
kernel: ------------[ cut here ]------------
kernel: Error: Removing state 63 which has instances left.
kernel: WARNING: CPU: 7 PID: 70457 at kernel/cpu.c:2069 __cpuhp_remove_state_cpuslocked+0xf9/0x100
kernel: Modules linked in: zram(E-) zsmalloc(E) <etc>
kernel: CPU: 7 PID: 70457 Comm: rmmod Tainted: G            E     5.12.0-rc1-next-20210304 #3
kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
kernel: RIP: 0010:__cpuhp_remove_state_cpuslocked+0xf9/0x100
kernel: Code: <etc>
kernel: RSP: 0018:ffffa800c139be98 EFLAGS: 00010282
kernel: RAX: 0000000000000000 RBX: ffffffff9083db58 RCX: ffff9609f7dd86d8
kernel: RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9609f7dd86d0
kernel: RBP: 0000000000000000i R08: 0000000000000000 R09: ffffa800c139bcb8
kernel: R10: ffffa800c139bcb0 R11: ffffffff908bea40 R12: 000000000000003f
kernel: R13: 00000000000009d8 R14: 0000000000000000 R15: 0000000000000000
kernel: FS: 00007f1b075a7540(0000) GS:ffff9609f7dc0000(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES 0000 CR0: 0000000080050033
kernel: CR2: 00007f1b07610490 CR3: 00000001bd04e000 CR4: 0000000000350ee0
kernel: Call Trace:
kernel: __cpuhp_remove_state+0x2e/0x80
kernel: __do_sys_delete_module+0x190/0x2a0
kernel:  do_syscall_64+0x33/0x80
kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae

The "Error: Removing state 63 which has instances left" refers
to the zram per CPU compression streams still left.

[0] https://github.com/linux-test-project/ltp.git

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/zram/zram_drv.c | 63 ++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a711a2e2a794..63b6119cee93 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -44,6 +44,8 @@ static DEFINE_MUTEX(zram_index_mutex);
 static int zram_major;
 static const char *default_compressor = CONFIG_ZRAM_DEF_COMP;
 
+bool zram_up;
+
 /* Module params (documentation at end) */
 static unsigned int num_devices = 1;
 /*
@@ -1699,6 +1701,7 @@ static void zram_reset_device(struct zram *zram)
 	comp = zram->comp;
 	disksize = zram->disksize;
 	zram->disksize = 0;
+	zram->comp = NULL;
 
 	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(zram->disk->part0, 0);
@@ -1719,9 +1722,18 @@ static ssize_t disksize_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	int err;
 
+	mutex_lock(&zram_index_mutex);
+
+	if (!zram_up) {
+		err = -ENODEV;
+		goto out;
+	}
+
 	disksize = memparse(buf, NULL);
-	if (!disksize)
-		return -EINVAL;
+	if (!disksize) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	down_write(&zram->init_lock);
 	if (init_done(zram)) {
@@ -1749,12 +1761,16 @@ static ssize_t disksize_store(struct device *dev,
 	set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
 	up_write(&zram->init_lock);
 
+	mutex_unlock(&zram_index_mutex);
+
 	return len;
 
 out_free_meta:
 	zram_meta_free(zram, disksize);
 out_unlock:
 	up_write(&zram->init_lock);
+out:
+	mutex_unlock(&zram_index_mutex);
 	return err;
 }
 
@@ -1770,8 +1786,17 @@ static ssize_t reset_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (!do_reset)
-		return -EINVAL;
+	mutex_lock(&zram_index_mutex);
+
+	if (!zram_up) {
+		len = -ENODEV;
+		goto out;
+	}
+
+	if (!do_reset) {
+		len = -EINVAL;
+		goto out;
+	}
 
 	zram = dev_to_zram(dev);
 	bdev = zram->disk->part0;
@@ -1780,7 +1805,8 @@ static ssize_t reset_store(struct device *dev,
 	/* Do not reset an active device or claimed device */
 	if (bdev->bd_openers || zram->claim) {
 		mutex_unlock(&bdev->bd_mutex);
-		return -EBUSY;
+		len = -EBUSY;
+		goto out;
 	}
 
 	/* From now on, anyone can't open /dev/zram[0-9] */
@@ -1795,6 +1821,8 @@ static ssize_t reset_store(struct device *dev,
 	zram->claim = false;
 	mutex_unlock(&bdev->bd_mutex);
 
+out:
+	mutex_unlock(&zram_index_mutex);
 	return len;
 }
 
@@ -2016,6 +2044,10 @@ static ssize_t hot_add_show(struct class *class,
 	int ret;
 
 	mutex_lock(&zram_index_mutex);
+	if (!zram_up) {
+		mutex_unlock(&zram_index_mutex);
+		return -ENODEV;
+	}
 	ret = zram_add();
 	mutex_unlock(&zram_index_mutex);
 
@@ -2043,6 +2075,11 @@ static ssize_t hot_remove_store(struct class *class,
 
 	mutex_lock(&zram_index_mutex);
 
+	if (!zram_up) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	zram = idr_find(&zram_index_idr, dev_id);
 	if (zram) {
 		ret = zram_remove(zram);
@@ -2052,6 +2089,7 @@ static ssize_t hot_remove_store(struct class *class,
 		ret = -ENODEV;
 	}
 
+out:
 	mutex_unlock(&zram_index_mutex);
 	return ret ? ret : count;
 }
@@ -2078,12 +2116,15 @@ static int zram_remove_cb(int id, void *ptr, void *data)
 
 static void destroy_devices(void)
 {
+	mutex_lock(&zram_index_mutex);
+	zram_up = false;
 	class_unregister(&zram_control_class);
 	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
 	zram_debugfs_destroy();
 	idr_destroy(&zram_index_idr);
 	unregister_blkdev(zram_major, "zram");
 	cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
+	mutex_unlock(&zram_index_mutex);
 }
 
 static int __init zram_init(void)
@@ -2111,15 +2152,21 @@ static int __init zram_init(void)
 		return -EBUSY;
 	}
 
+	mutex_lock(&zram_index_mutex);
+
 	while (num_devices != 0) {
-		mutex_lock(&zram_index_mutex);
 		ret = zram_add();
-		mutex_unlock(&zram_index_mutex);
-		if (ret < 0)
+		if (ret < 0) {
+			mutex_unlock(&zram_index_mutex);
 			goto out_error;
+		}
 		num_devices--;
 	}
 
+	zram_up = true;
+
+	mutex_unlock(&zram_index_mutex);
+
 	return 0;
 
 out_error:
-- 
2.30.1

