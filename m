Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086FF9DA
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931800; cv=none; b=YENJMwUHnSc4MUtWFQz4qMi4rwcDMIR49m7YYY9nnA1RyHrO/WekI++j3NA4Fsrsz1cfuGNSqmcsT/vbaBzR5QlsMzMmXUt/BKgJkqUZM751+TepBkvAdT6LdnGeFtp3W7ju77/y9WFKCglzOlNS1Kg+QtBIs2D5tlZ370SfWv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931800; c=relaxed/simple;
	bh=japlrBVs3GNvjaE3jTX3f3XSzvTYr+WtDLNY0X32b8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6XTvbIG4y/zo2oniwxtysFjt0cQDOlPv8ZESXCXbBWhB5mvmJyF378Xw0FEA/fU7+Wg0AdplN9ZoAr2f+pxujPiweq1lfG6bVklaMNWAz821ylDdP5BW1hGs2Y9CGuNAyn7CyTRw8+HA3sRBkcjmvIdSp5AvshbztdX6c+nOpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMrqPPOl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMrqPPOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B34C4CEE4;
	Thu, 22 May 2025 16:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747931800;
	bh=japlrBVs3GNvjaE3jTX3f3XSzvTYr+WtDLNY0X32b8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMrqPPOlY7AujTvkCW9xVssk05jAKPryx//59+xbISnZtc+Td46xC8emJy3oCRkqj
	 iMZCeHuE8/vjo2aBGo0eSfE5QUtpKQHNKlT282kjEhbUvUQAKNysE2df/8k1yNu3cm
	 QC7eBPloWAZDjLJAwEshSuAWhFjwb3NtWwO6L5a/Fa0InqHM7gjLnMKO6m0T0tM8X7
	 xsfEMTBj/Uu1MNXLmJd9pAy1ttmGDwUWl+Hs1Bav8dnctrS6qwMxZSIrLljnYjLTv5
	 +rjz6hq3VtoJG7DnTaKzJ4w6olp6yL5ZSlKlH3/P50LOulsTz4hB/MJFe09Vmlj+Sq
	 gcM4BHJlL7nhA==
Date: Thu, 22 May 2025 10:36:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/5] block: add support for vectored copies
Message-ID: <aC9SlcN6gTIz0F2E@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-5-kbusch@meta.com>
 <4fdbe560-d646-496c-be51-49ea49d47449@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fdbe560-d646-496c-be51-49ea49d47449@suse.de>

On Thu, May 22, 2025 at 03:58:18PM +0200, Hannes Reinecke wrote:
> On 5/22/25 00:31, Keith Busch wrote:
> > ---
> >   block/blk-lib.c         | 50 ++++++++++++++++++++++++----------
> >   block/ioctl.c           | 59 +++++++++++++++++++++++++++++++++++++++++
> >   include/linux/blkdev.h  |  2 ++
> >   include/uapi/linux/fs.h | 14 ++++++++++
> >   4 files changed, 111 insertions(+), 14 deletions(-)
> > 
> Any specific reason why this is a different patch, and not folded into
> patch 2? It really feels odd to continuously updating interfaces which
> have been added with the same patchset...

Sure, I can do that if that's preferred. I just started this as simple
as possible, and added new capabilities from there. I thought having the
patch set show the journey might make it easier to review. If the
evolving interfaces are not helping, though, I don't mind squashing them.
 
> >   	case BLKCPY:
> >   		return blk_ioctl_copy(bdev, mode, argp);
> > +	case BLKCPY_VEC:
> > +		return blk_ioctl_copy_vec(bdev, mode, argp);
> >   	case BLKZEROOUT:
> >   		return blk_ioctl_zeroout(bdev, mode, arg);
> >   	case BLKGETDISKSEQ:
> 
> And that makes it even worse; introducing two ioctls which basically do
> the same thing (or where one is actually a special case of the other)
> is probably not what we should be doing.

There are many interfaces that have a single vs vectored user input.
It's like read vs readv. The use cases I'm working with are in-kernel
though so I don't strongly need these user interfaces here, but it's
been great for testing. I developed some that would work well in
blktests, for example.
