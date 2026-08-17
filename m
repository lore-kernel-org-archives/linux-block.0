Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C6390618
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952890; cv=none; b=Ce0sBgRxK0SkS+eaz2CYbDEwfHzqzdQA3RHipHOSivivGWJxeO0hM4PKxAy7BIXUiF93GnFoGMkrWXQ8tmfJtbrMdd2OTA1ghavTUA5Au+Fis6W0MxslxHsmz221IPUVIfFnIzqKaLlPtMsHGgCKUcFk3Jd1k6tsyXm2SWM43uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952890; c=relaxed/simple;
	bh=MQzJfhbMCBTqcbkrjzwPmJWu1yQ1rk4O3jYn57cAIeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odAGibjNK2nNXjQGzJ6kWK3eAULjVuYf40qeSI80yiFGugk1NqAgyhOn4K0MxIJnFFMrWnDWzvTBfGAlrzJFiWaQTKh/xGuSg12eveI76s+uZwlDIZ2Wl0NY2Ifi5XOOHfKfY8OxYUhEhhmvvvMSANf8rdfTc/Shjja0mt4rlDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3ABE268CFE; Mon, 17 Aug 2026 09:48:05 +0200 (CEST)
Date: Mon, 17 Aug 2026 09:48:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 00/13] Improve handling of offline and read-only
 zones
Message-ID: <20260817074804.GA20451@lst.de>
References: <20260814134750.2100304-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814134750.2100304-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Can you send patch 13 as a standalone fix for 7.3?

