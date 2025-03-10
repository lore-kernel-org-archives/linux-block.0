Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8483B1C5D64
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605311; cv=none; b=VKizNkhfQ5rwdL4rS/EH5RespkHso082bUOLJZPsiG/SckV8iaTTpXao0G30xoK0XKobCHuJ8Dh/9R9welNUjd8RlgBdoAjBe9hSFnnshkmz605AmHZNqtmdVelT3U3s4t3HKE7EjhToFXpTrP7vovBIGRH0hs83JAZygtGgcKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605311; c=relaxed/simple;
	bh=Yo2bDDgRVQ5EAzMlH5Zmgthv4P8A7TBBu31JVjocaSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIMrDGHXH8IczioU4DC2HrLxLq/yL0U1HLa6GGIckYH9AtSz40+4KBmcoeJh6cjVfsVtoOIsM4kxYNpnE6tzRz/FUlETr+zMy1WljdPyTTpANJk3yuW5Ku4d0LwaPAQs+8sGPfyEEdbjUz5qPXneN8wgkiU0O+jmMHr47H24Mho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2Y24OgnO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2Y24OgnO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WC5vobSJxHBiNyrT0FtyHcXf8TcdKjkrsn+slAV1Ync=; b=2Y24OgnOdRwF4mbCE1lHxs9NCq
	PXbsrMCuVmZhGPeyekNgWQNljp4HB4MDSDw28pLNVfRS8DOjhObEZVxqZ77CvIsozQ7Q+8sc6cs4f
	Zgo/qNafJyOJftNMPowgaWo68aC8ElJeZ01W5UcXR0cLIdOwnTj4XzzMdNr63fq1fDMKQHsbKnCwc
	lu3h5/LHVYOf/uJBvFaJoxoacf9kI7DiVhU0pJPQHBUjOplNa8l9hPn5v+MICcPtHA1SqATLy+V2a
	T116xlcDNOWaDyhqRdYDum4IQAi5kxI5B4gAJCJ1EKRHKIw679+pax7gvnUMQeJcM29/8aLT5NjUh
	ptFjc2lQ==;
Received: from [80.149.170.9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trb65-00000002OW4-3HtL;
	Mon, 10 Mar 2025 11:15:08 +0000
Date: Mon, 10 Mar 2025 12:14:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [RESEND PATCH 4/5] loop: try to handle loop aio command via
 NOWAIT IO first
Message-ID: <Z87JpLwpw-Fc2bkJ@infradead.org>
References: <20250308162312.1640828-1-ming.lei@redhat.com>
 <20250308162312.1640828-5-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308162312.1640828-5-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Mar 09, 2025 at 12:23:08AM +0800, Ming Lei wrote:
> Try to handle loop aio command via NOWAIT IO first, then we can avoid to
> queue the aio command into workqueue.
> 
> Fallback to workqueue in case of -EAGAIN.
> 
> BLK_MQ_F_BLOCKING has to be set for calling into .read_iter() or
> .write_iter() which might sleep even though it is NOWAIT.

This needs performance numbers (or other reasons) justifying the
change, especially as BLK_MQ_F_BLOCKING is a bit of an overhead.

>  static DEFINE_IDR(loop_index_idr);
>  static DEFINE_MUTEX(loop_ctl_mutex);
>  static DEFINE_MUTEX(loop_validate_mutex);
> @@ -380,8 +382,17 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
>  
>  	if (!atomic_dec_and_test(&cmd->ref))
>  		return;
> +
> +	if (cmd->ret == -EAGAIN) {
> +		struct loop_device *lo = rq->q->queuedata;
> +
> +		loop_queue_work(lo, cmd);
> +		return;
> +	}

This looks like the wrong place for the rety, as -EAGAIN can only come from
the submissions path.  i.e. we should never make it to the full completion
path for that case.

>  static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd, loff_t pos)
> +{
> +	unsigned int nr_bvec = lo_cmd_nr_bvec(cmd);
> +	int ret;
> +
> +	cmd->iocb.ki_flags &= ~IOCB_NOWAIT;
> +	ret = lo_submit_rw_aio(lo, cmd, pos, nr_bvec);
> +	if (ret != -EIOCBQUEUED)
> +		lo_rw_aio_complete(&cmd->iocb, ret);
> +	return 0;

This needs an explanation that it is for the fallback path and thus
clears the nowait flag.

> +}
> +
> +static int lo_rw_aio_nowait(struct loop_device *lo, struct loop_cmd *cmd, loff_t pos)

Overly long line.

> @@ -1926,6 +1955,17 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		break;
>  	}
>  
> +	if (cmd->use_aio) {
> +		loff_t pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset;
> +		int ret = lo_rw_aio_nowait(lo, cmd, pos);
> +
> +		if (!ret)
> +			return BLK_STS_OK;
> +		if (ret != -EAGAIN)
> +			return BLK_STS_IOERR;
> +		/* fallback to workqueue for handling aio */
> +	}

Why isn't all the logic in this branch in lo_rw_aio_nowait?

