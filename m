Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964123A984F;
	Mon, 17 Aug 2026 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949826; cv=none; b=to7LUinrowNlOodoqtpv5peLT7cE99UK8ZR3qZf4WhPqQAeHgoHpsM8Lu0RzHEwQJYmQmheG2BrCRs6Umgt/nMsnKKc2UhWMIVlTEiiv2G0nZ3aAKPq0wJ+9W7jxT1oR/GCYQWRHMuIqD1jA9sU4O1Upogb7dEF1GQ8Bq4OkHok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949826; c=relaxed/simple;
	bh=l2wg+rfCZ64Xwq1Xa2X24CcP3fSPwfgL/DFDcNq4Z8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPLIsrCUoDZLVitFdsrDkuU5hOPwGP8rX/gkBaS2lREmCDjI9tLKD4bDq7tKQ1v/Aj9lF71aciqzWtno1hzY9wKN4q96xd2nAj/2mDm3Wi3WCpv42Ts0opQAoo8EwPQbpgRptEErsgF3Yv2wvFW2N3jAaUhEkK0DD7r6O3Ydccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D10C68CFE; Mon, 17 Aug 2026 08:57:00 +0200 (CEST)
Date: Mon, 17 Aug 2026 08:57:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Md Haris Iqbal <haris.iqbal@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@kernel.org>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: block: fix the sector 0 error injection
 example
Message-ID: <20260817065700.GC16255@lst.de>
References: <20260815191100.43956-1-haris.iqbal@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815191100.43956-1-haris.iqbal@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Aug 15, 2026 at 09:11:00PM +0200, Md Haris Iqbal wrote:
> The first error injection example is introduced as failing one in ten
> reads of sector 0, but the rule it shows does not set nr_sectors, which
> defaults to the remainder of the device.  As written it fails one in ten
> reads of the whole device.
> 
> Add nr_sectors=1 so that the rule does what the text says.  This also
> gives the documentation one example that uses nr_sectors.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

