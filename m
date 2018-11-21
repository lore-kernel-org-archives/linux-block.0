Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A1AC43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 09:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB162145D
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 09:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="lhBZf8SH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB162145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scylladb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbeKUTsw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:48:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51758 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbeKUTsw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 14:48:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so4709065wmc.1
        for <linux-block@vger.kernel.org>; Wed, 21 Nov 2018 01:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b8N6WTwh1G0x01KrVa3aRSRRdwLBeMG5Eceu93XKNOw=;
        b=lhBZf8SHpyIzJarH3ochkiipwkRt1oUUtw13RznM+CAw/Bojj9hAtmomt455Q6b7Gm
         bVONpLf37b9gI7wmV9OLul4iOLL+yq0F8eBdyYfuXpvEzOI3+Q/0OLmgNqf90cTaN/Ix
         qXSi1EJPq0kUxdp4ct1JbhcGeo31eswfyMtQcgayHI0AlNFx/dBALb1x2Fa2l2OPfXig
         wzAq2+GxbKZx8t0PGDf8X6/eo2Ye7XtYe3//ZK9es5of6a6ojmqUzAzi2JCyKZuD3xKI
         AVX+s//DKIe03LILDaeggp+otkPqtG+fgCVnM0+TJaCiKPfWMpgkrDVcDZOcXO/LiNqR
         FqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b8N6WTwh1G0x01KrVa3aRSRRdwLBeMG5Eceu93XKNOw=;
        b=p13PIMOiAVzRcByX1o+CrzGIjsfwy6CeqPT+iuzl/SWLr0Vb62pb8OZrIjQ7ebo5yl
         wp6XxiKFKsMyAbJbLYB6/nd4Ep1TLO9KBDDP3HY+J5GyUtNfrgFurMDubhtqN/HHCubp
         9AsCXMJ0EihRzMmQPD1AVg4lLKXoUHj2pGkrwK3eKDdu0vidh/oYx7tYc8MffzgYXfV7
         vFQZSzLx/hDvWgckzq3USZJsz+iRfIts2r9QDK6LMPrsxKIA8iW/kXJ1IbKMMRgra/4B
         gFNc76IKeA8hexpKUgV/SdEi1sO8lz64w4xP1zqybRiZdkfa2lTxlAhOvE2zYoLo4tbo
         w0ZA==
X-Gm-Message-State: AGRZ1gJJOTIXIK15XR/dJeMS+seA8ycCA6sKVBvdsdsS/f8GCHl4wHD6
        1cjmpi244ypkzoajZZYnXVPIIw==
X-Google-Smtp-Source: AJdET5eYo4ht07GVq0//St5jfQHwPI/Qcpp54in6EA7Fuxy2sFKMW+tcUTWKQpCkfN78zppSSzhFVw==
X-Received: by 2002:a1c:9f8f:: with SMTP id i137mr4890142wme.30.1542791709525;
        Wed, 21 Nov 2018 01:15:09 -0800 (PST)
