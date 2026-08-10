Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255A83DE438
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373291; cv=none; b=EEAWupNvg2juyXPB/psROjRcieQvCES5D1wvfHXFf95DeeGJOgfNjDK3mjIoqQ6WcoaS7+LfpFXmJ3i1y+zFOUS33igSQ1m+/Wgf4ZktpHV7m+rZ6UPGfLk414fqh+o9wToiYDF/iTgI0bTTxY5aVI3e20ex2r68G6VUqXJHw3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373291; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpOy24v28iAgGBuq8n9X2frAbu4h7/GZsFijzKI9f5eApM04Nf8XrWlL285tFgHfa0oaQ0QDG9U1tm9Z+MUVhI7WlkXt2kMhaxdJrDvOgQJZ1ie7q6Bmhb7Wp6a9edWrAehdNqsPhSN7Z4tiOl6JrzO5pmUbXsyHrKcWQy017nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50F1368B05; Mon, 10 Aug 2026 16:48:05 +0200 (CEST)
Date: Mon, 10 Aug 2026 16:48:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 03/13] block: refactor disk_update_zone_resources()
Message-ID: <20260810144805.GC16182@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org> <20260806160445.848337-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806160445.848337-4-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

