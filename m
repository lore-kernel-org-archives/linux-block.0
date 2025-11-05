Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E8311966
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353764; cv=none; b=rTljNBV5cOV3DGzaKelxEPq9drXkwjaWBgJdlWHTSNflrPjh3Dmsg1EcRmVPvLFCd7rUZJRzw1NhYZQDASiBm2rkhGIdOyCgRUVqUQPdGg8ht7BDXuczIjyUNeetpyuZdpWup4LNvCiJlcC6hWnTLR89HAH+RiJclPxtT5yOCnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353764; c=relaxed/simple;
	bh=C+cgI2xN1H/+2EiNT628AnITTXv8PPjjM4ggBeu4wxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJslAEkK2DB3ZlCy5fxrpjN5QBl5SERkcd2xTDUas2y1gFd4WGP4rzAHHq9f8a0+AIC64Ui8r7PH3XI7iivMR5W+8KLHv6v9Nts+HtwB04vcO9cFLxnSuGIr/d0EoG78j4qVvP5PuTf+g7P8EOqBu4Y/kxVjXfnXU0x2nIMntNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMHHLtru; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMHHLtru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12B1C4CEF5;
	Wed,  5 Nov 2025 14:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762353763;
	bh=C+cgI2xN1H/+2EiNT628AnITTXv8PPjjM4ggBeu4wxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMHHLtru0wBWa2naW3VNYf3k8r2iTksiTu9fKmNG3ePINEI5RNYv25V9hNK7RZtVL
	 mlamFrFPW2oOBx38I0DhuPQUa+F60B9a5yian+E0FsOw9RjoyAmbIPTcRZu8SoHQSj
	 BU/k1gM+VTlGF/YOB/r/2GOltfnoqMpYF/14WegECISpZUDn6I5QF0aRgMWzggLnYA
	 1Nj/44oj9BtLvfWETN/B/pCcqt+r+JaxUWKCoJMaRdw1zz9SMGa7IeqFUdQ7XEe8x/
	 56f4zE0tgiGc9qQLKRlcHFyI/46RpbNRHYx5rCyfO5LlaGiGTjoX0Bn2KSvooshCQ7
	 hkYjBB9fVzjfg==
Date: Wed, 5 Nov 2025 07:42:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, axboe@kernel.dk
Subject: Re: [RFC PATCH] blk-integrity: support arbitrary buffer alignment
Message-ID: <aQtiYd69E-3G_PC4@kbusch-mbp>
References: <20251104224045.3396384-1-kbusch@meta.com>
 <20251105141504.GC22325@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105141504.GC22325@lst.de>

On Wed, Nov 05, 2025 at 03:15:04PM +0100, Christoph Hellwig wrote:
> I have a hard time understanding how this actually works, mostly due to
> "union pi_tuple".  What does that union of two pointers buy us over just
> passing a void pointer and deriving the type we need deeper down?  Also
> given that taking the address and the comparing it (at thbeginning of
> blk_tuple_remap_end) how is this actually going to work?

It's a good question.

This generally does pass 'void *' to contiguous protection data. If the
actual protection payload is spread across multiple segments, though, we
don't have contiguous data, so we have to bounce it through something.
Declaring the union on the stack provides this memory for that unusual
case. If the bip segment is big enough, we point the 'void *' directly
at it; if not, we point it to the temporary onstack allocation. Using
a union ensures that it's definitely big enough for any checksum type.

Again, it's a weird corner case. The kernel auto-pi wouldn't allocate
that way unless you have very weird metadata format, like with an odd
number of bytes preceding or following the DIF (never encountered such a
thing, but the specs allow it). User space can send weird alignemnts
with io_uring now, too.
