Return-Path: <jack@suse.cz>
Date: Mon, 24 Sep 2018 20:47:34 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Ming Lei <ming.lei@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
	syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
Subject: Re: [PATCH v4] block/loop: Serialize ioctl operations.
Message-ID: <20180924184734.GH28775@quack2.suse.cz>
References: <1537009136-4839-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1af79300-cb04-36e3-a650-168a5942161f@i-love.sakura.ne.jp>
 <20180923220300.GA12589@ming.t460p>
 <ba535251-c206-6242-3e6d-a4ed825c8114@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ba535251-c206-6242-3e6d-a4ed825c8114@i-love.sakura.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Mon 24-09-18 19:29:10, Tetsuo Handa wrote:
> From 2278250ac8c5b912f7eb7af55e36ed40e2f7116b Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Mon, 24 Sep 2018 18:58:37 +0900
> Subject: [PATCH v4] block/loop: Serialize ioctl operations.
> 
> syzbot is reporting NULL pointer dereference [1] which is caused by
> race condition between ioctl(loop_fd, LOOP_CLR_FD, 0) versus
> ioctl(other_loop_fd, LOOP_SET_FD, loop_fd) due to traversing other
> loop devices without holding corresponding locks.
> 
> syzbot is also reporting circular locking dependency between bdev->bd_mutex
> and lo->lo_ctl_mutex [2] which is caused by calling blkdev_reread_part()
> with lock held.

Please explain in the changelog that it is indeed loop_validate_file() and
only that AFAICT that is doing these racy unlocked accesses. Otherwise it's
pretty hard to find that.

> Since ioctl() request on loop devices is not frequent operation, we don't
> need fine grained locking. Let's use global lock and simplify the locking
> order.
> 
> Strategy is that the global lock is held upon entry of ioctl() request,
> and release it before either starting operations which might deadlock or
> leaving ioctl() request. After the global lock is released, current thread
> no longer uses "struct loop_device" memory because it might be modified
> by next ioctl() request which was waiting for current ioctl() request.
> 
> In order to enforce this strategy, this patch inverted
> loop_reread_partitions() and loop_unprepare_queue() in loop_clr_fd().
> According to Ming Lei, calling loop_unprepare_queue() before
> loop_reread_partitions() (like we did until 3.19) is fine.
> 
> Since this patch serializes using global lock, race bugs should no longer
> exist. Thus, it will be easy to test whether this patch broke something.
> Since syzbot is reporting various bugs [3] where a race in the loop module
> is suspected, let's check whether this patch affects these bugs too.
> 
> [1] https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
> [2] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889
> [3] https://syzkaller.appspot.com/bug?id=b3c7e1440aa8ece16bf557dbac427fdff1dad9d6
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jens Axboe <axboe@kernel.dk>

Looking into the patch, this is convoluting several things together and as
a result the patch is very difficult to review. Can you please split it up
so that it's reviewable? I can see there:

1) Change to not call blkdev_reread_part() with loop mutex held - that
deserves a separate patch.

2) Switch to global loop_mutex - another patch.

3) Some unrelated adjustments - like using path instead of file in
loop_get_status(), doing
	int ret = foo();

instead of
	int ret;

	ret = foo();

etc. One patch for each such change please.

Some more comments inline.

> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index ea9debf..a7058ec 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -83,11 +83,50 @@
>  #include <linux/uaccess.h>
>  
>  static DEFINE_IDR(loop_index_idr);
> -static DEFINE_MUTEX(loop_index_mutex);
> +static DEFINE_MUTEX(loop_mutex);
> +static void *loop_mutex_owner; /* == __mutex_owner(&loop_mutex) */
>  
>  static int max_part;
>  static int part_shift;
>  
> +/*
> + * lock_loop - Lock loop_mutex.
> + */
> +static void lock_loop(void)
> +{
> +	mutex_lock(&loop_mutex);
> +	loop_mutex_owner = current;
> +}
> +
> +/*
> + * lock_loop_killable - Lock loop_mutex unless killed.
> + */
> +static int lock_loop_killable(void)
> +{
> +	int err = mutex_lock_killable(&loop_mutex);
> +
> +	if (err)
> +		return err;
> +	loop_mutex_owner = current;
> +	return 0;
> +}
> +
> +/*
> + * unlock_loop - Unlock loop_mutex as needed.
> + *
> + * Explicitly call this function before calling fput() or blkdev_reread_part()
> + * in order to avoid circular lock dependency. After this function is called,
> + * current thread is no longer allowed to access "struct loop_device" memory,
> + * for another thread would access that memory as soon as loop_mutex is held.
> + */
> +static void unlock_loop(void)
> +{
> +	if (loop_mutex_owner == current) {

Urgh, why this check? Conditional locking / unlocking is evil so it has to
have *very* good reasons and there is not any explanation here. So far I
don't see a reason why this is needed at all.

> +		loop_mutex_owner = NULL;
> +		mutex_unlock(&loop_mutex);
> +	}
> +}
> +
>  static int transfer_xor(struct loop_device *lo, int cmd,
>  			struct page *raw_page, unsigned raw_off,
>  			struct page *loop_page, unsigned loop_off,
> @@ -630,7 +669,12 @@ static void loop_reread_partitions(struct loop_device *lo,
>  				   struct block_device *bdev)
>  {
>  	int rc;
> +	/* Save variables which might change after unlock_loop() is called. */
> +	char filename[sizeof(lo->lo_file_name)];
			^^^^ LO_NAME_SIZE would do. I don't think it's any
less maintainable and certainly easier to read.

> +	const int num = lo->lo_number;
>  
> +	memmove(filename, lo->lo_file_name, sizeof(filename));

Why not memcpy? Buffers certainly don't overlap.

> +	unlock_loop();

Unlocking in loop_reread_partitions() makes the locking rules ugly. And
unnecessarily AFAICT. Can't we just use lo_refcnt to protect us against
loop_clr_fd() and freeing of 'lo' structure itself?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
