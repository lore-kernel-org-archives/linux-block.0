Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D724B143C61
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763530874; cv=none; b=CEQs8CK0nQmWa1BDf7iCgd1gZpnrsbptoCV0JPuiWRO94tc+ehRQm5Br5ibjAuNIZdKSBHIT5joROmNXtY1kquSVZdncXlfV5vV6s3RM7Ze5r9nv/c+4etGUx3KtSQIRjniJDkoZo35eOudsq8tVR+UL7ubCS/IjqY0G/ZwXU+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763530874; c=relaxed/simple;
	bh=3/f6axIeqfAoDGRjjxIv7bLEYbJ24yUQDsd50SkuiMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6lLKlWZ6myL5xXGxaIiguFQZxhJrX/c8l+KRORaMPSMmmF7xfRoL9XTbvuaysTyXV0dhHhzr4zsoyObdalvzw1CNxj6sVQNS3DhD+4lq0RfNxo3+pUB9RB8VPqNDHC2TNi1oO29zliPw53f/LHaD36toDDCU2c2z7N9FZnBACQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EF30268AFE; Wed, 19 Nov 2025 06:41:08 +0100 (CET)
Date: Wed, 19 Nov 2025 06:41:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
	hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] zloop: clear REQ_NOWAIT before workqueue submission
Message-ID: <20251119054108.GB19866@lst.de>
References: <20251119003647.156537-1-ckulkarnilinux@gmail.com> <20251119003647.156537-2-ckulkarnilinux@gmail.com> <7bf811d2-257a-4be0-b65d-e255717bcd35@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf811d2-257a-4be0-b65d-e255717bcd35@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 19, 2025 at 10:50:09AM +0900, Damien Le Moal wrote:
> To be able to catch any potential issue with this function blocking, I think it
> is preferable to unset REQ_NOWAIT only once we are in the context of the worker
> thread.

...


> The same comment applies to loop as well. I think it is better to clear
> REQ_NOWAIT only once the request is owned by the worker thread context.

Agreed.

