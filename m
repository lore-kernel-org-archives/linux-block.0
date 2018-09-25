Return-Path: <jack@suse.cz>
Date: Tue, 25 Sep 2018 10:33:20 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block/loop: Don't grab "struct file" for vfs_getattr()
 operation.
Message-ID: <20180925083320.GB6567@quack2.suse.cz>
References: <1537847461-6013-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1537847461-6013-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Tue 25-09-18 12:51:01, Tetsuo Handa wrote:
> vfs_getattr() needs "struct path" rather than "struct file".
> Let's use path_get()/path_put() rather than get_file()/fput().
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Thanks for splitting off the cleanup. The patch looks good to me. Feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index abad6d1..c2745e6 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1206,7 +1206,7 @@ static int loop_clr_fd(struct loop_device *lo)
>  static int
>  loop_get_status(struct loop_device *lo, struct loop_info64 *info)
>  {
> -	struct file *file;
> +	struct path path;
>  	struct kstat stat;
>  	int ret;
>  
> @@ -1231,16 +1231,16 @@ static int loop_clr_fd(struct loop_device *lo)
>  	}
>  
>  	/* Drop lo_ctl_mutex while we call into the filesystem. */
> -	file = get_file(lo->lo_backing_file);
> +	path = lo->lo_backing_file->f_path;
> +	path_get(&path);
>  	mutex_unlock(&lo->lo_ctl_mutex);
> -	ret = vfs_getattr(&file->f_path, &stat, STATX_INO,
> -			  AT_STATX_SYNC_AS_STAT);
> +	ret = vfs_getattr(&path, &stat, STATX_INO, AT_STATX_SYNC_AS_STAT);
>  	if (!ret) {
>  		info->lo_device = huge_encode_dev(stat.dev);
>  		info->lo_inode = stat.ino;
>  		info->lo_rdevice = huge_encode_dev(stat.rdev);
>  	}
> -	fput(file);
> +	path_put(&path);
>  	return ret;
>  }
>  
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
