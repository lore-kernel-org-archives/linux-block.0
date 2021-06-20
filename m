Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC03C48BDF
	for <linux-block@archiver.kernel.org>; Sun, 20 Jun 2021 13:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9299561007
	for <linux-block@archiver.kernel.org>; Sun, 20 Jun 2021 13:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhFTN5p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Jun 2021 09:57:45 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58083 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhFTN5p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Jun 2021 09:57:45 -0400
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 15KDsXeT045516;
        Sun, 20 Jun 2021 22:54:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sun, 20 Jun 2021 22:54:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 15KDsXLG045511
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 20 Jun 2021 22:54:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] block: genhd: don't call probe function with
 major_names_lock held
To:     Hillf Danton <hdanton@sina.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, hch@infradead.org,
        axboe@kernel.dk, desmondcheongzx@gmail.com,
        linux-block@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        Shuah Khan <skhan@linuxfoundation.org>,
        syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com,
        vigneshr@ti.com
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <YM2STfTN5AupWlSa@kroah.com> <20210620024403.820-1-hdanton@sina.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <24b7c3a9-e10a-f983-9fde-1ae66b0bc6b0@i-love.sakura.ne.jp>
Date:   Sun, 20 Jun 2021 22:54:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210620024403.820-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/20 11:44, Hillf Danton wrote:
> Good craft in regard to triggering the ABBA deadlock, but curious why not
> move unregister_blkdev out of and before loop_ctl_mutex, given it will also
> serialise with the prober.
> 

Well, something like this untested diff?

Call unregister_blkdev() as soon as __exit function starts, for calling
probe function after cleanup started will be unexpected for __exit function.

Keep probe function no-op until __init function ends, for probe function
might be called as soon as __register_blkdev() succeeded but calling probe
function before setup completes will be unexpected for __init function.

 drivers/block/ataflop.c |    6 +++++-
 drivers/block/brd.c     |    8 ++++++--
 drivers/block/floppy.c  |    4 ++++
 drivers/block/loop.c    |    4 ++--
 drivers/ide/ide-probe.c |    8 +++++++-
 drivers/md/md.c         |    5 +++++
 drivers/scsi/sd.c       |   10 +---------
 7 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index d601e49f80e0..3681e8c493b1 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1995,6 +1995,7 @@ static int ataflop_alloc_disk(unsigned int drive, unsigned int type)
 }
 
 static DEFINE_MUTEX(ataflop_probe_lock);
+static bool module_initialize_completed;
 
 static void ataflop_probe(dev_t dev)
 {
@@ -2006,6 +2007,8 @@ static void ataflop_probe(dev_t dev)
 
 	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS)
 		return;
+	if (!module_initialize_completed)
+		return;
 	mutex_lock(&ataflop_probe_lock);
 	if (!unit[drive].disk[type]) {
 		if (ataflop_alloc_disk(drive, type) == 0)
@@ -2080,6 +2083,7 @@ static int __init atari_floppy_init (void)
 	       UseTrackbuffer ? "" : "no ");
 	config_types();
 
+	module_initialize_completed = true;
 	return 0;
 
 err:
