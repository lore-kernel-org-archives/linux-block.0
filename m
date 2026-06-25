Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6F3B42E2
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782388356; cv=none; b=mXdlYeVnGQaOzTXcO0yUbH4jlDRcg4wdoowALNflxiA0IY+DPxLUCF3j7ZzVu+SHIcg4LrNoKdzKPZnc/+EiJ1f9k2VcKde8RBdqvops4I66Cd83Ejd5gmPJQM2Wj/I/tJILZhOOx7WyhRfZkkjWBQCdYOJZCIZyLQKG3bMyeZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782388356; c=relaxed/simple;
	bh=DpcZ9sNtZyx/camiMUnaVV7BFk0NnlJTJ2c1VyWTDaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaRUKsS6jLVaeaVPQ7wvJMZMPpVe5bBdutIcNuNMgWiJEeTLQUcAEGeKsuchHlc1xB5WhxbhLfMj8gpIiYuOea6G/tnFKm6+Zi0iS/Avt/hZwetpgJV9J9jZs5ZUVy4gzVSy+nV9Miw8MMtAIAUuLFFYXbFI9GEFVJB9vC7f/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5A08768B05; Thu, 25 Jun 2026 13:52:32 +0200 (CEST)
Date: Thu, 25 Jun 2026 13:52:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: avoid potential deadlock on zone revalidation
 failure
Message-ID: <20260625115232.GC18076@lst.de>
References: <20260625062824.2013244-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625062824.2013244-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 25, 2026 at 03:28:24PM +0900, Damien Le Moal wrote:

[very long lockdep trace]

> +	/*
> +	 * We may already have a zone write plug workqueue as this function may
> +	 * be called after disk_free_zone_resources(), which does not destroy
> +	 * the workqueue (the zone write plugs workqueue is destroyed at
> +	 * disk_release() time).
> +	 */
> +	if (!disk->zone_wplugs_wq) {

Can't we just allocate this at add_disk time instead of the magic NULL
check here to mirror the freeing side?

