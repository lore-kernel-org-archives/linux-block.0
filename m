Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30D218A95A
	for <linux-block@vger.kernel.org>; Mon, 17 Feb 2025 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739775383; cv=none; b=tXHwqRw1rhRP4C/4o41+EfsCLqs7eXM2h/x7CinQ7E9nwsniguMO8ivZOSHA4Tv7szMzM/uAvVa9AmC4qvkGnOqozEFas+OTs0HgnJfWef4eDbA3wqqE4r+FND3Slk1TXe4c+jiFNtLO352TseXQijepbqJGi6kQ8l3GwMTPktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739775383; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EClNxnvZeDhw83sa7PwhYpJOYlAKvO7V1zaKNtoZxE1E38oOzS7Lar4TLW760T0X5tAaaBv36tbYkDIwRJ1GW05UtSdmKg+1OZZt1grHJ73PdVCdKpcUlFSb6oEUI7/Xtrvid6z24E9rshFJUiTMXbQ697Q0sEJmrn2sKRHq7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 16E8868AA6; Mon, 17 Feb 2025 07:56:10 +0100 (CET)
Date: Mon, 17 Feb 2025 07:56:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Cheyenne Wills <cheyenne.wills@gmail.com>
Subject: Re: [PATCH V2] block: fix NULL pointer dereferenced within
 __blk_rq_map_sg
Message-ID: <20250217065609.GA23707@lst.de>
References: <20250217031626.461977-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217031626.461977-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

