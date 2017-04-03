Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 7/7] Guard bvec iteration logic v2
To: Dmitry Monakhov <dmonakhov@openvz.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, martin.petersen@oracle.com
References: <1491204212-9952-1-git-send-email-dmonakhov@openvz.org>
 <1491204212-9952-8-git-send-email-dmonakhov@openvz.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c5328f91-79ec-f4f8-a9d1-bdf467e8c5f4@kernel.dk>
Date: Mon, 3 Apr 2017 08:34:28 -0600
MIME-Version: 1.0
In-Reply-To: <1491204212-9952-8-git-send-email-dmonakhov@openvz.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/03/2017 01:23 AM, Dmitry Monakhov wrote:
> @@ -66,12 +67,15 @@ struct bvec_iter {
>  	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
>  })
>  
> -static inline void bvec_iter_advance(const struct bio_vec *bv,
> +static inline int bvec_iter_advance(const struct bio_vec *bv,
>  				     struct bvec_iter *iter,
>  				     unsigned bytes)
>  {
> -	WARN_ONCE(bytes > iter->bi_size,
> -		  "Attempted to advance past end of bvec iter\n");
> +	if(unlikely(bytes > iter->bi_size)) {
> +		WARN(1, "Attempted to advance past end of bvec iter\n");
> +		iter->bi_size = 0;
> +		return -EINVAL;
> +	}

	if (WARN_ONCE(bytes > iter->bi_size,
			"Attempted to advance past end of bvec iter\n")) {
		...

would be cleaner.

-- 
Jens Axboe
