Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51A280318
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 05:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017709; cv=none; b=IA1ww8RJEq8WzTO/feRdDViE/4HwoPJWJ0aUHNp7duM0aUNf9RrAHO5+W5CawyyI7JZh8yovqpicu7Q7Cx4cDl4ivCBo8VEm0XHfKlpCS51jNv90Yy0DYLYH9kIuGkjeRvk2Upps9pne7hn5PmrcM7sgtqC9d0Chpq1x4bZtQw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017709; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fuzw39fYg2vSCI556pI11k0HOfY0NOTmzcVLDHaYiRrajJrvhy71JUcf3nwOlfn34wViuEW0AJaqXStQ/hjg/sqcVOXbt+saIsKp+p0Jlei/gdZU59/x2uzseD9VFRoHaie5lOiKbQsIHtR1OLqOnP8oekng4EDX1Kqcbs1pTso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 546BB68BFE; Thu, 10 Sep 2026 07:21:45 +0200 (CEST)
Date: Thu, 10 Sep 2026 07:21:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 09/16] block: serialize zone revalidation
Message-ID: <20260910052145.GD27013@lst.de>
References: <20260908085745.1082697-1-dlemoal@kernel.org> <20260908085745.1082697-10-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908085745.1082697-10-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
