Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33495 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760262AbcDFDqd (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2016 23:46:33 -0400
Date: Tue, 5 Apr 2016 19:46:28 -0800
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Ming Lei <ming.lei@canonical.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Eric Wheeler <bcache@lists.ewheeler.net>,
	Sebastian Roesner <sroesner-kernelorg@roesner-online.de>,
	"4.3+" <stable@vger.kernel.org>, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH v1] block: make sure big bio is splitted into at most 256
 bvecs
Message-ID: <20160406034628.GA25428@kmo-pixel>
References: <1459914212-9330-1-git-send-email-ming.lei@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459914212-9330-1-git-send-email-ming.lei@canonical.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Apr 06, 2016 at 11:43:32AM +0800, Ming Lei wrote:
> After arbitrary bio size is supported, the incoming bio may
> be very big. We have to split the bio into small bios so that
> each holds at most BIO_MAX_PAGES bvecs for safety reason, such
> as bio_clone().
> 
> This patch fixes the following kernel crash:
> 
> > [  172.660142] BUG: unable to handle kernel NULL pointer dereference at 0000000000000028
> > [  172.660229] IP: [<ffffffff811e53b4>] bio_trim+0xf/0x2a
> > [  172.660289] PGD 7faf3e067 PUD 7f9279067 PMD 0
> > [  172.660399] Oops: 0000 [#1] SMP
> > [...]
> > [  172.664780] Call Trace:
> > [  172.664813]  [<ffffffffa007f3be>] ? raid1_make_request+0x2e8/0xad7 [raid1]
> > [  172.664846]  [<ffffffff811f07da>] ? blk_queue_split+0x377/0x3d4
> > [  172.664880]  [<ffffffffa005fb5f>] ? md_make_request+0xf6/0x1e9 [md_mod]
> > [  172.664912]  [<ffffffff811eb860>] ? generic_make_request+0xb5/0x155
> > [  172.664947]  [<ffffffffa0445c89>] ? prio_io+0x85/0x95 [bcache]
> > [  172.664981]  [<ffffffffa0448252>] ? register_cache_set+0x355/0x8d0 [bcache]
> > [  172.665016]  [<ffffffffa04497d3>] ? register_bcache+0x1006/0x1174 [bcache]
> 
> Fixes: 54efd50(block: make generic_make_request handle arbitrarily sized bios)
> Reported-by: Sebastian Roesner <sroesner-kernelorg@roesner-online.de>
> Reported-by: Eric Wheeler <bcache@lists.ewheeler.net>
> Cc: stable@vger.kernel.org (4.3+)
> Cc: Shaohua Li <shli@fb.com>
> Cc: Kent Overstreet <kent.overstreet@gmail.com>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>

That'll work

Acked-by: Kent Overstreet <kent.overstreet@gmail.com>

> ---
> V1:
> 	- Kent pointed out that using max io size can't cover
> 	the case of non-full bvecs/pages
> 
> The issue can be reproduced by the following approach:
>         - create one raid1 over two virtio-blk
>         - build bcache device over the above raid1 and another cache device
> 	and bucket size is set 2Mbytes
>         - set cache mode as writeback
>         - run random write over ext4 on the bcache device
>         - then the crash can be triggered
> 
>  block/blk-merge.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 2613531..7b96471 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -94,8 +94,10 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  	bool do_split = true;
>  	struct bio *new = NULL;
>  	const unsigned max_sectors = get_max_io_size(q, bio);
> +	unsigned bvecs = 0;
>  
>  	bio_for_each_segment(bv, bio, iter) {
> +		bvecs++;
>  		/*
>  		 * If the queue doesn't support SG gaps and adding this
>  		 * offset would create a gap, disallow it.
> @@ -103,6 +105,23 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  		if (bvprvp && bvec_gap_to_prev(q, bvprvp, bv.bv_offset))
>  			goto split;
>  
> +		/*
> +		 * With arbitrary bio size, the incoming bio may be very
> +		 * big. We have to split the bio into small bios so that
> +		 * each holds at most BIO_MAX_PAGES bvecs because
> +		 * bio_clone() can fail to allocate big bvecs.
> +		 *
> +		 * It should have been better to apply the limit per
> +		 * request queue in which bio_clone() is involved,
> +		 * instead of globally. The biggest blocker is
> +		 * bio_clone() in bio bounce.
> +		 *
> +		 * TODO: deal with bio bounce's bio_clone() gracefully
> +		 * and convert the global limit into per-queue limit.
> +		 */
> +		if (bvecs >= BIO_MAX_PAGES)
> +			goto split;
> +
>  		if (sectors + (bv.bv_len >> 9) > max_sectors) {
>  			/*
>  			 * Consider this a new segment if we're splitting in
> -- 
> 1.9.1
> 
