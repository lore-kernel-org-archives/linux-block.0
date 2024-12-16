Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626EE84A5E
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364578; cv=none; b=A3D5R9vYR6MMZez/6eRaWhj8FzruFaAwi8yLToY4sY47AhPq9JQPKcIak674fZUfmHTCm4b0f8VLUXGbXup+YYCzKMuoQfGS08fP2POcNK7ZE/k9AnAekJc6cs4kR4dgp7IF3e5GKeJ9LY0Oc2PZdb9He7cF4zu+2zjAy8viGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364578; c=relaxed/simple;
	bh=uqQwGX8x3kiKeFY4eessz5qZ0h6rjEwJ7kWIdgYdWNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzqWGh7/mxF5V9tstk5ksrDboP0DyUcNIf6BBHkK/Nwr8oqQoNW5/C2ZNAgw4vJsD60WEpQb9slYgxA6PcwrgAQdnNO6mZUiIfToAlWGXzDkt5vcwioceh1cK14AaH2p+k4wXzVz9R4ZPmuIYt2vroeH2CjmqCwiKnsjnS6KaQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE1EB68C4E; Mon, 16 Dec 2024 16:56:11 +0100 (CET)
Date: Mon, 16 Dec 2024 16:56:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] block: Fix queue_iostats_passthrough_show()
Message-ID: <20241216155611.GB24280@lst.de>
References: <20241212212941.1268662-1-bvanassche@acm.org> <20241212212941.1268662-4-bvanassche@acm.org> <20241213044615.GC5281@lst.de> <7399171c-6cf3-4e07-b4e5-1d5d362198ba@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7399171c-6cf3-4e07-b4e5-1d5d362198ba@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 13, 2024 at 08:26:44AM -0800, Bart Van Assche wrote:
> There are about 16 functions in include/linux/blkdev.h that test a single 
> bit in q->queue_flags or q->limits.features. Do you really want
> me to convert all these macros into inline functions?

Given that all of them could leak the __bitwise type that could be
worthwhile.  Alternatively we could also take a hard look at these
helpers and check if they are even worth having and otherwise just
open code the check for the bits.

