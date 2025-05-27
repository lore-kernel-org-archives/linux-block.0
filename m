Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C12520E00C
	for <linux-block@vger.kernel.org>; Tue, 27 May 2025 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748381583; cv=none; b=ReyKl4lsPLcm1UXGTkzizB683y6KwKILCidXg09aEVZzjVEjnJ6n/2dnS6AFOzRf7e4pqu/g1l+Mc0I7QmDk4jAFfc0LLfOHwEQO4ICYimO7WtuB4PDyiiYbr5i+//pmIYF/gPbjT8qXnwo8D5DYB+tht+wwCN7nB/saEHa2u/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748381583; c=relaxed/simple;
	bh=AGs9X2CYdiqd1UEmpwxAc4YS4cDP1HJekBBrTkn1KQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2huvaue4Lf5qSx5rs93nnLpCIn8Gywhs/iwa4i+1Cj1+LMeoCeY4mDgLpQZ/MXEu8Y469/73NLBpJkWvwcHjHtWW054FrJmB6U/+WQQHut2Tn43W+nKwvEyWUMobwb8gTBuHdbUHsID9Q9BDFfdwI+ze7EEs3YwJZ5L/xEvFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhhEmXaZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhhEmXaZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF777C4CEE9;
	Tue, 27 May 2025 21:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748381583;
	bh=AGs9X2CYdiqd1UEmpwxAc4YS4cDP1HJekBBrTkn1KQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhhEmXaZa8iQ3lubsGKhgoEZD1rtwjFAh88h+0E4nTUR52mnm8yJppTY2ZpvqJ0ub
	 y2TYZ92UWeVdyKzSqmypAhdJR8N5JFvSJqoAE0nzw39q+wk/+zKn9SI3v6TXWgbIg3
	 NhwdYOnhEZdjOLfLnk41FJv7vhTdYZzoGtssMpZ6w2RtvXgXqJUDxN0kE2t+4PVPO5
	 OhtyVVHoNJxGxkEG1sSmKbpR/9jQIUn5r9I33fXHroAPcB7aU3rvSvlEJyghcVhR2P
	 oG4CRiHJejiKhsrO/a7ORhRUWK4zrRu3xSseG/zH57O9MAS1QOeB7pJ/txbwMf7mGf
	 2ADYEKnQbr3xg==
Date: Tue, 27 May 2025 15:33:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] block: add support for copy offload
Message-ID: <aDYvjGcswPkbHlR7@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-3-kbusch@meta.com>
 <aDBuQbsBRVjOc5wU@infradead.org>
 <aDB3lSQRLxjDHTSE@kbusch-mbp>
 <aDB6Hdp9ZQ1gX5gr@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDB6Hdp9ZQ1gX5gr@infradead.org>

On Fri, May 23, 2025 at 06:37:33AM -0700, Christoph Hellwig wrote:
> Anyway, below is a patch to wire it up to the XFS garbage collection
> daemin.  It survices the xfstests test cases for GC when run on a
> conventional device, but otherwise I've not done much testing with it.
> 
> It shows two things, though:
> 
>  - right now there is block layer merging, and we always see single
>    range bios.  That is really annoying, and fixing the fs code to
>    submit multiple ranges in one go would be really annoying, as
>    extent-based completions hang off the bio completions.  So I'd
>    really like to block layer merges similar to what the old
>    multi-bio code or the discard code do.

This series should handle bio merging REQ_OP_COPY. If it's inconvenient
to get multiple source sectors, bios that fit in the queue limits will
merge to one request when the using the blk_plug like you're doing.

>  - copy also needs to be handled by the zoned write plugs

This is about emulating "copy append" behavior for sequential zones? In
case it gets split, we can't safely dispatch multiple copy operations
targeting the same destination zone, right?
