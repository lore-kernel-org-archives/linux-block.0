Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F830363089
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 05:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017667; cv=none; b=QnwMPHHcGUkytOlQ7IGRIn6ZYScC4TsDeU0uiHKcoBVXbmxKWrr18I186f30HdI80TFzX5eZfB3/HQQ2whx9K3Yn9fzFcKmuYHpMzOOSXzy/aAnIEaspxw7jLotd6sxcOZIoB6saJhzCpvG0vilyTPfNcBbObycBDStwFGoB+RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017667; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYh9YA8Tow/w7MTHs+5gnJrEYK4bdBSz9WNvyByAw321xL6xUXI4r/z1hNIMRZy5b+0FgyfD26o27fXAlwZkEy7Elxa5x+7jjzERNoh5LGSAds24zzrwP7Th/aG0J9e7d9almJ+qAMXgH9zMU5gWctT7LsOHlt4oO2wWGFVJe3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3294C68BFE; Thu, 10 Sep 2026 07:21:03 +0200 (CEST)
Date: Thu, 10 Sep 2026 07:21:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 07/16] block: improve blkdev_get_zone_info()
Message-ID: <20260910052103.GC27013@lst.de>
References: <20260908085745.1082697-1-dlemoal@kernel.org> <20260908085745.1082697-8-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908085745.1082697-8-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

