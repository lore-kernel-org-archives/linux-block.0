Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0233B47D5
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 06:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506515; cv=none; b=Ne4VwnQONiqyNp1pKGLzkJ6Ar+r6pHd11CV6UuXNI29IxuwT5taxIPIclnpRrT0SgzUHwOLpdhcGuglssLZLn5D/sCSPwCaR0oMrhqd8QKlO6+wGJmtXyeV0/aw9v2MBxzppEEYc8CDLkDy0oX57RV/AzT3eDT++1PUAHLrUvz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506515; c=relaxed/simple;
	bh=VDvmum7v/Lq+eq4Ab7KXCTTR/EhBOrmpCyhavyFOF0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HppqT4oc5kBQnNwAOphmw1b7thnq/PyxrIt4k9wRPC5Ut11Cn+zbsdvt88CnWiHTDINXItHXNku+YGKtaHk8jyYSj3hnpSIWpeX4ukDszFKUSR7Tw4vs0hOHb5Tf1HNoWCjANaBlPgpO8ZbWGu8gcxV/ZM3DQuhLPDXF4AGfwFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 31C6F68B05; Thu, 26 Mar 2026 07:28:30 +0100 (CET)
Date: Thu, 26 Mar 2026 07:28:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 05/26] block/cgroup: Modify the
 blkg_conf_open_bdev_frozen() calling convention
Message-ID: <20260326062829.GF24071@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-6-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-6-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 25, 2026 at 02:44:46PM -0700, Bart Van Assche wrote:
> Instead of returning either a negative error number or a positive memory
> flags value, pass a memory flags pointer as an argument and return zero
> upon success. This patch prepares for adding thread-safety annotations
> by changing the calling convention into something that is supported by
> __cond_acquires().

Looking at this code it seems like a really messy API.  It seems
like blkg_conf_open_bdev_frozen and blkg_conf_exit_frozen should
just be open coded in the only caller using the lower-level helpers
you just added earlier.

