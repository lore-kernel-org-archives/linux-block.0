Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376A2EBB8D
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779451744; cv=none; b=DZt0Cacu0ZCPIn8vhKWLbzd+hOgZk2g3H2DHm6yMZk7qL1/tvLMfjPwdTjysWus5sdB/DkTvNR7kDnI50sO+NJ9NID0+bBl0JFNUJHLj43vrxWkl6tDoD0TTgWvtVDkEvJdRCZbndhKRr6vquH82CsNOMGT/QlNq6qJE90n/Vhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779451744; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4pHyIWRM08MGjXO0vI3r0sEoKheTJCDZnOVd2rz7VUYwv67WsMe8UmPGvQqyloagTsKrGY35dkWc4wLqG6wNONV+Pu1+G44HRxAUyCI2ObBy7uwXn+FuxwNavigoHTuQGWcRL1c+GV4SdIpxKn1iEySmJE3vTv5rEs8uTvRuIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9414068BFE; Fri, 22 May 2026 14:09:00 +0200 (CEST)
Date: Fri, 22 May 2026 14:09:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: avoid use-after-free in
 disk_free_zone_resources()
Message-ID: <20260522120900.GC21041@lst.de>
References: <20260522115622.588535-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522115622.588535-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
