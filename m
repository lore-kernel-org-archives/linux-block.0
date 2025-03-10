Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F01B4138
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604880; cv=none; b=WrGDObELYKotT1MnEPAPWdwwPsXIEtvKcdl2DSIdapUED/ga3f6Yzd1paCF2IzsKOGDRHjJRiWQD6G/dS47ad8oX2hxSO9sqBMESqVFbxMfVSPlDfIORKP+f8n/m2cJnTVcEH7Xs/tP+Dtg3aYTbOj7TVYT5ITE9DsTGyUEqI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604880; c=relaxed/simple;
	bh=rT/LvJL6Tm1TPNFeTKvHum6NjbhWZrrJ9YF2bAASuv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGb1FaFqx/Uwj+QAZESmrPDxHq/PKPbUtbGt7NmIlWmB+SKJf6w3iaDYe8TkX2gWKpg0hqs6ypEutJVZIrTL1+nCcjWY3GbFmrQpzieTybUOwqhnL3IEKMXY21P/YXxDBdWkx41sxB0pRIT/nZpgUrx5oC3Ux+9oGS0v8DPECys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wDW+xpr7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wDW+xpr7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ImRw+Aj4EEQuxf9PnP4GLKad17fJiLChRSi7eajOIFQ=; b=wDW+xpr7qldFaWsjVrKxD+Z2zN
	1UX7H5FZGANHv7ivgpCJDQ2oNTFJqMW98xQ5jKa2Rvfzhikit48JbF0Wv4xUFnhH4ZSqY1+WdcKaB
	kWma9Ek3zcOvsI10CMyZOYgzGoZ8LcDeey4wwvlIcwcb9FdLuYg6hpQS2JSXbHv0Y799Naq2PYqiQ
	G7d6/eerrnPMGUynQpwm1MgCx8UBTG99DS8Pw+E6vwwMowUoC4tlc1fb3GcyJvdeGE/MDFKgJbeOe
	DlqvgklvnjsVck3FlMJJjfrxuPhPq3TTZaZV+5GpzyyGQCqUZSYGFSaiPpni0kJBSUqKPHOBG/CsV
	iTze3USw==;
Received: from [80.149.170.9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1traz9-00000002NHQ-0zPb;
	Mon, 10 Mar 2025 11:07:54 +0000
Date: Mon, 10 Mar 2025 12:07:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [RESEND PATCH 2/5] loop: cleanup lo_rw_aio()
Message-ID: <Z87H_UGknDva9ixP@infradead.org>
References: <20250308162312.1640828-1-ming.lei@redhat.com>
 <20250308162312.1640828-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308162312.1640828-3-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Mar 09, 2025 at 12:23:06AM +0800, Ming Lei wrote:
> +	if (rq->bio != rq->biotail) {

This would probably be more self-explaining by checking for cmd->bdev
here.

> +		bvec = cmd->bvec;
> +		offset = 0;
> +	} else {
> +		struct bio *bio = rq->bio;
> +
> +		offset = bio->bi_iter.bi_bvec_done;
> +		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
> +	}
> +	iov_iter_bvec(&iter, dir, bvec, nr_bvec, blk_rq_bytes(rq));
> +	iter.iov_offset = offset;

And given that bvec and offset are only used here I'd just move the
iov_iter_bvec into the branches and do away with the two variables,
and kill the bio variable as well while at it.

> +static inline unsigned lo_cmd_nr_bvec(struct loop_cmd *cmd)
> +{
> +	struct req_iterator rq_iter;
> +	struct request *rq = blk_mq_rq_from_pdu(cmd);
> +	struct bio_vec tmp;
> +	int nr_bvec = 0;
> +
>  	rq_for_each_bvec(tmp, rq, rq_iter)
>  		nr_bvec++;
>  
> +	return nr_bvec;
> +}
> +
> +static int lo_rw_aio_prep(struct loop_device *lo, struct loop_cmd *cmd,
> +			  unsigned nr_bvec)

The function order is a bit weird.  I would expect them to appear in
the rough order that they are called, e.g. lo_cmd_nr_bvec first, then
lo_rw_aio_prep, then the submit helper.

> -		/*
> -		 * Same here, this bio may be started from the middle of the
> -		 * 'bvec' because of bio splitting, so offset from the bvec
> -		 * must be passed to iov iterator
> -		 */

It would be good if this comment didn't get lost.

