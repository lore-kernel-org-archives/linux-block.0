Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE21C277CB2
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753822514; cv=none; b=LN2Pljd+4SQw4g7cMaUY7qyLHJ05glxCZRSiuYKWc9kCHX9hjuaaSLYwPpLpW3228k1q9RlzsodyLJg6DzQ0N3azkJuOtqvTQt3mk9BhzrFKdTLpR9JZhpJTMgfARfGkkYmCDVzU2dQbbUQwNNFae3MepQN2oAVEpNBntEX16jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753822514; c=relaxed/simple;
	bh=ZzYN96Moe8AtxV3K1biVgKSey9DTJG3tHDYusHZa7ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mtm2xlC1huKi8WeLoWTn4+C0ODC+Kl0t5q5WYOt/fekw5pg/d5NCcOurGJcbjJcxdgDmFmBJ0kSS0kwHscQzCb1t46HNiIJ53T3que85CbKuuCZjdzxLqccs8bnB1Yz/8WNLDO3Esu4Kc4vI0WlSUqIwgYBGOuVTTolOyj/Jcjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=robIGI1T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="robIGI1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0862C4CEEF;
	Tue, 29 Jul 2025 20:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753822514;
	bh=ZzYN96Moe8AtxV3K1biVgKSey9DTJG3tHDYusHZa7ZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=robIGI1TLqiOPkAznr10kff37xRqHA52O4BOzbC6VYFTpLoIKUcZ5iEd0T7dGcMgb
	 CsXwIEyPU3c/QSfMiSEIouaBywg8sJfdYK8XkdTTqHpyH0b8zfIb6HzfUF3C1/sAlp
	 k/U1A77RCwjr28QQauKsZi8rwcp5hTcpYt5MvbqIAT0BvsXp9Pgh0pdQhX8AbPWa8Z
	 NHElScaTAGfTcHxb6St/LqiO6o+pxTAo0kM+/MatgIlQ8JgfbgO7qwj+W12jnQf88m
	 z+BwIDZ3AX68giQMRwC0seehrYmNnd+HLkWSLab/wpZMdjUi0pXTAVkma6nTwbDvFP
	 W/G5AgJLB85Fg==
Date: Tue, 29 Jul 2025 14:55:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com
Subject: Re: [PATCHv3 2/7] blk-mq-dma: provide the bio_vec list being iterated
Message-ID: <aIk1L5DpRpn_O_mS@kbusch-mbp>
References: <20250729143442.2586575-1-kbusch@meta.com>
 <20250729143442.2586575-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729143442.2586575-3-kbusch@meta.com>

On Tue, Jul 29, 2025 at 07:34:37AM -0700, Keith Busch wrote:
> @@ -244,8 +244,10 @@ int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
>  	int nsegs = 0;
>  
>  	/* the internal flush request may not have bio attached */
> -	if (bio)
> +	if (bio) {
>  		iter.iter = bio->bi_iter;
> +		iter.bvec = bio->bi_io_vec;

Oops, this should have been:

		if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
			iter.bvec = &rq->special_vec;
		else
			iter.bvec = bio->bi_io_vec;

Hopefully over time everything coverts to the dma iterator and this
legacy sg mapping can fade away.

> +	}
