Return-Path: <loberman@redhat.com>
Return-Path: <loberman@redhat.com>
Message-ID: <1541601972.24444.1.camel@redhat.com>
Subject: Re: [PATCH] block: Clear kernel memory before copying to user
From: Laurence Oberman <loberman@redhat.com>
To: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Date: Wed, 07 Nov 2018 09:46:12 -0500
In-Reply-To: <20181107143745.11845-1-keith.busch@intel.com>
References: <20181107143745.11845-1-keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-11-07 at 07:37 -0700, Keith Busch wrote:
> If the kernel allocates a bounce buffer for user read data, this
> memory
> needs to be cleared before copying it to the user, otherwise it may
> leak
> kernel memory to user space.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  block/bio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index d5368a445561..a50d59236b19 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1260,6 +1260,7 @@ struct bio *bio_copy_user_iov(struct
> request_queue *q,
>  		if (ret)
>  			goto cleanup;
>  	} else {
> +		zero_fill_bio(bio);
>  		iov_iter_advance(iter, bio->bi_iter.bi_size);
>  	}
>  

Straightforward, looks good from my view.

Reviewed-by:
Laurence Oberman <loberman@redhat.com>
