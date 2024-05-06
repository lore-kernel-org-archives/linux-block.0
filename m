Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8515B100
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027770; cv=none; b=F9t/SVC4V5VI6GAk8JsCJF0Kq6OkF4XN3Jpi/6wVu1weZ40RyewJugAjI2S7u3iD14Dvo7PODlHZWm9ESRb9967MUqXfLttkv2vLpmxPEspkXjstJZDY6ODiG+mm7/Q/gcOdUfU+grlTe0dStfH8Ebzq7CmBHS9A19tGViwS37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027770; c=relaxed/simple;
	bh=cGs+5aO3ya1aiI6TjCTjV/8vTFQ7Z0RHBfhLJ34umGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCc93lLybb5OLwOGO4S5szuJxavGCNky1tug65qGRjKlgNrKDNyHbHEJU8PdM0uRJYWuSzRaU+JiipmIACXaL1y1akpfjg3uj/tWQ8SS3QCi2/Eh4EAKpt2zKvYEiHzgW2L6m/3eC4qQYu7mQ0qF4x+m9+m4zoVtV1iwV4RQx+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btOoHgqr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btOoHgqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA81C116B1;
	Mon,  6 May 2024 20:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715027769;
	bh=cGs+5aO3ya1aiI6TjCTjV/8vTFQ7Z0RHBfhLJ34umGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btOoHgqrwt6ymGzgcOfgHHN69NPNZjk1nMuEWiaSPpDwd3hCBWCbiG+Q7v2alTLOl
	 E2eP+d7UhZxre/mN0nf4DsNYgxLgRGfNXr6jATBz0br2p+qxq+ZEr2WvMoiwdelC3k
	 DnIedIptCF++LGqwS4KnW9afNMz+VSrElNjIy8Rv7iS8V7U4UQ41mCP5GngQ240MT0
	 7dX39m66p5QjLCVpBI+7NbGjgdfT2QgMc9DrpgPIO+paplecI1h+b4JRjlZtMqds+5
	 EVEdIXv5DRTgay2rPbYu528baLzCOsqrK3f7Xc+t2cwgpkbpXi71Rc0EHlBs8t5XWo
	 aMuRY2EUEV/Nw==
Date: Mon, 6 May 2024 14:36:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, martin.petersen@oracle.com,
	anuj20.g@samsung.com
Subject: Re: [PATCH] block: streamline meta bounce buffer handling
Message-ID: <Zjk_Nnn-T0SgWoNv@kbusch-mbp>
References: <CGME20240506051751epcas5p1ed84e21495e12c7bf41e94827aa85e33@epcas5p1.samsung.com>
 <20240506051047.4291-1-joshi.k@samsung.com>
 <20240506060509.GA5362@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506060509.GA5362@lst.de>

On Mon, May 06, 2024 at 08:05:09AM +0200, Christoph Hellwig wrote:
> Can we take a step back first?
> 
> Current the blk-map user buffer handling decided to either pin
> the memory and use that directly or use the normal user copy helpers
> through copy_page_to_iter/copy_page_from_iter.
> 
> Why do we even pin the memory here to then do an in-kernel copy instead
> of doing the copy_from/to_user which is going to be a lot more efficient?

Unlike blk-map, the integrity user buffer will fallback to a copy if the
ubuf has too many segments, where blk_rq_map_user() fails with EINVAL.

For user integrity, we have to pin the buffer anyway to get the true
segment count and check against the queue limits, so the copy to/from
takes advantage of that needed pin.

That EINVAL has been the source of a lot of "bugs" where we have to
explain why huge pages are necessary for largish (>512k) transfer nvme
passthrough commands. It might be a nice feature if blk_rq_map_user()
behaved like blk_integrity_map_user() for that condition.
 
> Sort of related to that is that this does driver the copy to user and
> unpin from bio_integrity_free, which is a low-level routine.  It really
> should be driven from the highlevel blk-map code that is the I/O
> submitter, just like the data side.  Shoe-horning uaccess into the
> low-level block layer plumbing is just going to get us into trouble.

Okay, I think I see what you're saying. We can make the existing use
more like the blk-map code for callers using struct request. The
proposed iouring generic read/write user metadata would need something
different, but looks reasonable.
