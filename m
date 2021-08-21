Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F24C4320E
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 06:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32421611F0
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 06:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhHUGNZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Aug 2021 02:13:25 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50853 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhHUGNZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Aug 2021 02:13:25 -0400
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17L6CFw1076960;
        Sat, 21 Aug 2021 15:12:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Sat, 21 Aug 2021 15:12:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17L6C75V076844
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 21 Aug 2021 15:12:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH v5] block: genhd: don't call probe function with
 major_names_lock held
To:     Greg KH <gregkh@linuxfoundation.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
 <YRi9EQJqfK6ldrZG@kroah.com>
 <a3f43d54-8d10-3272-1fbb-1193d9f1b6dd@i-love.sakura.ne.jp>
 <YRjcHJE0qEIIJ9gA@kroah.com>
 <d7d31bf1-33d3-b817-0ce3-943e6835de33@i-love.sakura.ne.jp>
 <YR0KySFfiDk+s7pn@kroah.com>
 <a9056084-8a9a-40b3-1a20-1052135c1ee2@i-love.sakura.ne.jp>
 <YR0nLGdH3zVMSRXm@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b2af8a5b-3c1b-204e-7f56-bea0b15848d6@i-love.sakura.ne.jp>
Date:   Sat, 21 Aug 2021 15:12:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YR0nLGdH3zVMSRXm@kroah.com>
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

This patch adds THIS_MODULE parameter to __register_blkdev() as with
usb_register(), and drops major_names_lock before calling probe function
by holding a reference to that module which contains that probe function.

Link: https://syzkaller.appspot.com/bug?id=7bb10e8b62f83e4d445cdf4c13d69e407e629558 [1]
Link: https://syzkaller.appspot.com/bug?id=7bd106c28e846d1023d4ca915718b1a0905444cb [2]
Link: https://lkml.kernel.org/r/c4edf07f-92e1-a350-2743-f0b0234a2b6c@i-love.sakura.ne.jp [3]
Reported-by: syzbot <syzbot+f61766d5763f9e7a118f@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+f61766d5763f9e7a118f@syzkaller.appspotmail.com>
Fixes: a160c6159d4a0cf8 ("block: add an optional probe callback to major_names")
---
Changes in v5:
  Repost of v4, with history added.

  We should admit that the locking dependency complication caused by
  a160c6159d4a0cf8 is currently an untamable beast, for we can't allocate
  resources for finding approaches that can reduce the locking complexity
  of all individual modules using probe function.

  Keeping this locking dependency problem unresolved degrades quality of
  future kernels by "patches are merged and kernels are released without
  testing, for it is impossible to test due to this locking dependency".
  I'm not worrying about only stable kernels. Stopping this untamable
  beast immediately is important for "releasing tested kernels".

  As an example which kills loop_ctl_mutex => &lo->lo_mutex chain, I wrote
  "[PATCH] loop: break loop_ctl_mutex into loop_idr_spinlock and
  loop_removal_mutex"
  ( https://lkml.kernel.org/r/2901b9c2-f798-413e-4073-451259718288@i-love.sakura.ne.jp ).
  However, this approach is not considered as reducing the locking
  complexity
  ( https://lkml.kernel.org/r/20210819091941.GB12883@lst.de ).
  Then, what different approach is possible? We are run out of ideas
  which can stop this untamable beast from the loop module side.

  I consider that "making it possible to release tested kernels" (instead
  of leaving this problem by refusing to convert from multi-purposed
  long-held single lock into single-purposed short-held two locks) is
  also "Fix it right". But if we can't add new locks, we have no choice
  but addressing this problem in the common path.

  Note that "[PATCH v5] block: genhd: don't call probe function with
  major_names_lock held" is easily revetrtable because this patch can
  fix the locking dependency without adding new locks and without any
  dependent commits. We can revert this patch after we succeeded in making
  locking dependency of all individual modules using probe function
  simple enough.

Changes in v4:
  Use a macro and an inline function for transparently passing THIS_MODULE
  argument to all __register_blkdev() users, as a response to "avoid
  directly modifying __register_blkdev() users" feedback.

Changes in v3:
  Directly add THIS_MODULE argument to all __register_blkdev() users,
  as a response to "avoid use of ____ naming scheme" feedback.

Changes in v2:
  Changed the strategy for addressing this problem from individual modules
  to common path. Chose ____ naming scheme for transparently passing
  THIS_MODULE argument.
---
 block/genhd.c         | 33 ++++++++++++++++++++++++++-------
 include/linux/genhd.h | 11 +++++++++--
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 298ee78c1bda..a3e2e5666457 100644
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
@@ -207,8 +209,9 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
  *
  * Use register_blkdev instead for any new code.
  */
+#undef __register_blkdev
 int __register_blkdev(unsigned int major, const char *name,
-		void (*probe)(dev_t devt))
+		      void (*probe)(dev_t devt), struct module *owner)
 {
 	struct blk_major_name **n, *p;
 	int index, ret = 0;
@@ -248,6 +251,7 @@ int __register_blkdev(unsigned int major, const char *name,
 
 	p->major = major;
 	p->probe = probe;
+	p->owner = owner;
 	strlcpy(p->name, name, sizeof(p->name));
 	p->next = NULL;
 	index = major_to_index(major);
@@ -653,14 +657,29 @@ void blk_request_module(dev_t devt)
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
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 13b34177cc85..2ed856616d47 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -303,9 +303,16 @@ struct gendisk *__blk_alloc_disk(int node);
 void blk_cleanup_disk(struct gendisk *disk);
 
 int __register_blkdev(unsigned int major, const char *name,
-		void (*probe)(dev_t devt));
+		      void (*probe)(dev_t devt), struct module *owner);
+static inline int register_blkdev_with_probe(unsigned int major, const char *name,
+					     void (*probe)(dev_t devt), struct module *owner)
+{
+	return __register_blkdev(major, name, probe, owner);
+}
+#define __register_blkdev(major, name, probe) \
+	register_blkdev_with_probe(major, name, probe, THIS_MODULE)
 #define register_blkdev(major, name) \
-	__register_blkdev(major, name, NULL)
+	register_blkdev_with_probe(major, name, NULL, NULL)
 void unregister_blkdev(unsigned int major, const char *name);
 
 bool bdev_check_media_change(struct block_device *bdev);
-- 
2.18.4


