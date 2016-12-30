Return-Path: <linux-block-owner@vger.kernel.org>
Received: from server.coly.li ([162.144.45.48]:51298 "EHLO server.coly.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbcL3LBc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Dec 2016 06:01:32 -0500
Subject: Re: [PATCH v1 23/54] bcache: handle bio_clone() & bvec updating for
 multipage bvecs
To: Ming Lei <tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
 <1482854250-13481-24-git-send-email-tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Shaohua Li <shli@kernel.org>,
        Mike Christie <mchristi@redhat.com>,
        Guoqing Jiang <gqjiang@suse.com>,
        "open list:BCACHE (BLOCK LAYER CACHE)" <linux-bcache@vger.kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT"
        <linux-raid@vger.kernel.org>
From: Coly Li <i@coly.li>
Message-ID: <4d015585-c830-17ff-de4a-60f2d5f06a0d@coly.li>
Date: Fri, 30 Dec 2016 19:01:11 +0800
MIME-Version: 1.0
In-Reply-To: <1482854250-13481-24-git-send-email-tom.leiming@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2016/12/27 下午11:56, Ming Lei wrote:
> The incoming bio may be too big to be cloned into
> one singlepage bvecs bio, so split the bio and
> check the splitted bio one by one.
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  drivers/md/bcache/debug.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
> index 48d03e8b3385..18b2d2d138e3 100644
> --- a/drivers/md/bcache/debug.c
> +++ b/drivers/md/bcache/debug.c
> @@ -103,7 +103,7 @@ void bch_btree_verify(struct btree *b)
>  	up(&b->io_mutex);
>  }
>  
> -void bch_data_verify(struct cached_dev *dc, struct bio *bio)
> +static void __bch_data_verify(struct cached_dev *dc, struct bio *bio)
>  {
>  	char name[BDEVNAME_SIZE];
>  	struct bio *check;
> @@ -116,7 +116,7 @@ void bch_data_verify(struct cached_dev *dc, struct bio *bio)
>  	 * in the new cloned bio because each single page need
>  	 * to assign to each bvec of the new bio.
>  	 */
> -	check = bio_clone(bio, GFP_NOIO);
> +	check = bio_clone_sp(bio, GFP_NOIO);
>  	if (!check)
>  		return;
>  	check->bi_opf = REQ_OP_READ;
> @@ -151,6 +151,26 @@ void bch_data_verify(struct cached_dev *dc, struct bio *bio)
>  	bio_put(check);
>  }
>  
> +void bch_data_verify(struct cached_dev *dc, struct bio *bio)
> +{
> +	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> +	struct bio *clone = bio_clone_fast(bio, GFP_NOIO, q->bio_split);
> +	unsigned sectors;
> +
> +	while (!bio_can_convert_to_sp(clone, &sectors)) {
> +		struct bio *split = bio_split(clone, sectors,
> +					      GFP_NOIO, q->bio_split);
> +
> +		__bch_data_verify(dc, split);
> +		bio_put(split);
> +	}
> +
> +	if (bio_sectors(clone))
> +		__bch_data_verify(dc, clone);
> +
> +	bio_put(clone);
> +}
> +

Hi Lei,

The above patch is good IMHO. Just wondering why not use the classical
style ? something like,


do {
	if (!bio_can_convert_to_sp(clone, &sectors))
		split = bio_split(clone, sectors,
				  GFP_NOIO, q->bio_split);
	else
		split = clone;

	__bch_data_verity(gc, split);
	bio_put(split);
} while (split != clone);


I guess maybe the above style generates less binary code.


-- 
Coly Li
