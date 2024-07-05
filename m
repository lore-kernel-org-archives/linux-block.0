Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C9B171BB;
	Fri,  5 Jul 2024 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720162258; cv=none; b=Z2A3NmA6eiNldLG6xD7SLOpBEJaE2j7L8VeRHffxpiA2SRJhwzD8rBAUGknz2RPXZykErxn4+6cYzVskmfX9oBl1f0KRj5c6bgVBcW8mehwIk9CDBw7JDZbEmRtkOJLQfOprRvAX2X5APzxMFlza/iO5yGgC8G9u/IhQZNDcDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720162258; c=relaxed/simple;
	bh=8qclzp6ljZKAufRSvKof13wDlra50zqmbOD5k5C4K44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2Xge+9XN8X+i/iDcJuSZ/2/UTyAtmoPaBJv19IisuMtM1eD+GBCeVs8VFKkgpBSQZe1qzud95g+Rq2Ib5zlLmjcLvaS5iPVehdaIq54gT9p+t/piSSPwKOSJapsopdjcakNhLx7auO0Dpgowy0vicT2U1CDHDHEmjbEdXNdBV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 75D7868AA6; Fri,  5 Jul 2024 08:50:53 +0200 (CEST)
Date: Fri, 5 Jul 2024 08:50:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: make secure erase and write zeroes ioctls interruptible as well
Message-ID: <20240705065053.GA12771@lst.de>
References: <20240701165219.1571322-1-hch@lst.de> <b4940767-b5ba-477d-98c6-a9671b2bc290@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4940767-b5ba-477d-98c6-a9671b2bc290@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 05, 2024 at 12:45:08AM -0600, Jens Axboe wrote:
> In lieu of that, qemu does support mmc it looks like?

Hmm, I can take a look.

> Wanted to get this queued up, but would probably be best to have
> that tested first.

The write zeroes patches do not depend on the secure erase patches, and
they are what people really care about.  Maybe just skip the secure
erase patches and apply the rest for now?

