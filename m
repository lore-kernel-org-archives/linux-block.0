Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] lightnvm: pblk: advance bio according to lba index
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>, mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
References: <1501166990-24366-1-git-send-email-javier@javigon.com>
 <1501166990-24366-2-git-send-email-javier@javigon.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <11d126aa-e04c-bec3-80fd-77baa37a0575@kernel.dk>
Date: Thu, 27 Jul 2017 10:31:55 -0600
MIME-Version: 1.0
In-Reply-To: <1501166990-24366-2-git-send-email-javier@javigon.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/27/2017 08:49 AM, Javier González wrote:
> When a lba either hits the cache or corresponds to an empty entry in the
> L2P table, we need to advance the bio according to the position in which
> the lba is located. Otherwise, we will copy data in the wrong page, thus
> causing data corruption for the application.
> 
> In case of a cache hit, we assumed that bio->bi_iter.bi_idx would
> contain the correct index, but this is no necessarily true. Instead, use
> the local bio advance counter and iterator. This guarantees that lbas
> hitting the cache are copied into the right bv_page.
> 
> In case of an empty L2P entry, we omitted to advance the bio. In the
> cases when the same I/O also contains a cache hit, data corresponding
> to this lba will be copied to the wrong bv_page. Fix this by advancing
> the bio as we do in the case of a cache hit.
> 
> Fixes: a4bd217b4326 lightnvm: physical block device (pblk) target
> 
> Signed-off-by: Javier González <javier@javigon.com>
> ---
>  drivers/lightnvm/pblk-rb.c   |  4 ++--
>  drivers/lightnvm/pblk-read.c | 19 ++++++++++++++-----
>  drivers/lightnvm/pblk.h      |  2 +-
>  3 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index 5ecc154f6831..2e88c3d6d9a1 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -657,7 +657,7 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb *rb, struct nvm_rq *rqd,
>   * be directed to disk.
>   */
>  int pblk_rb_copy_to_bio(struct pblk_rb *rb, struct bio *bio, sector_t lba,
> -			struct ppa_addr ppa, int bio_iter)
> +			struct ppa_addr ppa, int bio_iter, int advanced_bio)

This would be cleaner as a 'bool advance_bio' as both the type and as a
reversed info on whether to do the advance or not.

-- 
Jens Axboe


-- 
Jens Axboe
