Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929B7C433EF
	for <linux-block@archiver.kernel.org>; Fri, 14 Jan 2022 19:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244181AbiANT6p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jan 2022 14:58:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36810 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiANT6p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jan 2022 14:58:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3DBCD1F386;
        Fri, 14 Jan 2022 19:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642190324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E5i+R3XEiZAqOGm9b/PbA1/tHE/Gec75YDhTldr90Pk=;
        b=Gyaa0corR49SKK/z82ayItWfurTMrwvs8asemV0gb0dMWnUzniWkBEjIRUIxzDn2Seicrq
        ROjtPvC1K+fTRdzn6L4p6H/CZ4TMfmg5rXVrSGFDPPQfN1RScYfBriSfjO9LLQGGkhbR74
        9a4U5UFl4/YT7vMSTl6r3NiYU+BFlpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642190324;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E5i+R3XEiZAqOGm9b/PbA1/tHE/Gec75YDhTldr90Pk=;
        b=mXG2JN7W+HHaKcXoqxv04VbniL/pIGBZm9pbDFnB8yWvucFBLrnmEF4qbf0B/+EwTeMURl
        TurxjOieZ2wWvgBQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C59E4A3B83;
        Fri, 14 Jan 2022 19:58:43 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D5435A05DB; Fri, 14 Jan 2022 20:58:40 +0100 (CET)
Date:   Fri, 14 Jan 2022 20:58:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Message-ID: <20220114195840.kdzegicjx7uyscoq@quack3.lan>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
 <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
 <20220110103057.h775jv2br2xr2l5k@quack3.lan>
 <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
 <20220110134234.qebxn5gghqupsc7t@quack3.lan>
 <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp>
 <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan>
 <20220113104424.u6fj3z2zd34ohthc@quack3.lan>
 <f893638a-2109-c197-9783-c5e6dced23e5@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wizfrpswfn5c5lmo"
Content-Disposition: inline
In-Reply-To: <f893638a-2109-c197-9783-c5e6dced23e5@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--wizfrpswfn5c5lmo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat 15-01-22 00:50:32, Tetsuo Handa wrote:
> On 2022/01/13 19:44, Jan Kara wrote:
> > OK, so I think I understand the lockdep complaint better. Lockdep
> > essentially complains about the following scenario:
> > 
> > blkdev_put()
> >   lock disk->open_mutex
> >   lo_release
> >     __loop_clr_fd()
> >         |
> >         | wait for IO to complete
> >         v
> > loop worker
> >   write to backing file
> >     sb_start_write(file)
> >         |
> >         | wait for fs with backing file to unfreeze
> >         v
> > process holding fs frozen
> >   freeze_super()
> >         |
> >         | wait for remaining writers on the fs so that fs can be frozen
> >         v
> > sendfile()
> >   sb_start_write()
> >   do_splice_direct()
> >         |
> >         | blocked on read from /sys/power/resume, waiting for kernfs file
> >         | lock
> >         v
> > write() "/dev/loop0" (in whatever form) to /sys/power/resume
> >   calls blkdev_get_by_dev("/dev/loop0")
> >     lock disk->open_mutex => deadlock
> > 
> 
> Then, not calling flush_workqueue() from destroy_workqueue() from
> __loop_clr_fd() will not help because the reason we did not need to call
> flush_workqueue() is that blk_mq_freeze_queue() waits until all "struct
> work_struct" which flush_workqueue() would have waited completes?

Yes.

> If flush_workqueue() cannot complete because an I/O request cannot
> complete, blk_mq_freeze_queue() as well cannot complete because it waits
> for I/O requests which flush_workqueue() would have waited?
> 
> Then, any attempt to revert commit 322c4293ecc58110 ("loop: make
> autoclear operation asynchronous")
> (e.g.
> https://lkml.kernel.org/r/4e7b711f-744b-3a78-39be-c9432a3cecd2@i-love.sakura.ne.jp
> ) cannot be used?

Well, it could be used but the deadlock would be reintroduced. There are
still possibilities to fix it in some other way. But for now I think that
async loop cleanup is probably the least painful solution.

> Now that commit 322c4293ecc58110 already arrived at linux.git, we need to
> quickly send a fixup patch for these reported regressions. This "[PATCH
> v2 2/2] loop: use task_work for autoclear operation" did not address "if
> (lo->lo_state == Lo_bound) { }" part. If we address this part, something
> like below diff?

Please no. That is too ugly to live. I'd go just with attached version of
your solution. That should fix the xfstests regression. The LTP regression
needs to be fixed in mount.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--wizfrpswfn5c5lmo
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-loop-use-task_work-for-autoclear-operation.patch"

From e36d7507bd65a880b1bb032a498a74e101c5368e Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 7 Jan 2022 20:04:31 +0900
Subject: [PATCH] loop: use task_work for autoclear operation

The kernel test robot is reporting that commit 322c4293ecc58110 ("loop:
make autoclear operation asynchronous") broke xfstest which does

  umount ext2 image file on xfs
  umount xfs

sequence. Let's use task work for calling __loop_clr_fd() so that by the
time umount returns to userspace the loop device is cleaned up (unless
there are other device users but in that case the problem lies in
userspace).

Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 25 ++++++++++++++++++++-----
 drivers/block/loop.h |  5 ++++-
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..814605e2cbef 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1175,10 +1175,8 @@ static void loop_rundown_completed(struct loop_device *lo)
 	module_put(THIS_MODULE);
 }
 
-static void loop_rundown_workfn(struct work_struct *work)
+static void loop_rundown_start(struct loop_device *lo)
 {
-	struct loop_device *lo = container_of(work, struct loop_device,
-					      rundown_work);
 	struct block_device *bdev = lo->lo_device;
 	struct gendisk *disk = lo->lo_disk;
 
@@ -1188,6 +1186,18 @@ static void loop_rundown_workfn(struct work_struct *work)
 	loop_rundown_completed(lo);
 }
 
+static void loop_rundown_callbackfn(struct callback_head *callback)
+{
+	loop_rundown_start(container_of(callback, struct loop_device,
+					rundown.callback));
+}
+
+static void loop_rundown_workfn(struct work_struct *work)
+{
+	loop_rundown_start(container_of(work, struct loop_device,
+					rundown.work));
+}
+
 static void loop_schedule_rundown(struct loop_device *lo)
 {
 	struct block_device *bdev = lo->lo_device;
@@ -1195,8 +1205,13 @@ static void loop_schedule_rundown(struct loop_device *lo)
 
 	__module_get(disk->fops->owner);
 	kobject_get(&bdev->bd_device.kobj);
-	INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
-	queue_work(system_long_wq, &lo->rundown_work);
+	if (!(current->flags & PF_KTHREAD)) {
+		init_task_work(&lo->rundown.callback, loop_rundown_callbackfn);
+		if (!task_work_add(current, &lo->rundown.callback, TWA_RESUME))
+			return;
+	}
+	INIT_WORK(&lo->rundown.work, loop_rundown_workfn);
+	queue_work(system_long_wq, &lo->rundown.work);
 }
 
 static int loop_clr_fd(struct loop_device *lo)
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 918a7a2dc025..596472f9cde3 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -56,7 +56,10 @@ struct loop_device {
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
 	bool			idr_visible;
-	struct work_struct      rundown_work;
+	union {
+		struct work_struct   work;
+		struct callback_head callback;
+	} rundown;
 };
 
 struct loop_cmd {
-- 
2.31.1


--wizfrpswfn5c5lmo--
