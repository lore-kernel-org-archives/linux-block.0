Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006482DBF75
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774507217; cv=none; b=l338LIsY1eFB67XUKT9IJKKoFhUAQpj/9LfxbX16iXhg1M/kCX4Cj5emVnSWFq9lJbaBNgq+pnJpqXq658N6h4LA/OLKN1qfKQJQn+995OysmOr+khy1ZuTfQ8xCojz0NvPO+TuZDEtyOMW0e//5pbCGVbylw1CVnAM51NAv8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774507217; c=relaxed/simple;
	bh=eXnNku640hGtN9oh2Z1pOTwjF63fuXZBH2l4t3WDr8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiBq9zAbbXB5ROTtVVZn6q0YnECGbixkAZfGI3U9clHiEW0KP664rJUidxtT28XYKSXbohMzCh6Tecvd10V4a3Rs4DkEpMP9yqjiSlMqedsQazJrsbTjmBzm5D4PjOCbpObJ4f6dmjn6v5s6Vr5rCkozJ5SkdblMxFblwpJVrgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9165B68B05; Thu, 26 Mar 2026 07:40:13 +0100 (CET)
Date: Thu, 26 Mar 2026 07:40:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 11/26] block/Kyber: Make the lock context
 annotations compatible with Clang
Message-ID: <20260326064013.GK24071@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-12-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-12-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Kyber in the subject seem incorrectly capitalized.

On Wed, Mar 25, 2026 at 02:44:52PM -0700, Bart Van Assche wrote:
> Prepare for enabling lock context analysis.

This doesn't say anything.

