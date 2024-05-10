Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB21429A
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367416; cv=none; b=BQfOoI2K2o+/uRwDXB8K/wetUUQxVzZtZ9XdnK1qTfHkE4J52JvG1PKQOymCPJS5vng3OiFWfb16xGQ1dPPv5wE3I+JUC+OseZj4E5rbLvFOovPPm8SqQBjRA0u3akrbluapM/4Ui1kSo9DifDup2fn+BofM5Lph3REa2nZj37A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367416; c=relaxed/simple;
	bh=ECaDfO5MsNDA5UYbwvN2Kr+iU2d22VaDi3QcHpzAw6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rptFV9qJijrUfYgPbEtm5/gsHNJUisa1K1W3t25k/ezv7NNId80xjZta/rBtW6mrChNtcVDmnd6/Ltkhg+v2JkmIpq9snAbI1GtH09yuEV3W6zs+YP41clTwEw1rOoL1Lu9GgroQHB/pjZx5HS0J3yo4SWPb2ruTfmgMhoUo7kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1sgAvhf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1sgAvhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5704C113CC;
	Fri, 10 May 2024 18:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715367416;
	bh=ECaDfO5MsNDA5UYbwvN2Kr+iU2d22VaDi3QcHpzAw6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1sgAvhfSX3ExUtvbZqiIs1cXjbERgdIloprJYf05b33LZLczfOneKbjGOlGE4aBR
	 1ZrZuKJY7NccMR/3QMJbCQfOqvUjWnnbSlL8Pa5mD167VSwUc1d4LoznKVb0g3XqIr
	 Ys47ZyO2teHAB7j1HY3RwsSEDeuw3N5A32JgvEuqQ3c5oNo3ZQFerc+LCav3N/2z8d
	 KgSY3vRTcZwCegUC9+1IaZN5D+t6gaw0W7yHEvA/3cvSDSGY1L5J/WApgBffSY/Gqe
	 xcHXbJIsPbkje5pu1KtTpg+zVDq4KBM+RcvGzw32x49o+d4VXZcaRQ9MvFXFP6hHW7
	 GEtchJ0hZKhAw==
Date: Fri, 10 May 2024 12:56:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, martin.petersen@oracle.com,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH] block: unmap and free user mapped integrity via submitter
Message-ID: <Zj5t9TwrT77KGOyr@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240510095142epcas5p4fde65328020139931417f83ccedbce90@epcas5p4.samsung.com>
 <20240510094429.2489-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510094429.2489-1-anuj20.g@samsung.com>

On Fri, May 10, 2024 at 03:14:29PM +0530, Anuj Gupta wrote:
> The user mapped intergity is copied back and unpinned by
> bio_integrity_free which is a low-level routine. Do it via the submitter
> rather than doing it in the low-level block layer code, to split the
> submitter side from the consumer side of the bio.

Thanks, this looks pretty good.

>  out_unmap:
> -	if (bio)
> +	if (bio) {
> +		if (bio_integrity(bio))
> +			bio_integrity_unmap_free_user(bio);
>  		blk_rq_unmap_user(bio);
> +	}

Since we're adding more cleanup responsibilities on the caller, and this
pattern is repeated 4 times, I think a little helper function is
warranted: 'nvme_unmap_bio(struct bio *bio)', or something like that.
