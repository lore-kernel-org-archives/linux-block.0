Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1492546971-2682-1-git-send-email-jbacik@fb.com>
References: <1492546971-2682-1-git-send-email-jbacik@fb.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 19 Apr 2017 08:54:59 +0800
Message-ID: <CACVXFVNM5Fvd2O2XmeZXVESMct8mHd_TMGTCZ+T80KZVtp5sZQ@mail.gmail.com>
Subject: Re: [PATCH] nbd: set the max segment size to UINT_MAX
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>,
	linux-block <linux-block@vger.kernel.org>, FB Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Apr 19, 2017 at 4:22 AM, Josef Bacik <josef@toxicpanda.com> wrote:
> NBD doesn't care about limiting the segment size, let the user push the
> largest bio's they want.  This allows us to control the request size
> solely through max_sectors_kb.
>
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
>  drivers/block/nbd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index b78f23c..6e592c2 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1469,6 +1469,7 @@ static int nbd_dev_add(int index)
>         queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, disk->queue);
>         disk->queue->limits.discard_granularity = 512;
>         blk_queue_max_discard_sectors(disk->queue, UINT_MAX);
> +       blk_queue_max_segment_size(disk->queue, UINT_MAX);
>         blk_queue_max_hw_sectors(disk->queue, 65536);
>         disk->queue->limits.max_sectors = 256;

The change is fine, since the segment size limit should be from hw itself.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
