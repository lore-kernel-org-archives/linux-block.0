Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841A1E5B82
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841214; cv=none; b=mrg01sdF1HPwYBoLnMRF04S+rGV0Gse2FVeOd/JjJpohku6eBgxwyNNXLPCMi1LjgRrfYIO1aylYOHGXcLO1j1fiR9dTOOxRjg7gd8+DWG40OgN4qbFtID99cbf5Uv/yppwke0MCzOCtnZgQZoStk9wfLU7CzMOay6uPqInvsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841214; c=relaxed/simple;
	bh=PC90K3B7UeB7ISIGkmfceYnCTwrfpm1V5tbBIPFvZp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoE53hEYRcNj3RdHX5227XFxE1Ow6G/H+cnK//20VkRl66WWl65hNwAx0x7K0E2m8b0Q7yOs8zF+Eh1RcHbNN7tCs4FseFhRwV8PaHZWn1fPQ/KSSRR2wRcVIvSkIk8GiaffUJ7WnDEr4VzerPprntop5TuDj8cZDUsDLro3SzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQMXvG6E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQMXvG6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E015AC4CEF1;
	Tue,  7 Oct 2025 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759841214;
	bh=PC90K3B7UeB7ISIGkmfceYnCTwrfpm1V5tbBIPFvZp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQMXvG6EcTxgzfTsE/7Z5fe/qPbCIRixXr/FjKxWpEOm927w80axOH3wZuhvz9OWJ
	 UApj8v0O2jx6nQdt4XC/0tgLG/f+BStQ9xt8Kr1KgnOJb/QJtQasrwQPtvIA6O6X9h
	 QG4Xver/c5dfGJDzhn9AnyPiM0sMb0tBjjUrr4ISr0d/s2amQxz5dq/zr0lJdgOF/T
	 FVWaJ9t3TVXNgZAAvtsqoqd7C4ADGoAyoXaPt1q/0ODVCXdAxKXw/4gifWfr4fsYO5
	 9fXLr29V3DHzZzGMXOAREgXabF9ZaORK15TQ8idYFOeAx+WIYkjwUwxpEG6IEgw7ZQ
	 nflqaGb3I52nA==
Date: Tue, 7 Oct 2025 06:46:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	linux-block@vger.kernel.org
Subject: Re: cleanup for the recent bio_iov_iter_get_pages changes
Message-ID: <aOULvGcmmSB0Ys7n@kbusch-mbp>
References: <20251007090642.3251548-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007090642.3251548-1-hch@lst.de>

On Tue, Oct 07, 2025 at 11:06:24AM +0200, Christoph Hellwig wrote:
> while looking over the bio splitting issue reported by Qu, I noticed
> that some of the recent changes to bio_iov_iter_get_pages lead to
> more indirections than really needed, especially with the bcachefs
> abuse now removed in 6.18-rc.  This small series cleans this up
> an prepares for the file system block size splitting needed by
> btrfs bs > PAGE_SIZE support.

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
