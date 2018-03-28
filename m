Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Wed, 28 Mar 2018 09:38:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, hch@lst.de, rdorr@microsoft.com
Subject: Re: [PATCH 2/3] iomap: iomap_dio_rw() handles all sync writes
Message-ID: <20180328073847.GC18726@lst.de>
References: <20180327070717.7107-1-david@fromorbit.com> <20180327070717.7107-3-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180327070717.7107-3-david@fromorbit.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

> @@ -769,12 +777,9 @@ static void iomap_dio_complete_work(struct work_struct *work)
>  {
>  	struct iomap_dio *dio = container_of(work, struct iomap_dio, aio.work);
>  	struct kiocb *iocb = dio->iocb;
> -	bool is_write = (dio->flags & IOMAP_DIO_WRITE);
>  	ssize_t ret;
>  
>  	ret = iomap_dio_complete(dio);
> -	if (is_write && ret > 0)
> -		ret = generic_write_sync(iocb, ret);
>  	iocb->ki_complete(iocb, ret, 0);

Could be simplified to:

{
 	struct iomap_dio *dio = container_of(work, struct iomap_dio, aio.work);

 	iocb->ki_complete(dio->iocb, iomap_dio_complete(dio); 0);
}

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
