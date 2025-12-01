Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C030496A
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582878; cv=none; b=dIYq7/g6zj2Dx19Xp+B35aBoLBsbxtpvCuO9q+21EJRGR0skFB24mTQat2eI4m/OLQ1fFCB5JrMsBm2muHKg183M4DS0ScRMsEK0pIDTq35sptxWsiqVpxwX8u3NtIzRO62eyqtCUARTnMK9IHTKVuVcNfrJeVLQ1kAfIAmFT7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582878; c=relaxed/simple;
	bh=MzdPFRAa+ie0qCQYawM/QZeNS/AqI5HkwFUm+H8HLu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0nX2J+PihD0+8F2+yeqjOT5qqZR3n5QSNRfB5QhUMIHBWk5dLaDBdaBNY421iM9cuHcfm+2gsZ6hU8MATJn2aGs7VclfOYLJ9JFQktHtPArQBWMCX01SlSm6Xz+D0lYNSGjw+ssT+PJQXoQJW5mIByh+W+Spezwxgr/vJJ4e74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MegJCiHK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MegJCiHK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C39C113D0;
	Mon,  1 Dec 2025 09:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764582878;
	bh=MzdPFRAa+ie0qCQYawM/QZeNS/AqI5HkwFUm+H8HLu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MegJCiHKAelA4frNd5KDXMSrDhTH5xtTSIJ0uiGkuweRm4i/DeDM6TzvT/SlM7tfK
	 OIwddrojnpb+WOQOocKbHMeJewG9CvdrVil3C6V6xKdQqgdRPo0QVlMgcyz8RT6Qz7
	 iUxEZhBrer8PY3A1JcePAEPTbFNHoRtxoXDxcD5jSpiUMXGH6VW3/F3oLTy2Fkx98J
	 TQopf2/PDQhPvnaVgi/4DX1Cu2NJGMOL3K8rqtuR5+k7kvWvKQuDw1aU0SZ/yImZ6U
	 ZNTKbpVNe010NMevkQ52QMYxW0nbVGYy605Qp5G6c0PhTC4zvZaHNSevlRW0gzN3YI
	 oV6Bjn1UckflA==
Date: Mon, 1 Dec 2025 10:54:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	kch@nvidia.com, dlemoal@kernel.org
Subject: Re: [PATCH V2] blk-mq: add blk_rq_nr_bvec() helper
Message-ID: <aS1l2pr50kXzsjuc@ryzen>
References: <20251111232252.24941-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111232252.24941-1-ckulkarnilinux@gmail.com>

On Tue, Nov 11, 2025 at 03:22:52PM -0800, Chaitanya Kulkarni wrote:
> Add a new helper function blk_rq_nr_bvec() that returns the number of
> bvecs in a request. This count represents the number of iterations
> rq_for_each_bvec() would perform on a request.
> 
> Drivers need to pre-allocate bvec arrays before iterating through
> a request's bvecs. Currently, they manually count bvecs using
> rq_for_each_bvec() in a loop, which is repetitive. The new helper
> centralizes this logic.
> 
> This pattern exists in loop and zloop drivers, where multi-bio requests
> require copying bvecs into a contiguous array before creating
> an iov_iter for file operations.
> 
> Update loop and zloop drivers to use the new helper, eliminating
> duplicate code.
> 
> This patch also provides a clear API to avoid any potential misuse of
> blk_nr_phys_segments() for calculating the bvecs since, one bvec can
> have more than one segments and use of blk_nr_phys_segments() can
> lead to extra memory allocation :-
> 
> [ 6155.673749] nullb_bio: 128K bio as ONE bvec: sector=0, size=131072
> [ 6155.673846] null_blk: #### null_handle_data_transfer:1375
> [ 6155.673850] null_blk: nr_bvec=1 blk_rq_nr_phys_segments=2
> [ 6155.674263] null_blk: #### null_handle_data_transfer:1375
> [ 6155.674267] null_blk: nr_bvec=1 blk_rq_nr_phys_segments=1
> 
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---

What is the status of this patch?


FWIW, looks good to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
