Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <149266672902.27388.15322863417005890204.stgit@noble>
References: <149266645258.27388.14083229348123176454.stgit@noble> <149266672902.27388.15322863417005890204.stgit@noble>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 21 Apr 2017 23:39:27 +0800
Message-ID: <CACVXFVO=Mp=1AO-NcKX3H5n0TojBgrO=zR4NBAv-FJth9_r0Eg@mail.gmail.com>
Subject: Re: [PATCH 04/11] block: Improvements to bounce-buffer handling
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 20, 2017 at 1:38 PM, NeilBrown <neilb@suse.com> wrote:
> Since commit 23688bf4f830 ("block: ensure to split after potentially
> bouncing a bio") blk_queue_bounce() is called *before*
> blk_queue_split().
> This means that:
>  1/ the comments blk_queue_split() about bounce buffers are
>     irrelevant, and
>  2/ a very large bio (more than BIO_MAX_PAGES) will no longer be
>     split before it arrives at blk_queue_bounce(), leading to the
>     possibility that bio_clone_bioset() will fail and a NULL
>     will be dereferenced.
>
> Separately, blk_queue_bounce() shouldn't use fs_bio_set as the bio
> being copied could be from the same set, and this could lead to a
> deadlock.
>
> So:
>  - allocate 2 private biosets for blk_queue_bounce, one for
>    splitting enormous bios and one for cloning bios.
>  - add code to split a bio that exceeds BIO_MAX_PAGES.
>  - Fix up the comments in blk_queue_split()
>
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  block/blk-merge.c |   14 ++++----------
>  block/bounce.c    |   27 ++++++++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index d59074556703..51c84540d3bb 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -117,17 +117,11 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>                  * each holds at most BIO_MAX_PAGES bvecs because
>                  * bio_clone() can fail to allocate big bvecs.
>                  *
> -                * It should have been better to apply the limit per
> -                * request queue in which bio_clone() is involved,
> -                * instead of globally. The biggest blocker is the
> -                * bio_clone() in bio bounce.
> +                * Those drivers which will need to use bio_clone()
> +                * should tell us in some way.  For now, impose the
> +                * BIO_MAX_PAGES limit on all queues.
>                  *
> -                * If bio is splitted by this reason, we should have
> -                * allowed to continue bios merging, but don't do
> -                * that now for making the change simple.
> -                *
> -                * TODO: deal with bio bounce's bio_clone() gracefully
> -                * and convert the global limit into per-queue limit.
> +                * TODO: handle users of bio_clone() differently.
>                  */
>                 if (bvecs++ >= BIO_MAX_PAGES)
>                         goto split;
> diff --git a/block/bounce.c b/block/bounce.c
> index 1cb5dd3a5da1..51fb538b504d 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -26,6 +26,7 @@
>  #define POOL_SIZE      64
>  #define ISA_POOL_SIZE  16
>
> +struct bio_set *bounce_bio_set, *bounce_bio_split;
>  static mempool_t *page_pool, *isa_page_pool;
>
>  #if defined(CONFIG_HIGHMEM) || defined(CONFIG_NEED_BOUNCE_POOL)
> @@ -40,6 +41,14 @@ static __init int init_emergency_pool(void)
>         BUG_ON(!page_pool);
>         pr_info("pool size: %d pages\n", POOL_SIZE);
>
> +       bounce_bio_set = bioset_create(BIO_POOL_SIZE, 0);
> +       BUG_ON(!bounce_bio_set);
> +       if (bioset_integrity_create(bounce_bio_set, BIO_POOL_SIZE))
> +               BUG_ON(1);
> +
> +       bounce_bio_split = bioset_create_nobvec(BIO_POOL_SIZE, 0);
> +       BUG_ON(!bounce_bio_split);
> +
>         return 0;
>  }
>
> @@ -194,7 +203,23 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
>
>         return;
>  bounce:
> -       bio = bio_clone_bioset(*bio_orig, GFP_NOIO, fs_bio_set);
> +       if (bio_segments(*bio_orig) > BIO_MAX_PAGES) {
> +               int cnt = 0;
> +               int sectors = 0;
> +               struct bio_vec bv;
> +               struct bvec_iter iter;
> +               bio_for_each_segment(bv, *bio_orig, iter) {

The two bio_for_each_segment()(one is in bio_segments()) can be merged to
one.

> +                       if (cnt++ < BIO_MAX_PAGES)
> +                               sectors += bv.bv_len >> 9;
> +                       else
> +                               break;
> +               }
> +               bio = bio_split(*bio_orig, sectors, GFP_NOIO, bounce_bio_split);
> +               bio_chain(bio, *bio_orig);
> +               generic_make_request(*bio_orig);
> +               *bio_orig = bio;
> +       }
> +       bio = bio_clone_bioset(*bio_orig, GFP_NOIO, bounce_bio_set);
>
>         bio_for_each_segment_all(to, bio, i) {
>                 struct page *page = to->bv_page;
>
>



Thanks,
Ming Lei
