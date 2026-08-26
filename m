Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0678E480950;
	Wed, 26 Aug 2026 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787774573; cv=none; b=Yi04NH1vMmJ9AhxSXMLZ6bNxN4Z9otxIxaU4h+oEZAvmMQY0h2gqtXLAvvhjxQ8fmoTeOVIPdjuP78UpcD03+sXV042mzApUgMSJppa0NxC/k2TOb0intr171VkDW1zP6XdiMet5c+jhggDDEAF3+/Fs462us6XNKbX1BLP/Vp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787774573; c=relaxed/simple;
	bh=7DYlKtCD8vGSbGoBLfwStmj2pFQc3BlcdnwLWMlbX1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eacpqkWb5h+lSxHyZqHn4sWssE2/Qx+GrrQhRIGylm5tZpy5wE8UQdfEKkMFV6dPHo+yOh02kCumHh4D46Jydkdt0tR9WJKh2YvqaAo+1NeQ4mhSOBV0fMWKS4ojA1dz7q4SG0srHFjKk2RZlV+nv4CJJOgm4gykEpQSg9DAACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYKaLvQ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYKaLvQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E324A1F000E9;
	Wed, 26 Aug 2026 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787774565;
	bh=ii/lDoqvcVrQ7r/ckxGnKPc0p3SVjaGNYR7FGCq0zcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mYKaLvQ/t1Y4FpepXxr/TCf7r3jHBDkjxCwh9/e5KZIO2b3siMiruOsswaluUG23r
	 WMcRo0kp/bAaZ5FsTtQjJSwHv06AXx/5Xpd4koG2/lkYc0O38048wzcRdbNbHt5gkM
	 c/kUn66rNwFibyUEZlBXLkmhg4oZgiK74bpQnb+yFGXboIk09DZnzeEqAI7R1weXeq
	 1dVXLAd6AL6SLAtKbY+WjxrWbAkpMrr75XnZZfwTfczBEFFHko3LGaZJdYAnHuMC/k
	 iioWe2T5zmpbSvGkv8JqoiZ9Mqn/z/Ae/mfvylyo7ax+LCg5O9XkE4eLsYQ2xQHH03
	 G01g2Fx0gOZDw==
Date: Wed, 26 Aug 2026 14:02:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix start and length check added to
 iov_iter_extract_bvecs()
Message-ID: <ao9GY22aAvnZUye0@kbusch-mbp>
References: <ao8xqMXoCfj4AWUw@kbusch-mbp>
 <1819786.1787768317@warthog.procyon.org.uk>
 <1864928.1787773740@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1864928.1787773740@warthog.procyon.org.uk>

On Wed, Aug 26, 2026 at 08:49:00PM +0100, David Howells wrote:
> Keith Busch <kbusch@kernel.org> wrote:
> 
> > iov_iter_alignment loops over all the vectors when we only need to
> > examine the current one here.
> 
> Actually, I don't think that's true.  iov_iter_extract_pages() is allowed to
> pull from multiple bio_vecs in an ITER_BVEC, for example - and if, say, the
> page in the second bio_vec is contiguous with the first, then
> iov_iter_extract_bvecs() will use it - so you still need to check bv_len on
> it.

I don't think we should be extracting bvecs for the ITER_BVEC type.
bio_iov_iter_get_pages() already doesn't. I'll look more into the
recently introduced bio_iov_iter_bounce_read() usage, as there may be an
optimization there.

But in general, yeah, it should be safe for any type. The proposal I
sent a bit ago will handle the ITER_BVEC as you've desribed.
