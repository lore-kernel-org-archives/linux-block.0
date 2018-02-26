Return-Path: <hare@suse.com>
Subject: Re: [PATCH] block: copy ioprio in __bio_clone_fast()
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Mike Christie <mchristi@redhat.com>
References: <20180226105552.22120-1-hare@suse.de>
From: Hannes Reinecke <hare@suse.com>
Message-ID: <6ad5eabb-30ff-4094-0873-3cb03bba9b1c@suse.com>
Date: Mon, 26 Feb 2018 12:40:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180226105552.22120-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 02/26/2018 11:55 AM, Hannes Reinecke wrote:
> We need to copy the io priority, too; otherwise the clone will run
> with a different priority than the original one.
> 
> Fixes: 43b62ce3ff0a ("block: move bio io prio to a new field")
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  block/bio.c          |   1 +
>  drivers/vhost/npiv.c | 379 +++++----------------------------------------------
>  2 files changed, 37 insertions(+), 343 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index e1708db48258..e079911c640f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -605,6 +605,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
>  	bio->bi_write_hint = bio_src->bi_write_hint;
>  	bio->bi_iter = bio_src->bi_iter;
>  	bio->bi_io_vec = bio_src->bi_io_vec;
> +	bio->bi_ioprio = bio_src->bi_ioprio;
>  
>  	bio_clone_blkcg_association(bio, bio_src);
>  }
> diff --git a/drivers/vhost/npiv.c b/drivers/vhost/npiv.c
> index 20e2a66e332d..3527996aab3f 100644
> --- a/drivers/vhost/npiv.c
> +++ b/drivers/vhost/npiv.c
> @@ -13,7 +13,7 @@

Gnaa.
Please ignore.

Will be sending the correct patch.

-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
