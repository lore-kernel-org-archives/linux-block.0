Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0CFC47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 13:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B982761374
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 13:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhFJNjw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:39:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64614 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhFJNjv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 09:39:51 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 15ADbs8X002584;
        Thu, 10 Jun 2021 22:37:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp);
 Thu, 10 Jun 2021 22:37:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 15ADbrdu002580
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 10 Jun 2021 22:37:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [syzbot] possible deadlock in del_gendisk
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Petr Vorel <pvorel@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block <linux-block@vger.kernel.org>,
        syzbot <syzbot+61e04e51b7ac86930589@syzkaller.appspotmail.com>,
        Tejun Heo <tj@kernel.org>
References: <000000000000ae236f05bfde0678@google.com>
 <1435f266-9f6d-22ef-ba7d-f031c616aede@I-love.SAKURA.ne.jp>
 <7b8c9eeb-789d-e5e6-04d6-130ee8be7305@i-love.sakura.ne.jp>
 <20210609164639.GM4910@sequoia>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <718b44b5-a230-1907-e1e1-9f609cb67322@i-love.sakura.ne.jp>
Date:   Thu, 10 Jun 2021 22:37:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609164639.GM4910@sequoia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/10 1:46, Tyler Hicks wrote:
> On 2021-06-10 01:31:17, Tetsuo Handa wrote:
>> Hello, Christoph.
>>
>> I'm currently trying full bisection.

I reached commit c76f48eb5c084b1e ("block: take bd_mutex around delete_partitions in del_gendisk").

  # bad: [fc0586062816559defb14c947319ef8c4c326fb3] Merge tag 'for-5.13/drivers-2021-04-27' of git://git.kernel.dk/linux-block
  # good: [42dec9a936e7696bea1f27d3c5a0068cd9aa95fd] Merge tag 'perf-core-2021-04-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
  # good: [68a32ba14177d4a21c4a9a941cf1d7aea86d436f] Merge tag 'drm-next-2021-04-28' of git://anongit.freedesktop.org/drm/drm
  # good: [a800abd3ecb9acc55821f7ac9bba6c956b36a595] net: enetc: move skb creation into enetc_build_skb
  # good: [6cc8e7430801fa238bd7d3acae1eb406c6e02fe1] loop: scale loop device by introducing per device lock
  git bisect start 'fc0586062816559defb14c947319ef8c4c326fb3' '42dec9a936e7696bea1f27d3c5a0068cd9aa95fd' '68a32ba14177d4a21c4a9a941cf1d7aea86d436f' 'a800abd3ecb9acc55821f7ac9bba6c956b36a595' '6cc8e7430801fa238bd7d3acae1eb406c6e02fe1'
  # good: [2958a995edc94654df690318df7b9b49e5a3ef88] block/rnbd-clt: Support polling mode for IO latency optimization
  git bisect good 2958a995edc94654df690318df7b9b49e5a3ef88
  # good: [16b3d0cf5bad844daaf436ad2e9061de0fe36e5c] Merge tag 'sched-core-2021-04-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
  git bisect good 16b3d0cf5bad844daaf436ad2e9061de0fe36e5c
  # bad: [cbb749cf377aa8aa32a036ebe9dd9f2d89037bf0] block: remove an incorrect check from blk_rq_append_bio
  git bisect bad cbb749cf377aa8aa32a036ebe9dd9f2d89037bf0
  # good: [9bb33f24abbd0fa2fadad01ec75438d7cc239189] block: refactor the bounce buffering code
  git bisect good 9bb33f24abbd0fa2fadad01ec75438d7cc239189
  # bad: [c76f48eb5c084b1e15c931ae8cc1826cd771d70d] block: take bd_mutex around delete_partitions in del_gendisk
  git bisect bad c76f48eb5c084b1e15c931ae8cc1826cd771d70d
  # good: [b896fa85e0ee4f09ba4be48a3f405fc82c38afb4] dasd: use bdev_disk_changed instead of blk_drop_partitions
  git bisect good b896fa85e0ee4f09ba4be48a3f405fc82c38afb4
  # good: [473338be3aaea117a7133720305f240eb7f68951] block: move more syncing and invalidation to delete_partition
  git bisect good 473338be3aaea117a7133720305f240eb7f68951
  # good: [d3c4a43d9291279c28b26757351a6ab72c110753] block: refactor blk_drop_partitions
  git bisect good d3c4a43d9291279c28b26757351a6ab72c110753
  # first bad commit: [c76f48eb5c084b1e15c931ae8cc1826cd771d70d] block: take bd_mutex around delete_partitions in del_gendisk

> 
> Thanks for doing this. I haven't had a chance to retry this commit with
> lockdep but I did re-review it and didn't think that it would be the
> cause of this lockdep report since it strictly reduced the usage of the
> loop_ctl_mutex.

OK. It seems that a patch shown below avoids this warning.

Since I think loop_remove() does not access resources in
loop module, I think we can drop loop_ctl_mutex as soon as
idr_remove(&loop_index_idr, lo->lo_number) completes.

Hmm, what protects lo_open() from loop_exit() destroying everything?
Is module's refcount taken before calling lo_open() ? If yes, does
module_exiting and/or loop_ctl_mutex in loop_exit() help protecting
something? If no, nothing protects and just crashes the kernel?

