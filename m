Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AFB20299B
	for <linux-block@vger.kernel.org>; Wed, 28 May 2025 22:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748472122; cv=none; b=Ta1xezimY4hXa60j0+Y/8eV3J3jAA/Vf7bD41oBD7PHN0Mx7LnA0aVWGTPGFm6utw0ZAhhrrMhAqAmkYDrJx8klOZarxsFGgH3J9Eb2K8NuJWFqqlU7AOw3R74Pgo10JuEmb9I0/GvdC7DpEhuyXtfRn0MnE8mDptIXj4UVKsuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748472122; c=relaxed/simple;
	bh=ODdciq5CPilvv2sX+jC3jzyer7v1cNd7rtqpkTLUeeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIEk8HAg6nmOgLChqEiWVVc8/yYRauGrMCmcpp8XkxLlou29JuYWEyO3dSmWv6lOQoCS6XQVTYF1zFKWIMHcWocLe/BwNY4Yrxsl8d/3O3tWHcRkGkd1tyWPshJjSwGysVZJY0+oal9xLWwVeCIhhNonWXlLRgz4auRFxJmZXao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBUnQcdi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBUnQcdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5349CC4CEE3;
	Wed, 28 May 2025 22:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748472121;
	bh=ODdciq5CPilvv2sX+jC3jzyer7v1cNd7rtqpkTLUeeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uBUnQcdiV6rTXTtXWA68kYP7PQFcmiykecdmy8GayayaBsdmstzouiE1O+OhYtthq
	 VqTsWOzUyj3/b4QwmMGkj+ipdgXVBwOkQ15kisgZdyUOBRFjjYnU+5KKxiUI0im0SF
	 mZMeVEgVa797NMSc4gbUjoosHXmV9hWMCatpHKiinefU2XfsN1RYeJ6ijfqLtt6tTe
	 5aZ7knEl62wwJFkGBKR9grmenMXdjf3QlVx6RelgNIb56SmHjC1wXozuPa5wmlwO2B
	 DTDfEZd2s1JzH9shqKQYfgMjAo4xymv3jOe796ltcglhQVq76I9Q56HcDJAWTLB2DL
	 ufErIPmsk9OHw==
Date: Wed, 28 May 2025 16:41:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Mark Harmstone <maharmstone@fb.com>
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aDeRNvT5x_qRj3kX@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <aDBt1qXj90JO1y2v@infradead.org>
 <aDCqGLY4irp-6N5M@kbusch-mbp>
 <aDP5o1qb02iwgw-V@infradead.org>
 <aDX6NjOuGvxhbw7C@kbusch-mbp>
 <aDa_O4HGWjy_35I7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDa_O4HGWjy_35I7@infradead.org>

On Wed, May 28, 2025 at 12:46:03AM -0700, Christoph Hellwig wrote:
> On Tue, May 27, 2025 at 11:45:26AM -0600, Keith Busch wrote:
> > Just fyi, the initial user I was planning to target with the block
> > layer's copy fallback isn't in kernel yet. Just an RFC at this moment on
> > btrfs:
> > 
> >   https://lore.kernel.org/linux-btrfs/20250515163641.3449017-10-maharmstone@fb.com/
> > 
> > The blk-lib function could easily replace that patch's "do_copy()"
> > without to much refactoring on the btrfs side.
> 
> Well, that code would be much better off using a long living buffer,
> because the frequent allocations are worse.  

No argument against that. I'm just adding context for where this blk lib
patch was targeted. I'm happy to help on both sides to make it more
usable, though refactoring other block copy implementations (splice,
kcopyd, xfs gc) to a common api looks like a much longer term project.
