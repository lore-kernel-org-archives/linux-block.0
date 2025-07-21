Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BEEDF49
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083586; cv=none; b=LA7JGLJYoaBvZANcyAVJn3Xd0XG/76ad7s28h2F4ZRK3ba6FKYGyuEGYNjEoyYeIZkV/3XAUxct9fs2AD63Hy1Aub4wLj+t51ky6iL/k9pYeGCzk9zkpOvJ20mwFnAse+o6MVwPsi4IvzlTZZ7g1gMRdvHHjvHpXC/DtB0cli8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083586; c=relaxed/simple;
	bh=BGdDJiN8oQpNiowTRtmxvl9kFnNSk7Y3P6OCDnugRf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjjz69vZGITayRmeMNlpzcA6AH9BxqO0TwJYroPr0pJdletXKi9uwWbik1iBNbU9Y3d6vnHb6ferPo3PjL/205WZRhO7oXHrUc9QqzA5sMEKJ+VQxNZqKqXJoZxY4ZwiqdbDYVUMkN2GMc8GTRv8wsiVaMDVGSglBQKi5aTep3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1131B68B05; Mon, 21 Jul 2025 09:39:40 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:39:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 4/7] blk-mq: remove REQ_P2PDMA flag
Message-ID: <20250721073939.GD32034@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-5-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jul 20, 2025 at 11:40:37AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> It's not serving any particular purpose anymore. pci_p2pdma_state()
> already has all the appropriate checks, so the flag isn't guarding
> anything.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

