Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52CCC433EF
	for <linux-block@archiver.kernel.org>; Wed, 23 Feb 2022 14:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiBWOZK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241542AbiBWOZG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Feb 2022 09:25:06 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFBDB1A98
        for <linux-block@vger.kernel.org>; Wed, 23 Feb 2022 06:24:38 -0800 (PST)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 21NEOHsC093057;
        Wed, 23 Feb 2022 23:24:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Wed, 23 Feb 2022 23:24:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 21NEOGjC093051
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 23 Feb 2022 23:24:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cf61ca83-d9b0-2e5d-eb3b-018e16753749@I-love.SAKURA.ne.jp>
Date:   Wed, 23 Feb 2022 23:24:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 5/8] loop: only take lo_mutex for the first reference in
 lo_open
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
References: <20220128130022.1750906-1-hch@lst.de>
 <20220128130022.1750906-6-hch@lst.de>
 <397e50c7-ae46-8834-1632-7bac1ad7df99@I-love.SAKURA.ne.jp>
 <10d156e7-4347-4ccd-51f4-ea5febd1b1ee@I-love.SAKURA.ne.jp>
 <20220208134559.qfs4pkukdzkuh2rg@quack3.lan>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220208134559.qfs4pkukdzkuh2rg@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/02/08 22:45, Jan Kara wrote:
> On Sat 05-02-22 09:28:33, Tetsuo Handa wrote:
>> Ping?
>>
>> I sent https://lkml.kernel.org/r/20220129071500.3566-1-penguin-kernel@I-love.SAKURA.ne.jp
>> based on ideas from your series.
>>
>> Since automated kernel tests are failing, can't we apply
>> [PATCH 1/7] loop: revert "make autoclear operation asynchronous"
>> for now if we can't come to a conclusion?
> 
> That's certainly a good start so feel free to add my Acked-by to the
> revert. I agree it should be merged quickly as I think it is better to have
> a theoretical deadlock in the code than userspace breakage hit in the wild.
> I'll find some more time to look into this but it will take a while.

Did you get a chance to look into this? As far as I tested, I found two problems
( https://lkml.kernel.org/r/a72c59c6-298b-e4ba-b1f5-2275afab49a1@I-love.SAKURA.ne.jp ).
That is, waiting for lo->lo_mutex upon open is not only for /bin/mount but for other
programs.

I found that we can use anon_inodes approach (basic idea is shown below) as a way
to use task_work context. If we can agree with this approach, I can re-implement
https://lkml.kernel.org/r/20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp
without exporting task_work_add().

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 19fe19eaa50e..6bd6af1836c6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -80,6 +80,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/sched/mm.h>
 #include <linux/statfs.h>
+#include <linux/anon_inodes.h>
 
 #include "loop.h"
 
@@ -1736,6 +1737,25 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 	return err;
 }
 
+static int loop_no_open(struct inode *inode, struct file *file)
+{
+	return -ENXIO;
+}
+
+static int loop_post_release(struct inode *inode, struct file *file)
+{
+	struct loop_device *lo = file->private_data;
+
+	pr_info("Performing autoclear operation.\n");
+	__loop_clr_fd(lo, false);
+	return 0;
+}
+
+static const struct file_operations loop_close_fops = {
+	.open = loop_no_open,
+	.release = loop_post_release,
+};
+
 static void lo_release(struct gendisk *disk, fmode_t mode)
 {
 	struct loop_device *lo = disk->private_data;
@@ -1745,6 +1765,8 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		goto out_unlock;
 
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
+		struct file *file;
+
 		if (lo->lo_state != Lo_bound)
 			goto out_unlock;
 		lo->lo_state = Lo_rundown;
@@ -1753,7 +1775,9 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		__loop_clr_fd(lo, true);
+		file = anon_inode_getfile("loop.close", &loop_close_fops, lo, O_CLOEXEC);
+		if (!IS_ERR(file))
+			fput(file);
 		return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*

