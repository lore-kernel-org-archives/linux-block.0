Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22905419FCC
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692680; cv=none; b=FcJ+C87STGFi7t+S/if88G6Q4gVXvIK6J/t+8iqo6LElD2h8wyrR+j0DeAYpnA0m/j94+WbgJxx0lYUmMMYi74BiiKmuLruFdFH7KA74THtAKGkFvWjEzuOG7Pf2zb0YIqxAs0D4qkhVDbw8z62rilfzcTWzW50ahkFage+JlYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692680; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVmRzqGPcq5BG5ZPYV04SUZBNfTef8c+eewoF2Bv/5KsWYKExQd+FcX306y0ZD4x0OTNa6Cp6Pw63sxJwt/wxdy+3hyBwNzDSIzb2b4ipVb+5FqJr8kXKiihcnFFBQ6Um0uApvY+XQQWASw3n/SEAwzfI+EHBFvk7Ba6ASDLDFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E24568B05; Fri, 14 Aug 2026 09:31:09 +0200 (CEST)
Date: Fri, 14 Aug 2026 09:31:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 05/13] block: refactor bdev_zone_is_seq()
Message-ID: <20260814073108.GB10268@lst.de>
References: <20260814063201.1762743-1-dlemoal@kernel.org> <20260814063201.1762743-6-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814063201.1762743-6-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

