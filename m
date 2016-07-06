Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <77238e99.142c5.155b660564f.Coremail.aaronlee0817@163.com>
References: <77238e99.142c5.155b660564f.Coremail.aaronlee0817@163.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 6 Jul 2016 09:10:00 +0800
Message-ID: <CACVXFVPO-7EEK02SUH16NtnwpE807KuYQHybBYYqVbXGZSzX2A@mail.gmail.com>
Subject: Re: cgroup: Fix split bio been throttled more than once
To: Jiale Li <aaronlee0817@163.com>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, Ming Lin <mlin@kernel.org>,
	Shaohua Li <shli@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cgroup@vger.kernel.org,
	jiale0817.li@samsung.com, yanzi.zhang@samsung.com, zhen1.zhang@samsung.com,
	linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Cc block list

On Mon, Jul 4, 2016 at 10:46 PM, Jiale Li <aaronlee0817@163.com> wrote:
> Hi Tejun,
>
> These days, we have tested the cgroup blkio throttle function use fio,
> and we found a problem that when we use buffered IO or set the big block
> size like 1M, then the IO performance cannot reach the value we set.
> For example we set blkio.throttle.read_bps_device as 10M, in kernel
> version 4.3 IO performance can only reach 6M, and in kernel version
> 4.4 the actual IO bps is only 3.1M.
>
> Then we did some research and find that in kernel version 4.3 brought in
> blk_queue_split() function to split the big size bio into several parts,
> and some of them are calling the generic_make_request() again, this result
> the bio been throttled more than once. so the actual bio sent to device is
> less than we expected.

Except for blk_queue_split(), there are other(stacked) drivers which call
generic_make_request() too, such as drbd, dm, md and bcache.

>
> We have checked the newest kernel of 4.7-rc5, this problem is still exist.
>
> Based on this kind of situation, we propose a fix solution to add a flag bit
> in bio to let the splited bio bypass the blk_queue_split(). Below is the patch
> we used to fix this problem.

The splitted bio is just a fast-cloned bio(except for discard bio) and not very
special compared with other fast-cloned bio, which is quite common used.

So I guess what you need is to bypass BIO_CLONED bio for this purpose
since all fast-cloned bio shares the same bvec table of the source bio.

Thanks,
Ming

>
> Thanks
>
> From b5ea98c9fc5612f9390b65bd9cf4ff344b6cfe92 Mon Sep 17 00:00:00 2001
> From: Jiale Li <aaronlee0817@163.com>
> Date: Mon, 4 Jul 2016 09:23:32 -0400
> Subject: [PATCH] cgroup: Fix split bio been throttled more than once
>
> From kernel version 4.3, blk_queue_split() been added into the kernel,
> it calls the generic_make_request() function,  witch means a part of
> the bio will be counted more than once in blk_throtl_bio(). This result
> the throttle function of cgroup cannot work as we expected.
>
> This patch add a new flag bit in bio, to let the split bio bypass the
> blk_throtl_bio().
>
> Signed-off-by: Jiale Li <aaronlee0817@163.com>
> ---
>  block/blk-merge.c         | 1 +
>  block/blk-throttle.c      | 4 ++++
>  include/linux/blk_types.h | 1 +
>  3 files changed, 6 insertions(+)
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 2613531..7b17a65 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -190,6 +190,7 @@ void blk_queue_split(struct request_queue *q, struct bio **bio,
>
>                 bio_chain(split, *bio);
>                 trace_block_split(q, split, (*bio)->bi_iter.bi_sector);
> +               bio_set_flag(*bio, BIO_SPLITED);
>                 generic_make_request(*bio);
>                 *bio = split;
>         }
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 47a3e54..4ffde95 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1403,6 +1403,10 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
>
>         WARN_ON_ONCE(!rcu_read_lock_held());
>
> +       /* if the bio has been splited, should not throttle again */
> +       if (bio_flagged(bio, BIO_SPLITED))
> +               goto out;
> +
>         /* see throtl_charge_bio() */
>         if ((bio->bi_rw & REQ_THROTTLED) || !tg->has_rules[rw])
>                 goto out;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 77e5d81..b294780 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -120,6 +120,7 @@ struct bio {
>  #define BIO_QUIET      6       /* Make BIO Quiet */
>  #define BIO_CHAIN      7       /* chained bio, ->bi_remaining in effect */
>  #define BIO_REFFED     8       /* bio has elevated ->bi_cnt */
> +#define BIO_SPLITED     9       /* bio has been splited */
>
>  /*
>   * Flags starting here get preserved by bio_reset() - this includes
> --
> 1.9.1
>



-- 
Ming Lei
