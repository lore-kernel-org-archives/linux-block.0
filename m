Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5341C62
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603064; cv=none; b=dmjd+8ZFnA0LjGYTOZVUdxXN9oPJNgp+8yP838Vd+vTAbWKqgNAjZETnaIu5qISyeBXm4ZLIs4Nie3+pHCDwKwTSg5ILDFap7U4PQcFtNGmrA0gVsRrutIVkjK1KPtEWJmeQy+JigkGhd8ehPz3E+8UNSKSu96mTCq9wZ+jMyBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603064; c=relaxed/simple;
	bh=8yMNOqFVLyvhj8/81VVUzIUWVRgSvCVh6Fn7ds+R6Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzM6W2SVLeDJbIfu68LiyoW5ML+2f+Vv4bE53oyCII/jK2icR03sn/gpIEUWhTG+S31lloaT6XNH6hI4/zMH2Vulw9fWCvfWs5YOlfzbkde1F8MUz7soXAJqAHmgW8eWykyArpkuJWDoSIJbS9dvasjVISi8nOzXboLu4egIanY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7424D68B05; Fri, 20 Feb 2026 16:57:40 +0100 (CET)
Date: Fri, 20 Feb 2026 16:57:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Correct comment on bio_alloc_clone()
Message-ID: <20260220155740.GA14875@lst.de>
References: <20260220143233.3500551-1-john.g.garry@oracle.com> <20260220151019.GA14027@lst.de> <26f345ba-9cb6-49ad-89f4-1ce0153fd86c@oracle.com> <20260220154324.GA14632@lst.de> <e7e48183-c5f7-4912-bbe4-a58035156f2b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7e48183-c5f7-4912-bbe4-a58035156f2b@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 20, 2026 at 03:55:41PM +0000, John Garry wrote:
> BTW, the comment for bio_init_clone() was much the same as 
> bio_alloc_clone(), modulo what I tried to originally remedy. I can just 
> mention that that the same bio_src->bi_io_vec lifecycle rules apply there 
> (as bio_alloc_clone())

Sounds good.
