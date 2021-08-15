Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B89FC4338F
	for <linux-block@archiver.kernel.org>; Sun, 15 Aug 2021 06:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5688A600CC
	for <linux-block@archiver.kernel.org>; Sun, 15 Aug 2021 06:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhHOHAM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 03:00:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52017 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhHOHAM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 03:00:12 -0400
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17F6qktp092437;
        Sun, 15 Aug 2021 15:52:46 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sun, 15 Aug 2021 15:52:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17F6qkrl092434
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Aug 2021 15:52:46 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: [PATCH v3] block: genhd: don't call probe function with
 major_names_lock held
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
Message-ID: <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
Date:   Sun, 15 Aug 2021 15:52:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot is reporting circular locking problem at __loop_clr_fd() [1], for
commit a160c6159d4a0cf8 ("block: add an optional probe callback to
major_names") is calling the module's probe function with major_names_lock
held.

When copying content of /proc/devices to another file via sendfile(),

  sb_writers#$N => &p->lock => major_names_lock

dependency is recorded.

When loop_process_work() from WQ context performs a write request,

  (wq_completion)loop$M => (work_completion)&lo->rootcg_work =>
  sb_writers#$N

dependency is recorded.

When flush_workqueue() from drain_workqueue() from destroy_workqueue()
 from __loop_clr_fd() from blkdev_put() from blkdev_close() from __fput()
is called,

  &disk->open_mutex => &lo->lo_mutex => (wq_completion)loop$M

dependency is recorded.

When loop_control_remove() from loop_control_ioctl(LOOP_CTL_REMOVE) is
called,

  loop_ctl_mutex => &lo->lo_mutex

dependency is recorded.

As a result, lockdep thinks that there is

  loop_ctl_mutex => &lo->lo_mutex => (wq_completion)loop$M =>
  (work_completion)&lo->rootcg_work => sb_writers#$N => &p->lock =>
  major_names_lock

dependency chain.

Then, if loop_add() from loop_probe() from blk_request_module() from
blkdev_get_no_open() from blkdev_get_by_dev() from blkdev_open() from
do_dentry_open() from path_openat() from do_filp_open() is called,

  major_names_lock => loop_ctl_mutex

dependency is appended to the dependency chain.

There would be two approaches for breaking this circular dependency.
One is to kill loop_ctl_mutex => &lo->lo_mutex chain. The other is to
kill major_names_lock => loop_ctl_mutex chain. This patch implements
the latter, due to the following reasons.

 (1) sb_writers#$N => &p->lock => major_names_lock chain is unavoidable

 (2) this patch can also fix similar problem in other modules [2] which
     is caused by calling the probe function with major_names_lock held

 (3) I believe that this patch is principally safer than e.g.
     commit bd5c39edad535d9f ("loop: reduce loop_ctl_mutex coverage in
     loop_exit") which waits until the probe function finishes using
     global mutex in order to fix deadlock reproducible by sleep
     injection [3]

This patch adds THIS_MODULE parameter to __register_blkdev(), based on an
assumption that a probe callback passed to __register_blkdev() belongs to
a module which calls __register_blkdev(). Then, drop major_names_lock
before calling probe function by holding a reference to that module which
contains that probe function.

It may sound strange to pass THIS_MODULE as a function argument, but
what this patch is doing is essentially the same with passing e.g.
"struct file_system_type" argument initialized with .owner = THIS_MODULE
to register_filesystem(). To minimize lines changed, this patch does not
define some "struct" for __register_blkdev().

Link: https://syzkaller.appspot.com/bug?id=7bb10e8b62f83e4d445cdf4c13d69e407e629558 [1]
Link: https://syzkaller.appspot.com/bug?id=7bd106c28e846d1023d4ca915718b1a0905444cb [2]
Link: https://lkml.kernel.org/r/c4edf07f-92e1-a350-2743-f0b0234a2b6c@i-love.sakura.ne.jp [3]
Reported-by: syzbot <syzbot+f61766d5763f9e7a118f@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+f61766d5763f9e7a118f@syzkaller.appspotmail.com>
Fixes: a160c6159d4a0cf8 ("block: add an optional probe callback to major_names")
---
 block/genhd.c           | 32 +++++++++++++++++++++++++-------
 drivers/block/ataflop.c |  2 +-
 drivers/block/brd.c     |  2 +-
 drivers/block/floppy.c  |  2 +-
 drivers/block/loop.c    |  2 +-
 drivers/md/md.c         |  4 ++--
 drivers/scsi/sd.c       |  2 +-
 include/linux/genhd.h   |  4 ++--
 8 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 298ee78c1bda..e7c75c5aa831 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -162,6 +162,7 @@ static struct blk_major_name {
 	int major;
 	char name[16];
 	void (*probe)(dev_t devt);
+	struct module *owner;
 } *major_names[BLKDEV_MAJOR_HASH_SIZE];
 static DEFINE_MUTEX(major_names_lock);
 
@@ -190,7 +191,8 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
  * @major: the requested major device number [1..BLKDEV_MAJOR_MAX-1]. If
  *         @major = 0, try to allocate any unused major number.
  * @name: the name of the new block device as a zero terminated string
- * @probe: allback that is called on access to any minor number of @major
+ * @probe: callback that is called on access to any minor number of @major
+ * @owner: THIS_MODULE if @probe is not NULL, ignored if @probe is NULL.
  *
  * The @name must be unique within the system.
  *
@@ -208,7 +210,7 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
  * Use register_blkdev instead for any new code.
  */
 int __register_blkdev(unsigned int major, const char *name,
-		void (*probe)(dev_t devt))
+		      void (*probe)(dev_t devt), struct module *owner)
 {
 	struct blk_major_name **n, *p;
 	int index, ret = 0;
@@ -248,6 +250,7 @@ int __register_blkdev(unsigned int major, const char *name,
 
 	p->major = major;
 	p->probe = probe;
+	p->owner = owner;
 	strlcpy(p->name, name, sizeof(p->name));
 	p->next = NULL;
 	index = major_to_index(major);
@@ -653,14 +656,29 @@ void blk_request_module(dev_t devt)
 {
 	unsigned int major = MAJOR(devt);
 	struct blk_major_name **n;
+	void (*probe_fn)(dev_t devt);
 
 	mutex_lock(&major_names_lock);
 	for (n = &major_names[major_to_index(major)]; *n; n = &(*n)->next) {
-		if ((*n)->major == major && (*n)->probe) {
-			(*n)->probe(devt);
-			mutex_unlock(&major_names_lock);
-			return;
-		}
+		if ((*n)->major != major || !(*n)->probe)
+			continue;
+		if (!try_module_get((*n)->owner))
+			break;
+		/*
+		 * Calling probe function with major_names_lock held causes
+		 * circular locking dependency problem. Thus, call it after
+		 * releasing major_names_lock.
+		 */
+		probe_fn = (*n)->probe;
+		mutex_unlock(&major_names_lock);
+		/*
+		 * Assuming that unregister_blkdev() is called from module's
+		 * __exit function, a module refcount taken above allows us
+		 * to safely call probe function without major_names_lock held.
+		 */
+		probe_fn(devt);
+		module_put((*n)->owner);
+		return;
 	}
 	mutex_unlock(&major_names_lock);
 
diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index a093644ac39f..1b7fe10d49e7 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -2016,7 +2016,7 @@ static int __init atari_floppy_init (void)
 		return -ENODEV;
 
 	mutex_lock(&ataflop_probe_lock);
-	ret = __register_blkdev(FLOPPY_MAJOR, "fd", ataflop_probe);
+	ret = __register_blkdev(FLOPPY_MAJOR, "fd", ataflop_probe, THIS_MODULE);
 	if (ret)
 		goto out_unlock;
 
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 95694113e38e..d0bdfd56dfc8 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -487,7 +487,7 @@ static int __init brd_init(void)
 	 *	dynamically.
 	 */
 
-	if (__register_blkdev(RAMDISK_MAJOR, "ramdisk", brd_probe))
+	if (__register_blkdev(RAMDISK_MAJOR, "ramdisk", brd_probe, THIS_MODULE))
 		return -EIO;
 
 	brd_check_and_reset_par();
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 87460e0e5c72..ee33ba03e6bd 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4570,7 +4570,7 @@ static int __init do_floppy_init(void)
 		timer_setup(&motor_off_timer[drive], motor_off_callback, 0);
 	}
 
-	err = __register_blkdev(FLOPPY_MAJOR, "fd", floppy_probe);
+	err = __register_blkdev(FLOPPY_MAJOR, "fd", floppy_probe, THIS_MODULE);
 	if (err)
 		goto out_put_disk;
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f0cdff0c5fbf..d6606c3b7d74 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2564,7 +2564,7 @@ static int __init loop_init(void)
 		goto err_out;
 
 
-	if (__register_blkdev(LOOP_MAJOR, "loop", loop_probe)) {
+	if (__register_blkdev(LOOP_MAJOR, "loop", loop_probe, THIS_MODULE)) {
 		err = -EIO;
 		goto misc_out;
 	}
diff --git a/drivers/md/md.c b/drivers/md/md.c
index ae8fe54ea358..c13f45c0f502 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9584,11 +9584,11 @@ static int __init md_init(void)
 	if (!md_rdev_misc_wq)
 		goto err_rdev_misc_wq;
 
-	ret = __register_blkdev(MD_MAJOR, "md", md_probe);
+	ret = __register_blkdev(MD_MAJOR, "md", md_probe, THIS_MODULE);
 	if (ret < 0)
 		goto err_md;
 
-	ret = __register_blkdev(0, "mdp", md_probe);
+	ret = __register_blkdev(0, "mdp", md_probe, THIS_MODULE);
 	if (ret < 0)
 		goto err_mdp;
 	mdp_major = ret;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index b8d55af763f9..ddd67a1045e7 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3729,7 +3729,7 @@ static int __init init_sd(void)
 	SCSI_LOG_HLQUEUE(3, printk("init_sd: sd driver entry point\n"));
 
 	for (i = 0; i < SD_MAJORS; i++) {
-		if (__register_blkdev(sd_major(i), "sd", sd_default_probe))
+		if (__register_blkdev(sd_major(i), "sd", sd_default_probe, THIS_MODULE))
 			continue;
 		majors++;
 	}
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 13b34177cc85..b0948003071d 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -303,9 +303,9 @@ struct gendisk *__blk_alloc_disk(int node);
 void blk_cleanup_disk(struct gendisk *disk);
 
 int __register_blkdev(unsigned int major, const char *name,
-		void (*probe)(dev_t devt));
+		      void (*probe)(dev_t devt), struct module *owner);
 #define register_blkdev(major, name) \
-	__register_blkdev(major, name, NULL)
+	__register_blkdev(major, name, NULL, NULL)
 void unregister_blkdev(unsigned int major, const char *name);
 
 bool bdev_check_media_change(struct block_device *bdev);
-- 
2.18.4


