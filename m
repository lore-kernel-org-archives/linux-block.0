Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128BC34DCF3
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373211; cv=none; b=Q9A+Gff8cDLit9zyBsJsNrzhu6U6uK1p2xOcgfT6M9NE3dcGAXxW0/MJ4Sx+OPVJVlZjcjzC15jAQFtMv8lLiyjjDvFzr2hkSj+z0AwfGcLMKC+rjNQGIaiGvg0kjVcvChImBBEcq049AGeHJXTCYxj61fs7Rlt7hHSDp6kn3Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373211; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StOGQ6rKK9rTYyYAI26WKRtkzrBtvdlDbIOjNO+PmgMFnhgoSjrvOGbj5BBMFjR49CEeQe1WkVQXP8dR4c+7c/g1+hjzJZSoqFQZsqkeEBNuqUb+yEOQSkaB+eDIoQxYp8F/oMeoFrflPsYxx8RRfml0/tQP4QmdFNQidJ68Qb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DFC6468B05; Mon, 10 Aug 2026 16:46:37 +0200 (CEST)
Date: Mon, 10 Aug 2026 16:46:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 01/13] block: remove disk_free_zone_resources()
Message-ID: <20260810144637.GA16182@lst.de>
References: <20260806160445.848337-1-dlemoal@kernel.org> <20260806160445.848337-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806160445.848337-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

