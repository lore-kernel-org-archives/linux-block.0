Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170807193818.GA22737@rage>
References: <20170807193818.GA22737@rage>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 8 Aug 2017 07:53:40 +0800
Message-ID: <CACVXFVPqY-Sz65uUtWAWu2wSS=Z0nU0NQnTaGmfOdfxcMVnwzQ@mail.gmail.com>
Subject: Re: [PATCH] block: Fix warning when I/O elevator is changed as
 request_queue is being removed
To: David Jeffery <djeffery@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 8, 2017 at 3:38 AM, David Jeffery <djeffery@redhat.com> wrote:
> There is a race between changing I/O elevator and request_queue removal
> which can trigger the warning in kobject_add_internal.  A program can
> use sysfs to request a change of elevator at the same time another task
> is unregistering the request_queue the elevator would be attached to.
> The elevator's kobject will then attempt to be connected to the
> request_queue in the object tree when the request_queue has just been
> removed from sysfs.  This triggers the warning in kobject_add_internal
> as the request_queue no longer has a sysfs directory:
>
> kobject_add_internal failed for iosched (error: -2 parent: queue)
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 14075 at lib/kobject.c:244 kobject_add_internal+0x103/0x2d0
>
>
> To fix this warning, we can check the QUEUE_FLAG_REGISTERED flag when
> changing the elevator and use the request_queue's sysfs_lock to
> serialize between clearing the flag and the elevator testing the flag.

I remember I saw this issue too.

>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> ---
>  block/blk-sysfs.c |    2 ++
>  block/elevator.c  |    4 ++++
>  2 files changed, 6 insertions(+)
>
>
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 27aceab..b8362c0 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -931,7 +931,9 @@ void blk_unregister_queue(struct gendisk *disk)
>         if (WARN_ON(!q))
>                 return;
>
> +       mutex_lock(&q->sysfs_lock);
>         queue_flag_clear_unlocked(QUEUE_FLAG_REGISTERED, q);
> +       mutex_unlock(&q->sysfs_lock);

Could you share why the lock of 'q->sysfs_lock' is needed here?

>
>         wbt_exit(q);
>
> diff --git a/block/elevator.c b/block/elevator.c
> index 4bb2f0c..51da592 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -1055,6 +1055,10 @@ static int __elevator_change(struct request_queue *q, const char *name)
>         char elevator_name[ELV_NAME_MAX];
>         struct elevator_type *e;
>
> +       /* Make sure queue is not in the middle of being removed */
> +       if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
> +               return -ENOENT;
> +

I suggest to check 'e->registered' here, which should be more
reasonable or straightforward.

-- 
Ming Lei
