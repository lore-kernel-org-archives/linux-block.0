Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD1532860F
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527629; cv=none; b=LMicOfWqdcdLfZ9EmbDbLZNkwXHBcxNGfWYtB4C0WEk+yp5/5teIzLrP5Gqo+sabP76yjstQVXniHk8kQtzP447pnmGkYv859G4M/dFIb/LsKUzCae8fvrXTqwJyCDC29L4x12csCMpJh8z0EPcrYMeK2Z2lpY3hG/BhbS7yj8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527629; c=relaxed/simple;
	bh=lKqfQR7LL2lamsn1cGjw+FBM6W0BRPmT2dEDvvuT3xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqpVKCu24GTCltIlqHx5HgcPr2VkgHZRI0Xw+luMFOkEF5dTqjlSiM8wPM5yz7gAVLVIydk4RTipbL7x2E+j5yatWgp2Aqt77z5s3KXrtefl52/ANvBJi8U22YnQkbMUBXxUElJC0X8ZAf1X/XkmApNaDk26a5t2mBPPt3Wac1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC4yrB3w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC4yrB3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35353C19421;
	Fri,  7 Nov 2025 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762527628;
	bh=lKqfQR7LL2lamsn1cGjw+FBM6W0BRPmT2dEDvvuT3xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nC4yrB3wVvdLRHY8ZpaiHJHakHVgV88hFkXc3FA2ZJep/V7AFq0qMbhxDh0S14hrm
	 fwJ7g4Dvvgf6sIy3OSqXSwNjlYvseu4BOHcRlZ30nQ9RGInOgKZeLHfs4KavksW5pV
	 xtgixH0R5eOflMx1EzodYy6mjy8CJy1YFRzopmObvhcAXq0lbpR7YNled73zmvukPQ
	 7DQ8llTYIY5aLHXwEcIOi7Pc2HbS4fuOtODvnS1jmP0SAqKt8tvUbgMhR6G8ddLJDH
	 D5kESiIAMe//N1lBLvCOiCKWBpvH+hlZOci8xkAi0vykPnZoqIeofaeHPa0c7pUHfq
	 GzHbuyT7Fg5qA==
Date: Fri, 7 Nov 2025 08:00:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, martin.petersen@oracle.com
Subject: Re: [PATCHv2] blk-integrity: support arbitrary buffer alignment
Message-ID: <aQ4JihZLWPrrgdCK@kbusch-mbp>
References: <20251107043447.3437347-1-kbusch@meta.com>
 <20251107131519.GA3975@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107131519.GA3975@lst.de>

On Fri, Nov 07, 2025 at 02:15:19PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 06, 2025 at 08:34:47PM -0800, Keith Busch wrote:
> > This was tested using recently proposed io_uring metadata test case
> > here:
> > 
> >   https://lore.kernel.org/io-uring/20251107042953.3393507-1-kbusch@meta.com/
> 
> Any chance we could get this test or something like it into blktests?
> 
> That way it would get regularly run as part of block layer validation.

I'll give it a shot. The only problem is that liburing currently doesn't
define the SQE fields or pi attributes for this feature, so we'd need to
have blktests conditionally redefine things depending on which liburing
version the system is using.
 
> The changes looks sensible to be, and pass very basic sanity testing
> using my PI setup.  I have few cleanups we should get into (attached).

Thanks! These all look good to me. If it's okay with you, I'll fold
these in and tag you for Co-developed-by.
