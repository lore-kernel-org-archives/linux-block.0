Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org
Subject: Re: [PATCH BUGFIX] block: add missing group association in bio_split
References: <5730CFC5.80201@kernel.dk>
	<1462871322-13217-1-git-send-email-paolo.valente@linaro.org>
Date: Tue, 10 May 2016 12:12:39 -0400
In-Reply-To: <1462871322-13217-1-git-send-email-paolo.valente@linaro.org>
	(Paolo Valente's message of "Tue, 10 May 2016 11:08:42 +0200")
Message-ID: <x4960ul7uyw.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Paolo Valente <paolo.valente@linaro.org> writes:

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
> ---
>  block/bio.c         | 15 +++++++++++++++
>  include/linux/bio.h |  2 ++
>  2 files changed, 17 insertions(+)
>
> diff --git a/block/bio.c b/block/bio.c
> index 807d25e..20795eb 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1811,6 +1811,8 @@ struct bio *bio_split(struct bio *bio, int sectors,
>  
>  	bio_advance(bio, split->bi_iter.bi_size);
>  
> +	bio_clone_blkcg_association(split, bio);
> +

First, I think this should be done inside of bio_clone_fast and
bio_clone_bioset instead of in bio_split.  Otherwise you miss other
places where bios are cloned, and I'm guessing that's bad.  You could
also then get rid of this code in btrfs/extent_io.c:

#ifdef CONFIG_BLK_CGROUP
                /* FIXME, put this into bio_clone_bioset */
                if (bio->bi_css)
                        bio_associate_blkcg(new, bio->bi_css);
#endif

Next, you went to the trouble of propagating the return value from
bio_associate_blkcg, and then it goes unchecked here in the only caller
of your new function.  Since bio_associate_blkcg should not fail when
cloning (right?), I'd change bio_clone_blkcg_association to return void
and to WARN_ON a failure return from bio_associate_blkcg.

Cheers,
Jeff

>  	return split;
>  }
>  EXPORT_SYMBOL(bio_split);
> @@ -2016,6 +2018,19 @@ void bio_disassociate_task(struct bio *bio)
>  	}
>  }
>  
> +/**
> + * bio_clone_blkcg_association - clone blkcg association from src to dst bio
> + * @dst: destination bio
> + * @src: source bio
> + */
> +int bio_clone_blkcg_association(struct bio *dst, struct bio *src)
> +{
> +	if (src->bi_css)
> +		return bio_associate_blkcg(dst, src->bi_css);
> +
> +	return 0;
> +}
> +
>  #endif /* CONFIG_BLK_CGROUP */
>  
>  static void __init biovec_init_slabs(void)
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 6b7481f..8535f81 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -527,11 +527,13 @@ extern unsigned int bvec_nr_vecs(unsigned short idx);
>  int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
>  int bio_associate_current(struct bio *bio);
>  void bio_disassociate_task(struct bio *bio);
> +int bio_clone_blkcg_association(struct bio *dst, struct bio *src);
>  #else	/* CONFIG_BLK_CGROUP */
>  static inline int bio_associate_blkcg(struct bio *bio,
>  			struct cgroup_subsys_state *blkcg_css) { return 0; }
>  static inline int bio_associate_current(struct bio *bio) { return -ENOENT; }
>  static inline void bio_disassociate_task(struct bio *bio) { }
> +int bio_clone_blkcg_association(struct bio *dst, struct bio *src) { return 0; }
>  #endif	/* CONFIG_BLK_CGROUP */
>  
>  #ifdef CONFIG_HIGHMEM
