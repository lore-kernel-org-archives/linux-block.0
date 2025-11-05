Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEDF1D5CC9
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360114; cv=none; b=f0+NRro1dRaeB0WWTTCZgbbpbdorbiogtiVMrRJL+eBqBwPS1G3oJoTMIHdrBxMbcSiXGQXMJsGafYUp7H+mEfpAMRR3duxz/7BnbCJV/HLttDZnLUMqJlPMdCgmloCDDWg3ZtW4VWNF6e6jv4Ac3EeEPgKBNba7X8oaJx8zWs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360114; c=relaxed/simple;
	bh=Fo/hbxDXHmIlJiY8bm+AiaSnrluEKXAs2vYsCcsD3H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nb3wk3NWrA65QEKWzaT3d0ElyB0QhIQJpoAYWYC6ZIbSsyrf37y/B8kvhRUH/6eLTvigMAvasjqcqVG8TEwIJJTJJsz0GgvrBU17kyHyXOAcARfJlIbEsgvRwSUEEvXZ34QSXuueOusMfS7PnmkQEsYpDfpUHSJqQtWbT/a8C8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMc1mi1o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMc1mi1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A52C4CEF8;
	Wed,  5 Nov 2025 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762360113;
	bh=Fo/hbxDXHmIlJiY8bm+AiaSnrluEKXAs2vYsCcsD3H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMc1mi1o64iUe4xnProDWT+mfFVNdB9XYeF0cVKIsF0TLt9GdNuQVNuPhDcKNvG84
	 6XgChjwdm1ZavaQeMkpWGMKJYjwzGtCJ9Rs/9Zhc48wzbmDT92mpe4nQwUNqlZgCiC
	 O1gjEPauFu46xuZdDi62V/kLakcTdKquXNoS5Nbg42TWfMGBtiXZVR3AnsG3i6Yt74
	 LboEQerxDEI4tiRqyvJz2gAqG4HErc32uI5rlJPMZINA25ROiLsqXCt+sdrCvzlb6H
	 qDD6pRRe9JZimLek+Hg6GoNe2+/zHeCPbDoYtMD2tBr4OI0SRCeUy4bDmcPq/J6x8N
	 KtMzHjCv0SeCw==
Date: Wed, 5 Nov 2025 09:28:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, axboe@kernel.dk
Subject: Re: [RFC PATCH] blk-integrity: support arbitrary buffer alignment
Message-ID: <aQt7L4rWnaFT9bsP@kbusch-mbp>
References: <20251104224045.3396384-1-kbusch@meta.com>
 <20251105141504.GC22325@lst.de>
 <aQtiYd69E-3G_PC4@kbusch-mbp>
 <20251105145309.GA26042@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105145309.GA26042@lst.de>

On Wed, Nov 05, 2025 at 03:53:09PM +0100, Christoph Hellwig wrote:
> On Wed, Nov 05, 2025 at 07:42:41AM -0700, Keith Busch wrote:
> > This generally does pass 'void *' to contiguous protection data. If the
> > actual protection payload is spread across multiple segments, though, we
> > don't have contiguous data, so we have to bounce it through something.
> > Declaring the union on the stack provides this memory for that unusual
> > case. If the bip segment is big enough, we point the 'void *' directly
> > at it; if not, we point it to the temporary onstack allocation. Using
> > a union ensures that it's definitely big enough for any checksum type.
> 
> The union contains pointers, which are always 8 bytes.  But I guess
> I can see now how this didn't blow up, assuming this was only tested
> on classic PI, as the tuples are just 8 bytes and you just used the
> pointer as storage?  I.e. these aren't supposed to be pointers, but
> values?

Yeah, should have been values, not pointers. My mistake.

We don't hit the condition that needs the copy buffer with the kernel's
auto-pi, so the bug would never get hit in that path.

I have an io_uring test program that sends pi with offsets such that the
field straddles pages. It does not look like it's hitting any of the ref
tag remapping code though, so still looking into that.
