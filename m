Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DC4C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 12:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355678AbiCPM1l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 08:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355735AbiCPM1b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 08:27:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C09166221
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 05:26:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9B111210FF;
        Wed, 16 Mar 2022 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647433575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y4knpUsII7JkwHNeMRAluZYtfBaGTxsL98qeTJVC3ew=;
        b=uh+B5/+JFbQRd7NZU8Vxjd594nVSdFqZVwQ5F0U5zFhVPv15lMSX68QfBWikp3OFHdL65B
        DyxmfsYudFJU3VhXkrbc1kiHh/IUPPdEyY0m/l6qu7gB4UIwgTVV8tkQ/PGvToIiZAu7rV
        EDbFgT7+uw3CMsRTHf4NXITbiupAmg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647433575;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y4knpUsII7JkwHNeMRAluZYtfBaGTxsL98qeTJVC3ew=;
        b=Hqbwnqw1wRF0h7sI9pJBDl84V/13Qvm9uVoTgzGDDJoip7ynEYfeyAh842nMASjf8D9Lm9
        EJAWq5Scf91gYpCg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 06B9AA3B83;
        Wed, 16 Mar 2022 12:26:10 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F1104A0615; Wed, 16 Mar 2022 13:26:14 +0100 (CET)
Date:   Wed, 16 Mar 2022 13:26:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+6479585dfd4dedd3f7e1@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] loop: don't hold lo->lo_mutex from lo_open() and
 lo_release()
Message-ID: <20220316122614.6fmgrx55n4st7tsp@quack3.lan>
References: <00000000000099c4ca05da07e42f@google.com>
 <bbdd20da-bccb-2dbb-7c46-be06dcfc26eb@I-love.SAKURA.ne.jp>
 <613b094e-2b76-11b7-458b-553aafaf0df7@I-love.SAKURA.ne.jp>
 <20220314152318.k4cvwe737q5r5juw@quack3.lan>
 <20220315084458.GA3911@lst.de>
 <134d1b65-f7c0-b8b3-d6c9-4a5e1d807afd@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <134d1b65-f7c0-b8b3-d6c9-4a5e1d807afd@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 15-03-22 19:57:25, Tetsuo Handa wrote:
> On 2022/03/15 17:44, Christoph Hellwig wrote:
> On 2022/03/15 0:23, Jan Kara wrote:
> > On Mon 14-03-22 00:15:22, Tetsuo Handa wrote:
> >> syzbot is reporting circular locking problem at __loop_clr_fd() [1], for
> >> commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
> >> is calling destroy_workqueue() with disk->open_mutex held.
> >>
> >> Commit 322c4293ecc58110 ("loop: make autoclear operation asynchronous")
> >> tried to fix this problem by deferring __loop_clr_fd() from lo_release()
> >> to a WQ context, but that commit was reverted because there are userspace
> >> programs which depend on that __loop_clr_fd() completes by the moment
> >> close() returns to user mode.
> >>
> >> This time, we try to fix this problem by deferring __loop_clr_fd() from
> >> lo_release() to a task work context. Since task_work_add() is not exported
> >> but Christoph does not want to export it, this patch uses anonymous inode
> >> interface as a wrapper for calling task_work_add() via fput().
> >>
> >> Although Jan has found two bugs in /bin/mount where one of these was fixed
> >> in util-linux package [2], I found that not holding lo->lo_mutex from
> >> lo_open() causes occasional I/O error [3] (due to
> >>
> >> 	if (lo->lo_state != Lo_bound)
> >> 		return BLK_STS_IOERR;
> >>
> >> check in loop_queue_rq()) when systemd-udevd opens a loop device and
> >> reads from it before loop_configure() updates lo->lo_state to Lo_bound.
> > 
> > Thanks for detailed explanation here. Finally, I can see what is the
> > problem with the open path. A few questions here:
> > 
> > 1) Can you please remind me why do we need to also remove the lo_mutex from
> > lo_open()? The original lockdep problem was only for __loop_clr_fd(),
> > wasn't it?
> 
> Right, but from locking dependency chain perspective, holding
> lo->lo_mutex from lo_open()/lo_release() is treated as if
> lo_open()/lo_release() waits for flush of I/O with lo->lo_mutex held,
> even if it is not lo_open()/lo_release() which actually flushes I/O with
> lo->lo_mutex held.
> 
> We need to avoid holding lo->lo_mutex from lo_open()/lo_release() while
> avoiding problems caused by not waiting for loop_configure()/__loop_clr_fd().

I thought the whole point of these patches is to move waiting for IO from
under lo->lo_mutex and disk->open_mutex? And if we do that, there's no
problem with open needing either of these mutexes? What am I missing?

Anyway, I have no problem with removing lo->lo_mutex from lo_open() as e.g.
Christoph done it. I just disliked the task work magic you did there...

> > 2) Cannot we just move the generation of DISK_EVENT_MEDIA_CHANGE event
> > after the moment the loop device is configured? That way systemd won't
> > start probing the new loop device until it is fully configured.
> 
> Do you mean
> 
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1024,7 +1024,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>                 goto out_unlock;
>         }
> 
> -       disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
>         set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
> 
>         INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
> @@ -1066,6 +1065,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>         wmb();
> 
>         lo->lo_state = Lo_bound;
> +       disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
>         if (part_shift)
>                 lo->lo_flags |= LO_FLAGS_PARTSCAN;
>         partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
> 
> ? Maybe possible, but looks strange.

Yes, something like that. But disk_force_media_change() has some
invalidation in it as well and that may need to stay in the original place
- needs a bit more thought & validation.

> Such change will defer only open()->read() sequence triggered via
> kobject_uevent(KOBJ_CHANGE). My patch defers all open() from userspace,
> like we did until 5.11.

Correct. But EIO error is the correct return if you access unbound loop
device. It is only after we tell userspace the device exists (i.e., after
we send the event), when we should better make sure the IO succeeds.

> > Because the less hacks with task_work we have the better.
> > 
> > Also I don't think the deadlock is really fixed when you wait for
> > __loop_clr_fd() during open. It is maybe just hidden from lockdep.
> 
> Since lo_post_open() is called with no locks held, how can waiting
> for __loop_clr_fd() after lo_open() can cause deadlock? The reason to
> choose task_work context is to synchronize without any other locks held.

Sorry, I was wrong here. It will not cause deadlock. But in-kernel openers
of the block device like swsusp_check() in kernel/power/swap.c (using
blkdev_get_by_dev()) will be now operating on a loop device without waiting
for __loop_clr_fd(). Which is I guess fine but the inconsistency between
in-kernel and userspace bdev openers would be a bit weird. Anyway,
Christophs patches look like a cleaner way forward to me...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
