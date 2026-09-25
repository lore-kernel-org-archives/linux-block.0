Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D73921E7
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319393; cv=none; b=hjscnDNV8S2KHOoKJA70wEb1184raWbIyGWtGs8xPEehjFmA4lhOlfFfYTHK9lOXWiG42ZJpyVg6ytR7EJXTGl6s46QbX9QQl/nDMVxKVWfEuIhh7aCEPpIY+5tpHXY0Q/dpThVbFn6jBdqydEBsF0IRR/wGsrMxeU2IZ0KCSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319393; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZVHw22teg90NN0/Psgwd/V4gdmGxOZzIFya4bAs9epYbq0R0NE49LVC68EtqxAaO0XbYf2sBgsuDoltIR249O1DO53HHrB6Hw+JtrQ3fcw8Ia5igIu8FmI81f+X043U/rHcrqcuYxtgKxStwSM/0ifSDSCMrpAhH04HpJyCh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0E33668BFE; Fri, 25 Sep 2026 08:56:28 +0200 (CEST)
Date: Fri, 25 Sep 2026 08:56:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] block/049: test polled dio with user PI
 metadata
Message-ID: <20260925065627.GA4442@lst.de>
References: <20260924025526.298050-1-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924025526.298050-1-yangxiuwei@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

