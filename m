Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661B226A08A
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762996921; cv=none; b=HL06PjPdbSl6Mgj6G1618+uTAINPP8EE8AJbpVuYYkUINiIB3lDc+L79EVSZBtEdlw5JqUU6OCxJyYPXy3uIA4iDiEfXx8OcXJq2m3OmMceZBJW4+KM5kAHU0dJXs1t4ocWtYBfQgwJSUeMIocH1nl5R+CTAKAR2lHAJuCG1rq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762996921; c=relaxed/simple;
	bh=VCU/UpThEEuUSJvH8oUai1bQrxsdrYWG4fWskAwTNYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2fsWGkXKvk1UpOOQAU5k/lq0mZeF+KFwrF9W5+YJuM5wLfARxosAurA8bHN5AKoXuP1s8cuX6QI72Sxf2eeN1kk4mqtSorXhcGuX6+y4Abu3iAXExOCKT4eBFEJVeGd9ehoOjQYSVGcYXCu8J7YWF59wXCvq+zhCg9hxuSKYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WlCTKE4m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlCTKE4m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762996917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EgETUmOyvY3UMMPLegrObzK3nipblxlLivW6LyEucSY=;
	b=WlCTKE4mPww1w3gRMjBtTCqccM0SivVzgKT9pjlt4FXYCipVfI1hWG9+MhnUu5fINcT7ha
	cMmTf+M483gWDnW7i/KblDrzXj7VjLSUMOzBj4jt59s68QZinMX4F0zPiLDIv8uPesbP6z
	tl+PIqYeCqTkZAAftAtQtlB9qkRlF6k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-_fY0jWUGNbGBk0Lg9Dsjmg-1; Wed,
 12 Nov 2025 20:21:54 -0500
X-MC-Unique: _fY0jWUGNbGBk0Lg9Dsjmg-1
X-Mimecast-MFC-AGG-ID: _fY0jWUGNbGBk0Lg9Dsjmg_1762996913
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 438921956050;
	Thu, 13 Nov 2025 01:21:52 +0000 (UTC)
Received: from fedora (unknown [10.72.116.134])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DD591955F1A;
	Thu, 13 Nov 2025 01:21:46 +0000 (UTC)
Date: Thu, 13 Nov 2025 09:21:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 01/27] kfifo: add kfifo_alloc_node() helper for NUMA
 awareness
Message-ID: <aRUypQzcovGikrV0@fedora>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
 <20251112093808.2134129-2-ming.lei@redhat.com>
 <20251112112914.459baa16c4e9117d67f53011@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112112914.459baa16c4e9117d67f53011@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Nov 12, 2025 at 11:29:14AM -0800, Andrew Morton wrote:
> On Wed, 12 Nov 2025 17:37:39 +0800 Ming Lei <ming.lei@redhat.com> wrote:
> 
> > Add __kfifo_alloc_node() by refactoring and reusing __kfifo_alloc(),
> > and define kfifo_alloc_node() macro to support NUMA-aware memory
> > allocation.
> > 
> > The new __kfifo_alloc_node() function accepts a NUMA node parameter
> > and uses kmalloc_array_node() instead of kmalloc_array() for
> > node-specific allocation. The existing __kfifo_alloc() now calls
> > __kfifo_alloc_node() with NUMA_NO_NODE to maintain backward
> > compatibility.
> > 
> > This enables users to allocate kfifo buffers on specific NUMA nodes,
> > which is important for performance in NUMA systems where the kfifo
> > will be primarily accessed by threads running on specific nodes.
> 
> I was about to ask "please don't add infrastructure without users", but
> I see a "01/27" there.  I wander over to lkml but I can't find 02-27
> there either.  Maybe something went wrong.

It can be found in lore:

https://lore.kernel.org/all/20251112093808.2134129-1-ming.lei@redhat.com/

> 
> I prefer to be cc'ed on the entire series, please.

OK.

> 
> > --- a/include/linux/kfifo.h
> > +++ b/include/linux/kfifo.h
> > @@ -369,6 +369,30 @@ __kfifo_int_must_check_helper( \
> >  }) \
> >  )
> >  
> > +/**
> > + * kfifo_alloc_node - dynamically allocates a new fifo buffer on a NUMA node
> > + * @fifo: pointer to the fifo
> > + * @size: the number of elements in the fifo, this must be a power of 2
> > + * @gfp_mask: get_free_pages mask, passed to kmalloc()
> > + * @node: NUMA node to allocate memory on
> > + *
> > + * This macro dynamically allocates a new fifo buffer with NUMA node awareness.
> > + *
> > + * The number of elements will be rounded-up to a power of 2.
> > + * The fifo will be release with kfifo_free().
> > + * Return 0 if no error, otherwise an error code.
> > + */
> > +#define kfifo_alloc_node(fifo, size, gfp_mask, node) \
> > +__kfifo_int_must_check_helper( \
> > +({ \
> > +	typeof((fifo) + 1) __tmp = (fifo); \
> > +	struct __kfifo *__kfifo = &__tmp->kfifo; \
> > +	__is_kfifo_ptr(__tmp) ? \
> > +	__kfifo_alloc_node(__kfifo, size, sizeof(*__tmp->type), gfp_mask, node) : \
> > +	-EINVAL; \
> > +}) \
> > +)
> 
> Well this is an eyesore.  Do we really need it?  It seems to be here so
> we can check for a programming bug?  Well, don't add programming bugs!
> 
> I'm actually not enjoying the existence of __is_kfifo_ptr() at all. 
> What  is it all doing?  It's a FIFO for heck's sake, why is this so hard.

It is basically a clone of existing kfifo_alloc().

Do we need to clean kfifo_alloc() first? Otherwise I'd keep the same
pattern with existing definitions.

> 
> > @@ -902,6 +926,9 @@ __kfifo_uint_must_check_helper( \
> >  extern int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
> >  	size_t esize, gfp_t gfp_mask);
> >  
> > +extern int __kfifo_alloc_node(struct __kfifo *fifo, unsigned int size,
> > +	size_t esize, gfp_t gfp_mask, int node);
> > +
> 
> Nit: please align things like this:
> 
> extern int __kfifo_alloc_node(struct __kfifo *fifo, unsigned int size,
> 			      size_t esize, gfp_t gfp_mask, int node);

OK.

Thanks,
Ming

