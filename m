Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0660F19F40B
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 02:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775615774; cv=none; b=RmeVNE2mV8Yo4r9sPejWNI/IKtWscwxeFIgZKqzONCnkPSOQ6hXmFxco0HGz+mH94m1A6jUHH6kqGXOJXyMEJUYCCXWY99TCZF+/CX8uTrfplgXQvSxps7knLCoxrZndRDv1byMf0QbDDE0xFl48mdmDJBemXqgfj/n6NLc9Lz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775615774; c=relaxed/simple;
	bh=Tu9CMjtSB2uEGymGc4SKE7J7XYG/W4YQhv4sSGRsmbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgYnb4FmDi1l4iEJqVvZC1ipNfdTveOjCyu+85rwlEhk1/K2ynoXMCTtqJWTVCINfT+lN86bEo5yzyTafHPQAmapp0u09uIC4GPN/TGLY8nF/QXVHuc5jXLB8r9G7xK/RUEYMYQDpAXc21gHI0Voe0luXX3BOJYgcI75yyvLYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dscBTYhE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dscBTYhE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775615771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XkVRYZCoXXduX4m2j0I5d3p20NYE2TO+QcdPMjKP2n8=;
	b=dscBTYhEyB8cTugL1UVlrXeI8kLqyQ48faL9cJHYI1PoPNihcZ8wTebvsheVTFeMPRn7Ps
	X1BHvYy26mv9WRhBY2gvdup/UrD1Co08I0ntNxj4DI6TQL3c2Fv70Gp89L5yP4jqb5cmmn
	w1dwIgckmkHbHdkFGjPQ5hGwRlkrF4E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-mjqYlIMCOoeST2U2d1sY8w-1; Tue,
 07 Apr 2026 22:36:10 -0400
X-MC-Unique: mjqYlIMCOoeST2U2d1sY8w-1
X-Mimecast-MFC-AGG-ID: mjqYlIMCOoeST2U2d1sY8w_1775615769
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60ADE1800344;
	Wed,  8 Apr 2026 02:36:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90F961955D84;
	Wed,  8 Apr 2026 02:36:06 +0000 (UTC)
Date: Wed, 8 Apr 2026 10:36:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 02/10] ublk: add PFN-based buffer matching in I/O path
Message-ID: <adW_EQW1AAJdaWqN@fedora>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
 <20260331153207.3635125-3-ming.lei@redhat.com>
 <CADUfDZq3rTwcnxAekdan3-fi3qdLwFp-T5LsJJ1viqoUv8RqOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZq3rTwcnxAekdan3-fi3qdLwFp-T5LsJJ1viqoUv8RqOw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Apr 07, 2026 at 12:47:29PM -0700, Caleb Sander Mateos wrote:
> On Tue, Mar 31, 2026 at 8:32 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add ublk_try_buf_match() which walks a request's bio_vecs, looks up
> > each page's PFN in the per-device maple tree, and verifies all pages
> > belong to the same registered buffer at contiguous offsets.
> >
> > Add ublk_iod_is_shmem_zc() inline helper for checking whether a
> > request uses the shmem zero-copy path.
> >
> > Integrate into the I/O path:
> > - ublk_setup_iod(): if pages match a registered buffer, set
> >   UBLK_IO_F_SHMEM_ZC and encode buffer index + offset in addr
> > - ublk_start_io(): skip ublk_map_io() for zero-copy requests
> > - __ublk_complete_rq(): skip ublk_unmap_io() for zero-copy requests
> >
> > The feature remains disabled (ublk_support_shmem_zc() returns false)
> > until the UBLK_F_SHMEM_ZC flag is enabled in the next patch.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 77 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 76 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index ac6ccc174d44..d53865437600 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -356,6 +356,8 @@ struct ublk_params_header {
> >
> >  static void ublk_io_release(void *priv);
> >  static void ublk_stop_dev_unlocked(struct ublk_device *ub);
> > +static bool ublk_try_buf_match(struct ublk_device *ub, struct request *rq,
> > +                                 u32 *buf_idx, u32 *buf_off);
> 
> buf_idx could be a u16 * for consistency?

Yeah.

> 
> >  static void ublk_buf_cleanup(struct ublk_device *ub);
> >  static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
> >  static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
> > @@ -426,6 +428,12 @@ static inline bool ublk_support_shmem_zc(const struct ublk_queue *ubq)
> >         return false;
> >  }
> >
> > +static inline bool ublk_iod_is_shmem_zc(const struct ublk_queue *ubq,
> > +                                       unsigned int tag)
> > +{
> > +       return ublk_get_iod(ubq, tag)->op_flags & UBLK_IO_F_SHMEM_ZC;
> > +}
> > +
> >  static inline bool ublk_dev_support_shmem_zc(const struct ublk_device *ub)
> >  {
> >         return false;
> > @@ -1494,6 +1502,18 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
> >         iod->nr_sectors = blk_rq_sectors(req);
> >         iod->start_sector = blk_rq_pos(req);
> >
> > +       /* Try shmem zero-copy match before setting addr */
> > +       if (ublk_support_shmem_zc(ubq) && ublk_rq_has_data(req)) {
> > +               u32 buf_idx, buf_off;
> > +
> > +               if (ublk_try_buf_match(ubq->dev, req,
> > +                                         &buf_idx, &buf_off)) {
> > +                       iod->op_flags |= UBLK_IO_F_SHMEM_ZC;
> > +                       iod->addr = ublk_shmem_zc_addr(buf_idx, buf_off);
> > +                       return BLK_STS_OK;
> > +               }
> > +       }
> > +
> >         iod->addr = io->buf.addr;
> >
> >         return BLK_STS_OK;
> > @@ -1539,6 +1559,10 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
> >             req_op(req) != REQ_OP_DRV_IN)
> >                 goto exit;
> >
> > +       /* shmem zero copy: no data to unmap, pages already shared */
> > +       if (ublk_iod_is_shmem_zc(req->mq_hctx->driver_data, req->tag))
> 
> This is a lot of pointer chasing. Could we track this with a flag on
> struct ublk_io instead?