@@ -2138,6 +2142,7 @@ static void __exit atari_floppy_exit(void)
 {
 	int i, type;
 
+	unregister_blkdev(FLOPPY_MAJOR, "fd");
 	for (i = 0; i < FD_MAX_UNITS; i++) {
 		for (type = 0; type < NUM_DISK_MINORS; type++) {
 			if (!unit[i].disk[type])
@@ -2148,7 +2153,6 @@ static void __exit atari_floppy_exit(void)
 		}
 		blk_mq_free_tag_set(&unit[i].tag_set);
 	}
-	unregister_blkdev(FLOPPY_MAJOR, "fd");
 
 	del_timer_sync(&fd_timer);
 	atari_stram_free( DMABuffer );
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 7562cf30b14e..91a10c938e65 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -371,6 +371,7 @@ __setup("ramdisk_size=", ramdisk_size);
 static LIST_HEAD(brd_devices);
 static DEFINE_MUTEX(brd_devices_mutex);
 static struct dentry *brd_debugfs_dir;
+static bool module_initialize_completed;
 
 static struct brd_device *brd_alloc(int i)
 {
@@ -439,6 +440,8 @@ static void brd_probe(dev_t dev)
 	struct brd_device *brd;
 	int i = MINOR(dev) / max_part;
 
+	if (!module_initialize_completed)
+		return;
 	mutex_lock(&brd_devices_mutex);
 	list_for_each_entry(brd, &brd_devices, brd_list) {
 		if (brd->brd_number == i)
@@ -530,6 +533,7 @@ static int __init brd_init(void)
 	mutex_unlock(&brd_devices_mutex);
 
 	pr_info("brd: module loaded\n");
+	module_initialize_completed = true;
 	return 0;
 
 out_free:
@@ -550,13 +554,13 @@ static void __exit brd_exit(void)
 {
 	struct brd_device *brd, *next;
 
+	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
+
 	debugfs_remove_recursive(brd_debugfs_dir);
 
 	list_for_each_entry_safe(brd, next, &brd_devices, brd_list)
 		brd_del_one(brd);
 
-	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
-
 	pr_info("brd: module unloaded\n");
 }
 
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 8a9d22207c59..37b8e53c183d 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4523,6 +4523,7 @@ static int floppy_alloc_disk(unsigned int drive, unsigned int type)
 }
 
 static DEFINE_MUTEX(floppy_probe_lock);
+static bool module_initialize_completed;
 
 static void floppy_probe(dev_t dev)
 {
@@ -4533,6 +4534,8 @@ static void floppy_probe(dev_t dev)
 	    type >= ARRAY_SIZE(floppy_type))
 		return;
 
+	if (!module_initialize_completed)
+		return;
 	mutex_lock(&floppy_probe_lock);
 	if (!disks[drive][type]) {
 		if (floppy_alloc_disk(drive, type) == 0)
@@ -4705,6 +4708,7 @@ static int __init do_floppy_init(void)
 				NULL);
 	}
 
+	module_initialize_completed = true;
 	return 0;
 
 out_remove_drives:
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 76e12f3482a9..08aef61ab791 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2386,13 +2386,13 @@ static int loop_exit_cb(int id, void *ptr, void *data)
 
 static void __exit loop_exit(void)
 {
+	unregister_blkdev(LOOP_MAJOR, "loop");
+
 	mutex_lock(&loop_ctl_mutex);
 
 	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
 	idr_destroy(&loop_index_idr);
 
-	unregister_blkdev(LOOP_MAJOR, "loop");
-
 	misc_deregister(&loop_misc);
 
 	mutex_unlock(&loop_ctl_mutex);
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index aefd74c0d862..8c71356cdcfe 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -40,6 +40,8 @@
 #include <linux/uaccess.h>
 #include <asm/io.h>
 
+static bool module_initialize_completed;
+
 /**
  *	generic_id		-	add a generic drive id
  *	@drive:	drive to make an ID block for
@@ -904,6 +906,8 @@ static int init_irq (ide_hwif_t *hwif)
 
 static void ata_probe(dev_t dev)
 {
+	if (!module_initialize_completed)
+		return;
 	request_module("ide-disk");
 	request_module("ide-cd");
 	request_module("ide-tape");
@@ -1475,6 +1479,8 @@ int ide_host_register(struct ide_host *host, const struct ide_port_info *d,
 		}
 	}
 
+	if (j)
+		module_initialize_completed = true;
 	return j ? 0 : -1;
 }
 EXPORT_SYMBOL_GPL(ide_host_register);
@@ -1539,6 +1545,7 @@ EXPORT_SYMBOL_GPL(ide_port_unregister_devices);
 
 static void ide_unregister(ide_hwif_t *hwif)
 {
+	unregister_blkdev(hwif->major, hwif->name);
 	mutex_lock(&ide_cfg_mtx);
 
 	if (hwif->present) {
@@ -1559,7 +1566,6 @@ static void ide_unregister(ide_hwif_t *hwif)
 	 * Remove us from the kernel's knowledge
 	 */
 	kfree(hwif->sg_table);
-	unregister_blkdev(hwif->major, hwif->name);
 
 	ide_release_dma_engine(hwif);
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 49f897fbb89b..6603900062bc 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -68,6 +68,8 @@
 #include "md-bitmap.h"
 #include "md-cluster.h"
 
+static bool module_initialize_completed;
+
 /* pers_list is a list of registered personalities protected
  * by pers_lock.
  * pers_lock does extra service to protect accesses to
@@ -5776,6 +5778,8 @@ static void md_probe(dev_t dev)
 {
 	if (MAJOR(dev) == MD_MAJOR && MINOR(dev) >= 512)
 		return;
+	if (!module_initialize_completed)
+		return;
 	if (create_on_open)
 		md_alloc(dev, NULL);
 }
@@ -9590,6 +9594,7 @@ static int __init md_init(void)
 	raid_table_header = register_sysctl_table(raid_root_table);
 
 	md_geninit();
+	module_initialize_completed = true;
 	return 0;
 
 err_mdp:
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index cb3c37d1e009..4fc8f4db2ccf 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -629,14 +629,6 @@ static struct scsi_driver sd_template = {
 	.eh_reset		= sd_eh_reset,
 };
 
-/*
- * Don't request a new module, as that could deadlock in multipath
- * environment.
- */
-static void sd_default_probe(dev_t devt)
-{
-}
-
 /*
  * Device no to disk mapping:
  * 
@@ -3715,7 +3707,7 @@ static int __init init_sd(void)
 	SCSI_LOG_HLQUEUE(3, printk("init_sd: sd driver entry point\n"));
 
 	for (i = 0; i < SD_MAJORS; i++) {
-		if (__register_blkdev(sd_major(i), "sd", sd_default_probe))
+		if (register_blkdev(sd_major(i), "sd"))
 			continue;
 		majors++;
 	}

