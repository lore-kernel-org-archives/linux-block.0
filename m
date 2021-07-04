Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081BCC07E95
	for <linux-block@archiver.kernel.org>; Sun,  4 Jul 2021 05:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65746138C
	for <linux-block@archiver.kernel.org>; Sun,  4 Jul 2021 05:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhGDFpV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Jul 2021 01:45:21 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54980 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhGDFpV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Jul 2021 01:45:21 -0400
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1645gBnt095379;
        Sun, 4 Jul 2021 14:42:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Sun, 04 Jul 2021 14:42:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1645gAGt095375
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 4 Jul 2021 14:42:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] loop: reintroduce global lock for safe
 loop_validate_file() traversal
To:     Arjan van de Ven <arjan@linux.intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Christoph Hellwig <hch@lst.de>
References: <20210702153036.8089-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <258f1892-bbbe-67e2-ead9-3287a3d7578b@i-love.sakura.ne.jp>
Date:   Sun, 4 Jul 2021 14:42:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702153036.8089-1-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

On 2021/07/03 0:30, Tetsuo Handa wrote:
> Commit 6cc8e7430801fa23 ("loop: scale loop device by introducing per
> device lock") re-opened a race window for NULL pointer dereference at
> loop_validate_file() where commit 310ca162d779efee ("block/loop: Use
> global lock for ioctl() operation.") closed.
> 
> Although we need to guarantee that other loop devices will not change
> during traversal, we can't take remote "struct loop_device"->lo_mutex
> inside loop_validate_file() in order to avoid AB-BA deadlock. Therefore,
> introduce a global lock dedicated for loop_validate_file() which is
> conditionally taken before local "struct loop_device"->lo_mutex is taken.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 6cc8e7430801fa23 ("loop: scale loop device by introducing per device lock")
> ---
>  drivers/block/loop.c | 138 ++++++++++++++++++++++++++++---------------
>  1 file changed, 89 insertions(+), 49 deletions(-)
> 
> This is a submission as a patch based on comments from Christoph Hellwig
> at https://lkml.kernel.org/r/20210623144130.GA738@lst.de . I don't know
> this patch can close all race windows.
> 
> For example, loop_change_fd() says
> 
>   This can only work if the loop device is used read-only, and if the
>   new backing store is the same size and type as the old backing store.
> 
> and has
> 
>         /* size of the new backing store needs to be the same */
>         if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
>                 goto out_err;
> 
> check. Then, do we also need to apply this global lock for
> lo_simple_ioctl(LOOP_SET_CAPACITY) path because it changes the size
> by loop_set_size(lo, get_loop_size(lo, lo->lo_backing_file)) ?
> How serious if this check is racy?
> 
> Any other locations to apply this global lock?
> 

LOOP_CHANGE_FD was introduced in 2.6.5 with the following changelog.

# 04/03/12	akpm@osdl.org	1.1608.83.42
# [PATCH] LOOP_CHANGE_FD ioctl
# 
# From: Arjan van de Ven <arjanv@redhat.com>
# 
# The patch below (written by Al Viro) solves a nasty chicken-and-egg issue
# for operating system installers (well at least anaconda but the problem
# domain is not exclusive to that)
# 
# The basic problem is this:
# 
# - The small first stage installer locates the image file of the second
#   stage installer (which has X and all the graphical stuff); this image can
#   be on the same CD, but it can come via NFS, http or ftp or ...  as well.
# 
# - The first stage installer loop-back mounts this image and gives control
#   to the second stage installer by calling some binary there.
# 
# - The graphical installer then asks the user all those questions and
#   starts installing packages.  Again the packages can come from the CD but
#   also from NFS or http or ...
# 
# Now in case of a CD install, once all requested packages from the first CD
# are installed, the installer wants to unmount and eject the CD and prompt
# the user to put CD 2 in.......  EXCEPT that the unmount can't work since
# the installer is actually running from a loopback mount of this cd.
# 
# The solution is a "LOOP_CHANGE_FD" ioctl, where basically the installer
# copies the image to the harddisk (which can only be done late since only
# late the target harddisk is mkfs'd) and then magically switches the backing
# store FD from underneath the loop device to the one on the target harddisk
# (and thus unbusying the CD mount).
# 
# This is obviously only allowed if the size of the new image is identical
# and if the loop image is read-only in the first place.  It's the
# responsibility of root to make sure the contents is the same (but that's of
# the give-root-enough-rope kind)

It is not clear why the size of old and new image files need to be the same.

It would be true that the size of old and new image files will not change
if these are stored in a read-only filesystem (e.g. isofs). But I think that
the size of new file (obtained by get_loop_size(lo, file)) and
the size of old file (obtained by get_loop_size(lo, old_file)) can change
via e.g. truncate() if these files are stored in a read-write filesystem.
Therefore,

	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
		goto out_err;

check in loop_change_fd() is racy. When we hit this race, nothing can prevent
LOOP_CHANGE_FD from succeeding, and I guess that nothing is broken by this race.
Can we kill this check (like a diff shown below)?

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cc0e8c39a48b..14adb6d5bc07 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -691,8 +691,7 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
  * a new file. This is useful for operating system installers to free up
  * the original file and in High Availability environments to switch to
  * an alternative location for the content in case of server meltdown.
- * This can only work if the loop device is used read-only, and if the
- * new backing store is the same size and type as the old backing store.
+ * This can only work if the loop device is used read-only.
  */
 static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 			  unsigned int arg)
@@ -724,12 +723,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 
 	old_file = lo->lo_backing_file;
 
-	error = -EINVAL;
-
-	/* size of the new backing store needs to be the same */
-	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
-		goto out_err;
-
 	/* and ... switch */
 	blk_mq_freeze_queue(lo->lo_queue);
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);



Also, does "the loop device is used read-only" check

        /* the loop device has to be read-only */
        error = -EINVAL;
        if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
                goto out_err;

make sense? If it is the responsibility of root to make sure that
the contents of the old and the new are the same, isn't it as well
the responsibility of root to use the loop device for read-only?
Unless there is a reason (i.e. we need this check in order to avoid
e.g. writeback failure, oops), can we also kill LO_FLAGS_READ_ONLY
check (like a diff shown below)?

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 14adb6d5bc07..af4ea57a4abb 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -691,7 +691,6 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
  * a new file. This is useful for operating system installers to free up
  * the original file and in High Availability environments to switch to
  * an alternative location for the content in case of server meltdown.
- * This can only work if the loop device is used read-only.
  */
 static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 			  unsigned int arg)
@@ -707,11 +706,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (lo->lo_state != Lo_bound)
 		goto out_err;
 
-	/* the loop device has to be read-only */
-	error = -EINVAL;
-	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
-		goto out_err;
-
 	error = -EBADF;
 	file = fget(arg);
 	if (!file)

