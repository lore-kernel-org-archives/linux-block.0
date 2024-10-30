Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E51E47BC
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296890; cv=none; b=LxsdZ0v7YZP/QZAKMF4VIi0cUftQ0hIJ1z5e+wZMF9LdTXUXoP8hwjnHWGDiV0JjAWaaCRi6KAuKPLuY3NtuVMuhRCtelDVrunV2RdP1pCp5lLwa+ArfHdYwszX/ncrpuEDnDs3buZmWd/anBqgPpCWfeBkADlAWth2xMc5bL0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296890; c=relaxed/simple;
	bh=6+7m6bYb0yRvXggvjkGS4Ftl7KoswgwqALAkltkMZJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgWXDSb2ImZhBNHaKP7rwFaCmUZCqk72OJZBcSDwfVDNQDSNhvI3IrllChfdh8oV9ntuxypgvBS+cNybkiANQLkFYNyaQNr1yXYHJ0e9BlT2IgQKhA/5pfU7UKjNxFcDTyLURE/H7p0tqk63N/vbxPK/xPTXkXrkYdkclfQgtSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl/5rLSk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl/5rLSk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6BFC4CECE;
	Wed, 30 Oct 2024 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730296890;
	bh=6+7m6bYb0yRvXggvjkGS4Ftl7KoswgwqALAkltkMZJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hl/5rLSk8xUWrwa5SZ9zEWoxtXYayiw4h5biVEPfkCNe1PLnhhaIxlW7qoL1s8OvN
	 lD8SC4/7kV0u6BKKt+J0ggTHKjCaCm8kqrcnYoUE7uiI57FDwlBD9I9r+6tVFnJaHy
	 accUAztW4Uo0lmN3+gxRYD8e3vOMBeicVCSYnBAoriaqNy875wtOvS1h+3eQihnzX9
	 qntUNReqYZOF5Rgkm1bP4MmaSHEVtTgWRQDWG91zV6teHVvZrbgGBH0enCSv5vVvfg
	 ZTQpRNSdgz/X4yuQh0+r8lHIyn3krgUmFK36eScMwEq8FmIUj9krmQ+FapM4B1AAoO
	 mFvR+YY3QzoEQ==
Date: Wed, 30 Oct 2024 08:01:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, anuj20.g@samsung.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
Message-ID: <ZyI8N3HpC_2ffxsS@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20241016201337epcas5p33625af2c67f92092078b0b43874d67bd@epcas5p3.samsung.com>
 <20241016201309.1090320-1-kbusch@meta.com>
 <5220b70f-13e9-4f73-b611-97235db87ed5@samsung.com>
 <c156bc1f-da5c-4522-8e5d-b138a94cb7d2@kernel.dk>
 <75331d62-fb0b-41ef-9a47-2bbe78e09f9f@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75331d62-fb0b-41ef-9a47-2bbe78e09f9f@kernel.dk>

On Wed, Oct 30, 2024 at 07:50:12AM -0600, Jens Axboe wrote:
> On 10/30/24 7:47 AM, Jens Axboe wrote:
> > On 10/30/24 7:38 AM, Kanchan Joshi wrote:
> >> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> >>
> >> Jens,
> >> Please see if this can be picked.
> >> Helps to reduce a dependency for io_uring metadata series.
> > 
> > Keith, is this queued in the nvme tree?
> 
> Doesn't look like it is, picked it up.

Thanks. It has block api changes, so I usually don't presume to apply
those patches through our nvme tree.
