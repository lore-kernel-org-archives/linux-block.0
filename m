Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B81192D8A
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775617146; cv=none; b=ldWW49cAe6dzKv6xrZOWvNKYRo2vhL0dYANlT9mr3La5ebJjFeISUyjlsJeqWAb30/oAXPU5nnTtDEizO5MRiMXaRvrasY6MG4oRatQsVR96HRswZ8P/H+fXEXrUWo2qdxNupdF+LTA3dqBOj+NmUYhqjlKRtZIRPMg8mtLsNwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775617146; c=relaxed/simple;
	bh=tZNttkFgR6Z0s72g0huCRNsj+YQ4788Y/sFWkwVt47A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjAKTbLDok4zWpP5LdjJEBwOQ2YCl1Fn14dy80IF12eR/KWO+77LdpV6hJc6YAYtaj8MVCdqI2Jvpcv0CIEOjnM+PWGF529r4RkNPvx9c5UL+qY6mNLxZcRJQl10P4ao9uyxObVVChvZJZi+uXc1xOFU7qgyAICyf7/lPm5JAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2ffuVAP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2ffuVAP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775617143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kw++DO/FO0ulURm9blOvbhcpb3YoJkLOBR7K6nKF41A=;
	b=P2ffuVAPpZJUlHH97JSrHI+GMrjK6II7WgJ4w0bdTXVnxFQAL92e8pWAkGjNIOG0W28OAP
	+v8ltZPLUJ1Ow4WHvFs/imo6Oh7uxObm3/wYEsxV9ZWooC3PfpXZEfMH/R4wnXqHS0IuTB
	hJmo+VURZk/17GHbyY6fAS9q3pU6Qfs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-1Pb5STZgMUW8IYwYOkChog-1; Tue,
 07 Apr 2026 22:59:02 -0400
X-MC-Unique: 1Pb5STZgMUW8IYwYOkChog-1
X-Mimecast-MFC-AGG-ID: 1Pb5STZgMUW8IYwYOkChog_1775617141
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A5E31800454;
	Wed,  8 Apr 2026 02:59:01 +0000 (UTC)
