Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944108AbcJaPfc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2016 11:35:32 -0400
Date: Mon, 31 Oct 2016 08:35:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 19/60] fs/buffer: comment on direct access to bvec table
Message-ID: <20161031153530.GJ30919@infradead.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-20-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477728600-12938-20-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


I think we'll just need a version zero_fill_bio with a length argument
and let that handle all the bvec access.  I have vague memories that
Kent posted one a while ago, Ccing him.

On Sat, Oct 29, 2016 at 04:08:18PM +0800, Ming Lei wrote:
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  fs/buffer.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index b205a629001d..81c3793948b4 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3018,8 +3018,13 @@ static void end_bio_bh_io_sync(struct bio *bio)
>  void guard_bio_eod(int op, struct bio *bio)
>  {
>  	sector_t maxsector;
> -	struct bio_vec *bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
>  	unsigned truncated_bytes;
> +	/*
> +	 * It is safe to truncate the last bvec in the following way
> +	 * even though multipage bvec is supported, but we need to
> +	 * fix the parameters passed to zero_user().
> +	 */
> +	struct bio_vec *bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
>  
>  	maxsector = i_size_read(bio->bi_bdev->bd_inode) >> 9;
>  	if (!maxsector)
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---
