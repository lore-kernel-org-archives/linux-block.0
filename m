Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B462417E0
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535026; cv=none; b=WaJMEbXtneim2nJUoIDk4ngU1eiwOVQUEg3xX1RVWeiJA+odV1zrjlajvIgbrX8onA/nOzCZAnKIFAO2XSEdMoqrYs/KcP0rhrGKOAH3DMHymf4o7x/sGQU+XCDhcJIqbUUtg92/A991TkN4wNUGluOe5mw5vKRJ+cdcMnX48j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535026; c=relaxed/simple;
	bh=x3j5kx+Pjcfkq0SreANrAa/r1W8HJnt05gFusPWdETE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJmJXqdPqeHev19s5h+wpA678xCtgTNwki2s3+XgI80oc9rGn/b6QN7Z0AOg1umgrpDpZ192QM2xG9aB04Uq4CfDEuAZkeU2LtV3RnSsZIB/1QosDQamGAvkOB7eNSctgFlZp5lnRKGeW1kVR5iEzQs2sYzD6tRJTdlD9On1Gto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8BB7768AFE; Thu, 26 Mar 2026 15:23:42 +0100 (CET)
Date: Thu, 26 Mar 2026 15:23:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 1/5] block: Fix a source code comment
Message-ID: <20260326142342.GA16940@lst.de>
References: <20260325213719.2850619-1-bvanassche@acm.org> <20260325213719.2850619-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325213719.2850619-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 25, 2026 at 02:37:11PM -0700, Bart Van Assche wrote:
> Fix a source code comment that is no longer correct since commit
> 889c57066cee ("block: make segment size limit workable for > 4K
> PAGE_SIZE").
> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

