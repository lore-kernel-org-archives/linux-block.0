Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB48171E70
	for <linux-block@vger.kernel.org>; Mon,  4 Nov 2024 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730706432; cv=none; b=STxH9E5mALae2yOwyRtpVcqzWkBlY1bvbTFojytq8DStAMVcflLYMulqF+zDEPUjTjeP9YuqAsJ/qp0bHtuaDEqQktU7salLANlFCFJU91e4DQqZsHuYblJP+9vT3FAx1ZbMPX4o+BAaEUZq9TaOxDXjjpME02wHlcN+gz9FlnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730706432; c=relaxed/simple;
	bh=b3mBQnP42erNHLaNnTK5ETdQ9fYU3mvdRfpdIk1fHHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKU+bvIque3OgIuv7h20JsIUqPzSzAJ2eghAbPDdGSp8tijBTBDKN150BLCJmN59WkEvoUjpknqKV91XoBsyUQvJZ3LScjAEa14To5tyTTwnq+1FWEdEK9d1PcWKi4BJendUjZe2e4ds86eViT8XkqVxrYf6i/z5kBPvCvaVy3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1FC38227A87; Mon,  4 Nov 2024 08:47:07 +0100 (CET)
Date: Mon, 4 Nov 2024 08:47:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: Use bdev limit helpers for configuring discard
Message-ID: <20241104074706.GA20887@lst.de>
References: <20241030111900.3981223-1-john.g.garry@oracle.com> <20241030140601.GA29107@lst.de> <27a2e5e7-9dbc-4fa6-81c2-1a8df906187b@oracle.com> <629883c0-9269-4820-801c-a5ed6e4b2803@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629883c0-9269-4820-801c-a5ed6e4b2803@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 01, 2024 at 09:08:51AM +0000, John Garry wrote:
>> ok, I see that set in blk_validate_limits()
>
> BTW, can the check for granularity ever fail in 
> queue_limit_discard_alignment()
>
> static unsigned int queue_limit_discard_alignment(...)
> {
> 	...
>
> 	granularity = lim->discard_granularity >> SECTOR_SHIFT;
> 	if (!granularity)
> 		return 0;

lim->discard_granularity is always set to SECTOR_SIZE or large,
so granularity can't be 0 here.

