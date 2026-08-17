Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C63B6C14
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953939; cv=none; b=rSYMRioR2bEnxgG/sO+VkWJtBwfMyQCXa3wE2CWXqCTsM1tv6qf8+ixgun+6WpRnzwtIRX9EelYe+DvEKLOZVjs2iWNbMJjsBkpFPFwZlqzHmxJR8NQX1rHiwVOWl0ZcEEGMSZn7io8ta3gnTbOzZAFin9iMKE/zyj4AGXct4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953939; c=relaxed/simple;
	bh=MfQLRO6q9qA+V9YV58Gg3v+PRHYkUkEi7kRvktH/jNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbBWBNn2/t140Rw/Z0Vfai0fv9s/O95UVL7OX3msw8WKAWcsI+YWW6x3qRmnKQnqgEzFTklrFkYxtR2cB/n6wsk0yPV4xgdCrOrhwAIzpleYU7PKNNW/ZYo21yl5Ib8JV9RLwcMr+HJsiUSgoYShDzDRJ99FtUiPM4U7osHBp5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52E2B68CFE; Mon, 17 Aug 2026 10:05:34 +0200 (CEST)
Date: Mon, 17 Aug 2026 10:05:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 2/4] block: factor block size and alignment handling
 out of blk_stack_limits
Message-ID: <20260817080534.GB21461@lst.de>
References: <20260806024658.4193386-1-sangyao@kylinos.cn> <20260806024658.4193386-3-sangyao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806024658.4193386-3-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Some of this could use the additional space on the lines due to reducing
the indentation, but otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

