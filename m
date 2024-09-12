Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173892F3E;
	Thu, 12 Sep 2024 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124382; cv=none; b=Srhc+Y3cE5PuPF6HM3Ki5NwCBgQOlO0UQrtpSjlZ4TIhDp0dzBln9XpAOGZk1PpP+HCZin3euOiFhGFCry1rBxSmhm2JP52U8FM3wptM33cHbZsCXoMkiISEwscj3Z8kPEqtmPIrhbHatVOlgm8sSZ/oeCGIyvJNS/wde0oVKF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124382; c=relaxed/simple;
	bh=ZpIG+NjEV3kJeeUb/z8kruye9iUIIosmhTA83pSq25Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww/WPNDyn3yvcRuHj3Z3SxT/stA9uRDsgAjstpSrAKQSq/qGN6gMO7xWgIAQaS54rYmasv1obmeARRg9LmPx65HXGKddheXZ/YxLMHZoNk+xEM5rYZMS5Dn1vNE3gb32MJN5NSU7tUsLXuVPeR0PXjS/2IVyyC86xSQVtCWu5/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 62CBD227AAF; Thu, 12 Sep 2024 08:59:36 +0200 (CEST)
Date: Thu, 12 Sep 2024 08:59:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: fix potential invalid pointer dereference in
 blk_add_partition
Message-ID: <20240912065936.GB7455@lst.de>
References: <20240911132954.5874-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911132954.5874-1-riyandhiman14@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks!

The patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

