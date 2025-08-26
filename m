Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FDC2FDC44;
	Tue, 26 Aug 2025 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216069; cv=none; b=XlSYlPF+Tt1OYwf1yvKvdjoWdCeuaJJ0slTtBy8+onvTZLvaMycPBFncGXDfoLGdk6nQNhmkzaewlauoxjz0FPO6GroR0sZiBYArmaUO07dEXnZArSWp3Xwx4lstsE90msejefoyKPIv6dhlw4zshALG8S1sred58BUdpei/Diw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216069; c=relaxed/simple;
	bh=SDKDv4TIVZyQwW8dTQHiERQW4dJY502u9RzkRSwZ3Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMcAoPhJ7RtN2YYstHj9zbDF9Hmu+kdQM5PBIMcLY151nLviG00wIGOckN7RrRqPyiFmNID8pixfy262OC2w6DF+J/xL3N/D8raZte+TJ2UXrlYtFVMoKNzMkHsukL1/YrTZwxgHkrBj5/2ZGUOF90n+jE476+HyKaJumMBByXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo9ZjFu9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo9ZjFu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39448C4CEF1;
	Tue, 26 Aug 2025 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756216068;
	bh=SDKDv4TIVZyQwW8dTQHiERQW4dJY502u9RzkRSwZ3Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mo9ZjFu9/1/CcP8hVMF3bnP53wARLg7+h/L6a3vI8IJd84pXBNRA02aSWeokQiaDG
	 QrwfLKd210bym3D57v3yJI3kSpDRWiGBRxtuNa/MM9z0cDpIeRUwO5fwmyD+7fWE7k
	 GpX9dUJw7Psu9+9CV1/zip4Vf6DX3GcH+WjO0tZWDHNdf6WTjkfXB2gghQWc2jEWBH
	 7dpoIae6CY7BBRP925vLa57bf4B+uVMTZt9ghbGNaOgUltsik4SbvhXaGnjGBqFcQz
	 bqp+iNh/KYDgzksf+ch4yLETehjnvhTeBfP1V161FdMLyxJisyijIcFHjstCZCWkWq
	 FQfY0DjsyrWyg==
Date: Tue, 26 Aug 2025 07:47:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, iommu@lists.linux.dev
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <aK27AhpcQOWADLO8@kbusch-mbp>
References: <20250821204420.2267923-1-kbusch@meta.com>
 <20250821204420.2267923-2-kbusch@meta.com>
 <aKxpSorluMXgOFEI@infradead.org>
 <aKxu83upEBhf5gT7@kbusch-mbp>
 <20250826130344.GA32739@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826130344.GA32739@lst.de>

On Tue, Aug 26, 2025 at 03:03:44PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 25, 2025 at 08:10:59AM -0600, Keith Busch wrote:
> > 
> > PAGE_SIZEs, iommu granules, and virt boundaries are all power-of-two
> > values, and PAGE_SIZE is always the largest (or tied for largest) of
> > these.
> 
> I just had an offlist conversation with someone trying to make a nvme
> device with a virt boundary larger than PAGE_SIZE work.  No idea
> where that device came from.

Currently, the virtual boundary is always compared to bv_offset, which
is a page offset. If the virtual boundary is larger than a page, then we
need something like "page_to_phys(bv.bv_page) + bv.bv_offset" every
place we need to check against the virt boundary.
