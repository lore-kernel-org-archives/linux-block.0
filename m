Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C8C39891D
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694799; cv=none; b=FzQ//omj+iNEX7zggX0jRI8jJE4AGuw0E4n0If8qRlEVy9A81QJF7RsAHhZSN2GmbpmeOYCG4VEqhSVCwoHdc/8lL9g/ccJGpGwGqakNTdsNbuuYPh8ditlVhxoWh4At2lvRUp4DYMXdo8uljf+HX0NJYxzGVpYhXNzej4Lok44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694799; c=relaxed/simple;
	bh=T+mu7e4QE5QrDD3GgjH0lbPjuA12qvu1xFtsShvJweo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQZHt0pWGoiKDoe1AW+FQsWIlsVbyj76auwGBH9Hd1YMeogAKo9uh+TMMQu9k4PMwgPRiiWq5GMADAiXXx3cp6MtpnbKjPdwVAiZmA4pYNyquUh38FE/tBpraqu7VOIhFyMR6iNOJ1+Wwxo9DHbVg9ztz0R0/GNkV6vuRh0z5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D76B868B05; Fri, 14 Aug 2026 10:06:34 +0200 (CEST)
Date: Fri, 14 Aug 2026 10:06:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v4 09/13] block: always treat offline and read-only
 zones as dead
Message-ID: <20260814080634.GD12566@lst.de>
References: <20260814063201.1762743-1-dlemoal@kernel.org> <20260814063201.1762743-10-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814063201.1762743-10-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Splitting the pure move of the functions from the functional changes
would have made this a lot more readable, but it looks fine as-is:

Reviewed-by: Christoph Hellwig <hch@lst.de>
