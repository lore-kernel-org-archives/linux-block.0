Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D21AC88B
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033598; cv=none; b=EY32WKOjVM23TngIRVqUR3x+o13eFQJlJ2mvAQInOwQR7tqzOexCU0Mra9jq5PG/Zb3dlEWlKBKhSUFQj7l7ckTzuZsv/3+t5UUGuHJ3TrtAtDgWZYeRJlMrGzfiM1MN0aKg7Q8moEHA1oqsRr+FPe0jV2cu9g9hc20gmtxvUCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033598; c=relaxed/simple;
	bh=D9qHWp37Sg6PMvv0RCGQLV5SowNt30Q3SVhrunA7nT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gR5rkLmYUAZ58Ve4JYrfNRkdLQ1fXb6HYzxGMHKOofw3DQX9fhEzp0EvyMo3MuDsPXYiDewqfkPrdzEe02utNql8+oCTZPPpXfyuAHNdsfXoXavBJy+esEkP6nu706zTQtwTq59wvHehQ5PaoUdiaFuwGDdD7GPV7rQE38L3Pss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6vhLHq/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6vhLHq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE201C4CEDD;
	Mon,  7 Apr 2025 13:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744033597;
	bh=D9qHWp37Sg6PMvv0RCGQLV5SowNt30Q3SVhrunA7nT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6vhLHq/4zoC8CxaNrO9qGr+CHVsf5UuWI5L4puQJULgYwy/aryQMM/qz/gtvEa+l
	 7KlnXdPkWInPwk2YM69/AY6CBTHXFNQYfOiHVB0s32hjSOGXgSwFRkAJ8vt2QkOWr4
	 r5kN72EWyITLwTkLG4UBmUijHpBN+aGp1oY8WvH7OUTLpMoUF9ChEC6/xn74PEjRjY
	 WZxQYM+2nA9OSmn/AlxHdILiaQNDV88zy7fM30K1b03B1olyOFRmmDjxFJjhGe8L4q
	 LDnM6mG1u+SRh5hVLTgcvoJCukd1S3UI6fZ0swkzASc+tHxjKrFjd0iltzwQ0DPptL
	 khZyk80wVEkgQ==
Date: Mon, 7 Apr 2025 14:46:32 +0100
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sean Anderson <seanga2@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	Zhihao Cheng <chengzhihao1@huawei.com>
Subject: Re: bio segment constraints
Message-ID: <Z_PXONJyuv4Z8ATr@kbusch-mbp>
References: <8dfd97ac-59e7-ae69-238a-85b7a2dae4f1@gmail.com>
 <Z_N5nxLDOBb5NDAM@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_N5nxLDOBb5NDAM@infradead.org>

On Mon, Apr 07, 2025 at 12:07:11AM -0700, Christoph Hellwig wrote:
> On Sun, Apr 06, 2025 at 03:40:04PM -0400, Sean Anderson wrote:
> > - What about bv_offset?
> 
> bv_offset is a memory offset and must only be aligned to the
> dma_alignment limit.
> 
> > - Is it possible to have a bio where the total length is a multiple of
> >   logical_sector_size, but the data is split across several segments
> >   where each segment is a multiple of SECTOR_SIZE?
> 
> Yes.
> 
> > - Is is possible to have segments not even aligned to SECTOR_SIZE?
> 
> No.

O_DIRECT only requires each user iovec be a multiple of the logical
block size with the address aligned to the dma_alignment. If the
dma_alignment is smaller than the logical block size, then this could
create bvec segments that are smaller. For nvme where we have 4-byte
dma alignment, you could have the first segment be the last 4 bytes of a
page, then the remaing 508 bytes from a different page in the next
segment.
