Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C130C433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 13:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiAJNmh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 08:42:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35694 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiAJNmh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 08:42:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2664C2112B;
        Mon, 10 Jan 2022 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641822156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LEZG69IvMHeeEqQTSKmf1op1UvQ9cRWEUSHsYHoYGHU=;
        b=AO4zcq0F06C8iGjRb8P37mvnuQLi9gGlzP8blp9GkCL2K0c28dbJNaT2iAmGyavGSnAUzU
        a4fYH2xs9VoLfzPy+57uSJDKNBf8iixr9gvKok2/hbt17Tbq2stIJlln3LJr/n8szEniky
        1Jo80dVjCek5WiMoWxP3btXDN1Q1rko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641822156;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LEZG69IvMHeeEqQTSKmf1op1UvQ9cRWEUSHsYHoYGHU=;
        b=80sG7O/LVlh/yXRU2ABrXMXBQGKYmsMXOQnsjocuXqbCMfB7Dw23fI4nnEZKsE72D6ePfz
        g11zhH0muNJj+hCQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C797BA3B89;
        Mon, 10 Jan 2022 13:42:34 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 47711A05B4; Mon, 10 Jan 2022 14:42:34 +0100 (CET)
Date:   Mon, 10 Jan 2022 14:42:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Message-ID: <20220110134234.qebxn5gghqupsc7t@quack3.lan>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
 <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
 <20220110103057.h775jv2br2xr2l5k@quack3.lan>
 <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 10-01-22 20:28:28, Tetsuo Handa wrote:
> On 2022/01/10 19:30, Jan Kara wrote:
> > Eek, I agree that the patch may improve the situation but is the complexity
> > and ugliness really worth it?
> 
> If we are clear about
> 
>   Now your patch will fix this lockdep complaint but we
>   still would wait for the write to complete through blk_mq_freeze_queue()
>   (just lockdep is not clever enough to detect this). So IHMO if there was a
>   deadlock before, it will be still there with your changes.
> 
> in https://lkml.kernel.org/r/20211223134050.GD19129@quack2.suse.cz ,
> we can go with the revert approach.
> 
> I want to call blk_mq_freeze_queue() without disk->open_mutex held.
> But currently lo_release() is calling blk_mq_freeze_queue() with
> disk->open_mutex held. My patch is going towards doing locklessly
> where possible.

I see. But:
a) We didn't fully establish a real deadlock scenario from the lockdep
report, did we? The lockdep report involved suspend locks, some locks on
accessing files in /proc etc. and it was not clear whether it all reflects
a real deadlock possibility or just a fact that lockdep tracking is rather
coarse-grained at times. Now lockdep report is unpleasant and loop device
locking was ugly anyway so your async change made sense but once lockdep is
silenced we should really establish whether there is real deadlock and more
work is needed or not.

b) Unless we have a realistic plan of moving *all* blk_mq_freeze_queue()
calls from under open_mutex in loop driver, moving stuff "where possible"
from under open_mutex is IMO just muddying water.

> >                               I mean using task work in
> > loop_schedule_rundown() makes a lot of sense because the loop
> > 
> > while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
> > 
> > will not fail because of dangling work in the workqueue after umount ->
> > __loop_clr_fd().
> 
> Using task work from lo_release() is for handling close() => umount() sequence.
> Using task work in lo_open() is for handling close() => open() sequence.
> The mount in
> 
>   while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
> 
> fails unless lo_open() waits for __loop_clr_fd() to complete.

Why? If we use task work, we are guaranteed the loop device is cleaned up
before umount returns unless some other process also has the loop device
open.

> >                  But when other processes like systemd-udevd start to mess
> > with the loop device, then you have no control whether the following mount
> > will see isofs.iso busy or not - it depends on when systemd-udevd decides
> > to close the loop device.
> 
> Right. But regarding that part the main problem is that the script is not
> checking for errors. What we are expected to do is to restore barrier
> which existed before commit 322c4293ecc58110 ("loop: make autoclear
> operation asynchronous").

OK, can you explain what you exactly mean by the barrier? Because it my
understanding your patch only makes one race somewhat less likely.

> 
> >                           What your waiting in lo_open() achieves is only
> > that if __loop_clr_fd() from systemd-udevd happens to run at the same time
> > as lo_open() from mount, then we won't see EBUSY.
> 
> My waiting in lo_open() is to fix a regression that
> 
>   while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
> 
> started to fail.

OK, so you claim this loop fails even with using task work in __loop_clr_fd(),
correct? And does it fail even without systemd-udev?

> >                                                   But IMO that is not worth
> > the complexity in lo_open() because if systemd-udevd happens to close the
> > loop device a millisecond later, you will get EBUSY anyway (and you would
> > get it even in the past) Or am I missing something?
> 
> Excuse me, but lo_open() does not return EBUSY?
> What operation are you talking about?

I didn't mean EBUSY from lo_open() but EBUSY from LOOP_SET_FD ioctl(2). But
maybe I misunderstood the failure. Where exactly does mount(1) fail? Because
with the options you mention it should do something like:
  ioctl(LOOP_CTL_GET_FREE) -> get free loop dev
  ioctl(LOOP_SET_FD) -> bind isofs.iso to free loop dev
  mount(loop_dev, isofs/)

and I though it is the second syscall that fails.


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
