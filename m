Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH BUGFIX V2] block: add missing group association in bio-cloning functions
References: <20160510204435.GN7110@mtj.duckdns.org>
	<1462914132-4479-1-git-send-email-paolo.valente@linaro.org>
Date: Tue, 10 May 2016 17:34:50 -0400
In-Reply-To: <1462914132-4479-1-git-send-email-paolo.valente@linaro.org>
	(Paolo Valente's message of "Tue, 10 May 2016 23:02:12 +0200")
Message-ID: <x49eg9961hh.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Paolo Valente <paolo.valente@linaro.org> writes:

> diff --git a/block/bio.c b/block/bio.c
> index 807d25e..e9b136a 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -622,6 +622,8 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
>  		}
>  	}
>  
> +	bio_clone_blkcg_association(b, bio);
> +
>  	return b;
>  }
>  EXPORT_SYMBOL(bio_clone_fast);
> @@ -695,6 +697,8 @@ integrity_clone:
>  		}
>  	}
>  
> +	bio_clone_blkcg_association(bio, bio_src);
> +
>  	return bio;
>  }
>  EXPORT_SYMBOL(bio_clone_bioset);
> @@ -1811,6 +1815,8 @@ struct bio *bio_split(struct bio *bio, int sectors,
>  
>  	bio_advance(bio, split->bi_iter.bi_size);
>  
> +	bio_clone_blkcg_association(split, bio);
> +

Hi, Paolo,

Did you test this?  bio_split calls bio_clone_bioset or bio_clone_fast,
so I'd be surprised if you didn't trigger that newly added warning.  :-)
Please remove the bio_split call site.

Cheers,
Jeff
