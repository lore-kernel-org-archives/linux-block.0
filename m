Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4402013FEE
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296029; cv=none; b=uN8OZ9UGRXadDYftdvfIDbyb52h36HBpVjGkxmwlPI0UgP14H6jJueu9LBJ4zk20NbPsa12JX0wMcwWOQuHfjqPLCJXARZUM800qN9YLD2eR44PXSSrPU6tFNVGQ50NrOaDxUuf2dgo3F8NMq1ruZzPI7gKEI6f230NmjAe7oOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296029; c=relaxed/simple;
	bh=fyzhWZ8Rq/cCceCIAyRBsxTEtxV7lsOpXos70hmNo30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSE3rr5R9N1TVtVNgh4LQNO7bLGkFDWWkYr+6AlwV50UVUS98d66n7jr7gQj9Sj1UYUMC1VHo/0YDD7lzujiSWilO4v5HqYN35l6UvZfSX9xj++JeRbqYkBrLFmTq3cRAny8ZC/fbOwG32Yv/ozH5hkdxoduXjwq+gWMjamo8XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 110CD227AAE; Wed, 30 Oct 2024 14:47:00 +0100 (CET)
Date: Wed, 30 Oct 2024 14:47:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Kundan Kumar <kundan.kumar@samsung.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] block: remove bio_add_zone_append_page
Message-ID: <20241030134700.GA27762@lst.de>
References: <20241030051859.280923-1-hch@lst.de> <20241030051859.280923-3-hch@lst.de> <790362cd-dfbb-4ca7-879a-68463156b69a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <790362cd-dfbb-4ca7-879a-68463156b69a@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 30, 2024 at 07:30:49AM +0000, Chaitanya Kulkarni wrote:
> if that is true should we just use the bio_add_hw_page() ? since
> bio_add_pc_page() is a simple wrapper over bio_add_hw_page() without
> the additional checks present in bio_add_zone_append_page() ?

bio_add_hw_page is currently static.  But just renaming bio_add_pc_page
to bio_add_hw_page and finding a different name for the version with
the same_page argument sounds like a good idea, but that's for a follow
on patch.  I can look into that.

> unless for some reason I failed to understand REQ_OP_ZONE_APPEND
> is categorized here as a passthru request, then sorry for wasting
> your time ...

It is not a passthrough request, but it is treated as one.

