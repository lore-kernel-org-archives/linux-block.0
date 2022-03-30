Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA709C433F5
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 08:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbiC3IP4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 04:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbiC3IPz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 04:15:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D31DBBC
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 01:14:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A8DAA1F37B;
        Wed, 30 Mar 2022 08:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648628046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e3DMJp9nphLsLvcjfDMvgaqnLJ4znnl+dEDdp+bNsQY=;
        b=IsF5tLAEYxuxjPV4WX8DDBeyosJeRLngcBo/Xd6RfiKLHvgMAVeuG9QMoD60OGxm3yUWsw
        5Rde+vp2XSE22g8i1i+i6xexxlR5SxfAi/50i/G/9bk6rHBDKqIITgEmUxgWOE+BGZIR8z
        qrIX+xFJNN9kBMeM4OBy759GxNSeCWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648628046;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e3DMJp9nphLsLvcjfDMvgaqnLJ4znnl+dEDdp+bNsQY=;
        b=hSlg0azAyUWECtOw0xb4wYpOdD4fOyMDcqkVU3GYt31BhIBditXYw8XPJrOnkHzuGWVw5w
        /FliLDE+SkN4G2Aw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7C58EA3B8A;
        Wed, 30 Mar 2022 08:14:06 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A2D5EA0610; Wed, 30 Mar 2022 10:14:00 +0200 (CEST)
Date:   Wed, 30 Mar 2022 10:14:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: [PATCH 15/14] loop: avoid loop_validate_mutex/lo_mutex in
 ->release
Message-ID: <20220330081400.womvc72fqnj6i44t@quack3.lan>
References: <20220325063929.1773899-1-hch@lst.de>
 <fda9e2b7-d1db-e00c-98aa-e8ff555b88eb@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fda9e2b7-d1db-e00c-98aa-e8ff555b88eb@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 30-03-22 00:36:49, Tetsuo Handa wrote:
> Since ->release is called with disk->open_mutex held, and __loop_clr_fd()
>  from lo_release() is called via ->release when disk_openers() == 0, we are
> guaranteed that "struct file" which will be passed to loop_validate_file()
> via fget() cannot be the loop device __loop_clr_fd(lo, true) will clear.
> Thus, there is no need to hold loop_validate_mutex from __loop_clr_fd()
> if release == true.
> 
> When I made commit 3ce6e1f662a91097 ("loop: reintroduce global lock for
> safe loop_validate_file() traversal"), I wrote "It is acceptable for
> loop_validate_file() to succeed, for actual clear operation has not started
> yet.". But now I came to feel why it is acceptable to succeed.
> 
> It seems that the loop driver was added in Linux 1.3.68, and
> 
>   if (lo->lo_refcnt > 1)
>     return -EBUSY;
> 
> check in loop_clr_fd() was there from the beginning. The intent of this
> check was unclear. But now I think that current
> 
>   disk_openers(lo->lo_disk) > 1
> 
> form is there for three reasons.
> 
> (1) Avoid I/O errors when some process which opens and reads from this
>     loop device in response to uevent notification (e.g. systemd-udevd),
>     as described in commit a1ecac3b0656a682 ("loop: Make explicit loop
>     device destruction lazy"). This opener is short-lived because it is
>     likely that the file descriptor used by that process is closed soon.
> 
> (2) Avoid I/O errors caused by underlying layer of stacked loop devices
>     (i.e. ioctl(some_loop_fd, LOOP_SET_FD, other_loop_fd)) being suddenly
>     disappeared. This opener is long-lived because this reference is
>     associated with not a file descriptor but lo->lo_backing_file.
> 
> (3) Avoid I/O errors caused by underlying layer of mounted loop device
>     (i.e. mount(some_loop_device, some_mount_point)) being suddenly
>     disappeared. This opener is long-lived because this reference is
>     associated with not a file descriptor but mount.
> 
> While race in (1) might be acceptable, (2) and (3) should be checked
> racelessly. That is, make sure that __loop_clr_fd() will not run if
> loop_validate_file() succeeds, by doing refcount check with global lock
> held when explicit loop device destruction is requested.
> 
> As a result of no longer waiting for lo->lo_mutex after setting Lo_rundown,
> we can remove pointless BUG_ON(lo->lo_state != Lo_rundown) check.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Yeah, the patch makes sense to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 38 +++++++++++++-------------------------
>  1 file changed, 13 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 2506193a4fd1..6b813c592159 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1135,27 +1135,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
>  	struct file *filp;
>  	gfp_t gfp = lo->old_gfp_mask;
>  
> -	/*
> -	 * Flush loop_configure() and loop_change_fd(). It is acceptable for
> -	 * loop_validate_file() to succeed, for actual clear operation has not
> -	 * started yet.
> -	 */
> -	mutex_lock(&loop_validate_mutex);
> -	mutex_unlock(&loop_validate_mutex);
> -	/*
> -	 * loop_validate_file() now fails because l->lo_state != Lo_bound
> -	 * became visible.
> -	 */
> -
> -	/*
> -	 * Since this function is called upon "ioctl(LOOP_CLR_FD)" xor "close()
> -	 * after ioctl(LOOP_CLR_FD)", it is a sign of something going wrong if
> -	 * lo->lo_state has changed while waiting for lo->lo_mutex.
> -	 */
> -	mutex_lock(&lo->lo_mutex);
> -	BUG_ON(lo->lo_state != Lo_rundown);
> -	mutex_unlock(&lo->lo_mutex);
> -
>  	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
>  		blk_queue_write_cache(lo->lo_queue, false, false);
>  
> @@ -1238,11 +1217,20 @@ static int loop_clr_fd(struct loop_device *lo)
>  {
>  	int err;
>  
> -	err = mutex_lock_killable(&lo->lo_mutex);
> +	/*
> +	 * Since lo_ioctl() is called without locks held, it is possible that
> +	 * loop_configure()/loop_change_fd() and loop_clr_fd() run in parallel.
> +	 *
> +	 * Therefore, use global lock when setting Lo_rundown state in order to
> +	 * make sure that loop_validate_file() will fail if the "struct file"
> +	 * which loop_configure()/loop_change_fd() found via fget() was this
> +	 * loop device.
> +	 */
> +	err = loop_global_lock_killable(lo, true);
>  	if (err)
>  		return err;
>  	if (lo->lo_state != Lo_bound) {
> -		mutex_unlock(&lo->lo_mutex);
> +		loop_global_unlock(lo, true);
>  		return -ENXIO;
>  	}
>  	/*
> @@ -1257,11 +1245,11 @@ static int loop_clr_fd(struct loop_device *lo)
>  	 */
>  	if (disk_openers(lo->lo_disk) > 1) {
>  		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
> -		mutex_unlock(&lo->lo_mutex);
> +		loop_global_unlock(lo, true);
>  		return 0;
>  	}
>  	lo->lo_state = Lo_rundown;
> -	mutex_unlock(&lo->lo_mutex);
> +	loop_global_unlock(lo, true);
>  
>  	__loop_clr_fd(lo, false);
>  	return 0;
> -- 
> 2.32.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
