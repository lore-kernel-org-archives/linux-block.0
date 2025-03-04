Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772A1519AC
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051865; cv=none; b=p5CiSJa7lezDclCyDkWiEMuaD7/SstiOABkpRaYdOH2/8g+hO04PKGBfIrVnT4BZXk4QucY1wGkA9wG4yW8LiZlVwg+QpbBVznJsWt2BH0YVyMsutfVzEMEx6tvcfjU535rfmAz3Tw6aC+XXzOet6ZKq4JTbifBSd1ACazRuzAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051865; c=relaxed/simple;
	bh=UlcHHeZ+Fqyg6F2Ylmgz68Q1YBYBf3lVcbN39KOCW9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pO4KQOD93EcqCcpocU4f1V7jOOl82Sg/IuQYXaDUxnK8zPPHi7q8oPXSJLP6XDnbUTdWXoyr0M7K5n0g9rkSU3BgC5PMTFZy0FgQPCBxWf7lYj1yvPqBf3MlVc/CyRyR/IxuehHtFOvczxz65QEpMdH7nzsEYKFTUy1jbl1JeMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KAYyJfXx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAYyJfXx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741051859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQxhV9x1rq0N0c9I3O2cIWOSyfRotx2cKActdfBAPbk=;
	b=KAYyJfXx5+S5BwSOBKmA0TJqXKbsrtSeRxUJwbuYEFgDeMRIOO3Cvvcf8uv+dnAya2PMCj
	289Yba06LkGdaAujseckme045ud41Dm1QdSLvigcs9d1Alje2M5Ij+RwTtDOl8KQcqpfPU
	GQ635pCeoFdnOJ/E5s9bwmbCeYjtt+o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-lsLcIlGCOeucfjOpc2GnFQ-1; Mon,
 03 Mar 2025 20:30:48 -0500
X-MC-Unique: lsLcIlGCOeucfjOpc2GnFQ-1
X-Mimecast-MFC-AGG-ID: lsLcIlGCOeucfjOpc2GnFQ_1741051847
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 855F318009A7;
	Tue,  4 Mar 2025 01:30:46 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DF8619560AA;
	Tue,  4 Mar 2025 01:30:39 +0000 (UTC)
Date: Tue, 4 Mar 2025 09:30:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Guangwu Zhang <guazhang@redhat.com>
Subject: Re: [PATCH] block: fix 'kmem_cache of name 'bio-108' already exists'
Message-ID: <Z8ZXuvo_Tx4EdLML@fedora>
References: <20250228132656.2838008-1-ming.lei@redhat.com>
 <Z8XNNosGwI8wGJ0x@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8XNNosGwI8wGJ0x@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Mar 03, 2025 at 07:39:34AM -0800, Christoph Hellwig wrote:
> On Fri, Feb 28, 2025 at 09:26:56PM +0800, Ming Lei wrote:
> > Device mapper bioset often has big bio_slab size, which can be more than
> > 1000, then 8byte can't hold the slab name any more, cause the kmem_cache
> > allocation warning of 'kmem_cache of name 'bio-108' already exists'.
> > 
> > Fix the warning by extending bio_slab->name to 12 bytes, but fix output
> > of /proc/slabinfo
> > 
> > Reported-by: Guangwu Zhang <guazhang@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/bio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index f0c416e5931d..6ac5983ba51e 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -77,7 +77,7 @@ struct bio_slab {
> >  	struct kmem_cache *slab;
> >  	unsigned int slab_ref;
> >  	unsigned int slab_size;
> > -	char name[8];
> > +	char name[12];
> 
> Can you please turn this into a pointer and use kasprintf to fill
> it?  That way we fix the string overflow problem for real and don't
> need to doctor around it the next time someone uses names with a
> longer name.

There isn't the overflow problem, please see create_bio_slab(), which
calls snprintf() to fill the ->name[].

Also extra 4byte can support bio size of ~10^7, which is big enough as
block layer API.


Thanks,
Ming

