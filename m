Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCFFC433FE
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 13:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353426AbiALNQ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:16:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52612 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353522AbiALNQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 08:16:18 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2E0D9210FB;
        Wed, 12 Jan 2022 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641993376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lXRsaAFqjIRinqATp45pgGoeydbBHOeXpNP9DwrtPDE=;
        b=nmdU0+aSPioXE1Vh98upleOrKyy7CDV9JPNRgc49LLFvBgdMDpQHjqdZlBKXPFoopIiRfo
        fWWikTbUJ6z5EJBiw8mgqmMHXNZMnv25/mtwTpR5XUZwTE5+CIHMDcqbMtxrvDRi2vuXbf
        AcaMGEtHs6+moR5wLYC6Lza4znYBzYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641993376;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lXRsaAFqjIRinqATp45pgGoeydbBHOeXpNP9DwrtPDE=;
        b=4oEpti54mUHpIBTbx6jpw72bPNcjrAkY7iYQQtWhnmzu1dfYaNm/qtQ5pSOkUArPUrPE1T
        2GmeSa/+MS9NGACQ==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 17AFFA3B8B;
        Wed, 12 Jan 2022 13:16:11 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7A16EA059C; Wed, 12 Jan 2022 14:16:15 +0100 (CET)
Date:   Wed, 12 Jan 2022 14:16:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Message-ID: <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
 <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
 <20220110103057.h775jv2br2xr2l5k@quack3.lan>
 <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
 <20220110134234.qebxn5gghqupsc7t@quack3.lan>
 <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 11-01-22 00:08:56, Tetsuo Handa wrote:
> On 2022/01/10 22:42, Jan Kara wrote:
> > a) We didn't fully establish a real deadlock scenario from the lockdep
> > report, did we? The lockdep report involved suspend locks, some locks on
> > accessing files in /proc etc. and it was not clear whether it all reflects
> > a real deadlock possibility or just a fact that lockdep tracking is rather
> > coarse-grained at times. Now lockdep report is unpleasant and loop device
> > locking was ugly anyway so your async change made sense but once lockdep is
> > silenced we should really establish whether there is real deadlock and more
> > work is needed or not.
> 
> Not /proc files but /sys/power/resume file.
> Here is a reproducer but I can't test whether we can trigger a real deadlock.
> 
> ----------------------------------------
> #include <stdio.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/ioctl.h>
> #include <linux/loop.h>
> #include <sys/sendfile.h>
> 
> int main(int argc, char *argv[])
> {
> 	const int file_fd = open("testfile", O_RDWR | O_CREAT, 0600);
> 	ftruncate(file_fd, 1048576);
> 	char filename[128] = { };
> 	const int loop_num = ioctl(open("/dev/loop-control", 3), LOOP_CTL_GET_FREE, 0);
> 	snprintf(filename, sizeof(filename) - 1, "/dev/loop%d", loop_num);
> 	const int loop_fd_1 = open(filename, O_RDWR);
> 	ioctl(loop_fd_1, LOOP_SET_FD, file_fd);
> 	const int loop_fd_2 = open(filename, O_RDWR);
> 	ioctl(loop_fd_1, LOOP_CLR_FD, 0);
> 	const int sysfs_fd = open("/sys/power/resume", O_RDWR);
> 	sendfile(file_fd, sysfs_fd, 0, 1048576);
> 	sendfile(loop_fd_2, file_fd, 0, 1048576);
> 	write(sysfs_fd, "700", 3);
> 	close(loop_fd_2);
> 	close(loop_fd_1); // Lockdep complains.
> 	close(file_fd);
> 	return 0;
> }
> ----------------------------------------

Thanks for the reproducer. I will try to simplify it even more and figure
out whether there is a real deadlock potential in the lockdep complaint or
not...

> > b) Unless we have a realistic plan of moving *all* blk_mq_freeze_queue()
> > calls from under open_mutex in loop driver, moving stuff "where possible"
> > from under open_mutex is IMO just muddying water.
> 
> As far as I know, only lo_open() and lo_release() are functions which are
> called with disk->open_mutex held in loop driver. And only lo_release() calls
> blk_mq_freeze_queue() with disk->open_mutex held.
> 
> blk_mq_freeze_queue() from __loop_clr_fd() from lo_release() (I mean, autoclear
> part) can be done without disk->open_mutex held if we call __loop_clr_fd() from
> task work context. And I think blk_mq_freeze_queue() from lo_release() (I mean,
> "if (lo->lo_state == Lo_bound) { }" part) can be done in the same manner.
> 
> Therefore, I think this is not "partial move" but "complete move".

OK, fair point.

> >>>                               I mean using task work in
> >>> loop_schedule_rundown() makes a lot of sense because the loop
> >>>
> >>> while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
> >>>
> >>> will not fail because of dangling work in the workqueue after umount ->
> >>> __loop_clr_fd().
> >>
> >> Using task work from lo_release() is for handling close() => umount() sequence.
> >> Using task work in lo_open() is for handling close() => open() sequence.
> >> The mount in
> >>
> >>   while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
> >>
> >> fails unless lo_open() waits for __loop_clr_fd() to complete.
> > 
> > Why? If we use task work, we are guaranteed the loop device is cleaned up
> > before umount returns unless some other process also has the loop device
> > open.
> 
> Since systemd-udevd opens this loop device asynchronously,
> __loop_clr_fd() from lo_release() is called by not mount or umount but
> systemd-udevd. This means that we are not guaranteed that the loop device
> is cleaned up before umount returns.

OK, understood. Thanks for explanation.

...
> >>>                           What your waiting in lo_open() achieves is only
> >>> that if __loop_clr_fd() from systemd-udevd happens to run at the same time
> >>> as lo_open() from mount, then we won't see EBUSY.
> >>
> >> My waiting in lo_open() is to fix a regression that
> >>
> >>   while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
> >>
> >> started to fail.
> > 
> > OK, so you claim this loop fails even with using task work in __loop_clr_fd(),
> > correct?
> 
> Correct. If we run this loop with
> https://lkml.kernel.org/r/9eff2034-2f32-54a3-e476-d0f609ab49c0@i-love.sakura.ne.jp ,
> we get errors like below.
> 
> ----------------------------------------
> root@fuzz:/mnt# while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
> mount: /mnt/isofs: can't read superblock on /dev/loop0.
> umount: isofs/: not mounted.

OK, so I was still wondering why this happens and now after poking a bit
more into util-linux I think I understand. As you say, someone
(systemd-udev in our case) has /dev/loop0 open when umount isofs/ runs. So
/dev/loop0 stays alive after umount. Then mount runs, sees /dev/loop0 is
still attached to isofs.iso and wants to reuse it for mount but before it
gets to opening the loop device in mnt_context_setup_loopdev(), the loop
device is already cleaned up. Open still succeeds but because backing file
is detached, by the time mount(2) tries to do any IO, it fails.

I don't think we can fully solve this race in the kernel and IMO it is
futile to try that - depending on when exactly systemd-udev decides to
close /dev/loop0 and how exactly mount decides to implement its loop device
reuse, different strategies will / will not work. But there is one subtlety
we need to solve - when __loop_clr_fd() is run outside of disk->open_mutex,
it can happen that next lo_open() rus before __loop_clr_fd(). Thus we can
hand away a file descriptor to a loop device that is half torn-down and
will be cleaned up in uncontrollable point in the future which can lead to
interesting consequences when the device is used at that time as well.

Perhaps we can fix these problems by checking lo_refcnt in __loop_clr_fd()
once we grab lo_mutex and thus make sure the device still should be
destroyed?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
