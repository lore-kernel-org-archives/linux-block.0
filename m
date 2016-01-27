Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Alexey Klimov <klimov.linux@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yury.norov@gmail.com
Subject: Re: [PATCH] elevator: remove second argument in elevator_init()
References: <1452822371-4967-1-git-send-email-klimov.linux@gmail.com>
Date: Wed, 27 Jan 2016 16:01:49 -0500
In-Reply-To: <1452822371-4967-1-git-send-email-klimov.linux@gmail.com> (Alexey
	Klimov's message of "Fri, 15 Jan 2016 01:46:11 +0000")
Message-ID: <x49r3h2ag8y.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Alexey Klimov <klimov.linux@gmail.com> writes:

> Last user of elevator_init() with non-NULL name as second argument
> that supposed to be s390 dasd driver has gone few releases ago.
> Drivers rely on elevator_change(), elevator_switch() and friends
> for example. Right now elevator_init() is always called as
> elevator_init(q, NULL).
>
> Patch removes passing of second name argument and its usage.
>
> While we're at it fix following if-check after removed lines. We know
> that elevator_type e is initialized by NULL and need to check only
> chosen_elevator.
>
> Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>


> ---
>  block/blk-core.c         |  2 +-
>  block/elevator.c         | 10 ++--------
>  include/linux/elevator.h |  2 +-
>  3 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 33e2f62..f742ef4 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -861,7 +861,7 @@ blk_init_allocated_queue(struct request_queue *q, request_fn_proc *rfn,
>  	mutex_lock(&q->sysfs_lock);
>  
>  	/* init elevator */
> -	if (elevator_init(q, NULL)) {
> +	if (elevator_init(q)) {
>  		mutex_unlock(&q->sysfs_lock);
>  		goto fail;
>  	}
> diff --git a/block/elevator.c b/block/elevator.c
> index c3555c9..ff5c830 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -177,7 +177,7 @@ static void elevator_release(struct kobject *kobj)
>  	kfree(e);
>  }
>  
> -int elevator_init(struct request_queue *q, char *name)
> +int elevator_init(struct request_queue *q)
>  {
>  	struct elevator_type *e = NULL;
>  	int err;
> @@ -196,18 +196,12 @@ int elevator_init(struct request_queue *q, char *name)
>  	q->end_sector = 0;
>  	q->boundary_rq = NULL;
>  
> -	if (name) {
> -		e = elevator_get(name, true);
> -		if (!e)
> -			return -EINVAL;
> -	}
> -
>  	/*
>  	 * Use the default elevator specified by config boot param or
>  	 * config option.  Don't try to load modules as we could be running
>  	 * off async and request_module() isn't allowed from async.
>  	 */
> -	if (!e && *chosen_elevator) {
> +	if (*chosen_elevator) {
>  		e = elevator_get(chosen_elevator, false);
>  		if (!e)
>  			printk(KERN_ERR "I/O scheduler %s not found\n",
> diff --git a/include/linux/elevator.h b/include/linux/elevator.h
> index 638b324..0ae0efd 100644
> --- a/include/linux/elevator.h
> +++ b/include/linux/elevator.h
> @@ -154,7 +154,7 @@ extern void elv_unregister(struct elevator_type *);
>  extern ssize_t elv_iosched_show(struct request_queue *, char *);
>  extern ssize_t elv_iosched_store(struct request_queue *, const char *, size_t);
>  
> -extern int elevator_init(struct request_queue *, char *);
> +extern int elevator_init(struct request_queue *);
>  extern void elevator_exit(struct elevator_queue *);
>  extern int elevator_change(struct request_queue *, const char *);
>  extern bool elv_rq_merge_ok(struct request *, struct bio *);
