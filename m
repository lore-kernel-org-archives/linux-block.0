Return-Path: <BATV+c839010d8a82889b76e4+5048+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 18 Jun 2017 23:28:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
Subject: Re: [PATCH 06/11] fs: add O_DIRECT support for sending down write
 life time hints
Message-ID: <20170619062824.GE2311@infradead.org>
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
 <1497729594-4707-7-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497729594-4707-7-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Sat, Jun 17, 2017 at 01:59:49PM -0600, Jens Axboe wrote:
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/block_dev.c | 2 ++
>  fs/direct-io.c | 2 ++
>  fs/iomap.c     | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 519599dddd36..b9222a9d285e 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -239,6 +239,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>  			should_dirty = true;
>  	} else {
>  		bio.bi_opf = dio_bio_write_op(iocb);
> +		bio.bi_opf |= write_hint_to_opf(iocb_write_hint(iocb));

Move this into dio_bio_write_op instead of duplicating it?
