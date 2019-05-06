Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B93C04AAA
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 08:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D572B20830
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 08:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEFIUH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfEFIUG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 May 2019 04:20:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 496C387630;
        Mon,  6 May 2019 08:20:06 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A98082D1AB;
        Mon,  6 May 2019 08:19:59 +0000 (UTC)
Date:   Mon, 6 May 2019 16:19:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 8/8] block: never take page references for ITER_BVEC
Message-ID: <20190506081952.GA24702@ming.t460p>
References: <20190502233332.28720-1-hch@lst.de>
 <20190502233332.28720-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502233332.28720-9-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 06 May 2019 08:20:06 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 02, 2019 at 07:33:32PM -0400, Christoph Hellwig wrote:
> If we pass pages through an iov_iter we always already have a reference
> in the caller.  Thus remove the ITER_BVEC_FLAG_NO_REF and don't take
> reference to pages by default for bvec backed iov_iters.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c          | 14 +-------------
>  drivers/block/loop.c | 16 ++++------------
>  fs/io_uring.c        |  3 ---
>  include/linux/uio.h  |  8 --------
>  4 files changed, 5 insertions(+), 36 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 3938e179a530..e999d530d863 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -846,15 +846,6 @@ int bio_add_page(struct bio *bio, struct page *page,
>  }
>  EXPORT_SYMBOL(bio_add_page);
>  
> -static void bio_get_pages(struct bio *bio)
> -{
> -	struct bvec_iter_all iter_all;
> -	struct bio_vec *bvec;
> -
> -	bio_for_each_segment_all(bvec, bio, iter_all)
> -		get_page(bvec->bv_page);
> -}
> -
>  void bio_release_pages(struct bio *bio)
>  {
>  	struct bvec_iter_all iter_all;
> @@ -967,11 +958,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  			ret = __bio_iov_iter_get_pages(bio, iter);
>  	} while (!ret && iov_iter_count(iter) && !bio_full(bio));
>  
> -	if (iov_iter_bvec_no_ref(iter))
> +	if (is_bvec)
>  		bio_set_flag(bio, BIO_NO_PAGE_REF);
> -	else if (is_bvec)
> -		bio_get_pages(bio);
> -
>  	return bio->bi_vcnt ? 0 : ret;
>  }
>  
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 102d79575895..c20710e617c2 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -264,20 +264,12 @@ lo_do_transfer(struct loop_device *lo, int cmd,
>  	return ret;
>  }
>  
> -static inline void loop_iov_iter_bvec(struct iov_iter *i,
> -		unsigned int direction, const struct bio_vec *bvec,
> -		unsigned long nr_segs, size_t count)
> -{
> -	iov_iter_bvec(i, direction, bvec, nr_segs, count);
> -	i->type |= ITER_BVEC_FLAG_NO_REF;
> -}
> -
>  static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
>  {
>  	struct iov_iter i;
>  	ssize_t bw;
>  
> -	loop_iov_iter_bvec(&i, WRITE, bvec, 1, bvec->bv_len);
> +	iov_iter_bvec(&i, WRITE, bvec, 1, bvec->bv_len);
>  
>  	file_start_write(file);
>  	bw = vfs_iter_write(file, &i, ppos, 0);
> @@ -355,7 +347,7 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
>  	ssize_t len;
>  
>  	rq_for_each_segment(bvec, rq, iter) {
> -		loop_iov_iter_bvec(&i, READ, &bvec, 1, bvec.bv_len);
> +		iov_iter_bvec(&i, READ, &bvec, 1, bvec.bv_len);
>  		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
>  		if (len < 0)
>  			return len;
> @@ -396,7 +388,7 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
>  		b.bv_offset = 0;
>  		b.bv_len = bvec.bv_len;
>  
> -		loop_iov_iter_bvec(&i, READ, &b, 1, b.bv_len);
> +		iov_iter_bvec(&i, READ, &b, 1, b.bv_len);
>  		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
>  		if (len < 0) {
>  			ret = len;
> @@ -563,7 +555,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  	}
>  	atomic_set(&cmd->ref, 2);
>  
> -	loop_iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
> +	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
>  	iter.iov_offset = offset;
>  
>  	cmd->iocb.ki_pos = pos;
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index f65f85d89217..f7eb63a5b3db 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -853,9 +853,6 @@ static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
>  	iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs, offset + len);
>  	if (offset)
>  		iov_iter_advance(iter, offset);
> -
> -	/* don't drop a reference to these pages */
> -	iter->type |= ITER_BVEC_FLAG_NO_REF;
>  	return 0;
>  }
>  
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index f184af1999a8..bace8fd40d0c 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -23,9 +23,6 @@ struct kvec {
>  };
>  
>  enum iter_type {
> -	/* set if ITER_BVEC doesn't hold a bv_page ref */
> -	ITER_BVEC_FLAG_NO_REF = 2,
> -
>  	/* iter types */
>  	ITER_IOVEC = 4,
>  	ITER_KVEC = 8,
> @@ -93,11 +90,6 @@ static inline unsigned char iov_iter_rw(const struct iov_iter *i)
>  	return i->type & (READ | WRITE);
>  }
>  
> -static inline bool iov_iter_bvec_no_ref(const struct iov_iter *i)
> -{
> -	return (i->type & ITER_BVEC_FLAG_NO_REF) != 0;
> -}
> -
>  /*
>   * Total number of bytes covered by an iovec.
>   *

I remember that this way is the initial version of Jens' patch, however
kernel bug is triggered:

https://lore.kernel.org/linux-block/20190226034613.GA676@sol.localdomain/

Or maybe I miss some recent changes, could you explain it a bit?

Thanks,
Ming
