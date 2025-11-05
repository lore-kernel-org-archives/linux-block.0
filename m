Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E770434D3BD
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 01:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307305; cv=none; b=RdqxTnUVyiH4A556rU0+jrWmDzwsCFgiAb5x5x0u13HkCDWtb/PSnDTl2B6XVz4hshgjuD7MzhlrvcB4ARrLce9ooq2gl46ha58ABWT5Ya6cMCHORgNl9OQLpgV2iI5t2DYjY1HadHNi0l1LNHN/raHMWzhiu9463j3Y0IgH8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307305; c=relaxed/simple;
	bh=k3rauIZ5CGXgfrJkKcA12x7VQSg277A/Wjd7cYzgaOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz94PHwgi7wzKVWgNXhWwlJkR9Rbly7yAMU2OTBzrG7CozgawP77jjDs1ADC8+0jVggeC1b43Gcc9fZ0xLpPduBefDRwsAU4YtBgCkYWB7dh9EBcmfLdu8pZX//xNDKxBnMHTaiqDeKPt21nXxHZm5dpKFOrt/Xn4+Qe67GyuWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZgKSGdlh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgKSGdlh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762307302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMbwjC+PDOMjlfFNbA9ncfkYxb/LczwezWdontvo8i0=;
	b=ZgKSGdlhkHKuZDEfxrIpJyjoFtV6rsm5AZ62xT17PN99qeG4O5QZUUgcM6lGdJpOedlrIl
	ChzCmc850uO7y5TlA6IUi77nV+Fj9eNSRmUWn6ftSrN0mkjUAQMvFoN6MOhh9/YtGsQigv
	8/ESE8qI3EdEJAzfTMN2yBOIdTOgcJ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-dQ_x-NeQNsSSKyQw_rO_Ug-1; Tue,
 04 Nov 2025 20:48:20 -0500
X-MC-Unique: dQ_x-NeQNsSSKyQw_rO_Ug-1
X-Mimecast-MFC-AGG-ID: dQ_x-NeQNsSSKyQw_rO_Ug_1762307299
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A52D19560B0;
	Wed,  5 Nov 2025 01:48:19 +0000 (UTC)
