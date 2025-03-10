Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4724227BA4
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603615; cv=none; b=cND7AOz+gSVC94vVf9Jn0qDMnwYuO0OmG2qe0W6v8C6vKsujGDo2MGoxBfnjeFghE91DCEdGofbAIVLBxe0D3Qq3Hj+CozEcqjc3GP8qOB8caWQWiLQdQYgRGnsgWF5lG/u7qu9a8p6tfFxACTCLq1raPMeMgQHQOdn9bxbgh/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603615; c=relaxed/simple;
	bh=sdy5eaOI042e4wDDm+i++bwXqk8Z7mAD2FWuxMk5hag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyzWcSimZlA6kXmfYB6I0JovnP0Oq27oNmYAu4jVZQC1G4Q23PG4k8iWK43fkcblpjl6CVNhOt7+PZJVfbAu0thvvaGNbhe+XPeN5gpVOuPxBkMQDnIij9Eo1DHElM8xNMyf0VOANgJtM0kEkgIaxmMhSou9bnKrQyEopjnUj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sA2PFhpZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sA2PFhpZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wq3mb0BDrKNYhS8eJFzopXuQ5KZkNnLX4FcCp8qaNr4=; b=sA2PFhpZ/HTHWhmoISnrTtN8r3
	wqfbLlSKOvlwX3jz8Qcfdx2DCvyohIyAOBRiuy0YI2sY+D0X1lhH5YldlST/q8hfOEPjo/am2HAcX
	A6Nl/6n5cP4Y09qPPyqxeyEbo0LISI9YDccZrc3MDCMCYCzFw8tPDgNJWW7hiB0hi9U1XMK5RbANf
	ejWYo71c5KeOGuqIfdzO0nbu+G/vEJN0HX0wAOG2h6/0g30/7iRhTiwjBjs0fINLCn1YYYXhPmW6l
	eaYIZMzgOkVA2TpR5rvJ9yryAmEyf0jqsHZxwVDij8DvUK8Sxc2IhceVRyqN9lb4Y+yquuGwFPprz
	/7TFrNKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1traeq-00000002IYo-2x7t;
	Mon, 10 Mar 2025 10:46:52 +0000
Date: Mon, 10 Mar 2025 03:46:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [RESEND PATCH 1/5] loop: remove 'rw' parameter from lo_rw_aio()
Message-ID: <Z87DHHqd-HNPIpUG@infradead.org>
References: <20250308162312.1640828-1-ming.lei@redhat.com>
 <20250308162312.1640828-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308162312.1640828-2-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Mar 09, 2025 at 12:23:05AM +0800, Ming Lei wrote:
> lo_rw_aio() is only called for READ/WRITE operation, which can be
> figured out from request directly, so remove 'rw' parameter from
> lo_rw_aio(), meantime rename the local variable as 'dir' which matches
> the actual use more.
> 
> Meantime merge lo_read_simple() and lo_write_simple() into
> lo_rw_simple().

That's two entirely separate things, please split them into separate
patches.

static int lo_rw_simple(struct loop_device *lo, struct request *rq, loff_t pos)
>  {
>  	struct bio_vec bvec;
>  	struct req_iterator iter;
>  	struct iov_iter i;
>  	ssize_t len;
>  
> +	if (req_op(rq) == REQ_OP_WRITE) {
> +		int ret;
> +
> +		rq_for_each_segment(bvec, rq, iter) {
> +			ret = lo_write_bvec(lo->lo_backing_file, &bvec, &pos);
> +			if (ret < 0)
> +				break;
> +			cond_resched();
> +		}
> +		return ret;
> +	}
> +
>  	rq_for_each_segment(bvec, rq, iter) {

.. and nothing is really merged here.  So unless you actually merge
some code later this part doesn't seem particularly useful.

>  	struct request *rq = blk_mq_rq_from_pdu(cmd);
> +	int dir = (req_op(rq) == REQ_OP_READ) ? ITER_DEST : ITER_SOURCE;
>  	struct bio *bio = rq->bio;
>  	struct file *file = lo->lo_backing_file;
>  	struct bio_vec tmp;
> @@ -448,7 +442,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  	}
>  	atomic_set(&cmd->ref, 2);
>  
> -	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
> +	iov_iter_bvec(&iter, dir, bvec, nr_bvec, blk_rq_bytes(rq));
>  	iter.iov_offset = offset;
>  
>  	cmd->iocb.ki_pos = pos;
> @@ -457,7 +451,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  	cmd->iocb.ki_flags = IOCB_DIRECT;
>  	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
>  
> -	if (rw == ITER_SOURCE)
> +	if (dir == ITER_SOURCE)


i'd just use the request direction check here, and then open code
the iter source/dest in the iov_iter_bvec call.

>  	case REQ_OP_READ:
>  		if (cmd->use_aio)
> -			return lo_rw_aio(lo, cmd, pos, ITER_DEST);
> +			return lo_rw_aio(lo, cmd, pos);
>  		else
> -			return lo_read_simple(lo, rq, pos);
> +			return lo_rw_simple(lo, rq, pos);

Not entirely new here, but there is no reason to use an else after a
return.

