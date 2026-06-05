Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2930C179
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642163; cv=none; b=uCqfSVtDU+luCc1p6FUBb3kWwQzKtZlVn9RsuSNkAA0L2ibsqtCc6i+SEV/EosuGHHJDhbOVgIzVjByY68MJHtMKQPxUBewxFOQOoQY/Tz+raBY5kmYijw2MvODIzG11oGW3eqvP0/cCjLcoZPT+OYrJbPWMFhCBoNs2OftqjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642163; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhJM4Wt7ahpncg21YCm/DdeH3BqZGJM+gLWhfYVfnYMfOYThx4/bzv12m0jc93oX4ZdbXGHVr5CB+sScoCiF/WgoU3A6YNh6vxZK/V5sZ4f0xkhfGn3Bjat/of7UtgFzRbZgwpzxv2v5wWo1PftUfRGL67AvpuWK8MQiGk+bVqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 68BFF68AFE; Fri,  5 Jun 2026 08:49:17 +0200 (CEST)
Date: Fri, 5 Jun 2026 08:49:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v6 07/14] block/cgroup: Inline
 blkg_conf_{open,close}_bdev_frozen()
Message-ID: <20260605064917.GB26230@lst.de>
References: <cover.1780419600.git.bvanassche@acm.org> <08f0e3d5f8c01523a66cf55303acfa3c4ff47725.1780419600.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08f0e3d5f8c01523a66cf55303acfa3c4ff47725.1780419600.git.bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

