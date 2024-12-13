Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD74183CC2
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 04:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734065104; cv=none; b=bcPWsqGgqHcFcRa8TrvXLhiU5FblTsNjVl8abQDAAOp9+oD1TV+lkdJKbdxFaxh/P8wRD7/jse9q26rKsDEIdokWgcc1ypi3YwoqGfPkGeBJvNiMWdNEAjxYpLDFH9DSjatBOCNGsSmqqhDFj/xy32qj7Z59nSAaZiHqo8cfHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734065104; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CffMIwZW/kIPO5iZJX0CxuGtjDe1KZS6GClkgvfM6RSdE6nGHo0OfEKopVHk3Buh+OZgJR38UHBFmYOOxKvfYtmT1vqOZGChwbFnUYfQidZipSO3h3Ri8aja1vYmwSGxHPurclF2KuYsVrknJBHUE79cOULBkBCr7hyVDE/oBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1B8C768BEB; Fri, 13 Dec 2024 05:44:59 +0100 (CET)
Date: Fri, 13 Dec 2024 05:44:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 2/3] blk-mq: Clean up blk_mq_requeue_work()
Message-ID: <20241213044458.GB5281@lst.de>
References: <20241212212941.1268662-1-bvanassche@acm.org> <20241212212941.1268662-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212212941.1268662-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

