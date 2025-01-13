Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CA014B07A
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 05:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736747382; cv=none; b=i8eGkeQ7Tl2FaJ+TturDj0viAQR5ce7FsDZ9qcmnzMaxQB6q2/FPmuVWJbQpJCzqnqDIEHS//nLjIm31zEtS8Myd5Z1yep141PdPqOjIHqMiKqphcH5izh3DzyF2XFuylLZlokMGzkYIGtrpouxx5B6vCs5tLpBXVJrRb0s86yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736747382; c=relaxed/simple;
	bh=NCHlbwPWOm0kcULr8SRHWbwOQKkJ5cbfAcBVf8PAio8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxco/wsidnyNzG7bIbX6sfJtIH7IcB83iqP9q8e31LHFLmLCDf5+Av7Px3yG5jo4udlHNmpty8taVXhKdOu7GypAOjfLzsy7TabnBnUJpesNvGnznl/FohuAZxl2oPG5zKZa9k7062wTRjXiYBprf9VBoGKoX1vGvl3sBoeRUZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DrvmsZT1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DrvmsZT1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZQic7tBkFpwD+N5Jf9azbZzpijmjF93WS7/9bp6Ns84=; b=DrvmsZT1k0WVY5aQoPvf2N+CvY
	UeIh+2CV4oEZzqd3qk4rgnRsan8vQxH6X+dUdF5eJuOYW9Raw33I9Wmse8nkYyU7S7O494ItzjEQN
	v6XqbScpNmToyXh/UTWlBrGP46Yzxe4i5EU39S/+GgTbURNZT+Xs/o9MtnfLwj1vQ+3ycT8zqOpMp
	A1YKn6OfgwNODOWiycwmXgUQOO8rAuFbpBA8wVD7uBv2RwUn9YUXLH10xxwDuv4P+h6YbyHmuIFRJ
	cqFCoOd6wsMLo15Aqkfdu0ng+A65dpCNUGxD7MVTnL4G1p3jscvtYPd9zaO9nAzmQe9TzPrcq7N48
	KSQQ83/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXDKV-0000000456q-3xyy;
	Mon, 13 Jan 2025 05:49:39 +0000
Date: Sun, 12 Jan 2025 21:49:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH] loop: don't call vfs_flush() with queue frozen
Message-ID: <Z4Spc75EiBXowzMu@infradead.org>
References: <20250113022426.703537-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113022426.703537-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 13, 2025 at 10:24:26AM +0800, Ming Lei wrote:
> If vfs_flush() is called with queue frozen, the queue freeze lock may be
> connected with FS internal lock

What "FS internal lock" ?

> , and potential deadlock could be
> triggered.
> 
> Fix it by moving vfs_flush() out of queue freezing.

That doesn't work.  The pagecache will be dirties by any command
processed using buffered I/O, so we need to freeze first to ensure
that there are no outstanding commands.

