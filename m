Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C961A292B33
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077732; cv=none; b=UeVjjD8Sxjm1WwVNCG4Jh8CMjdJ4aauoBoa722WbjcsTNYAueukrQGlITnU34YxFYJ1BtFDrNEX+MMwWCFC2JTlCkc3lEOzDWqK+ATTKJW7j5Ij8xmmqvi0BrRTNCvhPn8uNUFttUkAgrqMwK65BTnh4kbG7BRcw1NClXweTOZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077732; c=relaxed/simple;
	bh=YtcjehBGESoMhT9Sl/ORrLA4t4SWi2YB8kvVKvbmdgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1p+xLyg5hg5JaBXeGXUjBYgl51TnCs0KIMF0LNbqndNEsa+x6NwkrM9/ScK6lyZqshKl0a6Bp8JMEXc3XG+kzjjKIQHTeXI1yIG5gCzZOZf70CvvqIQrFN7nIFw9AfbdhF8ORoeZ6R0eARCIGG8dX7hDn4RO9WuT94iXhq8x/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F05567373; Mon, 16 Jun 2025 14:42:06 +0200 (CEST)
Date: Mon, 16 Jun 2025 14:42:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
Message-ID: <20250616124205.GA27570@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-3-hch@lst.de> <dab07466-a1fe-4fba-b3a8-60da853a48be@kernel.org> <20250616050247.GA860@lst.de> <2105172c-5540-40d0-9573-15001b745648@kernel.org> <20250616113141.GA21749@lst.de> <4973015e-ecb2-4bd9-ac26-05927fa8fbd4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4973015e-ecb2-4bd9-ac26-05927fa8fbd4@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 02:37:43PM +0200, Daniel Gomez wrote:
> 	
> 2. In the if/switch case default case (line 181-183):
> 	It sets the status to invalid and *iter_start() returns false:
> 	
> 		default:
> 			iter->status = BLK_STS_INVAL;
> 			return false;
> 
> 
> Removing the invalid assignment "makes it" valid (because of the
> initialization)

Huhhh?  How do you make a field access valid by dropping an assignment?