Received: from fedora (unknown [10.72.116.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 749531800576;
	Wed,  8 Apr 2026 02:58:58 +0000 (UTC)
Date: Wed, 8 Apr 2026 10:58:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 04/10] ublk: eliminate permanent pages[] array from
 struct ublk_buf
Message-ID: <adXEa9bcCUQfPCDo@fedora>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
 <20260331153207.3635125-5-ming.lei@redhat.com>
 <CADUfDZow_gmwzQk41kn=Hw4w4bhsF9ogm2ZPGNgRuz9d5aF_kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZow_gmwzQk41kn=Hw4w4bhsF9ogm2ZPGNgRuz9d5aF_kQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Apr 07, 2026 at 12:50:15PM -0700, Caleb Sander Mateos wrote:
> On Tue, Mar 31, 2026 at 8:32 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > The pages[] array (kvmalloc'd, 8 bytes per page = 2MB for a 1GB buffer)
> > was stored permanently in struct ublk_buf but only needed during
> > pin_user_pages_fast() and maple tree construction. Since the maple tree
> > already stores PFN ranges via ublk_buf_range, struct page pointers can
> > be recovered via pfn_to_page() during unregistration.
> >
> > Make pages[] a temporary allocation in ublk_ctrl_reg_buf(), freed
> > immediately after the maple tree is built. Rewrite __ublk_ctrl_unreg_buf()
> > to iterate the maple tree for matching buf_index entries, recovering
> > struct page pointers via pfn_to_page() and unpinning in batches of 32.
> > Simplify ublk_buf_erase_ranges() to iterate the maple tree by buf_index
> > instead of walking the now-removed pages[] array.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 87 +++++++++++++++++++++++++---------------
> >  1 file changed, 55 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index c2b9992503a4..2e475bdc54dd 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -296,7 +296,6 @@ struct ublk_queue {
> >
> >  /* Per-registered shared memory buffer */
> >  struct ublk_buf {
> > -       struct page **pages;
> >         unsigned int nr_pages;
> >  };
> 
> It looks like nr_pages doesn't need to be stored either, it could just
> be passed to __ublk_ctrl_reg_buf(). Then I think we could get rid of
> struct ublk_buf and the xarray entirely. We really just need a bitmap
> for allocating buffer indices.

Maybe idr_alloc().

> 
> >
> > @@ -5261,27 +5260,25 @@ static void ublk_unquiesce_and_resume(struct gendisk *disk)
> >   * coalescing consecutive PFNs into single range entries.
> >   * Returns 0 on success, negative error with partial insertions unwound.
> >   */
> > -/* Erase coalesced PFN ranges from the maple tree for pages [0, nr_pages) */
> > -static void ublk_buf_erase_ranges(struct ublk_device *ub,
> > -                                 struct ublk_buf *ubuf,
> > -                                 unsigned long nr_pages)
> > +/* Erase coalesced PFN ranges from the maple tree matching buf_index */
> > +static void ublk_buf_erase_ranges(struct ublk_device *ub, int buf_index)
> >  {
> > -       unsigned long i;
> > -
> > -       for (i = 0; i < nr_pages; ) {
> > -               unsigned long pfn = page_to_pfn(ubuf->pages[i]);
> > -               unsigned long start = i;
> > +       MA_STATE(mas, &ub->buf_tree, 0, ULONG_MAX);
> > +       struct ublk_buf_range *range;
> >
> > -               while (i + 1 < nr_pages &&
> > -                      page_to_pfn(ubuf->pages[i + 1]) == pfn + (i - start) + 1)
> > -                       i++;
> > -               i++;
> > -               kfree(mtree_erase(&ub->buf_tree, pfn));
> > +       mas_lock(&mas);
> > +       mas_for_each(&mas, range, ULONG_MAX) {
> > +               if (range->buf_index == buf_index) {
> > +                       mas_erase(&mas);
> > +                       kfree(range);
> > +               }
> >         }
> > +       mas_unlock(&mas);
> >  }
> >
> >  static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
> > -                              struct ublk_buf *ubuf, int index,
> > +                              struct ublk_buf *ubuf,
> > +                              struct page **pages, int index,
> >                                unsigned short flags)
> >  {
> >         unsigned long nr_pages = ubuf->nr_pages;
> > @@ -5289,13 +5286,13 @@ static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
> >         int ret;
> >
> >         for (i = 0; i < nr_pages; ) {
> > -               unsigned long pfn = page_to_pfn(ubuf->pages[i]);
> > +               unsigned long pfn = page_to_pfn(pages[i]);
> >                 unsigned long start = i;
> >                 struct ublk_buf_range *range;
> >
> >                 /* Find run of consecutive PFNs */
> >                 while (i + 1 < nr_pages &&
> > -                      page_to_pfn(ubuf->pages[i + 1]) == pfn + (i - start) + 1)
> > +                      page_to_pfn(pages[i + 1]) == pfn + (i - start) + 1)
> >                         i++;
> >                 i++;    /* past the last page in this run */
> >
> > @@ -5320,7 +5317,7 @@ static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
> >         return 0;
> >
> >  unwind:
> > -       ublk_buf_erase_ranges(ub, ubuf, i);
> > +       ublk_buf_erase_ranges(ub, index);
> >         return ret;
> >  }
> >
> > @@ -5335,6 +5332,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
> >         void __user *argp = (void __user *)(unsigned long)header->addr;
> >         struct ublk_shmem_buf_reg buf_reg;
> >         unsigned long addr, size, nr_pages;
> > +       struct page **pages = NULL;
> >         unsigned int gup_flags;
> >         struct gendisk *disk;
> >         struct ublk_buf *ubuf;
> > @@ -5371,9 +5369,8 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
> >                 goto put_disk;
> >         }
> >
> > -       ubuf->pages = kvmalloc_array(nr_pages, sizeof(*ubuf->pages),
> > -                                    GFP_KERNEL);
> > -       if (!ubuf->pages) {
> > +       pages = kvmalloc_array(nr_pages, sizeof(*pages), GFP_KERNEL);
> > +       if (!pages) {
> >                 ret = -ENOMEM;
> >                 goto err_free;
> >         }
> > @@ -5382,7 +5379,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
> >         if (!(buf_reg.flags & UBLK_SHMEM_BUF_READ_ONLY))
> >                 gup_flags |= FOLL_WRITE;
> >
> > -       pinned = pin_user_pages_fast(addr, nr_pages, gup_flags, ubuf->pages);
> > +       pinned = pin_user_pages_fast(addr, nr_pages, gup_flags, pages);
> >         if (pinned < 0) {
> >                 ret = pinned;
> >                 goto err_free_pages;
> > @@ -5406,7 +5403,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
> >         if (ret)
> >                 goto err_unlock;
> >
> > -       ret = __ublk_ctrl_reg_buf(ub, ubuf, index, buf_reg.flags);
> > +       ret = __ublk_ctrl_reg_buf(ub, ubuf, pages, index, buf_reg.flags);
> >         if (ret) {
> >                 xa_erase(&ub->bufs_xa, index);
> >                 goto err_unlock;
> > @@ -5414,6 +5411,7 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
> >
> >         mutex_unlock(&ub->mutex);
> >
> > +       kvfree(pages);
> >         ublk_unquiesce_and_resume(disk);
> >         ublk_put_disk(disk);
> >         return index;
> > @@ -5422,9 +5420,9 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
> >         mutex_unlock(&ub->mutex);
> >         ublk_unquiesce_and_resume(disk);
> >  err_unpin:
> > -       unpin_user_pages(ubuf->pages, pinned);
> > +       unpin_user_pages(pages, pinned);
> >  err_free_pages:
> > -       kvfree(ubuf->pages);
> > +       kvfree(pages);
> >  err_free:
> >         kfree(ubuf);
> >  put_disk:
> > @@ -5433,11 +5431,36 @@ static int ublk_ctrl_reg_buf(struct ublk_device *ub,
> >  }
> >
> >  static void __ublk_ctrl_unreg_buf(struct ublk_device *ub,
> > -                                 struct ublk_buf *ubuf)
> > +                                 struct ublk_buf *ubuf, int buf_index)
> 
> ubuf is only passed to kfree() now, maybe it would make sense to move
> that to the caller so the argument can be dropped?

Yeah, looks fine.


Thanks,
Ming

