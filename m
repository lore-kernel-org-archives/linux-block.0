Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3141E3DE8
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788778; cv=none; b=alDTfXDH7oMdMtOtmMatPC1I2ZKeVDgHbTTkcSbsyJ7Ma2fzvCqHzwI0h4PBzxguCHz07DUFRVkGosSu8tVB8IFr4bCQ9jDubL6ycgjmismxe7RwoJDA2Lnxps/qGzAdv9hNJ8dBncA+593EizSFj8dcvdeLlmDaqshquvIKERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788778; c=relaxed/simple;
	bh=+/7AbLm/fC2Gv5bJt/sys9hAPjrlLI1mH7Uw+V3Uvbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+LPBIZmescuWCUtCncFjIc0vw0iOYAHhetWirR3+cf7UvzAmIZO1NinqZSrXFpVNLexZikR5Gwu/GQfbrvsobrNw+LDCA7oKSCj5Zwf5s7yaPgOLswL/zbnKH9HpYCwSK0hz5HyQ4p2/YqQ5/k3wD+6zhPKkp29hdKc9rF/bJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7B3B768BFE; Wed, 12 Mar 2025 15:12:51 +0100 (CET)
Date: Wed, 12 Mar 2025 15:12:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCH] block: protect debugfs attributes using
 q->elevator_lock
Message-ID: <20250312141251.GA13250@lst.de>
References: <20250312102903.3584358-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312102903.3584358-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 12, 2025 at 03:58:38PM +0530, Nilay Shroff wrote:
> Additionally, debugfs attribute "busy" is currently unprotected. This
> attribute iterates over all started requests in a tagset and prints them. 
> However, the tags can be updated simultaneously via the sysfs attribute 
> "nr_requests" or "scheduler" (elevator switch), leading to potential race 
> conditions. Since the sysfs attributes "nr_requests" and "scheduler" are 
> already protected using q->elevator_lock, extend this protection to the 
> debugfs "busy" attribute as well.

I'd split that into a separate patch for bisectability.

>  	struct show_busy_params params = { .m = m, .hctx = hctx };
> +	int res;
>  
> +	res = mutex_lock_interruptible(&hctx->queue->elevator_lock);
> +	if (res)
> +		goto out;

Is mutex_lock_interruptible really the right primitive here?  We don't
really want this read system call interrupted by random signals, do
we?  I guess this should be mutex_lock_killable.

(and the same for the existing methods this is copy and pasted from).

>  	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy_rq,
>  				&params);
> -
> -	return 0;
> +	mutex_unlock(&hctx->queue->elevator_lock);
> +out:
> +	return res;

And as Damien already said, no need for the labels here, including for
the existing code.  That should probably be alsot changed in an extra
patch for the existing code while you're at it.