Is my understanding correct? Do you think this approach is OK?

 drivers/block/loop.c |   32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d58d68f3c7cd..5baa0207512e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -80,18 +80,19 @@
 #include <linux/ioprio.h>
 #include <linux/blk-cgroup.h>
 
 #include "loop.h"
 
 #include <linux/uaccess.h>
 
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
+static bool module_exiting;
 
 static int max_part;
 static int part_shift;
 
 static int transfer_xor(struct loop_device *lo, int cmd,
 			struct page *raw_page, unsigned raw_off,
 			struct page *loop_page, unsigned loop_off,
 			int size, sector_t real_block)
 {
@@ -1877,25 +1878,29 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 }
 #endif
 
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
 	struct loop_device *lo;
 	int err;
 
 	/*
-	 * take loop_ctl_mutex to protect lo pointer from race with
-	 * loop_control_ioctl(LOOP_CTL_REMOVE), however, to reduce contention
-	 * release it prior to updating lo->lo_refcnt.
+	 * Take loop_ctl_mutex to protect lo pointer from race with
+	 * loop_control_ioctl(LOOP_CTL_REMOVE) and loop_exit(). However,
+	 * to reduce contention, release it prior to updating lo->lo_refcnt.
 	 */
 	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
 		return err;
+	if (unlikely(module_exiting)) {
+		mutex_unlock(&loop_ctl_mutex);
+		return -EINVAL;
+	}
 	lo = bdev->bd_disk->private_data;
 	if (!lo) {
 		mutex_unlock(&loop_ctl_mutex);
 		return -ENXIO;
 	}
 	err = mutex_lock_killable(&lo->lo_mutex);
 	mutex_unlock(&loop_ctl_mutex);
 	if (err)
 		return err;
@@ -2073,18 +2078,19 @@ static int loop_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	return 0;
 }
 
 static const struct blk_mq_ops loop_mq_ops = {
 	.queue_rq       = loop_queue_rq,
 	.init_request	= loop_init_request,
 	.complete	= lo_complete_rq,
 };
 
+/* Must be called with loop_ctl_mutex held. */
 static int loop_add(struct loop_device **l, int i)
 {
 	struct loop_device *lo;
 	struct gendisk *disk;
 	int err;
 
 	err = -ENOMEM;
 	lo = kzalloc(sizeof(*lo), GFP_KERNEL);
 	if (!lo)
@@ -2180,18 +2186,19 @@ static int loop_add(struct loop_device **l, int i)
 	blk_mq_free_tag_set(&lo->tag_set);
 out_free_idr:
 	idr_remove(&loop_index_idr, i);
 out_free_dev:
 	kfree(lo);
 out:
 	return err;
 }
 
+/* Must not be called with loop_ctl_mutex or lo->lo_mutex held. */
 static void loop_remove(struct loop_device *lo)
 {
 	del_gendisk(lo->lo_disk);
 	blk_cleanup_queue(lo->lo_queue);
 	blk_mq_free_tag_set(&lo->tag_set);
 	put_disk(lo->lo_disk);
 	mutex_destroy(&lo->lo_mutex);
 	kfree(lo);
 }
@@ -2251,18 +2258,22 @@ static void loop_probe(dev_t dev)
 static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			       unsigned long parm)
 {
 	struct loop_device *lo;
 	int ret;
 
 	ret = mutex_lock_killable(&loop_ctl_mutex);
 	if (ret)
 		return ret;
+	if (unlikely(module_exiting)) {
+		mutex_unlock(&loop_ctl_mutex);
+		return -EINVAL;
+	}
 
 	ret = -ENOSYS;
 	switch (cmd) {
 	case LOOP_CTL_ADD:
 		ret = loop_lookup(&lo, parm);
 		if (ret >= 0) {
 			ret = -EEXIST;
 			break;
 		}
@@ -2282,19 +2293,21 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 		}
 		if (atomic_read(&lo->lo_refcnt) > 0) {
 			ret = -EBUSY;
 			mutex_unlock(&lo->lo_mutex);
 			break;
 		}
 		lo->lo_disk->private_data = NULL;
 		mutex_unlock(&lo->lo_mutex);
 		idr_remove(&loop_index_idr, lo->lo_number);
+		mutex_unlock(&loop_ctl_mutex);
 		loop_remove(lo);
+		return ret;
 		break;
 	case LOOP_CTL_GET_FREE:
 		ret = loop_lookup(&lo, -1);
 		if (ret >= 0)
 			break;
 		ret = loop_add(&lo, -1);
 	}
 	mutex_unlock(&loop_ctl_mutex);
 
@@ -2391,28 +2404,35 @@ static int loop_exit_cb(int id, void *ptr, void *data)
 {
 	struct loop_device *lo = ptr;
 
 	loop_remove(lo);
 	return 0;
 }
 
 static void __exit loop_exit(void)
 {
-	mutex_lock(&loop_ctl_mutex);
+	module_exiting = true;
 
+	/* Block future lo_open()/loop_control_ioctl() callers. */
+	mutex_lock(&loop_ctl_mutex);
+	mutex_unlock(&loop_ctl_mutex);
+	/*
+	 * Since loop_exit_cb() calls loop_remove(), we can not take
+	 * loop_ctl_mutex here. But since module_exiting == true is blocking
+	 * lo_open() and loop_control_ioctl(), it is safe to access
+	 * loop_index_idr without taking loop_ctl_mutex here.
+	 */
 	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
 	idr_destroy(&loop_index_idr);
 
 	unregister_blkdev(LOOP_MAJOR, "loop");
 
 	misc_deregister(&loop_misc);
-
-	mutex_unlock(&loop_ctl_mutex);
 }
 
 module_init(loop_init);
 module_exit(loop_exit);
 
 #ifndef MODULE
 static int __init max_loop_setup(char *str)
 {
 	max_loop = simple_strtol(str, NULL, 0);


