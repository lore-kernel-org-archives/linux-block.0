Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5086C1E1E0E
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037063; cv=none; b=bLIWQ4wP0BvmfLTD/6nOrA5qn/185Q/0oIsK7kbsFDeJ0Jg4oCkCfcFPHRN7IJuLPTzzfRFjPy8ou3YkcP9KMs6gvorGLk0X2WfhFi+3YiOTG+1I/nWlpojHl4L3G7FSmqJ3tHHKmtFBeFe4r7VRtdelFlH/MClVRli09H9aGT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037063; c=relaxed/simple;
	bh=iXj8fhp2iTTCZK4DuWqXbJ8yP1ZpZZ9p+7SSPqnYNIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaNR32916SeE/B4jsahyaMwNd2sUjSuKfoDVxu2nKhRGwm8HaZOdnYj8GJ2QTaX8OGAUbnLZKI50alE+Es0Rckx/TZe2OPTDoySIWB2uFELn/BKvW3mkJPGTE2+bUSvrcmpciFOGApwAcaS3k0vp8yaom6emW1O3SUXbbexVr84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C9A367373; Mon,  7 Apr 2025 16:44:14 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:44:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
	jmeneghi@redhat.com, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [RFC PATCH 1/2] nvme-multipath: introduce delayed removal of
 the multipath head node
Message-ID: <20250407144413.GA12216@lst.de>
References: <20250321063901.747605-1-nilay@linux.ibm.com> <20250321063901.747605-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321063901.747605-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> @@ -3690,6 +3690,10 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
>  	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
>  	kref_init(&head->ref);
> +#ifdef CONFIG_NVME_MULTIPATH
> +	if (ctrl->ops->flags & NVME_F_FABRICS)
> +		set_bit(NVME_NSHEAD_FABRICS, &head->flags);
> +#endif

We might want to make the flags unconditional or move this into a helper
to avoid the ifdef'ery if we keep the flag (see below).

> -	if (last_path)
> -		nvme_mpath_shutdown_disk(ns->head);
> +	nvme_mpath_shutdown_disk(ns->head);

I guess this function is where the shutdown naming came from, and it
probably was a bad idea even back then..

Maybe throw in an extra patch to rename it as well.

> +	/*
> +	 * For non-fabric controllers we support delayed removal of head disk
> +	 * node. If we reached up to here then it means that head disk is still
> +	 * alive and so we assume here that even if there's no path available
> +	 * maybe due to the transient link failure, we could queue up the IO
> +	 * and later when path becomes ready we re-submit queued IO.
> +	 */
> +	if (!(test_bit(NVME_NSHEAD_FABRICS, &head->flags)))
> +		return true;

Why is this conditional on fabrics or not?  The same rationale should
apply as much if not more for fabrics controllers.

Also no need for the set of braces around the test_bit() call.

>  }
>  
> +static void nvme_remove_head(struct nvme_ns_head *head)
> +{
> +	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> +		/*
> +		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
> +		 * to allow multipath to fail all I/O.
> +		 */

Full sentence are supposed to start with a capitalized word.

(yes, I saw this just move, but it's a good chance to fix it)

