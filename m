Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694014430A
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186596; cv=none; b=AOBZRRdwat0R/ZQ1ycKl3Qbka1fi3JfTuYvmwHz0majfAGFhAYd9jtnvT9qe3wkpUS4MYuowWXr/iMscZ+g5HVcFNdUSa4Qai83QbXmIaID6TA07YisDFIpO9HGQRrwXIH2fr/OtS3HuPcwW7LkVrQSgAXF5ywJjqPLN7x7OGi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186596; c=relaxed/simple;
	bh=kWCgBun3LwmVKyYxbQ4Q5x5YqOrpHHJ591W8eeuNnDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nw209Nu++lyyP2o5hJaUtn0w4W6k5LfaXwmY61aoYK0WEIu5KEYFgVgvQO+e7/iHQGlc7aa7dv8/1t4tP+nmVZ5PKEDz88dkA6LGvwCMcpMSLLXK6OMjjARKre4oT9t3F6ljzhdGb7Mui2AyCSGBFU7GreLrvm10nB8oaGGjk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F1B4568B05; Fri,  5 Jul 2024 15:36:30 +0200 (CEST)
Date: Fri, 5 Jul 2024 15:36:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also check bio alignment for bio based
 drivers
Message-ID: <20240705133630.GA30748@lst.de>
References: <20240705125700.2174367-1-hch@lst.de> <20240705125700.2174367-2-hch@lst.de> <Zofzm6TRrOFb5iy9@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zofzm6TRrOFb5iy9@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 05, 2024 at 09:22:35PM +0800, Ming Lei wrote:
> On Fri, Jul 05, 2024 at 02:56:50PM +0200, Christoph Hellwig wrote:
> > Extend the checks added in 0676c434a99b ("block: check bio alignment
> > in blk_mq_submit_bio") for blk-mq drivers to bio based drivers as
> > all the same reasons apply for them as well.
> 
> Do we have bio based driver which may re-configure logical block size?

nvme multipath can, and it looks drbd might be able to do so as well.

> If yes, is it enough to do so? Cause queue usage counter is only held
> during bio submission, and it won't cover the whole bio lifetime.

Yes.  But for me the prime intend here is not to prevent that, but
to ensure we actually have the damn sanity check for all drivers
instead of just a few and instead a gazillion more or less equivalent
open coded versions.

That doesn't mean we shouldn't look into actually holding q_usage_count
over the entire bio lifetime for bio based drivers, but that's a
separate project.
