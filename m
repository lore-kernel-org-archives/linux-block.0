Return-Path: <darrick.wong@oracle.com>
Date: Tue, 20 Jun 2017 18:35:53 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/9] xfs: add support for passing in write hints for
 buffered writes
Message-ID: <20170621013553.GC4730@birch.djwong.org>
References: <1498004526-4543-1-git-send-email-axboe@kernel.dk>
 <1498004526-4543-8-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498004526-4543-8-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 20, 2017 at 06:22:04PM -0600, Jens Axboe wrote:
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks ok to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_aops.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 76b6f988e2fa..e4d9d470402c 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -506,6 +506,7 @@ xfs_submit_ioend(
>  		return status;
>  	}
>  
> +	ioend->io_bio->bi_opf |= write_hint_to_opf(inode_write_hint(ioend->io_inode));
>  	submit_bio(ioend->io_bio);
>  	return 0;
>  }
> @@ -565,6 +566,7 @@ xfs_chain_bio(
>  	bio_chain(ioend->io_bio, new);
>  	bio_get(ioend->io_bio);		/* for xfs_destroy_ioend */
>  	ioend->io_bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
> +	ioend->io_bio->bi_opf |= write_hint_to_opf(inode_write_hint(ioend->io_inode));
>  	submit_bio(ioend->io_bio);
>  	ioend->io_bio = new;
>  }
> -- 
> 2.7.4
> 