Yeah, it can be done by adding and setting the new flag in ublk_start_io(), or
we can just pass `ubq` to __ublk_complete_rq() from its call sites.

I prefer to the latter.

> 
> > +               goto exit;
> > +
> >         /* for READ request, writing data in iod->addr to rq buffers */
> >         unmapped_bytes = ublk_unmap_io(need_map, req, io);
> >
> > @@ -1697,8 +1721,13 @@ static void ublk_auto_buf_dispatch(const struct ublk_queue *ubq,
> >  static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
> >                           struct ublk_io *io)
> >  {
> > -       unsigned mapped_bytes = ublk_map_io(ubq, req, io);
> > +       unsigned mapped_bytes;
> >
> > +       /* shmem zero copy: skip data copy, pages already shared */
> > +       if (ublk_iod_is_shmem_zc(ubq, req->tag))
> > +               return true;
> > +
> > +       mapped_bytes = ublk_map_io(ubq, req, io);
> >
> >         /* partially mapped, update io descriptor */
> >         if (unlikely(mapped_bytes != blk_rq_bytes(req))) {
> > @@ -5458,7 +5487,53 @@ static void ublk_buf_cleanup(struct ublk_device *ub)
> >         mtree_destroy(&ub->buf_tree);
> >  }
> >
> > +/* Check if request pages match a registered shared memory buffer */
> > +static bool ublk_try_buf_match(struct ublk_device *ub,
> > +                                  struct request *rq,
> > +                                  u32 *buf_idx, u32 *buf_off)
> > +{
> > +       struct req_iterator iter;
> > +       struct bio_vec bv;
> > +       int index = -1;
> > +       unsigned long expected_offset = 0;
> > +       bool first = true;
> 
> Could check index < 0 in place of first?
> 
> > +
> > +       rq_for_each_bvec(bv, rq, iter) {
> > +               unsigned long pfn = page_to_pfn(bv.bv_page);
> > +               struct ublk_buf_range *range;
> > +               unsigned long off;
> >
> > +               range = mtree_load(&ub->buf_tree, pfn);
> > +               if (!range)
> > +                       return false;
> > +
> > +               off = range->base_offset +
> > +                       (pfn - range->base_pfn) * PAGE_SIZE + bv.bv_offset;
> 
> Doesn't this need to check that the end of the bvec is less than the
> end of the range? Otherwise, the bvec could extend into physically
> contiguous pages that aren't part of the registered range.

It is actually fixed in my local tree:

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2e475bdc54dd..69db3b3b9071 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5524,13 +5524,20 @@ static bool ublk_try_buf_match(struct ublk_device *ub,

        rq_for_each_bvec(bv, rq, iter) {
                unsigned long pfn = page_to_pfn(bv.bv_page);
+               unsigned long end_pfn = pfn +
+                       ((bv.bv_offset + bv.bv_len - 1) >> PAGE_SHIFT);
                struct ublk_buf_range *range;
                unsigned long off;
+               MA_STATE(mas, &ub->buf_tree, pfn, pfn);

-               range = mtree_load(&ub->buf_tree, pfn);
+               range = mas_walk(&mas);
                if (!range)
                        return false;

+               /* verify all pages in this bvec fall within the range */
+               if (end_pfn > mas.last)
+                       return false;
+
                off = range->base_offset +
                        (pfn - range->base_pfn) * PAGE_SIZE + bv.bv_offset;

> 
> Also, the range could precompute base_pfn - base_offset / PAGE_SIZE
> instead of base_offset to make this a bit cheaper.
> 
> > +
> > +               if (first) {
> > +                       /* Read-only buffer can't serve READ (kernel writes) */
> > +                       if ((range->flags & UBLK_SHMEM_BUF_READ_ONLY) &&
> > +                           req_op(rq) != REQ_OP_WRITE)
> > +                               return false;
> > +                       index = range->buf_index;
> > +                       expected_offset = off;
> > +                       *buf_off = off;
> > +                       first = false;
> > +               } else {
> > +                       if (range->buf_index != index)
> > +                               return false;
> > +                       if (off != expected_offset)
> > +                               return false;
> > +               }
> > +               expected_offset += bv.bv_len;
> > +       }
> > +
> > +       if (first)
> > +               return false;
> 
> How is this case possible? That would mean the request has no bvecs,
> but ublk_try_buf_match() is only called for requests with data, right?

Your are right, will clean it in next version.
 
Thanks,
Ming

