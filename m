Return-Path: <ming.lei@redhat.com>
Date: Fri, 7 Apr 2017 17:37:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
	Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org
Subject: Re: [PATCHv6 1/2] loop: Remove unused 'bdev' argument from
 loop_set_capacity
Message-ID: <20170407093705.GB27631@ming.t460p>
References: <1491548338-71005-1-git-send-email-hare@suse.de>
 <1491548338-71005-2-git-send-email-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491548338-71005-2-git-send-email-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 07, 2017 at 08:58:57AM +0200, Hannes Reinecke wrote:
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/loop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index cc981f3..81b3900 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1307,7 +1307,7 @@ static int loop_clr_fd(struct loop_device *lo)
>  	return err;
>  }
>  
> -static int loop_set_capacity(struct loop_device *lo, struct block_device *bdev)
> +static int loop_set_capacity(struct loop_device *lo)
>  {
>  	if (unlikely(lo->lo_state != Lo_bound))
>  		return -ENXIO;
> @@ -1370,7 +1370,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>  	case LOOP_SET_CAPACITY:
>  		err = -EPERM;
>  		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
> -			err = loop_set_capacity(lo, bdev);
> +			err = loop_set_capacity(lo);
>  		break;
>  	case LOOP_SET_DIRECT_IO:
>  		err = -EPERM;

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming
