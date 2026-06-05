Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3533426EB9
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642250; cv=none; b=Z5mTNMXBBfO7w/AL/e9fkFKSERCnrOwfRC8k9TGcI1ucefN5ofGy+i5zdTTmBJQrSaSnDgpRg0no7KGRw3tfZyQhdDHo86glb3HLVY13X/QT4uP59P4C9yjQ+e2mI270b+yUnBuKXJamPm0RMTMmvCQp3q8wSD86nXLtYE+AD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642250; c=relaxed/simple;
	bh=eJZEjgLz+DSixItJhKZfldoHhyP8N9TOAbe8ZItaWbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVt9nN7KpSaHg8EqgOiv68CQVkqez5ke3h+v9fB+RDSFuo6TS08414p38WV0pcbNEeLY5b4NnTVd1sd3/LuYZhGmJya3/fINXEn0+fi2MGWIlsyKr3b9p0pbj/6GXf8wtnfqr9wyrgR0CVABQSTdI6U9erYtpPhvinCE7AyWaXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0AF4668AFE; Fri,  5 Jun 2026 08:50:43 +0200 (CEST)
Date: Fri, 5 Jun 2026 08:50:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v6 10/14] block/blk-iocost: Inline iocg_lock() and
 iocg_unlock()
Message-ID: <20260605065042.GD26230@lst.de>
References: <cover.1780419600.git.bvanassche@acm.org> <e0e81fbd746bfb54c31cb84f8671a0c23dcdedb2.1780419600.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0e81fbd746bfb54c31cb84f8671a0c23dcdedb2.1780419600.git.bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 02, 2026 at 10:07:39AM -0700, Bart Van Assche wrote:
> +	if (ioc_locked) {
> +		guard(spinlock_irqsave)(&iocg->ioc->lock);
> +		guard(spinlock)(&iocg->waitq.lock);
> +		action = iocg_handle_over_budget(rqos, iocg, bio, &now, &wait,
> +						 use_debt, ioc_locked, abs_cost,
> +						 cost);
> +	} else {
> +		guard(spinlock_irqsave)(&iocg->waitq.lock);
> +		action = iocg_handle_over_budget(rqos, iocg, bio, &now, &wait,
> +						 use_debt, ioc_locked, abs_cost,
> +						 cost);

Please avoid the undebuggable guard mess.  This is a lot more readable with
good old locking calls.

