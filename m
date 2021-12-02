Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DAEC433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Dec 2021 12:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhLBMTs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Dec 2021 07:19:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47178 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357729AbhLBMTm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Dec 2021 07:19:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 098B11FD39;
        Thu,  2 Dec 2021 12:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638447376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bqHORWyAMXkhsNEMrkzaUn7507eNGMZOmslhy4VR9yo=;
        b=cBSv4MAP8Sa8gXojzQoLvq6SgSKFR6F0AebY6CtStfeegpMEvBW1v//aCpdVOaLXuta9tl
        20RLKf7X+zqCfe+YE6ZQVGNiaiFbrPZpmHeIU6YPWS4XIHXCeqwnOA33wTjlIZ3xnFYVm6
        6ylAiFGDw5g0Dg6smKZ44EjavOLeEfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638447376;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bqHORWyAMXkhsNEMrkzaUn7507eNGMZOmslhy4VR9yo=;
        b=d2j+YG3lvPfnPKIpLGfRwAq+DyCUrSMUdg47KcqC0t5MygTcIyOXW5UkUd3n8ePacQJunu
        eIQOiYuvIALaClAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id CCEB8A4759;
        Thu,  2 Dec 2021 12:16:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5B2361F2CB1; Thu,  2 Dec 2021 13:16:15 +0100 (CET)
Date:   Thu, 2 Dec 2021 13:16:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] loop: make autoclear operation asynchronous
Message-ID: <20211202121615.GC1815@quack2.suse.cz>
References: <0000000000007f2f5405d1bfe618@google.com>
 <e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp>
 <bb3c04cf-3955-74d5-1e75-ae37a44f2197@i-love.sakura.ne.jp>
 <20c6dcbd-1b71-eaee-5213-02ded93951fc@i-love.sakura.ne.jp>
 <YaSpkRHgEMXrcn5i@infradead.org>
 <baeeebb3-c04e-ce0a-cb1d-56eb4a7e1914@i-love.sakura.ne.jp>
 <YaYfu0H2k0PSQL6W@infradead.org>
 <de6ec247-4a2d-7c3e-3700-90604f88e901@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de6ec247-4a2d-7c3e-3700-90604f88e901@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 01-12-21 23:41:23, Tetsuo Handa wrote:
> On 2021/11/30 21:57, Christoph Hellwig wrote:
> > On Mon, Nov 29, 2021 at 07:36:27PM +0900, Tetsuo Handa wrote:
> >> If the caller just want to call ioctl(LOOP_CTL_GET_FREE) followed by
> >> ioctl(LOOP_CONFIGURE), deferring __loop_clr_fd() would be fine.
> >>
> >> But the caller might want to unmount as soon as fput(filp) from __loop_clr_fd() completes.
> >> I think we need to wait for __loop_clr_fd() from lo_release() to complete.
> > 
> > Anything else could have a reference to this or other files as well.
> > So I can't see how deferring the clear to a different context can be
> > any kind of problem in practice.
> > 
> 
> OK. Here is a patch.
> Is this better than temporarily dropping disk->open_mutex ?

The patch looks good to me. Just one suggestion for improvement:

> +static void loop_schedule_rundown(struct loop_device *lo)
> +{
> +	struct block_device *bdev = lo->lo_device;
> +	struct gendisk *disk = lo->lo_disk;
> +
> +	__module_get(disk->fops->owner);
> +	kobject_get(&bdev->bd_device.kobj);
> +	INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
> +	queue_work(system_long_wq, &lo->rundown_work);
>  }

Why not scheduling this using task_work_add()? It solves the locking
context problems, has generally lower overhead than normal work (no need to
schedule), and avoids possible unexpected side-effects of releasing
loopback device later. Also task work is specifically designed so that one
task work can queue another task work so we should be fine using it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
