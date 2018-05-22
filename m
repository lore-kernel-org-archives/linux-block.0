Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk,  linux-fsdevel@vger.kernel.org,  axboe@kernel.dk,  bcrl@kvack.org,  tglx@linutronix.de,  mingo@kernel.org,  pombredanne@nexb.com,  kstewart@linuxfoundation.org,  gregkh@linuxfoundation.org,  bigeasy@linutronix.de,  jack@suse.cz,  darrick.wong@oracle.com,  rgoldwyn@suse.com,  linux-block@vger.kernel.org,  linux-kernel@vger.kernel.org,  linux-aio@kvack.org,  linux-api@vger.kernel.org,  hch@infradead.org
Subject: Re: [PATCH v6 4/5] fs: blkdev set bio prio from kiocb prio
In-Reply-To: <20180522150737.9893-5-adam.manzanares@wdc.com> (adam
	manzanares's message of "Tue, 22 May 2018 08:07:36 -0700")
References: <20180522150737.9893-1-adam.manzanares@wdc.com>
	<20180522150737.9893-5-adam.manzanares@wdc.com>
Date: Tue, 22 May 2018 11:15:31 -0400
Message-ID: <x49fu2jafho.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

adam.manzanares@wdc.com writes:

> From: Adam Manzanares <adam.manzanares@wdc.com>
>
> Now that kiocb has an ioprio field copy this over to the bio when it is
> created from the kiocb.
>
> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

Thanks!
Jeff

> ---
>  fs/block_dev.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 7ec920e27065..11ba99e79d2a 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -216,6 +216,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>  	bio.bi_write_hint = iocb->ki_hint;
>  	bio.bi_private = current;
>  	bio.bi_end_io = blkdev_bio_end_io_simple;
> +	bio.bi_ioprio = iocb->ki_ioprio;
>  
>  	ret = bio_iov_iter_get_pages(&bio, iter);
>  	if (unlikely(ret))
> @@ -355,6 +356,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  		bio->bi_write_hint = iocb->ki_hint;
>  		bio->bi_private = dio;
>  		bio->bi_end_io = blkdev_bio_end_io;
> +		bio->bi_ioprio = iocb->ki_ioprio;
>  
>  		ret = bio_iov_iter_get_pages(bio, iter);
>  		if (unlikely(ret)) {
