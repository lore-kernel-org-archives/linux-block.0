Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA4431E68
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694656; cv=none; b=u+FdGO90EapKuSo21PoS3iWRBhpVlrYY1XoZ5sb6EH/jpp8Vnlr74p8MZcjVylJpaZOMbvGPHGmeD/egEb0r6/eaTc8yyuJ2/0kJhTht1GA92jccvvMpSintd3axG5gkb5Evi9zWhgE0erNYOemHxwS1kssdhNfUN0dtnip0aVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694656; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH0NQdLLcWu8xWG37eU5uEY10hEQr3eH+iyxvVGNB83pi0BrjqrO6uoxx/9fmhsWm1y3o80cQyGHWiYFt45nb0mXL5n3sR1KaqOWOEINj2APhm2QbiEwI2/nd3Vrnt0uj1zMciNiqOy/guHTwOD7KnA/yAYNdWnrzFohoGsRgIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 24F4C68B05; Fri, 14 Aug 2026 10:04:11 +0200 (CEST)
Date: Fri, 14 Aug 2026 10:04:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v4 06/13] block: introduce disk_for_all_zone_wplugs()
Message-ID: <20260814080410.GA12566@lst.de>
References: <20260814063201.1762743-1-dlemoal@kernel.org> <20260814063201.1762743-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814063201.1762743-7-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

