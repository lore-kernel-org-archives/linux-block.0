Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537CB1DEFF9
	for <linux-block@vger.kernel.org>; Fri,  7 Feb 2025 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929559; cv=none; b=C4GLMlegulsG5zZKfGarjb6gU0+iDVO/E/KSro4J9BGPfDe4J+d9/lIRYwWs/vOSPggJjE9q7MNRY1gIj9RHz5a40tCyUlTLmIbQ7L6ePbPPvtLW1remkqfd3XU0Cy3F8R7yzRZyn+Ys8XucnOqsP+sBFXsXxkvbqJ0iQUx15Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929559; c=relaxed/simple;
	bh=EGLvOxea/bbwdHXvx2vmZ8TwDxiD9pYbjg/DjRJjDeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTNlZmgz/ZdYPoy0akr6iF8zRra+/zxLo3a/E5fiKAps6An13nQzBSNMDlohE7Coobj0nBeNZrDZCIhRJXfzFPcegUprPxXfZD7MJZvSWrEzAEWZLIZN2MYSTd1ITY+JzYi838kQyiv2pdeuXfVrezJFXOBBq+UEPNRw/dyEUn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0lgA+SW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0lgA+SW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738929556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdchJ/Yo252lOV/yZLbH26/tXTC4OW+0Za5Nyfo6tRM=;
	b=F0lgA+SWaIptBO1TFfcv98iKGPplzwJjnSF1ftBtBvE2mp+3Ph7ccsMbS15vOXsxJjXukO
	bEbMtrwuGWt1xe7Na+KAsDCKRyHfG/Nzhd1mRXneaqL5EaPMFRFUDDAFHqZ8/awG0mbERV
	6p59Nwzkg0L/hDkmXx86eiP7zW/jLzk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-W_i3cq0JM7GlqbUZEUglfA-1; Fri,
 07 Feb 2025 06:59:12 -0500
X-MC-Unique: W_i3cq0JM7GlqbUZEUglfA-1
X-Mimecast-MFC-AGG-ID: W_i3cq0JM7GlqbUZEUglfA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A7961956096;
	Fri,  7 Feb 2025 11:59:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.158])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF2A31800872;
	Fri,  7 Feb 2025 11:59:06 +0000 (UTC)
Date: Fri, 7 Feb 2025 19:59:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCH 1/2] block: fix lock ordering between the queue
 ->sysfs_lock and freeze-lock
Message-ID: <Z6X1hbzI4euK_r-S@fedora>
References: <20250205144506.663819-1-nilay@linux.ibm.com>
 <20250205144506.663819-2-nilay@linux.ibm.com>
 <20250205155952.GB14133@lst.de>
 <715ba1fd-2151-4c39-9169-2559176e30b5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <715ba1fd-2151-4c39-9169-2559176e30b5@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Feb 06, 2025 at 06:52:36PM +0530, Nilay Shroff wrote:
> 
> 
> On 2/5/25 9:29 PM, Christoph Hellwig wrote:
> > On Wed, Feb 05, 2025 at 08:14:47PM +0530, Nilay Shroff wrote:
> >>  
> >>  static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> >> @@ -5006,8 +5008,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> >>  		return;
> >>  
> >>  	memflags = memalloc_noio_save();
> >> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> >> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> >> +		mutex_lock(&q->sysfs_lock);
> > 
> > This now means we hold up to number of request queues sysfs_lock
> > at the same time.  I doubt lockdep will be happy about this.
> > Did you test this patch with a multi-namespace nvme device or
> > a multi-LU per host SCSI setup?
> > 
> Yeah I tested with a multi namespace NVMe disk and lockdep didn't 
> complain. Agreed we need to hold up q->sysfs_lock for multiple 
> request queues at the same time and that may not be elegant, but 
> looking at the mess in __blk_mq_update_nr_hw_queues we may not
> have other choice which could help correct the lock order.

All q->sysfs_lock instance actually shares same lock class, so this way
should have triggered double lock warning, please see mutex_init().

The ->sysfs_lock involved in this patch looks only for sync elevator
switch with reallocating hctxs, so I am wondering why not add new
dedicated lock for this purpose only?

Then we needn't to worry about its dependency with q->q_usage_counter(io)?

Thanks,
Ming

