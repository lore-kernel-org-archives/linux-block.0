Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 9 May 2016 11:20:06 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
	linus.walleij@linaro.org, broonie@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH BUGFIX] block: add missing group association in bio_split
Message-ID: <20160509152006.GE7110@mtj.duckdns.org>
References: <1462567512-3007-1-git-send-email-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462567512-3007-1-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 06, 2016 at 10:45:12PM +0200, Paolo Valente wrote:
> When a bio is split, the newly created bio must be associated with the
> same blkcg as the original bio (if BLK_CGROUP is enabled). If this
> operation is not performed, then the new bio is not associated with
> any group, and the group of the current task is returned when the
> group of the bio is requested.
> 
> Depending on the frequency of splits, this may cause a large
> percentage of the bios belonging to a given group to be treated as if
> belonging to other groups (in most cases as if belonging to the root
> group). The expected group isolation may thereby be then broken.
> 
> This commit adds the missing association in bio_split.
> 
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>

Acked-by: Tejun Heo <tj@kernel.org>

> ---
>  block/bio.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 807d25e..c4a3834 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1811,6 +1811,11 @@ struct bio *bio_split(struct bio *bio, int sectors,
>  
>  	bio_advance(bio, split->bi_iter.bi_size);
>  
> +#ifdef CONFIG_BLK_CGROUP
> +	if (bio->bi_css)
> +		bio_associate_blkcg(split, bio->bi_css);
> +#endif

And yeah, we need to encapsulate this better to avoid scattering
CONFIG_BLK_CGROUP but that's for another patch.

Thanks.

-- 
tejun
