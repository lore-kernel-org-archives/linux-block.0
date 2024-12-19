Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2290B7E575
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 05:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734586448; cv=none; b=RRE3ONeYuJx3hmIishQwLbx+xhMGpaoVb+Pj756o/ldPbPRRb3W+HU/1NLripTWCLXIZBdNqUIs9J5GIsqD6X5Ma64UwIj/WYBZyCQZA7l6d9ihDuvuIdVSwQILhJDPo1Y4BBrwHo9SUIAp9GjXOdx9oFezL1GicabMCc9SJVqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734586448; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFUr+NFhqGPwRt3/IVkwO17kBFy3mAZWrnEr6cwxzo5ZmHzhxqIv42mO1uIKDSnue9mBOMYcvUUg+1C9dJtQCeTvnBBdoX5p3lrjHGYL7ChjcfCE727YMGeSrw+nRcXq5uO6QpdXW6KulMuHGPyGq8et+2Bb3+EXoTwwKZnfhmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C3FF368BFE; Thu, 19 Dec 2024 06:34:01 +0100 (CET)
Date: Thu, 19 Dec 2024 06:34:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 2/2] blk-mq: Move more error handling into
 blk_mq_submit_bio()
Message-ID: <20241219053401.GB18792@lst.de>
References: <20241218212246.1073149-1-bvanassche@acm.org> <20241218212246.1073149-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218212246.1073149-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

