Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADF934678D
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771600232; cv=none; b=FSzmedskNVJTFtCpKexmtDhOhU/qJT8XuL5Q4nVyPo7sCRhQZu9l7PW4c77CQw9iDKuu63Euww+vljDOUuG7qxFjFDGVHYv3V/s4roMlzesQI7UGySkFBhYfo6+td4uZiewn2Q2zDAu1nE4k3jAMy4QPUGq1QLsol0FgEVDnxhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771600232; c=relaxed/simple;
	bh=FQIfHSfSj7V5zSUgoYJnxLAC6ymM63EpTySMXRSLDWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfNBgj6hO7YR7Z66TdfWIZQ8P1fD/6t1zIpI/mbrzrAmDNcrFZxpXRZCOlyNbx/cWN62yRo/idzq3zVclZ8e6df9hKI3fnxMuAjJfWjTTuOzCpiNnLGQxjt65A1x92jbhDf7TrAj1R8jUjWPCpD2FyZgOx1RQi0d7AcE5LmIUgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0A2DB68B05; Fri, 20 Feb 2026 16:10:20 +0100 (CET)
Date: Fri, 20 Feb 2026 16:10:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] block: Correct comment on bio_alloc_clone()
Message-ID: <20260220151019.GA14027@lst.de>
References: <20260220143233.3500551-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220143233.3500551-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 20, 2026 at 02:32:33PM +0000, John Garry wrote:
> Correct the comment that the source bio must not be freed before the clone.

Note that while this version is better, it's not actually true either.
The bi_io_vec used by the clone must be freed after the clone, but it
might might not be owned by the passed in bio_src.

