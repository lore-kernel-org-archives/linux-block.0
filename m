Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A1625F996
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744094275; cv=none; b=dpwt0HLfi/hK8+HXSIo8SVljd+fKZeqGv1pWG2hLNiUn6GnBGUmFLnkENUaxChOaIa3EHvEUkIodZkLcl/985n8aeb9dRDE7Qypk4mbm5XSss+6JJuLCNO37lKQ7OEUWfcUtAf0xx3rBFyyIXH0QVGKJltD6Qep0l1Ft9s19zlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744094275; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8hzc9sRMi/LTH9p9iTM6ui4v+dqbukaI4H+1SpuaBxi23aBRk9tgyel97IU4zM9UMe/+B0q89n3RdetyU9cywOHpYx9/trUTZcvACHh+qzvBQH+Q1DqlprdSa2iwKX+FltDuXc4Dg3C4yI+7FjLdyG1cNR1JTHFGXE5XX5H6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B690967373; Tue,  8 Apr 2025 08:37:48 +0200 (CEST)
Date: Tue, 8 Apr 2025 08:37:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 2/2] Documentation: Document the new zoned loop
 block device driver
Message-ID: <20250408063748.GA1635@lst.de>
References: <20250407075222.170336-1-dlemoal@kernel.org> <20250407075222.170336-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407075222.170336-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

