Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BAF1FE44E
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736929319; cv=none; b=p56r3XcDjXzrkwmlaJEf39JAcDl8rWXJM/1vIu9sp7szrLmA3OhN7+0d+0QfeRuf7hyvRx3vnmfYIt4xqe6PTwLXYg2c9r09qt+ntKO0QHD/eEKAwJZW0jzktN0CLzsFI5ufRfXIy4VqKmCZ7xF5TaT4cgJzLZZFZjiatNiMTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736929319; c=relaxed/simple;
	bh=loo3gA/0GhczaYSKb9BkG1Tyi5mJUYBaw/IyGqajmKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4MOBDZx7aPLgDDVYlSDxVQ0NrS62Tx9GopGW1IsYFo81Y1l9HA+wNgKM1m7FJe2DiE8kSuXWnq5eWKMrkLIL5qb0BRRmLHqxAKccTc2T+GFkz4bAjmS64RJ9bXOCRISfJEh/qAGkZehG+NwFmeYhUsKUAkgsnOXql2I96wdTfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HML2g0n7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HML2g0n7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736929316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mT4UfuxWDIhSR76d9aqWp2zU2HBhTq7Aj9QwW+93HUk=;
	b=HML2g0n7AgeaDknLFOfZsfrEizzJw4Sg5xfvD3Ij+AEsI0TxljSBrJO1CXBAKSrTh2t6fF
	/+Twumb885EylcTseNDTYfGxjlWFoC8DFniUpLv0AMY8c7USHnLiOcVzWxjWCLLYiZl30u
	jMuozL4/yotzXqpgvO+6OnSYeAqWpsM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-wAYsW6KDPbagUWT1w2RiEw-1; Wed,
 15 Jan 2025 03:21:52 -0500
X-MC-Unique: wAYsW6KDPbagUWT1w2RiEw-1
X-Mimecast-MFC-AGG-ID: wAYsW6KDPbagUWT1w2RiEw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9506519560B0;
	Wed, 15 Jan 2025 08:21:50 +0000 (UTC)
Received: from fedora (unknown [10.72.116.128])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D87D19560A3;
	Wed, 15 Jan 2025 08:21:45 +0000 (UTC)
Date: Wed, 15 Jan 2025 16:21:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH] loop: don't call vfs_flush() with queue frozen
Message-ID: <Z4dwFFIb6gjAa4wd@fedora>
References: <20250113022426.703537-1-ming.lei@redhat.com>
 <Z4Spc75EiBXowzMu@infradead.org>
 <Z4TNW2PYyPUqwLaD@fedora>
 <Z4TaSGZDu_B2GS1c@infradead.org>
 <Z4Tb3pmnXMk_z2Fm@fedora>
 <Z4UZ947fLqHusJzv@infradead.org>
 <Z4UsPor30ss0ML9s@fedora>
 <Z4cfVBrd9OJiYYG-@fedora>
 <Z4deHFfJ2qC8VHjT@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4deHFfJ2qC8VHjT@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Jan 14, 2025 at 11:05:00PM -0800, Christoph Hellwig wrote:
> On Wed, Jan 15, 2025 at 10:37:08AM +0800, Ming Lei wrote:
> > Actually some FSs may call kmalloc(GFP_KERNEL) with i_rwsem grabbed,
> > which could call into real deadlock if IO on the loop disk is caused by
> > the kmalloc(GFP_KERNEL).
> 
> Well, loop can always deadlock when the lower fs is doing allocations,
> even without the freeze.  I'm actually kinda surprised loop doesn't
> force a context noio as we'd really need that.

Loop does call mapping_set_gfp_mask(~(__GFP_IO|__GFP_FS)).

> 
> > > > because we're talking about different file systems instances.  The only
> > > > exception would be file systems taking global locks in the I/O path,
> > > > but I sincerely hope no one does that.
> > >  
> > > Didn't you see the report on fs_reclaim and sysfs root lock?
> > > 
> > > https://lore.kernel.org/linux-block/197b07435a736825ab40dab8d91db031c7fce37e.camel@linux.intel.com/
> > 
> > There are more, such as mm->mmap_lock[1], hfs SB 'cat_tree' lock[2]...
> > 
> > 
> > [1] https://lore.kernel.org/linux-block/67863050.050a0220.216c54.006f.GAE@google.com/
> > [2] https://lore.kernel.org/linux-block/67582202.050a0220.a30f1.01cb.GAE@google.com/
> 
> And all of these are caused by not breaking the dependency loop..

Can you share how to break the dependency? Such as fs_reclaim &
mm->mmap_lock.


Thanks,
Ming

