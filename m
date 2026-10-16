Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9412442397;
	Fri, 16 Oct 2026 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792153722; cv=none; b=p9zrXL49cFJCAwCI9ukOum9CFrv9s3cIvoMYUbGAcabaHdnECtLcMRgu9su0bz2+T6KcJw++xuAtLNUVayV6VDDAQF21kf93G0tosAsrOPKxxGmJDTATUb5MaP2hhjDT+mtNFyq4lI2YkLtdugWDqanR4iSOJCaHfRn6XwHolew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792153722; c=relaxed/simple;
	bh=5J2o0JhQEeVFB8oYzQE4oBtp6Bc13TQlI66iTPBX3tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ttg0f7qKni9BTkeuBonJJ3y4s6WmFGI6UKgoWhFcyyOnF1cmq06RkZgzBnCMt3Ogs0ZJ3a+lgxCQle82axPkbHcSzmBVy9KaKf4p2M2MZhfyUa1BrGMWAfZOd0A4O1jGs4tE++iRa/zyydn4ul34FuQhNOFZNVVG5Yt0OelJfxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F16B68D0D; Fri, 16 Oct 2026 14:28:36 +0200 (CEST)
Date: Fri, 16 Oct 2026 14:28:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj1072538@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	asml.silence@gmail.com, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] nvme/io_uring: enable dma-buf backed passthrough I/O
Message-ID: <20261016122836.GB3555@lst.de>
References: <20261016103453.1129150-1-anuj1072538@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016103453.1129150-1-anuj1072538@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 16, 2026 at 04:04:20PM +0530, Anuj Gupta wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Allow registering a dma-buf against an NVMe namespace character device
> and using it as the data buffer of fixed uring_cmd passthrough I/O.
> 
> io_uring_cmd_import_fixed() now accepts dma-buf buffers and attaches
> the current map. blk_rq_map_user_iov() maps dma-buf iterators directly,
> since they cannot fall back to a bounce copy.

This really needs to be split into blk, io_uring and nvme parts, with
a good commit log for each part.

> +/* Prepare a bio for passthrough I/O from a directly mapped iterator. */
>  static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)

And adding a comment to an otherwise unrelated function probably also
wants a comment..

> +	if (iov_iter_is_dmabuf_map(iter)) {
> +		if (map_data || (iov_iter_alignment(iter) & align))
> +			return -EINVAL;
> +		ret = blk_rq_map_user_bvec(rq, iter);
> +		return ret == -EREMOTEIO ? -EINVAL : ret;

The error value remapping could probably also use a comment (and be
turned into an if to stand out).

> +static int nvme_ns_chr_init_dma_buf_io_ctx(struct file *file,
> +					   struct dma_buf_io_ctx *ctx)
> +{
> +	struct nvme_ns *ns = container_of(file_inode(file)->i_cdev,
> +					  struct nvme_ns, cdev);
	struct nvme_ns *ns =

>  }
>  
> +void io_uring_cmd_detach_dmabuf(struct io_uring_cmd *ioucmd)
> +{
> +	io_detach_dmabuf_map(cmd_to_io_kiocb(ioucmd));
> +}
> +EXPORT_SYMBOL_GPL(io_uring_cmd_detach_dmabuf);

Add a comment on when this should be used?

>  		return -EINVAL;
>  
> -	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags);
> +	ret = __io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags,
> +				  IO_REGBUF_IMPORT_ALLOW_DMABUF);
> +	if (ret)
> +		return ret;
> +	return io_attach_dmabuf_map(req, iter, issue_flags);

No new here, but maybe io_import_reg_buf should take the flags argument
instead of the spurious __variant given how few users there are?

