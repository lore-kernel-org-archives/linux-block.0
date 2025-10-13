Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F058E2D8764;
	Mon, 13 Oct 2025 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381630; cv=none; b=XF0Mz2WpyNPCpYjOQzzdxWLtmjQAmKj0s3GWA1DmsPiJxEY7Ot/ss/4WGW7WE8RjAhjQ/vMSYvneCkjJC5EGXLR76jJA/tyw+s0ae7VKFQD3s1Y/uDM6RRBC5ZIMsdZctaonVPCEr+MjkywkdXAhYueAT74jgmyOIru88UI/FiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381630; c=relaxed/simple;
	bh=QbCkkqHDRODaloYhX6Hv/SUHAubYrcVQyDlxupIG2jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoGtznaJVvrX3V3qiTmv+tk0NaKQrJnAcPvZ9M85ShhbOna0QT2M1vprLvupkcXj5Xk9rkPWnuN+nlLPG1fdKRaQRrmeITm14vcLVQEEMhQ8+wLVXx1k1j1+WdzeTe3xKMlsEzjxAxrCHnNWtFauXwvYzpL5P/xC+SdlHXstixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+VWFlby; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+VWFlby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F89AC4CEE7;
	Mon, 13 Oct 2025 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760381629;
	bh=QbCkkqHDRODaloYhX6Hv/SUHAubYrcVQyDlxupIG2jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h+VWFlbym/MbpFKzMA0bfI4FgsEQzA2Uv+xaqz8XNUt+vQrC3luUw15Zdmmn70O++
	 OQItyqjhCU1wvRt9DE1zHfO+SQ1GeKLtWMmBwufETANYEO2pTFTFR2PpcZ4yt3+9XN
	 VE+D6Ed7rPRbKv2m6DpvUdaK/bvHcz5wm65Mg6uta4IUx5EX3aDC7fpD2QCePcR3eM
	 hKWooNw4wnbGr96FeIEC2dT5IOCnvE/9VsD5WFYu2H5GIgnAHkP2UStgL3g2seV/as
	 PLOPYpFBFR9RKBFSfsYnINP2TgnWBNzvuGk9uphOiJDbypaZQ5V/0HRDi4XpxsyrlS
	 +s6vUK8mMnydg==
Date: Mon, 13 Oct 2025 12:53:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/4] blk-mq-dma: unify DMA unmap routine
Message-ID: <aO1Ku5DCIMVRirdu@kbusch-mbp>
References: <cover.1760369219.git.leon@kernel.org>
 <04baf1fdff8a04197d5f64c2653c29e7482a2840.1760369219.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04baf1fdff8a04197d5f64c2653c29e7482a2840.1760369219.git.leon@kernel.org>

On Mon, Oct 13, 2025 at 06:34:10PM +0300, Leon Romanovsky wrote:
> +bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
> +		struct dma_iova_state *state, size_t mapped_len)
> +{
> +	struct bio_integrity_payload *bip = bio_integrity(req->bio);
> +
> +	if ((!bip && req->cmd_flags & REQ_P2PDMA) ||
> +	    bio_integrity_flagged(req->bio, BIP_P2P_DMA))
> +		return true;

I don't think you can unify it at this part here because the data
payload might not be P2P but the integrity payload could be. The data
payload needs to proceed to the next unmapping step in that case, but
this change would have it return true early.
