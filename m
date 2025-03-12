Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7B11CF8B
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788188; cv=none; b=qCkbwAViBqNoJ/uPpQj7Yi1t43wwu2obYhF468igl/OHY/SfQhDoXJij2dVsV1SfstRJXSyOGRFctYCJJiE3ICnept7B1Bn6mQIA46f+3oRmx8niAy8FVahu7cSmfIAMQbYgE/FSr/4l8PtNE2eepHawqpS3VoLARNMKSH3L9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788188; c=relaxed/simple;
	bh=QD1G8zzczPvSippQf9uKubsd+0ZgcQxoQGogWuodubk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieXlR3D8VsFi+MtRikF1a3OL12jozuE22ON8PfD6EF/Mk9hftLkEHW8jmOZT2ON+nmShPUEtq3/OigP7lO3+Jp79T4Vt7VmzZIcw2HRaM3iXSfoo0/WCLVnUcQA3jwSisgODvBQuXqF283/L0GghlvrWl2fJsOTh8vKo644LzZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A61UnpFq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A61UnpFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741788185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fm81kvL+NoiFwtFzcD75rGYjXHph/Pchbe2Xxmy0iL4=;
	b=A61UnpFq8A3BF5SfQdT7cV7TDajUpp5xUWNBQpYMIpULM69aT6PEneFuj6lYuGlfDVMM93
	JZyyFQr3WD/6R2tMIqn3qs3u+9jydvRV49LSvcQFluV0o5+gRTbXbusGYE9F5nQ3fQl4Bv
	BxPzm1SgJ3L75Narxu1RlQ+ClPWGmFE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-F6i2LB2vMeaRKI5cRejoaQ-1; Wed,
 12 Mar 2025 10:03:01 -0400
X-MC-Unique: F6i2LB2vMeaRKI5cRejoaQ-1
X-Mimecast-MFC-AGG-ID: F6i2LB2vMeaRKI5cRejoaQ_1741788180
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E15019560BC;
	Wed, 12 Mar 2025 14:03:00 +0000 (UTC)
Received: from fedora (unknown [10.72.120.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A2FA1828A95;
	Wed, 12 Mar 2025 14:02:54 +0000 (UTC)
Date: Wed, 12 Mar 2025 22:02:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kundan Kumar <kundan.kumar@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] block: fix adding folio to bio
Message-ID: <Z9GUCBzE8wtHQhFe@fedora>
References: <20250312113805.2868986-1-ming.lei@redhat.com>
 <Z9F7wOB0PqouJfss@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9F7wOB0PqouJfss@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Mar 12, 2025 at 12:19:12PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 12, 2025 at 07:38:05PM +0800, Ming Lei wrote:
> > +++ b/block/bio.c
> > @@ -1026,9 +1026,17 @@ EXPORT_SYMBOL(bio_add_page);
> >  void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
> >  			  size_t off)
> >  {
> > +	struct page *page = &folio->page;
> > +
> >  	WARN_ON_ONCE(len > UINT_MAX);
> > -	WARN_ON_ONCE(off > UINT_MAX);
> > -	__bio_add_page(bio, &folio->page, len, off);
> > +	if (unlikely(off > UINT_MAX)) {
> 
> I think we should probably make this:
> 
> 	if (unlikely(off + len > UINT_MAX))
> 
> because I'm not sure that everything will cope well with an I/O that
> crosses the 4GB boundary.

If hardware doesn't support it, the bio will be splitted before submitting
to the disk, so I think the check isn't needed here.

> 
> Actually, why bother with the conditional?  Let's just do it always.
> 
>  {
> +	unsigned long nr = off / PAGE_SIZE;
>  	WARN_ON_ONCE(len > UINT_MAX);
> -	WARN_ON_ONCE(off > UINT_MAX);
> -	__bio_add_page(bio, &folio->page, len, off);
> +	off = off % PAGE_SIZE;
> +	__bio_add_page(bio, folio_page(folio, nr), len, off);
>  }
> 
> Also you need to do bio_add_folio(), not just the _nofail variant.
 
OK, will cover bio_add_folio() in V2 by the unconditional way.


Thanks,
Ming

