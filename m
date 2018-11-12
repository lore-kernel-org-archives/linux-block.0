Return-Path: <jack@suse.cz>
Date: Mon, 12 Nov 2018 12:02:00 +0100
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: axboe@kernel.dk, Jan Kara <jack@suse.cz>,
	syzbot <syzbot+c0138741c2290fc5e63f@syzkaller.appspotmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: locking bug in loop_control_ioctl
Message-ID: <20181112110200.GB7175@quack2.suse.cz>
References: <00000000000026aaac057a40a183@google.com>
 <913c3703-f6d3-a412-3b0c-ebc7422e8e69@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <913c3703-f6d3-a412-3b0c-ebc7422e8e69@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Sat 10-11-18 17:09:09, Tetsuo Handa wrote:
> From 4b9e5556fada37dff1eff13665a229b69e1f7dd8 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sat, 10 Nov 2018 17:04:40 +0900
> Subject: [PATCH] loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl().
> 
> Commit 0a42e99b58a20883 ("loop: Get rid of loop_index_mutex") forgot to
> remove mutex_unlock(&loop_ctl_mutex) from loop_control_ioctl() when
> replacing loop_index_mutex with loop_ctl_mutex.
> 
> Reported-by: syzbot <syzbot+c0138741c2290fc5e63f@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Jan Kara <jack@suse.cz>

Yeah, my bad. Thanks for fixing this. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index bf6bc35..176ab1f 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2074,12 +2074,10 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
>  			break;
>  		if (lo->lo_state != Lo_unbound) {
>  			ret = -EBUSY;
> -			mutex_unlock(&loop_ctl_mutex);
>  			break;
>  		}
>  		if (atomic_read(&lo->lo_refcnt) > 0) {
>  			ret = -EBUSY;
> -			mutex_unlock(&loop_ctl_mutex);
>  			break;
>  		}
>  		lo->lo_disk->private_data = NULL;
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