Received: from fedora (unknown [10.72.120.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C89A19560A2;
	Wed,  5 Nov 2025 01:48:15 +0000 (UTC)
Date: Wed, 5 Nov 2025 09:48:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: use copy_{to,from}_iter() for user copy
Message-ID: <aQqs2TlXU0UYlsuy@fedora>
References: <20251031010522.3509499-1-csander@purestorage.com>
 <aQQwy7l_OCzG430i@fedora>
 <CADUfDZoPDbKO60nNVFk35X2JvT=8EV7vgROP+y2jgx6P39Woew@mail.gmail.com>
 <aQVAVBGM7inQUa7z@fedora>
 <CADUfDZqKV2SzbWoe4gr4aSPaBtr+VwmEgEidZKo=LQBU9Quf2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqKV2SzbWoe4gr4aSPaBtr+VwmEgEidZKo=LQBU9Quf2Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Nov 03, 2025 at 08:40:30AM -0800, Caleb Sander Mateos wrote:
> On Fri, Oct 31, 2025 at 4:04 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Fri, Oct 31, 2025 at 09:02:48AM -0700, Caleb Sander Mateos wrote:
> > > On Thu, Oct 30, 2025 at 8:45 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Thu, Oct 30, 2025 at 07:05:21PM -0600, Caleb Sander Mateos wrote:
> > > > > ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
> > > > > iov_iter_get_pages2() to extract the pages from the iov_iter and
> > > > > memcpy()s between the bvec_iter and the iov_iter's pages one at a time.
> > > > > Switch to using copy_to_iter()/copy_from_iter() instead. This avoids the
> > > > > user page reference count increments and decrements and needing to split
> > > > > the memcpy() at user page boundaries. It also simplifies the code
> > > > > considerably.
> > > > >
> > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > ---
> > > > >  drivers/block/ublk_drv.c | 62 +++++++++-------------------------------
> > > > >  1 file changed, 14 insertions(+), 48 deletions(-)
> > > > >
> > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > index 0c74a41a6753..852350e639d6 100644
> > > > > --- a/drivers/block/ublk_drv.c
> > > > > +++ b/drivers/block/ublk_drv.c
> > > > > @@ -912,58 +912,47 @@ static const struct block_device_operations ub_fops = {
> > > > >       .open =         ublk_open,
> > > > >       .free_disk =    ublk_free_disk,
> > > > >       .report_zones = ublk_report_zones,
> > > > >  };
> > > > >
> > > > > -#define UBLK_MAX_PIN_PAGES   32
> > > > > -
> > > > >  struct ublk_io_iter {
> > > > > -     struct page *pages[UBLK_MAX_PIN_PAGES];
> > > > >       struct bio *bio;
> > > > >       struct bvec_iter iter;
> > > > >  };
> > > >
> > > > ->pages[] is actually for pinning user io pages in batch, so killing it may cause
> > > > perf drop.
> > >
> > > As far as I can tell, copy_to_iter()/copy_from_iter() avoids the page
> > > pinning entirely. It calls copy_to_user_iter() for each contiguous
> > > user address range:
> > >
> > > size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
> > > {
> > >         if (WARN_ON_ONCE(i->data_source))
> > >                 return 0;
> > >         if (user_backed_iter(i))
> > >                 might_fault();
> > >         return iterate_and_advance(i, bytes, (void *)addr,
> > >                                    copy_to_user_iter, memcpy_to_iter);
> > > }
> > >
> > > Which just checks that the address range doesn't include any kernel
> > > addresses and then memcpy()s directly via the userspace virtual
> > > addresses:
> > >
> > > static __always_inline
> > > size_t copy_to_user_iter(void __user *iter_to, size_t progress,
> > >                          size_t len, void *from, void *priv2)
> > > {
> > >         if (should_fail_usercopy())
> > >                 return len;
> > >         if (access_ok(iter_to, len)) {
> > >                 from += progress;
> > >                 instrument_copy_to_user(iter_to, from, len);
> > >                 len = raw_copy_to_user(iter_to, from, len);
> > >         }
> > >         return len;
> > > }
> > >
> > > static __always_inline __must_check unsigned long
> > > raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
> > > {
> > >         return copy_user_generic((__force void *)dst, src, size);
> > > }
> > >
> > > static __always_inline __must_check unsigned long
> > > copy_user_generic(void *to, const void *from, unsigned long len)
> > > {
> > >         stac();
> > >         /*
> > >          * If CPU has FSRM feature, use 'rep movs'.
> > >          * Otherwise, use rep_movs_alternative.
> > >          */
> > >         asm volatile(
> > >                 "1:\n\t"
> > >                 ALTERNATIVE("rep movsb",
> > >                             "call rep_movs_alternative",
> > > ALT_NOT(X86_FEATURE_FSRM))
> > >                 "2:\n"
> > >                 _ASM_EXTABLE_UA(1b, 2b)
> > >                 :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
> > >                 : : "memory", "rax");
> > >         clac();
> > >         return len;
> > > }
> > >
> > > Am I missing something?
> >
> > page is allocated & mapped in page fault handler.
> 
> Right, physical pages certainly need to be allocated for the virtual
> address range being copied to/from. But that would have happened
> previously in iov_iter_get_pages2(), so this isn't a new cost. And as
> you point out, in the common case that the virtual pages are already
> mapped to physical pages, the copy won't cause any page faults.
> 
> >
> > However, in typical cases, pages in io buffer shouldn't be swapped out
> > frequently, so this cleanup may be good, I will run some perf test.
> 
> Thanks for testing.

`fio/t/io_uring` shows 40% improvement on `./kublk -t null -q 2` with this
patch in my test VM, so looks very nice improvement.

Also it works well by forcing to pass IOSQE_ASYNC on the ublk uring_cmd,
and this change is correct because the copy is guaranteed to be done in ublk
daemon context.

> 
> >
> > Also copy_page_from_iter()/copy_page_to_iter() can be used for avoiding
> > bvec_kmap_local(), and the two helper can handle one whole bvec instead
> > of single page.
> 
> Yes, that's a good idea. Thanks, I didn't know about that.
> 
> >
> > Then rq_for_each_bvec() can be used directly, and `ublk_io_iter` may be
> > killed.
> 
> Hmm, we still need a way to offset into the request (i.e. what
> ublk_advance_io_iter() does currently). Are you thinking of a single
> rq_for_each_bvec() loop that would skip bvecs until the offset is
> reached and then copy until reaching the end of the user iterator?

Yeah, that is basically what ublk_advance_io_iter() does.


Thanks,
Ming

