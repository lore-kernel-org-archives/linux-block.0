Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727309AbeIYOxj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Sep 2018 10:53:39 -0400
Date: Tue, 25 Sep 2018 10:47:09 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        syzbot
        <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>
Subject: Re: [PATCH] block/loop: Don't hold lock while rereading partition.
Message-ID: <20180925084709.GD6567@quack2.suse.cz>
References: <1537852203-3193-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1537852203-3193-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue 25-09-18 14:10:03, Tetsuo Handa wrote:
> syzbot is reporting circular locking dependency between bdev->bd_mutex and
> lo->lo_ctl_mutex [1] which is caused by calling blkdev_reread_part() with
> lock held. Don't hold loop_ctl_mutex while calling blkdev_reread_part().
> Also, bring bdgrab() at loop_set_fd() to before loop_reread_partitions()
> in case loop_clr_fd() is called while blkdev_reread_part() from
> loop_set_fd() is in progress.
> 
> [1] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>

Thank you for splitting out this patch. Some comments below.

> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 920cbb1..877cca8 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -632,7 +632,12 @@ static void loop_reread_partitions(struct loop_device *lo,
>  				   struct block_device *bdev)
>  {
>  	int rc;
> +	char filename[LO_NAME_SIZE];
> +	const int num = lo->lo_number;
> +	const int count = atomic_read(&lo->lo_refcnt);
>  
> +	memcpy(filename, lo->lo_file_name, sizeof(filename));
> +	mutex_unlock(&loop_ctl_mutex);
>  	/*
>  	 * bd_mutex has been held already in release path, so don't
>  	 * acquire it if this function is called in such case.
> @@ -641,13 +646,14 @@ static void loop_reread_partitions(struct loop_device *lo,
>  	 * must be at least one and it can only become zero when the
>  	 * current holder is released.
>  	 */
> -	if (!atomic_read(&lo->lo_refcnt))
> +	if (!count)
>  		rc = __blkdev_reread_part(bdev);
>  	else
>  		rc = blkdev_reread_part(bdev);
> +	mutex_lock(&loop_ctl_mutex);
>  	if (rc)
>  		pr_warn("%s: partition scan of loop%d (%s) failed (rc=%d)\n",
> -			__func__, lo->lo_number, lo->lo_file_name, rc);
> +			__func__, num, filename, rc);
>  }

I still don't quite like this. It is non-trivial to argue that the
temporary dropping of loop_ctl_mutex in loop_reread_partitions() is OK for
all it's callers. I'm really strongly in favor of unlocking the mutex in
the callers of loop_reread_partitions() and reorganizing the code there so
that loop_reread_partitions() is called as late as possible so that it is
clear that dropping the mutex is fine (and usually we don't even have to
reacquire it). Plus your patch does not seem to take care of the possible
races of loop_clr_fd() with LOOP_CTL_REMOVE? See my other mail for
details...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
