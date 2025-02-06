Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E236125
	for <linux-block@vger.kernel.org>; Thu,  6 Feb 2025 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851324; cv=none; b=ZObWV/3urm4dQ27DMC31cgXEDCN2ZQmno8Jpndw+nC4zm1PTc307gnDH9Krhg/zp57SsMNfV47Imv45dMMOmEQh4ONqH54EZJk2kJmltwvsxtgQwFm5MuqSu0UFZYTJUIn3We0oEdMz6mCAu0O4r6oRwp+XpNScIA3nAAMSorAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851324; c=relaxed/simple;
	bh=KFWF/7nkLPqQqrwPAIs55g6bzdTIXPz6YDyJxE0+kis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qB8kiGPcmpcLKyvrOA2YiVfH4g0J12Ykyv2dOrPNq8Rk1Rgi86CsvbA6PDY2SGRZOlvg52yc9jezDPlKD2/E5yuB+tnNneWu4TqWDoQ5Px/WWXnXcR72PXfhQObSzGThRzyDdU+KWvDECuxNuCbwzIPapRMJZ6Cx5T5TrgvaNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F38E68D0D; Thu,  6 Feb 2025 15:15:18 +0100 (CET)
Date: Thu, 6 Feb 2025 15:15:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [PATCH 1/2] block: fix lock ordering between the queue
 ->sysfs_lock and freeze-lock
Message-ID: <20250206141518.GA3304@lst.de>
References: <20250205144506.663819-1-nilay@linux.ibm.com> <20250205144506.663819-2-nilay@linux.ibm.com> <20250205155952.GB14133@lst.de> <715ba1fd-2151-4c39-9169-2559176e30b5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <715ba1fd-2151-4c39-9169-2559176e30b5@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 06, 2025 at 06:52:36PM +0530, Nilay Shroff wrote:
> Yeah I tested with a multi namespace NVMe disk and lockdep didn't 
> complain. Agreed we need to hold up q->sysfs_lock for multiple 
> request queues at the same time and that may not be elegant, but 
> looking at the mess in __blk_mq_update_nr_hw_queues we may not
> have other choice which could help correct the lock order.

Odd, as it's usually very unhappy about nesting locks of the
same kind unless specifically annotated.

> Yes this is probably a good idea, that instead of using q->sysfs_lock 
> we may depend on q->tag_set->tag_list_lock here for sched/elevator updates
> as a fact that __blk_mq_update_nr_hw_queues already runs with tag_list_lock
> held.

Yes.

> But then it also requires using the same tag_list_lock instead of 
> current sysfs_lock while we update the scheduler from sysfs. But that's
> a trivial change.

Yes.  I think it's a good idea, but maybe wait a bit to see if Jens
or Ming also have opinions on this before starting the work.

