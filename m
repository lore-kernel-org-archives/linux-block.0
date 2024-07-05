Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773221494C9;
	Fri,  5 Jul 2024 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181530; cv=none; b=Ub6tcYU1qwWIKvESh647J5PeKFt5LwhP17CngbopAPTuOmCxjWrcduLHL/nbwIxzWrWEFoeOQdOvRw3bYx3lDd5SwTg8EYmW1DASIZvC3+yhjeVeckOuKo+h7FNBUUohMPNyIiLR4zhLr8vMsp1zru0oE6so+I4BXq4HR6DrkSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181530; c=relaxed/simple;
	bh=sbn9B0XlOBkDVt0kU9u+XK8ExebQM/zIzDPkuoYoh0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kS6Nfr5fHMYxLk4g3xMrIUnHV6P+7k9SIT/bMBdMf6Iiz4G9yAr91XbW4rDZVmDIjDNWDOEo83Sh1/B1sl9MwDi8h/NgH67gojYEriF/EIFvmJjr4ZhTYHrpv5yzMTaxgxFP7xksTysqjnzvmBJnfIKZ/YOMhKzq7/F5gDg7YhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD2CE68B05; Fri,  5 Jul 2024 14:12:03 +0200 (CEST)
Date: Fri, 5 Jul 2024 14:12:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: make secure erase and write zeroes ioctls interruptible as well
Message-ID: <20240705121203.GA29448@lst.de>
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

qemu does support mmc, but not the secure erase command.
virtio also has secure erase support, but that isn't implemented by
qemu either.

