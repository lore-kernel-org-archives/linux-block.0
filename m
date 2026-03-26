Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D63FA5EF
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534747; cv=none; b=SVYpo7BwHCkwS/YfGzYpjAbxvWgUIO9qjCM+le7umusoc2IUf6iDRCCHwwCdNdbSfDcmvK2//4h0Db+QGN7bgtyhbOXs7Ci/jUvDlKR0nH606pNNv+tA9RQSge24PrBVHXf+EkPlxWL3LNsyJtt+JeltxAxrZZhPwW/r5AvWq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534747; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u76a6ELaiPDRFwKNH8SPsL8rWbqU5EzXYwrICS/tvA7BvxUHox6w9g1BnbigpGS5E2HqS2jlaFwGwYaCPOk6n+FOJw40S2Tbdg1J6AUmY0PJCLegCTRh5OBzWXcGmBPCb9+Tq3JqtMCJJmJ8f0eA3Mq0zc26i1zXC7WDaunsonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 90A9568AFE; Thu, 26 Mar 2026 15:18:59 +0100 (CET)
Date: Thu, 26 Mar 2026 15:18:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 19/26] nbd: Enable lock context analysis
Message-ID: <20260326141859.GF16166@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-20-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-20-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

