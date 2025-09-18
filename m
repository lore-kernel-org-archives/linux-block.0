Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589DA2FF661
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186223; cv=none; b=bXAWb6gD7qZxdrg6506d68kzer/gSbuv3Htr0XeWZ89ytnaaunsbHY9U8VVmWPkTJ4La34CGrF90tnd1Y08OgOafUiwcMeMfVyn7SyH1f/LXDUaYuYB65ZhSlH8T89VrKQT6AForYL0JD+Od8hqIF0eK6gpWCEf8XY+I5h+Zkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186223; c=relaxed/simple;
	bh=yoROGMdAuqQ7xqzPSvu5AL7H1eHXsahxHGvnBCdywcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eXIM+bt1wMRQu1jyR8n2qWHCH3FtLGJg2aoV9nCZ1+3y7bbkSy9F7W7c6WiBW3f0F3Gq+wL/r1sV40n5sMCPNdDh86EVjq7Fjdwqx5ZPo+2XiWsr65A4WRSD+U+ftlnPJobO4ybiWdSLVcO9Mg4zUrKxql7+XPQIVWR+YoWOlBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cS8nM5Ln7zKHMRp
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 17:03:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8C2901A17BF
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 17:03:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDXIY7mystofFCkCw--.4335S4;
	Thu, 18 Sep 2025 17:03:36 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: linux-block@vger.kernel.org,
	shinichiro.kawasaki@wdc.com
Cc: nilay@linux.ibm.com,
	ming.lei@redhat.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 0/1] tests/throtl: add a deadlock regression test
Date: Thu, 18 Sep 2025 16:53:40 +0800
Message-Id: <20250918085341.3686939-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXIY7mystofFCkCw--.4335S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr1fKFWxKrWrCF17AF1UWrg_yoW3tFW8pF
	y3KFyfCr1UWryUXr4SyFn2q348ZFWkKFyUWrn3Krn7uF1UAr4UXF1DKF1UKryDCa4xAFZ5
	ta4DGr4UJF1DKw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

While I'm looking at another deadlock issue for blk-throtl, it's found
during test that lockdep is reporting another issue quite eazy, I'm
adding regerssion test for now, if anyone is interested. Otherwise, I'll
go back for this after I finish the problem at hand later.

BTW, maybe we can support to test for scsi_debug instead of null_blk for
all the throtl tests.

Kernel log with patch:

