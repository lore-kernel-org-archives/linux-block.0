Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB6EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 13 Jan 2022 15:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbiAMPXO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jan 2022 10:23:14 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38550 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiAMPXO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jan 2022 10:23:14 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 12C47210EC;
        Thu, 13 Jan 2022 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642087393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qSWSeCaWUSn+eUSJ6lumpBZqsaFofN0fV7W4oF2Vyfg=;
        b=dWmFX/oD8aFWJaWPh9b2o1ioGD/P6RwP5/aTFjbTN8mYPMdIHpXha6PSjm+5cGq6N/F9oQ
        588hGP3JAAtiqSByMAZ1PVlluvV4qZSZ70Ldoo7h9ZDLW7gCAU0UomEvuRGh48kip2x/+2
        PAjcD+6LqVTNj9rCCVE8HQgjwKnorGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642087393;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qSWSeCaWUSn+eUSJ6lumpBZqsaFofN0fV7W4oF2Vyfg=;
        b=CLUCQXTW0QXA02rvEo22S7P8/WOfOj8hWOqurTXMxKa+K7FQzRpExKnOvijcPwCXYyPHAn
        rGvF4nG/RC0P+iAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AF4E5A3B83;
        Thu, 13 Jan 2022 15:23:12 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F2826A05E2; Thu, 13 Jan 2022 16:23:06 +0100 (CET)
Date:   Thu, 13 Jan 2022 16:23:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Message-ID: <20220113152306.n4awebeougcamvny@quack3.lan>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
 <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
 <20220110103057.h775jv2br2xr2l5k@quack3.lan>
 <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
 <20220110134234.qebxn5gghqupsc7t@quack3.lan>
 <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp>
 <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan>
 <a614bffa-d2a8-60c0-a2d9-e0ad1be17939@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a614bffa-d2a8-60c0-a2d9-e0ad1be17939@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 12-01-22 23:00:00, Tetsuo Handa wrote:
> On 2022/01/12 22:16, Jan Kara wrote:
> > I don't think we can fully solve this race in the kernel and IMO it is
> > futile to try that - depending on when exactly systemd-udev decides to
> > close /dev/loop0 and how exactly mount decides to implement its loop device
> > reuse, different strategies will / will not work.
> 
> Right, there is no perfect solution.
> Only mitigation for less likely hitting this race window is possible.
> 
> >                                                   But there is one subtlety
> > we need to solve - when __loop_clr_fd() is run outside of disk->open_mutex,
> > it can happen that next lo_open() runs before __loop_clr_fd().
> 
> Yes, but the problem (I/O error) becomes visible when read() is called.
> Also, __loop_clr_fd() from ioctl(LOOP_CLR_FD) runs outside of disk->open_mutex.

True, that path is similar. But now I have realized that once we decide to
tear down the loop device we set lo_state to Lo_rundown and so ioctls such
as LOOP_GET_STATUS start to fail and also new IO submissions start to fail
with IO error. So from userspace POV everything should be consistent.

> >                                                               Thus we can
> > hand away a file descriptor to a loop device that is half torn-down and
> > will be cleaned up in uncontrollable point in the future which can lead to
> > interesting consequences when the device is used at that time as well.
> 
> Right, but I don't think we can solve this.

Well, we cannot guarantee what will be state of the loop device when you
open it but I think we should guarantee that once you have loop device
open, it will not be torn down under your hands. And now that I have
realized there are those lo_state checks, I think everything is fine in
that regard. I wanted to make sure that sequence such as:

	fd = open(loop device)
 	ioctl(fd, LOOP_GET_STATUS, &stats)
	verify in stats loop dev has parameters we want
	... use loop device ...

is race free and that already seems to be the case - once LOOP_GET_STATUS
does not return error, we know there is no pending loop device shutdown.
So the only bug seems to be in mount(8) code where the loop device reuse
detection is racy and the subtle change in the timing with your loop
changes makes it break. I'll write to util-linux maintainer about this.

> We don't want to hold disk->open_mutex and/or lo->lo_mutex when
> an I/O request on this loop device is issued, do we?

Currently, we may hold both. With your async patch we hold only lo_mutex.
Now that I better understand the nature of the deadlock, I agree that
holding either still creates the deadlock possibility because both are
acquired on loop device open. But now that I reminded myself the lo_state
handling, I think the following should be safe in __loop_clr_fd:

	/* Just a safety check... */
	if (WARN_ON_ONCE(data_race(lo->lo_state) != Lo_rundown))
		return -ENXIO;

	/*
	 * With Lo_rundown state, no new work can be queued. Flush pending
	 * IO and destroy workqueue.
	 */
	blk_mq_freeze_queue(lo->lo_queue);
	destroy_workqueue(lo->workqueue);

	mutex_lock(&lo->lo_mutex);
	... do the rest of the teardown ...


> Do we want to hold disk->open_mutex when calling __loop_clr_fd() from
> loop_clr_fd() ? That might be useful for avoiding some race situation
> but is counter way to locking simplification.

No, I'm not suggesting that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
