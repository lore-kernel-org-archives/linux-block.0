Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475DB30C610
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506694; cv=none; b=gaghMmP/U6LI9WGaglcDVieoN2eOZv6MhFBbuTVjWUuF3/ld8OQeItXJodlDs1G71oViJHp41aPC9xoQWDk4ZTuJmBr2uzqVaftBVp2xu3AYfUO3UhMPLsgssvAqZMtYfflcFec5n1lv37OYq3QgCsU8o6mLXkrlOCa/DfC8GhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506694; c=relaxed/simple;
	bh=nrH6H9/TvM+qpYLqh5jtanzLwaS8izpbYbXVHp9XOso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daUaZ28WoIn9+gLIPrRHO8pQ36o+CQU8irPu3ICncO+dWcZarQeK1WxZdOdhkKKrUmuOXj9lq/gRj8prebSN2FanJudHT185V8hXGCdUAyGof/5t6yJg1PbwcGAIoukHLdYOrkpBdgliQLDvsMPC+9s7v3KWZ1ghM4VgZrgcHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DFB4768B05; Thu, 26 Mar 2026 07:31:28 +0100 (CET)
Date: Thu, 26 Mar 2026 07:31:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 07/26] block/blk-iocost: Add lock context annotations
Message-ID: <20260326063128.GH24071@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-8-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-8-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 25, 2026 at 02:44:48PM -0700, Bart Van Assche wrote:
> Since iocg_lock() and iocg_unlock() both use conditional locking,
> annotate both with __no_context_analysis and use token_context_lock() to
> introduce a new lock context.

Looking at the two callers it seems like these helpers should simply
go away in favour of refactoring the callers.  iocg_waitq_timer_fn
only calls a single function inside the lock, which can be turned into
a conditional trivially, and ioc_rqos_throttle does basically totally
different things based on the same paramter passed as the lock_ioc
argument to iocg_lock/iocg_unlock.

