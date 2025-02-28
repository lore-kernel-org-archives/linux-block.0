Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694FB214A8C
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731382; cv=none; b=Wwp6r8g97gGAhNT/OTWutzBtufAgPZSbzwTY2puQNwykAMLc94NMiiMSFtxkAPv26nGs2M/CcCPA2MmXO55o1runNGKU1ztAV2BiToJHwIG/WeHj8GHaSqU4v2d7crkJpPdFww/kmSRnLOcvSCSaI5BpxGwSjMjXHB2qrvVeP5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731382; c=relaxed/simple;
	bh=5bcbXVf3/mj4OuUkP4c8sx/6U7HQJRql+qIMKa6mQHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvrVX2qhlUf0/LJObdSa6nlxXaqMtrLPBMp0Daa3FQCpQocYNztvUYHJNr5embLU3LzUdyVqDIDXsz7UVSQix0kLxWXf+nyJFLzbKcnJE4yObZ604HG0fJitB5sKhL32XULcqXLnTTK9hNMN+ZV2wEi/Qs4XT0j4xPtGlG+JFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4LwH945; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4LwH945"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740731379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I2GfZMWZwPpdBCz8AaKrxuNy6gNJlHvhcbiQhGSTizY=;
	b=U4LwH945yW3YPbmswx7i7MijsMaUSjKbASAs4w7vO7gcCQut5jkHzna1BzNhf2ww6Ii0yU
	sX+qoXbdgh5Zp5T56fo8seOSOlLVejKjGqn4su/+zFyb/45nB89Znc7URJwh4i4FiKGxjG
	t7qFF0ad/gbVBTUr59UkB4rnf8EdRA0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-6mSm8pezN4u0ABweKpANnw-1; Fri,
 28 Feb 2025 03:29:35 -0500
X-MC-Unique: 6mSm8pezN4u0ABweKpANnw-1
X-Mimecast-MFC-AGG-ID: 6mSm8pezN4u0ABweKpANnw_1740731374
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF7541944EB2;
	Fri, 28 Feb 2025 08:29:33 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87CFA1944D02;
	Fri, 28 Feb 2025 08:29:28 +0000 (UTC)
Date: Fri, 28 Feb 2025 16:29:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, dlemoal@kernel.org,
	hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv5 1/7] block: acquire q->limits_lock while reading sysfs
 attributes
Message-ID: <Z8Fz4lWp94IRl-qA@fedora>
References: <20250226124006.1593985-1-nilay@linux.ibm.com>
 <20250226124006.1593985-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226124006.1593985-2-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Feb 26, 2025 at 06:09:54PM +0530, Nilay Shroff wrote:
> There're few sysfs attributes(RW) whose store method is protected
> with q->limits_lock, however the corresponding show method of these
> attributes run holding q->sysfs_lock and that doesn't make sense
> as ideally the show method of these attributes should also run
> holding q->limits_lock instead of q->sysfs_lock. Hence update the
> show method of these sysfs attributes so that reading of these
> attributes acquire q->limits_lock instead of q->sysfs_lock.
> 
> Similarly, there're few sysfs attributes(RO) whose show method is
> currently protected with q->sysfs_lock however updates to these
> attributes could occur using atomic limit update APIs such as queue_
> limits_start_update() and queue_limits_commit_update() which run
> holding q->limits_lock. So that means that reading these attributes
> holding q->sysfs_lock doesn't make sense. Hence update the show method
> of these sysfs attributes(RO) such that they run with holding q->
> limits_lock instead of q->sysfs_lock.
> 
> We have defined a new macro QUEUE_LIM_RO_ENTRY() which uses new ->show_
> limit() method and it runs holding q->limits_lock. All existing sysfs
> attributes(RO) which needs protection using q->limits_lock while
> reading have been now updated to use this new macro for initialization.
> 
> Also, the existing QUEUE_LIM_RW_ENTRY() is updated to use new ->show_
> limit() method for reading attributes instead of existing ->show()
> method. As ->show_limit() runs holding q->limits_lock, the existing
> sysfs attributes(RW) requiring protection are now inherently protected
> using q->limits_lock instead of q->sysfs_lock.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

