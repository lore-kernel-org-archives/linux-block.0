Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D44274B2E
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763294416; cv=none; b=jv6mjn23owp3HMo5CEn606ws7WLvEjl+U68QN89qpQ4JHWEqs7cIvCcFQyX+gYAb+8iMxw7vw7FE2ILW76PXxhaZfnMpdF8JJfWYJ7uV+rhPMR+Qkc2Q4rGO8LxU80Kv3E2Z/ZZy8grWXVCHtlvAwF/IENPsLx9nEls3u90p9AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763294416; c=relaxed/simple;
	bh=UgifHQykeZ4ZMomR6gat/PeqqB4CWvAk/5DKHEuEwgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuOptOrlV1q5GDOF1KvJNIcb1WJtySxVyTqQWK6a0CZdNzHIYJrFxEBJPT+lw3URF+dmwDIo5ttxSvtDBc/R6glGprkejVZbQikqMmBwTDqnpMdufcBHUxPHTUc0R32iz8b3C/1RkIoMAG3dw9MHrGloa9munT/6M6AYjcQV6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmhFZddx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmhFZddx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763294413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/S7mZMjOJf0NUeuKlTCB8fNClaQ105nEL4CD3u5Bc08=;
	b=TmhFZddx6N7jRsmMW2BqQpxlScq8tqsuej1sTtL77m6j++M9k6307Ibr+5jTkH0KJXjuaV
	DAiQSm6pxPylobgnKiieb5R/bbhwMeMSQJZdyqWtZ+SNAM/mNR99YKiwExpuOxDdpH9SsT
	hNM5s3oHNfVlX1fVfh19vMVrm60IUMU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-xoM1WJIKNp2vr8fOQjuANg-1; Sun,
 16 Nov 2025 07:00:10 -0500
X-MC-Unique: xoM1WJIKNp2vr8fOQjuANg-1
X-Mimecast-MFC-AGG-ID: xoM1WJIKNp2vr8fOQjuANg_1763294408
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8586218AB400;
	Sun, 16 Nov 2025 12:00:07 +0000 (UTC)
Received: from fedora (unknown [10.72.116.55])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E002319560A7;
	Sun, 16 Nov 2025 11:59:59 +0000 (UTC)
Date: Sun, 16 Nov 2025 19:59:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 01/27] kfifo: add kfifo_alloc_node() helper for NUMA
 awareness
Message-ID: <aRm8sDRh2UEjpYH_@fedora>
References: <20251112093808.2134129-1-ming.lei@redhat.com>
 <20251112093808.2134129-2-ming.lei@redhat.com>
 <CADUfDZrSO5eAwzjzedMf1gHTUv3Bv7JPL-nspqQG4bQE+F=6XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrSO5eAwzjzedMf1gHTUv3Bv7JPL-nspqQG4bQE+F=6XA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Nov 14, 2025 at 08:14:29PM -0800, Caleb Sander Mateos wrote:
> On Wed, Nov 12, 2025 at 1:38 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
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
> >
> > Cc: Stefani Seibold <stefani@seibold.net>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  include/linux/kfifo.h | 27 +++++++++++++++++++++++++++
> >  lib/kfifo.c           | 13 ++++++++++---
> >  2 files changed, 37 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
> > index fd743d4c4b4b..61d1fe014a6c 100644
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
> > +       typeof((fifo) + 1) __tmp = (fifo); \
> > +       struct __kfifo *__kfifo = &__tmp->kfifo; \
> > +       __is_kfifo_ptr(__tmp) ? \
> > +       __kfifo_alloc_node(__kfifo, size, sizeof(*__tmp->type), gfp_mask, node) : \
> > +       -EINVAL; \
> > +}) \
> > +)
> > +
> >  /**
> >   * kfifo_free - frees the fifo
> >   * @fifo: the fifo to be freed
> > @@ -902,6 +926,9 @@ __kfifo_uint_must_check_helper( \
> >  extern int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
> >         size_t esize, gfp_t gfp_mask);
> >
> > +extern int __kfifo_alloc_node(struct __kfifo *fifo, unsigned int size,
> > +       size_t esize, gfp_t gfp_mask, int node);
> > +
> >  extern void __kfifo_free(struct __kfifo *fifo);
> >
> >  extern int __kfifo_init(struct __kfifo *fifo, void *buffer,
> > diff --git a/lib/kfifo.c b/lib/kfifo.c
> > index a8b2eed90599..195cf0feecc2 100644
> > --- a/lib/kfifo.c
> > +++ b/lib/kfifo.c
> > @@ -22,8 +22,8 @@ static inline unsigned int kfifo_unused(struct __kfifo *fifo)
> >         return (fifo->mask + 1) - (fifo->in - fifo->out);
> >  }
> >
> > -int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
> > -               size_t esize, gfp_t gfp_mask)
> > +int __kfifo_alloc_node(struct __kfifo *fifo, unsigned int size,
> > +               size_t esize, gfp_t gfp_mask, int node)
> >  {
> >         /*
> >          * round up to the next power of 2, since our 'let the indices
> > @@ -41,7 +41,7 @@ int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
> >                 return -EINVAL;
> >         }
> >
> > -       fifo->data = kmalloc_array(esize, size, gfp_mask);
> > +       fifo->data = kmalloc_array_node(esize, size, gfp_mask, node);
> >
> >         if (!fifo->data) {
> >                 fifo->mask = 0;
> > @@ -51,6 +51,13 @@ int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
> >
> >         return 0;
> >  }
> > +EXPORT_SYMBOL(__kfifo_alloc_node);
> > +
> > +int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
> > +               size_t esize, gfp_t gfp_mask)
> > +{
> > +       return __kfifo_alloc_node(fifo, size, esize, gfp_mask, NUMA_NO_NODE);
> > +}
> >  EXPORT_SYMBOL(__kfifo_alloc);
> 
> Is it worth keeping __kfifo_alloc() as an extern function? Seems like
> it would make the executable smaller to turn __kfifo_alloc() into a
> static inline function that just defers to __kfifo_alloc_node().

OK, will convert to inline __kfifo_alloc() in next version.


Thanks,
Ming

