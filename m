Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13136CE01
	for <linux-block@vger.kernel.org>; Wed, 20 Aug 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755717740; cv=none; b=cbVbyY/tSTlzUjS3g640KcC6+aLD61VGsus3o7JxzlEXwfLJBqTHlqq6CXeVLcgz+vYmpQylFehl7SwFKX09SXvKx62ToROi8cUwM4p5bOEiUM6xE49g8zHay46FlUAGjTu+JrZed09jHkCWoQEw/H+pzJQLTAGxK3YoDQBTgMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755717740; c=relaxed/simple;
	bh=nawA7cYxMgTGk3717d4LDLFaPbkaJzVudqPw3UlMoFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVyNrKcvZm76p637OZX6zZmpnTrplZ/S7y1pcvypmAnDZ1k74veqG/DjQ1YcxAcbM4ml01+t9x1P8pqEbXNJAHUjSAqOqy6/3SY0aHzQtdwMzgBMD346pXIrwDKb4+bYH4BjkeOV7GhyyYDJNoByjdh9nLWv1LCGomUOrqdUyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ/d+A7o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ/d+A7o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5C9C4CEE7;
	Wed, 20 Aug 2025 19:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755717740;
	bh=nawA7cYxMgTGk3717d4LDLFaPbkaJzVudqPw3UlMoFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJ/d+A7oXtpLOuON7gDLjFxOkgPHYYnE8z2tiFAV5urzXSGkyCyG0AkC7Z+Z2Tyy9
	 dKRsO2Np0klI+38IrfJoJdiYr5KgoyKFGkcpdN8kSdlIXdw9pBOOH+fTnYrGy4hyeG
	 lKDrp+xDqhuvlanuCK39i2UndokQ8mx4/5TBIF4t9MMK1ghlJe0rV+uNgZIV48oYPb
	 ULMqzPslbR3H/eL1ng+hExUawKFajvVfxOnXgSSiFUjMN0tLQPZc30KdFplk1W8cUE
	 RGBVyXoUb+grq7ytHEv67FYQ1QLLKosmEWSbo8a4D1DtQ1oQlkXpmsTD7kAIJ5X06y
	 Ww3Q9ALJg1c5A==
Date: Wed, 20 Aug 2025 13:22:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <aKYgacJZCQEx1kf1@kbusch-mbp>
References: <20250805195608.2379107-1-kbusch@meta.com>
 <20250806145621.GC20102@lst.de>
 <aJN4b6GS30eJdQLd@kbusch-mbp>
 <20250810143112.GA4860@lst.de>
 <aJoL1rsvI5bXkod_@kbusch-mbp>
 <20250811161756.GA25496@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811161756.GA25496@lst.de>

On Mon, Aug 11, 2025 at 06:17:56PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 11, 2025 at 09:27:18AM -0600, Keith Busch wrote:
> > I initially tried to copy the nsegs usage in the request, but there are
> > multiple places (iomap, xfs, and btrfs) that split to hardware limits
> > without a request, so I'm not sure where the result is supposed to go to
> > be referenced later. Or do those all call the same split function later
> > in the generic block layer, in which case it shouldn't matter if the
> > upper layers already called it?
> 
> Yes, we'll always end up calling into __bio_split_to_limits in blk-mq,
> no matter if someone split before.  The upper layer splits are only
> for zone append users that can't later be split, but
> __bio_split_to_limits is stilled called on them to count the segments
> and to assert that they don't need splitting.

Zone write plugging presents a problem. For the same reason that
"__bi_nr_segments" exists, I have to stash this result somewhere in the
bio struct. I mentioned earlier I just need one byte, and there's a byte
hole in the bio already, so won't need to increase the size.