Received: from bhalevy-lt (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id s206-v6sm327118wms.29.2018.11.21.01.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 01:15:08 -0800 (PST)
Message-ID: <feffd542a50966c7cd552c280290f406ea5629ef.camel@scylladb.com>
Subject: Re: [PATCH 3/8] iomap/xfs: wire up file_operations ->iopoll()
From:   Benny Halevy <bhalevy@scylladb.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 21 Nov 2018 11:15:07 +0200
In-Reply-To: <20181120171953.1258-4-axboe@kernel.dk>
References: <20181120171953.1258-1-axboe@kernel.dk>
         <20181120171953.1258-4-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2018-11-20 at 10:19 -0700, Jens Axboe wrote:
> Add an iomap implementation of fops->iopoll() and wire it up for
> XFS.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/iomap.c            | 50 +++++++++++++++++++++++++++++--------------
>  fs/xfs/xfs_file.c     |  1 +
>  include/linux/iomap.h |  1 +
>  3 files changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 74c1f37f0fd6..faf96198f99a 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -1419,14 +1419,14 @@ struct iomap_dio {
>  	unsigned		flags;
>  	int			error;
>  	bool			wait_for_completion;
> +	blk_qc_t		cookie;
> +	struct request_queue	*last_queue;
>  
>  	union {
>  		/* used during submission and for synchronous completion: */
>  		struct {
>  			struct iov_iter		*iter;
>  			struct task_struct	*waiter;
> -			struct request_queue	*last_queue;
> -			blk_qc_t		cookie;
>  		} submit;
>  
>  		/* used for aio completion: */
> @@ -1436,6 +1436,30 @@ struct iomap_dio {
>  	};
>  };
>  
> +int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
> +{
> +	struct iomap_dio *dio = kiocb->private;
> +	struct request_queue *q = READ_ONCE(dio->last_queue);
> +
> +	if (!q || dio->cookie == BLK_QC_T_NONE)
> +		return 0;
> +	return blk_poll(q, READ_ONCE(dio->cookie), spin);

How about:
	blk_qc_t cookie = READ_ONCE(dio->cookie);

	if (!q || cookie == BLK_QC_T_NONE)
		return 0;
	return blk_poll(q, cookie, spin);

Is there a chance the dio->cookie in the if () condition
will be stale?

> 
> +}
> +EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
> +
> +static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
> +		struct bio *bio)
> +{
> +	atomic_inc(&dio->ref);
> +
> +	/*
> +	 * iomap_dio_iopoll can race with us.  A non-zero last_queue marks that
> +	 * we are ready to poll.
> +	 */
> +	WRITE_ONCE(dio->cookie, submit_bio(bio));
> +	WRITE_ONCE(dio->last_queue, bdev_get_queue(iomap->bdev));
> +}
> +
>  static ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  {
>  	struct kiocb *iocb = dio->iocb;
> @@ -1548,7 +1572,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
>  	}
>  }
>  
> -static blk_qc_t
> +static void
>  iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
>  		unsigned len)
>  {
> @@ -1568,9 +1592,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
>  	get_page(page);
>  	__bio_add_page(bio, page, len, 0);
>  	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
> -
> -	atomic_inc(&dio->ref);
> -	return submit_bio(bio);
> +	iomap_dio_submit_bio(dio, iomap, bio);
>  }
>  
>  static loff_t
> @@ -1676,11 +1698,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		copied += n;
>  
>  		nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
> -
> -		atomic_inc(&dio->ref);
> -
> -		dio->submit.last_queue = bdev_get_queue(iomap->bdev);
> -		dio->submit.cookie = submit_bio(bio);
> +		iomap_dio_submit_bio(dio, iomap, bio);
>  	} while (nr_pages);
>  
>  	if (need_zeroout) {
> @@ -1782,6 +1800,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
>  	if (!dio)
>  		return -ENOMEM;
> +	iocb->private = dio;
>  
>  	dio->iocb = iocb;
>  	atomic_set(&dio->ref, 1);
> @@ -1791,11 +1810,11 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	dio->error = 0;
>  	dio->flags = 0;
>  	dio->wait_for_completion = is_sync_kiocb(iocb);
> +	dio->cookie = BLK_QC_T_NONE;
> +	dio->last_queue = NULL;
>  
>  	dio->submit.iter = iter;
>  	dio->submit.waiter = current;
> -	dio->submit.cookie = BLK_QC_T_NONE;
> -	dio->submit.last_queue = NULL;
>  
>  	if (iov_iter_rw(iter) == READ) {
>  		if (pos >= dio->i_size)
> @@ -1894,9 +1913,8 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  				break;
>  
>  			if (!(iocb->ki_flags & IOCB_HIPRI) ||
> -			    !dio->submit.last_queue ||
> -			    !blk_poll(dio->submit.last_queue,
> -					 dio->submit.cookie, true))
> +			    !dio->last_queue ||
> +			    !blk_poll(dio->last_queue, dio->cookie, true))
>  				io_schedule();
>  		}
>  		__set_current_state(TASK_RUNNING);
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 53c9ab8fb777..603e705781a4 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1203,6 +1203,7 @@ const struct file_operations xfs_file_operations = {
>  	.write_iter	= xfs_file_write_iter,
>  	.splice_read	= generic_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
> +	.iopoll		= iomap_dio_iopoll,
>  	.unlocked_ioctl	= xfs_file_ioctl,
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl	= xfs_file_compat_ioctl,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 9a4258154b25..0fefb5455bda 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -162,6 +162,7 @@ typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t ret,
>  		unsigned flags);
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, iomap_dio_end_io_t end_io);
> +int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
>  
>  #ifdef CONFIG_SWAP
>  struct file;

