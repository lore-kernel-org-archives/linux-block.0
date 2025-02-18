Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EB6238D42
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886319; cv=none; b=i+1LythJvcdNWbXmaBhIcybQdGOFLnzJ/AABa+F0HiERy5h9f9BTfLXMTTdnBigMOMwEAMawhbGHOytqnrJ0Pr/sBCQc8PkkTZ/W4ldnYVm5w8UTiFPam2+qfM/I0WI4pY39VMp8n+RoO+3i7n+Xsnda9ix2uSLKRGhV+/BCwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886319; c=relaxed/simple;
	bh=4kSPPM0+7cScqNkIomts6ERDyQQQtX4B4ZzvWA9Xblg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM1u3NXJUhdCUAu4aoLvQi4PJIOxuxvCOVM7GYCSL4QgeqPTaXMLMVC0d/Er++BbWLXLkatmW8td43VPqObSCvpReY92aNRoEm3r+V9pNndMf52FHf6+t+xIXiksDS5ExXoZjC8UXg8okO8e/HgVkNWCsIH+lf088vGasjvXJ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNFXMwxy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNFXMwxy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739886316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xClrP4mHwc2pJpQJjFCUMmV3lTp8bOBuj7X43hnPjmQ=;
	b=BNFXMwxyF83PdxlTCGqg9+5BVCAj5xhvmT+dYx4WNI0w6pdu3MR9bHUqCHUUZyMMxtn3s5
	2bQzxOnMc/QeQsJkhE6J+1djvzMe/YYsGl7FheyVxK5s1CZTllA6UjnsBfwFzJZMkCYDLX
	nR9hj711ZBOFR68H+Fm7t6FS8LnqFNs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-v38GKjS4Px2ShTSP92MjSg-1; Tue,
 18 Feb 2025 08:45:15 -0500
X-MC-Unique: v38GKjS4Px2ShTSP92MjSg-1
X-Mimecast-MFC-AGG-ID: v38GKjS4Px2ShTSP92MjSg_1739886314
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD52319373C4;
	Tue, 18 Feb 2025 13:45:13 +0000 (UTC)
Received: from fedora (unknown [10.72.120.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D80E1956048;
	Tue, 18 Feb 2025 13:45:08 +0000 (UTC)
Date: Tue, 18 Feb 2025 21:45:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, dlemoal@kernel.org,
	axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
Message-ID: <Z7SO3lPfTWdqneqA@fedora>
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-2-nilay@linux.ibm.com>
 <Z7R4sBoVnCMIFYsu@fedora>
 <5b240fe8-0b67-48aa-8277-892b3ab7e9c5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b240fe8-0b67-48aa-8277-892b3ab7e9c5@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Feb 18, 2025 at 06:41:06PM +0530, Nilay Shroff wrote:
> 
> 
> On 2/18/25 5:40 PM, Ming Lei wrote:
> > On Tue, Feb 18, 2025 at 01:58:54PM +0530, Nilay Shroff wrote:
> >> There're few sysfs attributes in block layer which don't really need
> >> acquiring q->sysfs_lock while accessing it. The reason being, writing
> >> a value to such attributes are either atomic or could be easily
> >> protected using WRITE_ONCE()/READ_ONCE(). Moreover, sysfs attributes
> >> are inherently protected with sysfs/kernfs internal locking.
> >>
> >> So this change help segregate all existing sysfs attributes for which 
> >> we could avoid acquiring q->sysfs_lock. We group all such attributes,
> >> which don't require any sorts of locking, using macro QUEUE_RO_ENTRY_
> >> NOLOCK() or QUEUE_RW_ENTRY_NOLOCK(). The newly introduced show/store 
> >> method (show_nolock/store_nolock) is assigned to attributes using these 
> >> new macros. The show_nolock/store_nolock run without holding q->sysfs_
> >> lock.
> >>
> >> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> >> ---
> > 
> > ...
> > 
> >>  
> >> +#define QUEUE_RO_ENTRY_NOLOCK(_prefix, _name)			\
> >> +static struct queue_sysfs_entry _prefix##_entry = {		\
> >> +	.attr		= {.name = _name, .mode = 0644 },	\
> >> +	.show_nolock	= _prefix##_show,			\
> >> +}
> >> +
> >> +#define QUEUE_RW_ENTRY_NOLOCK(_prefix, _name)			\
> >> +static struct queue_sysfs_entry _prefix##_entry = {		\
> >> +	.attr		= {.name = _name, .mode = 0644 },	\
> >> +	.show_nolock	= _prefix##_show,			\
> >> +	.store_nolock	= _prefix##_store,			\
> >> +}
> >> +
> >>  #define QUEUE_RW_ENTRY(_prefix, _name)			\
> >>  static struct queue_sysfs_entry _prefix##_entry = {	\
> >>  	.attr	= { .name = _name, .mode = 0644 },	\
> >> @@ -446,7 +470,7 @@ QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
> >>  QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
> >>  QUEUE_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
> >>  QUEUE_LIM_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
> >> -QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
> >> +QUEUE_RO_ENTRY_NOLOCK(queue_discard_zeroes_data, "discard_zeroes_data");
> > 
> > I think all QUEUE_RO_ENTRY needn't sysfs_lock, why do you just convert
> > part of them?
> > 
> I think we have few read-only attributes which still need protection
> using q->limits_lock. So if you refer 2nd patch in the series then you'd
> find it. In this patch we group only attributes which don't require any
> locking and grouped them under show_nolock/store_nolock.

IMO, this RO attributes needn't protection from q->limits_lock:

- no lifetime issue

- in-tree code needn't limits_lock.

- all are scalar variable, so the attribute itself is updated atomically

- the limits still may be updated after lock is released

So what do you want to protect on these RO attributes? My concern is
that it is too complicated to maintain multiple versions of such macro.


Thanks,
Ming

