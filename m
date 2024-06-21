Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6F5B1E0
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 05:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946899; cv=none; b=plv/CpOKWOevYU8p4n727GuaeqHvBrmbNWnQfBzzBawzcJsFTW5wS+iAOgGLm36ChgIMwz+jvNOl1NLkoqdl4UkwK3oZhWzZCwPvg4S/pP8ElFkvnv/1cYURPbWDkzWKcB8tLJmIWiOPlwZ0phDmKlIDGJp2WVouMR2CjlSJjlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946899; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YryTe5iNBJZJr9ShhuaERpuIvrWbFEI1ubhJY2ntWbTNyzH5pJ2o2U10kOSgSYYIrXITuc9+t2a7Cwl6GlgvsyGlXrTzvrVJ1JvnTY6J1oHCFpg7G9RMx8Ahq2XDNBEIWk6ymOfS0L/TTOXAQm+sA4gdSqXLaJkeNJ6GX4X2cEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nr0iR3W4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nr0iR3W4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=nr0iR3W4AVm9f87sq6okMduNX8
	ah5n9RF0oKJKp4JGKg43tzHOtrncRAyuyw/EK1CgHjtFDgspmmhiT0wdWNb2DaGnS+uLh82OD4QgY
	fLt+Ms0nNVROrfojeZLTJlum4w7EZmG0lCVPB9wOJkbTeaz5W2t7kpMOLml2dhuY04ekZkSgeFgF+
	tbft5C1bgZ5T/wXLSn8pnAzek58zacowCPohbtv6mQmfln5nPjk/2dyQzYXE0CRt2JMBeWo/+FGc7
	XGjnnxKSb2IEbI7sgkG5crGY1KXPjFjIuJ2wgH3H+a4OzR9tNGpwfq6UQKbFt0BoVP4ybahHLe4LU
	Y5CdWqlQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKWbx-00000007kQD-3KAO;
	Fri, 21 Jun 2024 05:14:57 +0000
Date: Thu, 20 Jun 2024 22:14:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] block: Define bdev_nr_zones() as an inline function
Message-ID: <ZnUMURVp-1A6Bif0@infradead.org>
References: <20240621031506.759397-1-dlemoal@kernel.org>
 <20240621031506.759397-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621031506.759397-3-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

