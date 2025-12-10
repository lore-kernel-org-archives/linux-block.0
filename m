Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C2A6F2F2
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765379931; cv=none; b=Ajo1MO9Jj+dxNxp8Vl6Hu/ToT6fxtnZZwC8X+IFu7ZGZPBiHuWTV93TQyFHS6DSdMM833kaDf41WK4+UuiC+CK0LbQMSWsFboVYS4tH2Yj5n9cEFofoHIwcRodPElgtCwVa/rD4dJURWmzXcCvvXsCkt66wYZdbDm+jApSuZ1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765379931; c=relaxed/simple;
	bh=09owCR2ALd+JoFhA6An9d/x3Qw2D1mj5zzs+3D9FXHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwnrGAXYhDG8GJdJiHdwM+EJ/aWGRDOs15+Zlt4uRtXeiz0d5Z1nC3uF7ZCfoOXBkp+kmmMr75FkAl6bGJ6mFYiaVOpph6Rer7NXPkGooEqRWNJ/qGBQHv4K7ioXNlZY3FNK0SITWcy3E+z2jld2aJcTqnqpShGgVPf+oQmsxaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66F3B227A87; Wed, 10 Dec 2025 16:18:43 +0100 (CET)
Date: Wed, 10 Dec 2025 16:18:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	Keith Busch <kbusch@kernel.org>, Sebastian Ott <sebott@redhat.com>
Subject: Re: [PATCHv2] blk-mq-dma: always initialize dma state
Message-ID: <20251210151842.GA2036@lst.de>
References: <20251210104346.379106-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210104346.379106-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 10, 2025 at 02:43:46AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Ensure the dma state is initialized when we're not using the contiguous
> iova, otherwise the caller may be using a stale state from a previous
> request that could use the coalesed iova allocation.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

