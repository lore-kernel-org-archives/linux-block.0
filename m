Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0579616C450
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978282; cv=none; b=VarHj1L/mYEyFPrLazYw9LIpdBM+ig69JZgissBJPoh6lgopF5qGE5CsMiqsK/yZcQ1EdM33rSRRlUc7oFfcBzXh/3uEncNzEYbp/W/ps+ws42RY4eqQxg6AxahtCPNvvLs9mVBaSO5LPahgYIXM6La+Nb8bCJzA88EQhx8ZXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978282; c=relaxed/simple;
	bh=sDtraN8UunpXEqIHGLWi4GaAFE/8ZhYvnMrfp7tfe0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQrr1Y7e8IwD5Xv1GwQ+logMItzoOIwJuESIQnn4gASvmzy6Q/6q9jXtHDEMw5CxFMmy5EqNDRJ1hZggaKzFRZlwFTgl/VBQNvndYnPKPDWM+yohtxQe1uRvqRcRYqQvFRY6rn1YvQfG1Bi7+8LsRfkPwWss9q31aYheCNbzoMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEqjdBFL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEqjdBFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2E2C113CD;
	Wed, 24 Apr 2024 17:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713978281;
	bh=sDtraN8UunpXEqIHGLWi4GaAFE/8ZhYvnMrfp7tfe0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEqjdBFLy91ZTMo69dt1rRA1yngUGXRAgrpq+FVTPuudAw8HNLwyqwBycTupEPDbZ
	 +L8A11+d/Z4Mx0xMSPiE0G2d/ZAcY6eseYRei7VKD5Vp+LurUHtJRPCf4hGzydalB7
	 Hkj0bklYqO+AjHK6S2vPweH94ygf5IcehWo/Nb2fgkEfcABCqtOFd5FXpLBsPqnW1W
	 V7VsDwe8rvCWrH/zzdMk/IjN+skkhDB3Ah3SMAfpOPlZlChmwDKTibrcg7ZBw/ghL3
	 a2AZHILwnxI4dIEnXivD5Zcxsq3tpwyTX7EwoceNhwH+iuyEtx/syHUqoKRddCxJJq
	 FTkB4xM80GEbA==
Date: Wed, 24 Apr 2024 11:04:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, willy@infradead.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH] block : add larger order folio size instead of pages
Message-ID: <Zik7poszllipdSmE@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240419092428epcas5p4f63759b0efa1f12dfbcf13c67fa8d0f0@epcas5p4.samsung.com>
 <20240419091721.1790-1-kundan.kumar@samsung.com>
 <20240422111407.GA10989@lst.de>
 <20240424132246.7ny74cec7cvphg5i@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424132246.7ny74cec7cvphg5i@green245>

On Wed, Apr 24, 2024 at 06:52:46PM +0530, Kundan Kumar wrote:
> > while the same_page logic in bio_iov_add_zone_append_page probablyg
> > needs to be folio-ized first, it should be handled the same way here
> > as well.
> 
> Regarding the same_page logic, if we add same page twice then we release
> the page on second addition. It seemed to me that this logic will work even
> if we merge large order folios. Please let me know if I am missing something.

The 'same_page' logic should only happen with successive calls to
__bio_iov_iter_get_pages(), and only for the first page considered, so I
think the logic is handled the same with your change.
