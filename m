Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D00C433EF
	for <linux-block@archiver.kernel.org>; Fri, 14 Jan 2022 16:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243266AbiANQVQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jan 2022 11:21:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58788 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiANQVQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jan 2022 11:21:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 44D1921129;
        Fri, 14 Jan 2022 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642177275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Kk5LXJ2ri231HYkIxeoUDJk+06B5IheewsWprd9rno=;
        b=mq3fVL2XmUaWAOMPTkrppBjpmK8MHo2AdZArQxHUG/Efb+lMyi3MuH1nmGLwH4YbJYkhde
        DsENc8sTt8+TcMQRETq4PmdoeNNEG1JTxVYvAU1E8wLwVjRAk0UZP/V9CN1tsIcmnjiGkv
        qt4kjDOntvSaBZnUvZ3IzspGzpsfyk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642177275;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Kk5LXJ2ri231HYkIxeoUDJk+06B5IheewsWprd9rno=;
        b=6WAtT3SBS8yCbf4SwqX9FhJUOhy3P4gaK4Neg8ID1ZAUccRv/bf5+x1eZ01kXlfSkeH36e
        yVcqueaYiUvUi6Cw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 359E1A3B83;
        Fri, 14 Jan 2022 16:21:15 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 17BB1A05B3; Fri, 14 Jan 2022 17:05:45 +0100 (CET)
Date:   Fri, 14 Jan 2022 17:05:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Message-ID: <20220114160545.lsgge7aom7rdttmo@quack3.lan>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
 <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
 <20220110103057.h775jv2br2xr2l5k@quack3.lan>
 <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
 <20220110134234.qebxn5gghqupsc7t@quack3.lan>
 <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp>
 <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan>
 <a614bffa-d2a8-60c0-a2d9-e0ad1be17939@I-love.SAKURA.ne.jp>
 <20220113152306.n4awebeougcamvny@quack3.lan>
 <37878b0a-da3b-1285-4f42-27871bfaddee@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37878b0a-da3b-1285-4f42-27871bfaddee@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 14-01-22 20:05:31, Tetsuo Handa wrote:
> On 2022/01/14 0:23, Jan Kara wrote:
> > Well, we cannot guarantee what will be state of the loop device when you
> > open it but I think we should guarantee that once you have loop device
> > open, it will not be torn down under your hands. And now that I have
> > realized there are those lo_state checks, I think everything is fine in
> > that regard. I wanted to make sure that sequence such as:
> 
> Well, we could abort __loop_clr_fd() if somebody called "open()", something
> like below. But
> 
> ----------------------------------------
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index b1b05c45c07c..960db2c484ab 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1082,7 +1082,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	return error;
>  }
>  
> -static void __loop_clr_fd(struct loop_device *lo)
> +static bool __loop_clr_fd(struct loop_device *lo, int expected_refcnt)
>  {
>  	struct file *filp;
>  	gfp_t gfp = lo->old_gfp_mask;
> @@ -1104,9 +1104,19 @@ static void __loop_clr_fd(struct loop_device *lo)
>  	 * Since this function is called upon "ioctl(LOOP_CLR_FD)" xor "close()
>  	 * after ioctl(LOOP_CLR_FD)", it is a sign of something going wrong if
>  	 * lo->lo_state has changed while waiting for lo->lo_mutex.
> +	 *
> +	 * However, if somebody called "open()" after lo->lo_state became
> +	 * Lo_rundown, we should abort rundown in order to avoid unexpected
> +	 * I/O error.
>  	 */
>  	mutex_lock(&lo->lo_mutex);
>  	BUG_ON(lo->lo_state != Lo_rundown);
> +	if (atomic_read(&lo->lo_refcnt) != expected_refcnt) {
> +		lo->lo_state = Lo_bound;
> +		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
> +		mutex_unlock(&lo->lo_mutex);
> +		return false;
> +	}
>  	mutex_unlock(&lo->lo_mutex);

Yeah, but as I wrote in my email, I don't think this is needed anymore (and
I even think it would be counterproductive). There can be new opens
happening before __loop_clr_fd() but any ioctl querying loop device state
will return error due to lo->lo_state == Lo_rundown. So from userspace POV
the loop device is already invalidated.

> > Currently, we may hold both. With your async patch we hold only lo_mutex.
> > Now that I better understand the nature of the deadlock, I agree that
> > holding either still creates the deadlock possibility because both are
> > acquired on loop device open. But now that I reminded myself the lo_state
> > handling, I think the following should be safe in __loop_clr_fd:
> > 
> > 	/* Just a safety check... */
> > 	if (WARN_ON_ONCE(data_race(lo->lo_state) != Lo_rundown))
> > 		return -ENXIO;
> > 
> 
> this is still racy, for somebody can reach lo_open() right after this check.

Yes, somebody can open but he cannot change lo->lo_state. Also this should
be just a safety check. We should never reach __loop_clr_fd() with
different lo_state.

> Anyway, since the problem that umount() immediately after close() (reported by
> kernel test robot) remains, we need to make sure that __loop_clr_fd() completes
> before close() returns to user mode.

I agree with this. But using task_work for __loop_clr_fd() is enough for
that. I was just arguing that we don't need extra waiting in lo_open().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
