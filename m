Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6C6C49361
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 01:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8346124C
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 01:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhFSBJC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 21:09:02 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53553 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhFSBJC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 21:09:02 -0400
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 15J15nGa006768;
        Sat, 19 Jun 2021 10:05:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Sat, 19 Jun 2021 10:05:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 15J15ikI006747
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 19 Jun 2021 10:05:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
In-Reply-To: 
To:     hch@infradead.org
Cc:     axboe@kernel.dk, desmondcheongzx@gmail.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        Shuah Khan <skhan@linuxfoundation.org>,
        syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com,
        vigneshr@ti.com
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH v2] block: genhd: don't call probe function with
 major_names_lock held
Message-ID: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
Date:   Sat, 19 Jun 2021 10:05:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot is reporting circular locking problem at blk_request_module() [1],
for blk_request_module() is calling probe function with major_names_lock
held while major_names_lock is held during module's __init and __exit
functions.

                                         loop_exit() {
                                           mutex_lock(&loop_ctl_mutex);
  blk_request_module() {
    mutex_lock(&major_names_lock);
    loop_probe() {
      mutex_lock(&loop_ctl_mutex); // Blocked by loop_exit()
      mutex_unlock(&loop_ctl_mutex);
    }
    mutex_unlock(&major_names_lock);
                                           unregister_blkdev() {
                                             mutex_lock(&major_names_lock); // Blocked by blk_request_module()
                                             mutex_unlock(&major_names_lock);
                                           }
                                           mutex_unlock(&loop_ctl_mutex);
  }
                                         }

Based on an assumption that a probe callback passed to __register_blkdev()
belongs to a module which calls __register_blkdev(), drop major_names_lock
before calling probe function by holding a reference to that module which
contains that probe function. If there is a module where this assumption
does not hold, such module can call ____register_blkdev() directly.

  blk_request_module() {
    mutex_lock(&major_names_lock);
    // Block loop_exit()
    mutex_unlock(&major_names_lock);
    loop_probe() {
      mutex_lock(&loop_ctl_mutex);
      mutex_unlock(&loop_ctl_mutex);
    }
    // Unblock loop_exit()
  }
                                         loop_exit() {
                                           mutex_lock(&loop_ctl_mutex);
                                           unregister_blkdev() {
                                             mutex_lock(&major_names_lock);
                                             mutex_unlock(&major_names_lock);
                                           }
                                           mutex_unlock(&loop_ctl_mutex);
                                         }

Note that regardless of this patch, it is up to probe function to
serialize module's __init function and probe function in that module
by using e.g. a mutex. This patch simply makes sure that module's __exit
function won't be called when probe function is about to be called.

While Desmond Cheong Zhi Xi already proposed a patch for breaking ABCD
circular dependency [2], I consider that this patch is still needed for
safely breaking AB-BA dependency upon module unloading. (Note that syzbot
does not test module unloading code because the syzbot kernels are built
with almost all modules built-in. We need manual inspection.)

By doing kmalloc(GFP_KERNEL) in ____register_blkdev() before holding
major_names_lock, we could convert major_names_lock from a mutex to
a spinlock. But that is beyond the scope of this patch.

Link: https://syzkaller.appspot.com/bug?id=7bd106c28e846d1023d4ca915718b1a0905444cb [1]
Link: https://lkml.kernel.org/r/20210617160904.570111-1-desmondcheongzx@gmail.com [2]
Reported-by: syzbot <syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com>
---
 block/genhd.c         | 36 +++++++++++++++++++++++++++---------
 include/linux/genhd.h |  8 +++++---
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9f8cb7beaad1..9577c70a6bd3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -169,6 +169,7 @@ static struct blk_major_name {
 	int major;
 	char name[16];
 	void (*probe)(dev_t devt);
+	struct module *owner;
 } *major_names[BLKDEV_MAJOR_HASH_SIZE];
 static DEFINE_MUTEX(major_names_lock);
 
@@ -197,7 +198,8 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
  * @major: the requested major device number [1..BLKDEV_MAJOR_MAX-1]. If
  *         @major = 0, try to allocate any unused major number.
  * @name: the name of the new block device as a zero terminated string
- * @probe: allback that is called on access to any minor number of @major
+ * @probe: callback that is called on access to any minor number of @major
+ * @owner: the owner of @probe function (i.e. THIS_MODULE or NULL).
  *
  * The @name must be unique within the system.
  *
@@ -214,8 +216,8 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
  *
  * Use register_blkdev instead for any new code.
  */
-int __register_blkdev(unsigned int major, const char *name,
-		void (*probe)(dev_t devt))
+int ____register_blkdev(unsigned int major, const char *name,
+			void (*probe)(dev_t devt), struct module *owner)
 {
 	struct blk_major_name **n, *p;
 	int index, ret = 0;
@@ -255,6 +257,7 @@ int __register_blkdev(unsigned int major, const char *name,
 
 	p->major = major;
 	p->probe = probe;
+	p->owner = owner;
 	strlcpy(p->name, name, sizeof(p->name));
 	p->next = NULL;
 	index = major_to_index(major);
@@ -277,7 +280,7 @@ int __register_blkdev(unsigned int major, const char *name,
 	mutex_unlock(&major_names_lock);
 	return ret;
 }
-EXPORT_SYMBOL(__register_blkdev);
+EXPORT_SYMBOL(____register_blkdev);
 
 void unregister_blkdev(unsigned int major, const char *name)
 {
@@ -676,14 +679,29 @@ void blk_request_module(dev_t devt)
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
index 6fc26f7bdf71..070b73c043e6 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -277,10 +277,12 @@ extern void put_disk(struct gendisk *disk);
 
 #define alloc_disk(minors) alloc_disk_node(minors, NUMA_NO_NODE)
 
-int __register_blkdev(unsigned int major, const char *name,
-		void (*probe)(dev_t devt));
+int ____register_blkdev(unsigned int major, const char *name,
+			void (*probe)(dev_t devt), struct module *owner);
+#define __register_blkdev(major, name, probe) \
+	____register_blkdev(major, name, probe, THIS_MODULE)
 #define register_blkdev(major, name) \
-	__register_blkdev(major, name, NULL)
+	____register_blkdev(major, name, NULL, NULL)
 void unregister_blkdev(unsigned int major, const char *name);
 
 bool bdev_check_media_change(struct block_device *bdev);
-- 
2.18.4
