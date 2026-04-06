Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046C8281369;
	Mon,  6 Apr 2026 05:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775453950; cv=none; b=jYugkgY2rgW/qLY+pCUQHn1ATRTGjWgrUpjH0zbvvo3HW/ql9q/ckzm64oZcir3a7y9QM3NhGIHUBIe5BDhSGCZsB1TiNKU6BFvbXO8lsgHtFN+KPDoOzzPY+MEon47G+7NMqoI8bm9U7wmyFH3Wdz1WHg/jikIy/1GztFZSb/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775453950; c=relaxed/simple;
	bh=vQgOMnCWvS/TmXpFQzFSDCXZDKI+MgWQcj9wabYm8Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=expKN/fnEmw6pGMKRGv0hNSARoWAMpoGkR/Y+enlap9iSC++yzPMhrT6zi5PUlFeBLYy5dUmZbW81RsvCxFv6cBsNaPl/zNfjuGOn5WEyRckmDi+xun0+S8fFVCeWsxRPRT/GnNZKRIcg/1OreSlUNfB2M6URYO45Tw56hFL3XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t0MA7AUX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t0MA7AUX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vQgOMnCWvS/TmXpFQzFSDCXZDKI+MgWQcj9wabYm8Ao=; b=t0MA7AUXzXveOky7wyiBycWfNA
	v4S9cB3YrnJCTE/1Im/7Qa8emSSig5GpsYX6riRMEOGScBDAYn5oKLaKd7vW94Cu3JHEMV+O8vAgY
	/aKKR/EA4tPFMRP1nQ9lQixyIkEYa3ilnD77lGetM6ZjOIzarlD0PLUg6E9upnLgBNW55h99VJwd/
	AP8m0QmvU5N9ZnDsmddcfUQD7nFhzUBXdHHxVFV/dj/hBANQFdF7h5Ixqk03pLWKaQIgi/AE5fZbD
	eLTyBMIts997Zlq05RVcIOIZ4V1V7rxaSAT7P5ZyFvUriVjzdhEOTB/KshYX1Wh29ry5qIJG0lBQ9
	dxjqO9ZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9cfy-00000004obI-1U7Y;
	Mon, 06 Apr 2026 05:39:06 +0000
Date: Sun, 5 Apr 2026 22:39:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Chao Shi <cshi008@fiu.edu>,
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: Fix general protection fault in
 bio_integrity_map_user()
Message-ID: <adNG-o3-2lru4E1s@infradead.org>
References: <20260330230256.4160820-2-iam@sung-woo.kim>
 <act0wKGUHCcQvAN8@infradead.org>
 <CAJNyHpK6ZPeRceCg5NWvvuRa23AMQYuwqhSQJcWJbNFiC6nrtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJNyHpK6ZPeRceCg5NWvvuRa23AMQYuwqhSQJcWJbNFiC6nrtA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 03, 2026 at 03:03:00AM +0900, Sungwoo Kim wrote:
> Thank you for letting me know about blktests. I'm learning this and
> finding a way to reproduce this bug.
> If blktests is not suitable for reproducing this - it might be too
> early to think about this though - I have another idea to reproduce
> this.
> I can modify the pin_user_pages_fast() source to make it always
> partial success, so there are always some unpinned pages, which is a
> precondition of this bug.
> I'd like to ask for comments on this if it doesn't make sense.

Using the failure injection framework to reproduce this sounds like a
good idea.

