Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C06AD51
	for <linux-block@vger.kernel.org>; Sun, 10 Aug 2025 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754834911; cv=none; b=YY4IyyMcblLfwCPvkMlhoDW3tvgcfzoyZu+KjHJbf490N7uQjqWvs0l4HDI5RyTk+pw/HFbHRa9o4gh/j8mUhHASee9a6DGLblwpgrr6HGgM1QxIn7TaOQCqoXwjCXhNZJ9HkgRSQvUGuJaYgEHdv7N8ukBlQBfXZgIEltEfCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754834911; c=relaxed/simple;
	bh=qQaIlcXmavapaM+KHshkJyFh3YV/Fma0TP6UNfsh2jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv7OzydtrwU0SdMVes2I3lt3fw5KZ64AHtUOB9zDSKu7j88/z2A/4N+no1brZrJf3aeBZXf6zwpWd8QmGfnm6EJnaBG2XGQ8U1eU/zWNxSmtAKrg2zq8DvIZTejP9zpJxQ+32aOSJC9htrFJde67dwusCTknhBEmlH4r7G8i2Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 778A2227A88; Sun, 10 Aug 2025 16:08:26 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:08:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 4/8] blk-mq: remove REQ_P2PDMA flag
Message-ID: <20250810140826.GD4262@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-5-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 08, 2025 at 08:58:22AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> It's not serving any particular purpose. pci_p2pdma_state() already has
> all the appropriate checks, so the config and flag checks are not
> guarding anything.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

