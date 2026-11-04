Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807041;
	b=e+N2daYTuGSD3KpyVrjZ2GUNj+KcoatzOs1C6KbsfjQb7foHPGru6WEpk5kNveX5pciG
	 roTm825ZwSG2Cyap2mc1dOhFlNNjgsb3i7CtFLgzT6rel4eqiHqYP2Fon+PnkEtil3anK
	 rJLBErNgF6r2pS5xVuYkDgVoER31EN2EltFeS8kj0GRlO/XzqqR0EFjS+vfGfRkJqltnZ
	 8veIzi/oIAS7IXmFfUZ7wn1Y2cbc7MUJGUAjANqHLlVxKEpg4HgzSX9HDeiYAG0kGa/b0
	 dN3amD2cl1JBpzMHEKvQ75TXmgeue+smzFuu6VJ6ewYhxH/FxioV7s+DzPmvbEq+ZAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807041;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lF9NRImeF95GP52QTNNPSmfWkww7eRLYyRehOXnMcnw=;
	b=h76j+yghW2kRkZJbQeDyphwzegksxMYcqffLdASS2kptpwC6gooe5bvtu8fv91OxWkMQ
	 ryeJyfmI9TJ9+nAARUTYiJK4dtLKM2le0+dxTqCnmafBPrDdQew8KV848YESnYsZVTZy+
	 1P3C9ssO3KmlEsuvkehEnYOpqMXwtcpVPuQLo/jDhHurCxcMxg0LcUdxmzukiOgSae/RS
	 OpwqBfl3n9eSDU+trVOr09j+z72mYOqQqvRtDdv6i61DXMBt4QGnfll1M5iDkV3QzMxL+
	 ttFQBju/sSUgCkmvV9/yklpTvFBx2T7sUsovkh1pm21YIw+mBJeyY8RGIEZsoEsCVjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWQ1J2TM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB31606A326
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWQ1J2TM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C151F000C1;
	Wed,  4 Nov 2026 15:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807041;
	bh=lF9NRImeF95GP52QTNNPSmfWkww7eRLYyRehOXnMcnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZWQ1J2TMKRRRZugh5FcjOgZeUYiMhBkkJEaV5H7TQ3GI7+dnUKGdBJincv1oLCkwp
	 MEltsp9IRTOQzd67lslFXQ289uKJMRu1p9peFoIIS25aNUUx5wmvRVLztVGv7tyb5j
	 jRKKWrboh6TnJgnzQ/CDBgdNwoefiNrn0zqSoT74jZ7X6IwRcpltoQrrjr/7eU3I9H
	 XwMpfcVctkPh34TETvopNmK7DF5fBRslek7g8r72UHvtEKRO8Jb52YeK3F/ZOu3GSe
	 jXWO4iQfzTtlSBBMiPpQDEuy0alz95SxpIOajgUBAnUHCIBA8U3kG1jMR4b6ff7Ber
	 xrO6nyM3vrasw==
Date: Wed, 4 Nov 2026 08:43:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 11/98] block: check dma alignment of bvec iters in async
 dio
Message-ID: <autSvxtcYwLAsZGj@kbusch-mbp>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-12-axboe@kernel.dk>
 <auNBy_Kx80VAZFnr@infradead.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auNBy_Kx80VAZFnr@infradead.org>

On Thu, Oct 29, 2026 at 05:53:31AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 28, 2026 at 10:41:14AM -0600, Jens Axboe wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> > 
> > __blkdev_direct_IO_async() uses bio_iov_iter_set() for an ITER_BVEC
> > iterator and never gets to the alignment check in
> > bio_iov_iter_get_pages(), which is the one that exists for io_uring
> > registered buffers in the first place. A bio based driver has nobody
> > else to enforce its DMA alignment: a misaligned READ_FIXED from brd
> > returns the wrong data, and dm-verity with panic_on_error panics.
> > 
> > Move bio_iov_bvec_aligned() to blk.h and check in the async path too,
> > failing with -EINVAL like the other direct IO paths.
> 
> I think the theory was that bvec callers have to validate the offsets
> themselves.  It looks like that doesn't always work?  Should we fix
> that in the callers or do we decide we're unlikely to get all of them
> right and do the checks unconditionally?

Yes that was the idea. Not that that's happening here with vectored
registered buffer usage, so the patch is correct as far as that goes.
It's a bit of a bummer as the point was to avoid repeated vector walks,
and I don't think we can efficiently validate while importing the
vector.

The block layer will still catch the invalid alignment, but further down
the stack, and I've learned the hard way that some mappers just are not
handling these kinds of errors that late in the submission path.
