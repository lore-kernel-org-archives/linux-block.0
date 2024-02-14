Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3918EB0
	for <linux-block@vger.kernel.org>; Wed, 14 Feb 2024 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909944; cv=none; b=cjU/OtMcd4L2Xlfjjn3QLMxZxXszXz8VwLJWPBe1moQJgG1OGqOjxMXHZRzYYnnXlTke3zseegjb40hFCGy0h2vPEoGO5dtwcvua2F9fS3GZ7nPzSeU733iJzbFqoWPJNZwHjDUUHsRkeOXmc8efVoiWpqhKnZXxhXNVwfbLEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909944; c=relaxed/simple;
	bh=3u+nYgPQtYp7lhHD+mtIHVMeO6syEWD1NKBuX5CtDvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5UwvmKua6ZSnbI3jx6Ti+DYurtei/HETHIk2Mei7LgPCCeT6dpb4CzpAPJ7fRBS/iQnGQAt2e3J1gYxSTmfvIbGXNj+rZX0zQ90hkd6T9PS+lWHJj9FxH6xNUmfB2Ho3VOLaP+mVG1el6jl6wYlv3NSV3avDpHjKNZs1wr2DF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJazyy8H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJazyy8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357EBC433F1;
	Wed, 14 Feb 2024 11:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707909943;
	bh=3u+nYgPQtYp7lhHD+mtIHVMeO6syEWD1NKBuX5CtDvM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mJazyy8HcHuY6KxsuL4NxRL1x40HDNs6HaBDn53MJ6RMVWnm7RyH18eszQO02HNoY
	 ONOnqPXPaD7OHN2kGcsj90yDFxcvV24y4WRlX03R+XCycsXrkKUfQhA7VCncCZ5a29
	 Zhw9/RLiuEiPJh72GomF0mTWmvYZEcuFP3G2NwpztlkEKEB1lskMcIRNGSO9ihW9CF
	 impIaqBERDXLq54qwIxQxq0FRP+zOFMqW7o1GIZXBzRStwOc+wVYj+h82LN56Ws6jh
	 T02VfjxYFLPKe2l/uHRHtTxUokkAvGABBjZAXqQbK/BFP0Qwzie7fECqmD4Cs+lAkN
	 HDvv59rFnTIlg==
Message-ID: <72dbe44d-5fb0-4488-8ecf-2de0eb74a88d@kernel.org>
Date: Wed, 14 Feb 2024 20:25:41 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] null_blk: remove the bio based I/O path
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20240214095501.1883819-1-hch@lst.de>
 <20240214095501.1883819-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240214095501.1883819-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/24 18:54, Christoph Hellwig wrote:
> The bio based I/O path complicates null_blk and also make various
> data structures, including the per-command one way bigger than
> required for the main request based interface.   As the bio-based
> path is mostly used by stacking drivers and simple memory based
> drivers, and brd is a good example driver for the latter there is
> no need to have a bio based path in null_blk.  Remove the path
> to simplify the driver and make future block layer API changes
> simpler by not having to deal with the complex two API setup in
> null_blk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

