Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 10 May 2018 10:02:32 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, osandov@fb.com, efault@gmx.de,
	paolo.valente@linaro.org
Subject: Re: [PATCH 6/9] sbitmap: warn if using smaller shallow depth than
 was setup
Message-ID: <20180510170232.GF30485@vader>
References: <1525969467-12476-1-git-send-email-axboe@kernel.dk>
 <1525969467-12476-7-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525969467-12476-7-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 10, 2018 at 10:24:24AM -0600, Jens Axboe wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Make sure the user passed the right value to
> sbitmap_queue_min_shallow_depth().

An unlucky bisect that lands between this change and the BFQ/Kyber
changes is going to trigger this warning. We should have it after the
BFQ/Kyber changes.

> Acked-by: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  lib/sbitmap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index d21473b42465..8f0950fbaa5c 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -402,6 +402,8 @@ int __sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
>  	unsigned int hint, depth;
>  	int nr;
>  
> +	WARN_ON_ONCE(shallow_depth < sbq->min_shallow_depth);
> +
>  	hint = this_cpu_read(*sbq->alloc_hint);
>  	depth = READ_ONCE(sbq->sb.depth);
>  	if (unlikely(hint >= depth)) {
> -- 
> 2.7.4
> 
