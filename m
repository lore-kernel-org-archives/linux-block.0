Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13732F99BD
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775716946; cv=none; b=OKGzFipPDVrz4JQ/8WAAPTFA53pKI4N9yneSMNMok8QjJinqJr0blPcqr416ZFUgUsEhQEuKBGOSTWIusPJlWi+SNowC9npE67utGK8vB5M0r5yHkODVbsI5g1sXvLlKxBdufmzzLyk2VVmhGxU2FXT+JggvSE/kWb9Ni0ChBuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775716946; c=relaxed/simple;
	bh=XMOZHZeGsYklPkTAZAU1XEPJBiaGORXoJiCRDaHGDCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gP9t8y2FWTD0rcObIuuKoZ6hCyg18022G/JdokXX7BLUSv/n9J4Xndhy1FL6SC2cWqX/ou94A2Oo4PdknBjDy8eHwUtSXqQ4FUe2KskRPgs1maFjXJ8Q2bnaxCRR66RlFxqRUa+LZUPS6sfykXszUBibfj9XYy4s1gw+f2oZEqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92D6468BFE; Thu,  9 Apr 2026 08:42:21 +0200 (CEST)
Date: Thu, 9 Apr 2026 08:42:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v3 02/12] block/bdev: Annotate the blk_holder_ops
 callback invocations
Message-ID: <20260409064221.GA8378@lst.de>
References: <20260402183950.3626956-1-bvanassche@acm.org> <20260402183950.3626956-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402183950.3626956-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 02, 2026 at 11:39:34AM -0700, Bart Van Assche wrote:
> The four callback functions in blk_holder_ops all release the
> bd_holder_lock. Add __release() annotations where appropriate to prepare
> for enabling thread-safety analysis. Explicit __release() annotations have
> been added since Clang does not support adding a __releases() annotation
> to a function pointer.

I have to say I still hate this with passion.  If we can't propagate
the lock context over function pointers it isn't ready for prime time
unfortunately, as much as I'm looking forward to it.

