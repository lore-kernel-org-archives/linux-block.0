Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59234232369
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 06:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747807233; cv=none; b=m0m5NIZix2vDolgQvYk18uDTchWaoixiHt2lXtwVLEPUHPxtCkdb57tfTw/xdCYBd+f7+4PUUQ766H8BOSB1/J8SlcpPzpjg8uc4U2K7J40BcSBvOZ6q3UT/S13IIvIhs/OYbHMh3gdQfuF2YiMeZaHEH5vydhsoYepemq9RbeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747807233; c=relaxed/simple;
	bh=AN99Zcj5NHmmHxSzO9t9v9SZZBjOdpjjgvVYI/njosU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMS+Y5nHeoFIFxBAdZpG0dkkHJaONbeRUK5qK5PNyl16orlBYfgogscqcaIzpRhBMFfAfJ3WBTIjVGFHfByfm/HsoqHBPE5CCIlROYK08g7E3adETdLup+zir6ef9yVLq/8VnvUflzAvHCxvKEkTIPXFvULLOOeHKOGakoV+KQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 73A5468D3F; Wed, 21 May 2025 08:00:27 +0200 (CEST)
Date: Wed, 21 May 2025 08:00:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH 2/3] blk-zoned: Move locking into
 disk_zone_wplug_abort()
Message-ID: <20250521060026.GC3109@lst.de>
References: <20250521000626.1314859-1-bvanassche@acm.org> <20250521000626.1314859-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521000626.1314859-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 20, 2025 at 05:06:25PM -0700, Bart Van Assche wrote:
> Instead of holding zwplug->lock around disk_zone_wplug_abort() calls, make
> disk_zone_wplug_abort() obtain zwplug->lock. Prepare for reducing the amount
> of code protected by zwplug->lock. No functionality has been changed.

Besides the comments from the last patch that apply here as well,
this does change critical sections withoyut any explanation of why
that is desirable and an explanation of why it is safe.

