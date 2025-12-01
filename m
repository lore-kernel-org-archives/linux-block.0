Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B32628D
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764553611; cv=none; b=dhbNQASaNFLKHUMTDhMdupc7l/Boj+W5/izYtjCUFyaqsnMP1lbqL3q+InKFoTVZ74MinaZQvs5CGgqqK9aLdWpNBhOg9hg9Wdnfq9ASZZMeWD2Xn25RfV4izaXokmXJoaffqYoJ52ZAkTqhZIH495nRLIGi8IGv51ANntk7vnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764553611; c=relaxed/simple;
	bh=TbiHVlVFCndjjqXEA+G0/k7V2eMo41bK/yGUb0f+mbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANYpJVxpc279V5/fC040naYCY9GRUIGY9oD5fheo7ueqnTIl4Tb91+gSfhj1Yn18wgWHnGkqTlXXWiY3tZKCLKvD3MGM/72OL+wf0LgpWLrTJmuUoQ7PQMsbLeF/aBkEnQAj4rkgS6pXPAcNk5svPUIxJibJvw7QLI+GKP2s6Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEeNEldP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEeNEldP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764553606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YtN6KgVNlbskaIoMf+joLqlH4K07xTUXgjr0khq+Teg=;
	b=WEeNEldPq3l9VSufy3Ctj4N3WY5Qg+Oc1Ynz8vnmtlLfMqk8aJ+WBl637AJOXil1t4GhAv
	ji7z1Igj/vRPx0GfMD5nill4G8IfCdcWuEKApJn5ouiUKYmh+gDvoNstp5e3hnPgAfetw6
	M7wBG03GOPWZlwQBANRXxW/dkV0gfSs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-RMjz_2TQPNqU1hE2jEkRdg-1; Sun,
 30 Nov 2025 20:46:40 -0500
X-MC-Unique: RMjz_2TQPNqU1hE2jEkRdg-1
X-Mimecast-MFC-AGG-ID: RMjz_2TQPNqU1hE2jEkRdg_1764553599
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9080F195608E;
	Mon,  1 Dec 2025 01:46:38 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8085430001B9;
	Mon,  1 Dec 2025 01:46:33 +0000 (UTC)
Date: Mon, 1 Dec 2025 09:46:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 01/27] kfifo: add kfifo_alloc_node() helper for NUMA
 awareness
Message-ID: <aSzzdFRAVAGpBMpr@fedora>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
 <20251121015851.3672073-2-ming.lei@redhat.com>
 <CADUfDZramMrqZ1=ZH2xXcT=n-p-QsdQ2nOpAeWGzxEpjc-9-Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZramMrqZ1=ZH2xXcT=n-p-QsdQ2nOpAeWGzxEpjc-9-Rg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Nov 29, 2025 at 11:12:43AM -0800, Caleb Sander Mateos wrote:
> On Thu, Nov 20, 2025 at 5:59 PM Ming Lei <ming.lei@redhat.com> wrote:
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
> >  include/linux/kfifo.h | 34 ++++++++++++++++++++++++++++++++--
> >  lib/kfifo.c           |  8 ++++----
> >  2 files changed, 36 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
> > index fd743d4c4b4b..8b81ac74829c 100644
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
> 
> Looks like we could avoid some code duplication by defining
> kfifo_alloc(fifo, size, gfp_mask) as kfifo_alloc_node(fifo, size,
> gfp_mask, NUMA_NO_NODE). Otherwise, this looks good to me.

It is just a single-line inline, and shouldn't introduce any code
duplication. Switching to kfifo_alloc_node() doesn't change result of
`size vmlinux` actually.



Thanks,
Ming