[  233.277591] run blktests throtl/004 at 2025-09-18 08:40:41
[  233.933598] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
[  234.034150] scsi 0:0:0:0: Power-on or device reset occurred
[  237.418408]
[  237.419010] ======================================================
[  237.420951] WARNING: possible circular locking dependency detected
[  237.422523] 6.17.0-rc3-00124-ga12c2658ced0 #1665 Not tainted
[  237.423760] ------------------------------------------------------
[  237.425088] check/1334 is trying to acquire lock:
[  237.426111] ff1100011d9d0678 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_unregister_queue+0x53/0x180
[  237.427995]
[  237.427995] but task is already holding lock:
[  237.429254] ff1100011d9d00e0 (&q->q_usage_counter(queue)#3){++++}-{0:0}, at: del_gendisk+0xba/0x110
[  237.431193]
[  237.431193] which lock already depends on the new lock.
[  237.431193]
[  237.432940]
[  237.432940] the existing dependency chain (in reverse order) is:
[  237.434550]
[  237.434550] -> #2 (&q->q_usage_counter(queue)#3){++++}-{0:0}:
[  237.435946]        blk_queue_enter+0x40b/0x470
[  237.436620]        blkg_conf_prep+0x7b/0x3c0
[  237.437261]        tg_set_limit+0x10a/0x3e0
[  237.437905]        cgroup_file_write+0xc6/0x420
[  237.438596]        kernfs_fop_write_iter+0x189/0x280
[  237.439334]        vfs_write+0x256/0x490
[  237.439934]        ksys_write+0x83/0x190
[  237.440533]        __x64_sys_write+0x21/0x30
[  237.441172]        x64_sys_call+0x4608/0x4630
[  237.441833]        do_syscall_64+0xdb/0x6b0
[  237.442460]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  237.443283]
[  237.443283] -> #1 (&q->rq_qos_mutex){+.+.}-{4:4}:
[  237.444201]        __mutex_lock+0xd8/0xf50
[  237.444823]        mutex_lock_nested+0x2b/0x40
[  237.445491]        wbt_init+0x17e/0x280
[  237.446068]        wbt_enable_default+0xe9/0x140
[  237.446768]        blk_register_queue+0x1da/0x2e0
[  237.447477]        __add_disk+0x38c/0x5d0
[  237.448079]        add_disk_fwnode+0x89/0x250
[  237.448741]        device_add_disk+0x18/0x30
[  237.449394]        virtblk_probe+0x13a3/0x1800
[  237.450073]        virtio_dev_probe+0x389/0x610
[  237.450648]        really_probe+0x136/0x620
[  237.451141]        __driver_probe_device+0xb3/0x230
[  237.451719]        driver_probe_device+0x2f/0xe0
[  237.452267]        __driver_attach+0x158/0x250
[  237.452802]        bus_for_each_dev+0xa9/0x130
[  237.453330]        driver_attach+0x26/0x40
[  237.453824]        bus_add_driver+0x178/0x3d0
[  237.454342]        driver_register+0x7d/0x1c0
[  237.454862]        __register_virtio_driver+0x2c/0x60
[  237.455468]        virtio_blk_init+0x6f/0xe0
[  237.455982]        do_one_initcall+0x94/0x540
[  237.456507]        kernel_init_freeable+0x56a/0x7b0
[  237.457086]        kernel_init+0x2b/0x270
[  237.457566]        ret_from_fork+0x268/0x4c0
[  237.458078]        ret_from_fork_asm+0x1a/0x30
[  237.458602]
[  237.458602] -> #0 (&q->sysfs_lock){+.+.}-{4:4}:
[  237.459304]        __lock_acquire+0x1835/0x2940
[  237.459840]        lock_acquire+0xf9/0x450
[  237.460323]        __mutex_lock+0xd8/0xf50
[  237.460813]        mutex_lock_nested+0x2b/0x40
[  237.461332]        blk_unregister_queue+0x53/0x180
[  237.461905]        __del_gendisk+0x226/0x690
[  237.462421]        del_gendisk+0xba/0x110
[  237.462903]        sd_remove+0x49/0xb0 [sd_mod]
[  237.463457]        device_remove+0x87/0xb0
[  237.463939]        device_release_driver_internal+0x11e/0x230
[  237.464607]        device_release_driver+0x1a/0x30
[  237.465162]        bus_remove_device+0x14d/0x220
[  237.465700]        device_del+0x1e1/0x5a0
[  237.466167]        __scsi_remove_device+0x1ff/0x2f0
[  237.466735]        scsi_remove_device+0x37/0x60
[  237.467260]        sdev_store_delete+0x77/0x100
[  237.467789]        dev_attr_store+0x1f/0x40
[  237.468277]        sysfs_kf_write+0x65/0x90
[  237.468766]        kernfs_fop_write_iter+0x189/0x280
[  237.469339]        vfs_write+0x256/0x490
[  237.469800]        ksys_write+0x83/0x190
[  237.470266]        __x64_sys_write+0x21/0x30
[  237.470767]        x64_sys_call+0x4608/0x4630
[  237.471276]        do_syscall_64+0xdb/0x6b0
[  237.471766]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  237.472404]
[  237.472404] other info that might help us debug this:
[  237.472404]
[  237.473304] Chain exists of:
[  237.473304]   &q->sysfs_lock --> &q->rq_qos_mutex --> &q->q_usage_counter(queue)#3
[  237.473304]
[  237.474651]  Possible unsafe locking scenario:
[  237.474651]
[  237.475331]        CPU0                    CPU1
[  237.475859]        ----                    ----
[  237.476391]   lock(&q->q_usage_counter(queue)#3);
[  237.476947]                                lock(&q->rq_qos_mutex);
[  237.477678]                                lock(&q->q_usage_counter(queue)#3);
[  237.478504]   lock(&q->sysfs_lock);
[  237.478929]
[  237.478929]  *** DEADLOCK ***
[  237.478929]
[  237.479619] 6 locks held by check/1334:
[  237.480068]  #0: ff11000105cca408 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0x35f/0x490
[  237.480983]  #1: ff1100013f7b2888 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x140/0x280
[  237.482020]  #2: ff110001082430e0 (&shost->scan_mutex){+.+.}-{4:4}, at: scsi_remove_device+0x27/0x60
[  237.483057]  #3: ff11000107e34380 (&dev->mutex){....}-{4:4}, at: __device_driver_lock+0x46/0x90
[  237.484044]  #4: ff110001082433c0 (&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0xaa/0x110
[  237.485078]  #5: ff1100011d9d00e0 (&q->q_usage_counter(queue)#3){++++}-{0:0}, at: del_gendisk+0xba/00
[  237.486155]
[  237.486155] stack backtrace:
[  237.486665] CPU: 16 UID: 0 PID: 1334 Comm: check Not tainted 6.17.0-rc3-00124-ga12c2658ced0 #1665 PR
[  237.486669] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014
[  237.486671] Call Trace:
[  237.486673]  <TASK>
[  237.486676]  dump_stack_lvl+0x124/0x180
[  237.486680]  dump_stack+0x18/0x30
[  237.486682]  print_circular_bug+0x396/0x460
[  237.486686]  check_noncircular+0x10b/0x140
[  237.486688]  ? __lock_acquire+0x105d/0x2940
[  237.486691]  ? mark_lock+0x59/0x8a0
[  237.486695]  __lock_acquire+0x1835/0x2940
[  237.486699]  ? mark_held_locks+0x78/0xc0
[  237.486703]  lock_acquire+0xf9/0x450
[  237.486706]  ? blk_unregister_queue+0x53/0x180
[  237.486711]  __mutex_lock+0xd8/0xf50
[  237.486714]  ? blk_unregister_queue+0x53/0x180
[  237.486717]  ? blk_unregister_queue+0x53/0x180
[  237.486720]  ? kfree_const+0x45/0x60
[  237.486722]  ? kobject_put+0x13e/0x3a0
[  237.486727]  ? mutex_lock_nested+0x2b/0x40
[  237.486730]  mutex_lock_nested+0x2b/0x40
[  237.486733]  blk_unregister_queue+0x53/0x180
[  237.486735]  __del_gendisk+0x226/0x690
[  237.486740]  del_gendisk+0xba/0x110
[  237.486743]  sd_remove+0x49/0xb0 [sd_mod]
[  237.486751]  device_remove+0x87/0xb0
[  237.486753]  device_release_driver_internal+0x11e/0x230
[  237.486756]  device_release_driver+0x1a/0x30
[  237.486759]  bus_remove_device+0x14d/0x220
[  237.486762]  device_del+0x1e1/0x5a0
[  237.486764]  ? mutex_unlock+0x22/0x30
[  237.486767]  ? attribute_container_device_trigger+0xcb/0x170
[  237.486774]  __scsi_remove_device+0x1ff/0x2f0
[  237.486777]  scsi_remove_device+0x37/0x60
[  237.486780]  sdev_store_delete+0x77/0x100
[  237.486784]  dev_attr_store+0x1f/0x40
[  237.486786]  sysfs_kf_write+0x65/0x90
[  237.486789]  kernfs_fop_write_iter+0x189/0x280
[  237.486794]  vfs_write+0x256/0x490
[  237.486801]  ksys_write+0x83/0x190
[  237.486805]  __x64_sys_write+0x21/0x30
[  237.486807]  x64_sys_call+0x4608/0x4630
[  237.486810]  do_syscall_64+0xdb/0x6b0
[  237.486814]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Yu Kuai (1):
  tests/throtl/004: add scsi_debug for test device

 tests/throtl/004 | 20 ++++++++++++++++++++
 tests/throtl/rc  | 11 +++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.39.2

