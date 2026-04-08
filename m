Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47AC31CA4E
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775615027; cv=none; b=kvpqp9HL9SOocKPLxLAehvnvdPF9LQvVGZI9dEJk3NwikZhr3CTVPeo+PfeWkDbYkH8lADprjtV1cKiq2muT+43iDySbmR1Ykhcod5c9I6iEYrMTgeCXOqpxXjfsj8wJPiCai4roD0DmtUaB/agV4eaI+vtwqHnKKVIbjMdlydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775615027; c=relaxed/simple;
	bh=WhM1SgeYhuxx+nwWf5gADo0hSuBE89Veyjh8KhNKem8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is98SFDkaHjZVOJ7qtUWE5yIGIBXcgZIjHX1AHO7hLNicpbqRwNSDazzdl35imkYsB1WWc8qeI0whuW7tC5QMHI8LXetiDbqSeA16aBfvLQcrXn2MN4jkpZ0R6WOyT5UMZK0vXF14rzoyLa4H0SWRKXK1TiT00iVYkppYUXLRgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdJhZ7Me; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdJhZ7Me"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775615023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ibjzmhxr7c3+YHTtfR3GQI23YLqZ2lzSYQgVgN0SQrY=;
	b=YdJhZ7Me4pMQzKrHVPwHw0nQD7z++K32XBWc3Hdfgx7ODo+WZCSX1RyVSk3yovOuYWEEIk
	+hSX8P8Q6s9ycGezcxSgurERqnPnPFbAjXMoOiJaYQW6oUVbyEuyfXvGe/ilTrxcXc8zku
	292fXv3+pSkNoNWpzeC3GePCRywBRI0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-fsf05wEDN1OSvMaWVBGItg-1; Tue,
 07 Apr 2026 22:23:41 -0400
X-MC-Unique: fsf05wEDN1OSvMaWVBGItg-1
X-Mimecast-MFC-AGG-ID: fsf05wEDN1OSvMaWVBGItg_1775615020
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB2C7180047F;
	Wed,  8 Apr 2026 02:23:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17078180035F;
	Wed,  8 Apr 2026 02:23:36 +0000 (UTC)
Date: Wed, 8 Apr 2026 10:23:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 01/10] ublk: add UBLK_U_CMD_REG_BUF/UNREG_BUF control
 commands
Message-ID: <adW8I8RpSD471iFy@fedora>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
 <20260331153207.3635125-2-ming.lei@redhat.com>
 <CADUfDZpUbses5NNR19M+81ZwDxSAb6ktz0+2f9GfkOL8yzEh+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpUbses5NNR19M+81ZwDxSAb6ktz0+2f9GfkOL8yzEh+w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Apr 07, 2026 at 12:35:49PM -0700, Caleb Sander Mateos wrote:
> On Tue, Mar 31, 2026 at 8:32 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add control commands for registering and unregistering shared memory
> > buffers for zero-copy I/O:
> >
> > - UBLK_U_CMD_REG_BUF (0x18): pins pages from userspace, inserts PFN
> >   ranges into a per-device maple tree for O(log n) lookup during I/O.
> >   Buffer pointers are tracked in a per-device xarray. Returns the
> >   assigned buffer index.
> >
> > - UBLK_U_CMD_UNREG_BUF (0x19): removes PFN entries and unpins pages.
> >
> > Queue freeze/unfreeze is handled internally so userspace need not
> > quiesce the device during registration.
> >
> > Also adds:
> > - UBLK_IO_F_SHMEM_ZC flag and addr encoding helpers in UAPI header
> >   (16-bit buffer index supporting up to 65536 buffers)
> > - Data structures (ublk_buf, ublk_buf_range) and xarray/maple tree
> > - __ublk_ctrl_reg_buf() helper for PFN insertion with error unwinding
> > - __ublk_ctrl_unreg_buf() helper for cleanup reuse
> > - ublk_support_shmem_zc() / ublk_dev_support_shmem_zc() stubs
> >   (returning false — feature not enabled yet)
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 300 ++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/ublk_cmd.h |  72 ++++++++
> >  2 files changed, 372 insertions(+)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 71c7c56b38ca..ac6ccc174d44 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -46,6 +46,8 @@
> >  #include <linux/kref.h>
> >  #include <linux/kfifo.h>
> >  #include <linux/blk-integrity.h>
> > +#include <linux/maple_tree.h>
> > +#include <linux/xarray.h>
> >  #include <uapi/linux/fs.h>
> >  #include <uapi/linux/ublk_cmd.h>
> >
> > @@ -58,6 +60,8 @@
> >  #define UBLK_CMD_UPDATE_SIZE   _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
> >  #define UBLK_CMD_QUIESCE_DEV   _IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
> >  #define UBLK_CMD_TRY_STOP_DEV  _IOC_NR(UBLK_U_CMD_TRY_STOP_DEV)
> > +#define UBLK_CMD_REG_BUF       _IOC_NR(UBLK_U_CMD_REG_BUF)
> > +#define UBLK_CMD_UNREG_BUF     _IOC_NR(UBLK_U_CMD_UNREG_BUF)
> >
> >  #define UBLK_IO_REGISTER_IO_BUF                _IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
> >  #define UBLK_IO_UNREGISTER_IO_BUF      _IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
> > @@ -289,6 +293,20 @@ struct ublk_queue {
> >         struct ublk_io ios[] __counted_by(q_depth);
> >  };
> >
> > +/* Per-registered shared memory buffer */
> > +struct ublk_buf {
> > +       struct page **pages;
> > +       unsigned int nr_pages;
> > +};
> > +
> > +/* Maple tree value: maps a PFN range to buffer location */
> > +struct ublk_buf_range {
> > +       unsigned long base_pfn;
> > +       unsigned short buf_index;
> > +       unsigned short flags;
> > +       unsigned int base_offset;       /* byte offset within buffer */
> > +};
> > +
> >  struct ublk_device {
> >         struct gendisk          *ub_disk;
> >
> > @@ -323,6 +341,10 @@ struct ublk_device {
> >
> >         bool                    block_open; /* protected by open_mutex */
> >
> > +       /* shared memory zero copy */
> > +       struct maple_tree       buf_tree;
> > +       struct xarray           bufs_xa;
> > +
> >         struct ublk_queue       *queues[];
> >  };
> >
> > @@ -334,6 +356,7 @@ struct ublk_params_header {
> >
> >  static void ublk_io_release(void *priv);
> >  static void ublk_stop_dev_unlocked(struct ublk_device *ub);
> > +static void ublk_buf_cleanup(struct ublk_device *ub);
> >  static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
> >  static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
> >                 u16 q_id, u16 tag, struct ublk_io *io);
> > @@ -398,6 +421,16 @@ static inline bool ublk_dev_support_zero_copy(const struct ublk_device *ub)
> >         return ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY;
> >  }
> >
> > +static inline bool ublk_support_shmem_zc(const struct ublk_queue *ubq)
> > +{
> > +       return false;
> > +}
> > +
> > +static inline bool ublk_dev_support_shmem_zc(const struct ublk_device *ub)
> > +{
> > +       return false;
> > +}
> > +
> >  static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ubq)
> >  {
> >         return ubq->flags & UBLK_F_AUTO_BUF_REG;
> > @@ -1460,6 +1493,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
> >         iod->op_flags = ublk_op | ublk_req_build_flags(req);
> >         iod->nr_sectors = blk_rq_sectors(req);
> >         iod->start_sector = blk_rq_pos(req);
> > +
> 
> nit: unrelated whitespace change?
> 
> >         iod->addr = io->buf.addr;
> >
> >         return BLK_STS_OK;
> > @@ -1665,6 +1699,7 @@ static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
> >  {
> >         unsigned mapped_bytes = ublk_map_io(ubq, req, io);
> >
> > +
> 
> nit: unrelated whitespace change?
> 
> >         /* partially mapped, update io descriptor */
> >         if (unlikely(mapped_bytes != blk_rq_bytes(req))) {
> >                 /*
> > @@ -4206,6 +4241,7 @@ static void ublk_cdev_rel(struct device *dev)
> >  {
> >         struct ublk_device *ub = container_of(dev, struct ublk_device, cdev_dev);
> >
> > +       ublk_buf_cleanup(ub);
> >         blk_mq_free_tag_set(&ub->tag_set);
> >         ublk_deinit_queues(ub);
> >         ublk_free_dev_number(ub);
> > @@ -4625,6 +4661,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
> >         mutex_init(&ub->mutex);
> >         spin_lock_init(&ub->lock);
> >         mutex_init(&ub->cancel_mutex);
> > +       mt_init(&ub->buf_tree);
> > +       xa_init_flags(&ub->bufs_xa, XA_FLAGS_ALLOC);
> >         INIT_WORK(&ub->partition_scan_work, ublk_partition_scan_work);
> >
> >         ret = ublk_alloc_dev_number(ub, header->dev_id);
> > @@ -5168,6 +5206,260 @@ static int ublk_char_dev_permission(struct ublk_device *ub,
> >         return err;
> >  }
> >
> > +/*
> > + * Drain inflight I/O and quiesce the queue. Freeze drains all inflight
> > + * requests, quiesce_nowait marks the queue so no new requests dispatch,
> > + * then unfreeze allows new submissions (which won't dispatch due to
> > + * quiesce). This keeps freeze and ub->mutex non-nested.
> > + */
> > +static void ublk_quiesce_and_release(struct gendisk *disk)
> > +{
> > +       unsigned int memflags;
> > +
> > +       memflags = blk_mq_freeze_queue(disk->queue);
> > +       blk_mq_quiesce_queue_nowait(disk->queue);
> > +       blk_mq_unfreeze_queue(disk->queue, memflags);
> > +}
> > +
> > +static void ublk_unquiesce_and_resume(struct gendisk *disk)
> > +{
> > +       blk_mq_unquiesce_queue(disk->queue);
> > +}
> > +
> > +/*
> > + * Insert PFN ranges of a registered buffer into the maple tree,
> > + * coalescing consecutive PFNs into single range entries.
> > + * Returns 0 on success, negative error with partial insertions unwound.
> > + */
> > +/* Erase coalesced PFN ranges from the maple tree for pages [0, nr_pages) */
> > +static void ublk_buf_erase_ranges(struct ublk_device *ub,
> > +                                 struct ublk_buf *ubuf,
> > +                                 unsigned long nr_pages)
> > +{
> > +       unsigned long i;
> > +
> > +       for (i = 0; i < nr_pages; ) {
> > +               unsigned long pfn = page_to_pfn(ubuf->pages[i]);
> > +               unsigned long start = i;
> > +
> > +               while (i + 1 < nr_pages &&
> > +                      page_to_pfn(ubuf->pages[i + 1]) == pfn + (i - start) + 1)
> > +                       i++;
> > +               i++;
> > +               kfree(mtree_erase(&ub->buf_tree, pfn));
> > +       }
> > +}
> > +
> > +static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
> > +                              struct ublk_buf *ubuf, int index,
> > +                              unsigned short flags)
> > +{
> > +       unsigned long nr_pages = ubuf->nr_pages;
> > +       unsigned long i;
> > +       int ret;
> > +
> > +       for (i = 0; i < nr_pages; ) {
> > +               unsigned long pfn = page_to_pfn(ubuf->pages[i]);
> > +               unsigned long start = i;
> > +               struct ublk_buf_range *range;
> > +
> > +               /* Find run of consecutive PFNs */
> > +               while (i + 1 < nr_pages &&
> > +                      page_to_pfn(ubuf->pages[i + 1]) == pfn + (i - start) + 1)
> > +                       i++;
> > +               i++;    /* past the last page in this run */
> 
> Move this increment to the for loop so you don't need the "- 1" in the
> mtree_insert_range() call?

Good catch!

> 
> > +
> > +               range = kzalloc(sizeof(*range), GFP_KERNEL);
> 
> Not sure kzalloc() is necessary; all the fields are initialized below

Yeah, kmalloc() is fine, and we shouldn't add more fields to `range` in
future.

> 
> > +               if (!range) {
> > +                       ret = -ENOMEM;
> > +                       goto unwind;
> > +               }
> > +               range->buf_index = index;
> > +               range->flags = flags;
> > +               range->base_pfn = pfn;
> > +               range->base_offset = start << PAGE_SHIFT;
> > +
> > +               ret = mtree_insert_range(&ub->buf_tree, pfn,
> > +                                        pfn + (i - start) - 1,
> > +                                        range, GFP_KERNEL);
> > +               if (ret) {
> > +                       kfree(range);
> > +                       goto unwind;
> > +               }
> > +       }
> > +       return 0;
> > +
> > +unwind:
> > +       ublk_buf_erase_ranges(ub, ubuf, i);
> > +       return ret;
> > +}
> > +
> > +/*
> > + * Register a shared memory buffer for zero-copy I/O.
> > + * Pins pages, builds PFN maple tree, freezes/unfreezes the queue
> > + * internally. Returns buffer index (>= 0) on success.
> > + */
> > +static int ublk_ctrl_reg_buf(struct ublk_device *ub,
> > +                            struct ublksrv_ctrl_cmd *header)
> > +{
> > +       void __user *argp = (void __user *)(unsigned long)header->addr;
> > +       struct ublk_shmem_buf_reg buf_reg;
> > +       unsigned long addr, size, nr_pages;
> 
> size and nr_pages could be u32

Yeah, it was caused by internal change on `ublk_shmem_buf_reg`.

> 
> > +       unsigned int gup_flags;
> > +       struct gendisk *disk;
> > +       struct ublk_buf *ubuf;
> > +       long pinned;
> 
> pinned could be int to match the return type of pin_user_pages_fast()

OK.

> 
> > +       u32 index;
> > +       int ret;
> > +
> > +       if (!ublk_dev_support_shmem_zc(ub))
> > +               return -EOPNOTSUPP;
> > +
> > +       memset(&buf_reg, 0, sizeof(buf_reg));
> > +       if (copy_from_user(&buf_reg, argp,
> > +                          min_t(size_t, header->len, sizeof(buf_reg))))
> > +               return -EFAULT;
> > +
> > +       if (buf_reg.flags & ~UBLK_SHMEM_BUF_READ_ONLY)
> > +               return -EINVAL;
> > +
> > +       addr = buf_reg.addr;
> > +       size = buf_reg.len;
> 
> nit: don't see much value in these additional variables that are just
> copies of buf_reg fields
> 
> > +       nr_pages = size >> PAGE_SHIFT;
> > +
> > +       if (!size || !PAGE_ALIGNED(size) || !PAGE_ALIGNED(addr))
> > +               return -EINVAL;
> > +
> > +       disk = ublk_get_disk(ub);
> > +       if (!disk)
> > +               return -ENODEV;
> 
> So buffers can't be registered before the ublk device is started? Is
> there a reason why that's not possible? Could we just make the
> ublk_quiesce_and_release() and ublk_unquiesce_and_resume() conditional
> on disk being non-NULL? I guess we'd have to hold the ublk_device
> mutex before calling ublk_get_disk() to prevent it from being assigned
> concurrently.

Here `disk` is used for freeze & quiesce queue.

But the implementation can be a bit more complicated given the dependency
between ub->mutex and freeze queue should be avoided.

Anyway, it is one nice requirement, I will try to relax the constraint.

> 
> > +
> > +       /* Pin pages before quiescing (may sleep) */
> > +       ubuf = kzalloc(sizeof(*ubuf), GFP_KERNEL);
> > +       if (!ubuf) {
> > +               ret = -ENOMEM;
> > +               goto put_disk;
> > +       }
> > +
> > +       ubuf->pages = kvmalloc_array(nr_pages, sizeof(*ubuf->pages),
> > +                                    GFP_KERNEL);
> > +       if (!ubuf->pages) {
> > +               ret = -ENOMEM;
> > +               goto err_free;
> > +       }
> > +
> > +       gup_flags = FOLL_LONGTERM;
> > +       if (!(buf_reg.flags & UBLK_SHMEM_BUF_READ_ONLY))
> > +               gup_flags |= FOLL_WRITE;
> > +
> > +       pinned = pin_user_pages_fast(addr, nr_pages, gup_flags, ubuf->pages);
> > +       if (pinned < 0) {
> > +               ret = pinned;
> > +               goto err_free_pages;
> > +       }
> > +       if (pinned != nr_pages) {
> > +               ret = -EFAULT;
> > +               goto err_unpin;
> > +       }
> > +       ubuf->nr_pages = nr_pages;
> > +
> > +       /*
> > +        * Drain inflight I/O and quiesce the queue so no new requests
> > +        * are dispatched while we modify the maple tree. Keep freeze
> > +        * and mutex non-nested to avoid lock dependency.
> > +        */
> > +       ublk_quiesce_and_release(disk);
> > +
> > +       mutex_lock(&ub->mutex);
> 
> Looks like the xarray and maple tree do their own spinlocking, is this needed?

Right, looks it isn't needed now, and it was added from beginning with plain
array.

> 
> > +
> > +       ret = xa_alloc(&ub->bufs_xa, &index, ubuf, xa_limit_16b, GFP_KERNEL);
> > +       if (ret)
> > +               goto err_unlock;
> > +
> > +       ret = __ublk_ctrl_reg_buf(ub, ubuf, index, buf_reg.flags);
> > +       if (ret) {
> > +               xa_erase(&ub->bufs_xa, index);
> > +               goto err_unlock;
> > +       }
> > +
> > +       mutex_unlock(&ub->mutex);
> > +
> > +       ublk_unquiesce_and_resume(disk);
> > +       ublk_put_disk(disk);
> > +       return index;
> > +
> > +err_unlock:
> > +       mutex_unlock(&ub->mutex);
> > +       ublk_unquiesce_and_resume(disk);
> > +err_unpin:
> > +       unpin_user_pages(ubuf->pages, pinned);
> > +err_free_pages:
> > +       kvfree(ubuf->pages);
> > +err_free:
> > +       kfree(ubuf);
> > +put_disk:
> > +       ublk_put_disk(disk);
> > +       return ret;
> > +}
> > +
> > +static void __ublk_ctrl_unreg_buf(struct ublk_device *ub,
> > +                                 struct ublk_buf *ubuf)
> > +{
> > +       ublk_buf_erase_ranges(ub, ubuf, ubuf->nr_pages);
> > +       unpin_user_pages(ubuf->pages, ubuf->nr_pages);
> > +       kvfree(ubuf->pages);
> > +       kfree(ubuf);
> > +}
> > +
> > +static int ublk_ctrl_unreg_buf(struct ublk_device *ub,
> > +                              struct ublksrv_ctrl_cmd *header)
> > +{
> > +       int index = (int)header->data[0];
> > +       struct gendisk *disk;
> > +       struct ublk_buf *ubuf;
> > +
> > +       if (!ublk_dev_support_shmem_zc(ub))
> > +               return -EOPNOTSUPP;
> > +
> > +       disk = ublk_get_disk(ub);
> > +       if (!disk)
> > +               return -ENODEV;
> > +
> > +       /* Drain inflight I/O before modifying the maple tree */
> > +       ublk_quiesce_and_release(disk);
> > +
> > +       mutex_lock(&ub->mutex);
> > +
> > +       ubuf = xa_erase(&ub->bufs_xa, index);
> > +       if (!ubuf) {
> > +               mutex_unlock(&ub->mutex);
> > +               ublk_unquiesce_and_resume(disk);
> > +               ublk_put_disk(disk);
> > +               return -ENOENT;
> > +       }
> > +
> > +       __ublk_ctrl_unreg_buf(ub, ubuf);
> > +
> > +       mutex_unlock(&ub->mutex);
> > +
> > +       ublk_unquiesce_and_resume(disk);
> > +       ublk_put_disk(disk);
> > +       return 0;
> > +}
> > +
> > +static void ublk_buf_cleanup(struct ublk_device *ub)
> > +{
> > +       struct ublk_buf *ubuf;
> > +       unsigned long index;
> > +
> > +       xa_for_each(&ub->bufs_xa, index, ubuf)
> > +               __ublk_ctrl_unreg_buf(ub, ubuf);
> 
> This looks quadratic in the number of registered buffers. Can we do a
> single pass over the xarray  and the maple tree?

It can be done two passes: first pass walks maple tree for unpinning
pages, the 2nd pass is for freeing buffers in xarray, which looks more
clean.

But the current way can reuse __ublk_ctrl_unreg_buf(), also
ublk_buf_cleanup() is only called one-shot in device release handler, so we can
leave it for future optimization.

> 
> > +       xa_destroy(&ub->bufs_xa);
> > +       mtree_destroy(&ub->buf_tree);
> > +}
> > +
> > +
> > +
> >  static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
> >                 u32 cmd_op, struct ublksrv_ctrl_cmd *header)
> >  {
> > @@ -5225,6 +5517,8 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
> >         case UBLK_CMD_UPDATE_SIZE:
> >         case UBLK_CMD_QUIESCE_DEV:
> >         case UBLK_CMD_TRY_STOP_DEV:
> > +       case UBLK_CMD_REG_BUF:
> > +       case UBLK_CMD_UNREG_BUF:
> >                 mask = MAY_READ | MAY_WRITE;
> >                 break;
> >         default:
> > @@ -5350,6 +5644,12 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
> >         case UBLK_CMD_TRY_STOP_DEV:
> >                 ret = ublk_ctrl_try_stop_dev(ub);
> >                 break;
> > +       case UBLK_CMD_REG_BUF:
> > +               ret = ublk_ctrl_reg_buf(ub, &header);
> > +               break;
> > +       case UBLK_CMD_UNREG_BUF:
> > +               ret = ublk_ctrl_unreg_buf(ub, &header);
> > +               break;
> >         default:
> >                 ret = -EOPNOTSUPP;
> >                 break;
> > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> > index a88876756805..52bb9b843d73 100644
> > --- a/include/uapi/linux/ublk_cmd.h
> > +++ b/include/uapi/linux/ublk_cmd.h
> > @@ -57,6 +57,44 @@
> >         _IOWR('u', 0x16, struct ublksrv_ctrl_cmd)
> >  #define UBLK_U_CMD_TRY_STOP_DEV                \
> >         _IOWR('u', 0x17, struct ublksrv_ctrl_cmd)
> > +/*
> > + * Register a shared memory buffer for zero-copy I/O.
> > + * Input:  ctrl_cmd.addr points to struct ublk_buf_reg (buffer VA + size)
> > + *         ctrl_cmd.len  = sizeof(struct ublk_buf_reg)
> > + * Result: >= 0 is the assigned buffer index, < 0 is error
> > + *
> > + * The kernel pins pages from the calling process's address space
> > + * and inserts PFN ranges into a per-device maple tree. When a block
> > + * request's pages match registered pages, the driver sets
> > + * UBLK_IO_F_SHMEM_ZC and encodes the buffer index + offset in addr,
> > + * allowing the server to access the data via its own mapping of the
> > + * same shared memory — true zero copy.
> > + *
> > + * The memory can be backed by memfd, hugetlbfs, or any GUP-compatible
> > + * shared mapping. Queue freeze is handled internally.
> > + *
> > + * The buffer VA and size are passed via a user buffer (not inline in
> > + * ctrl_cmd) so that unprivileged devices can prepend the device path
> > + * to ctrl_cmd.addr without corrupting the VA.
> > + */
> > +#define UBLK_U_CMD_REG_BUF             \
> > +       _IOWR('u', 0x18, struct ublksrv_ctrl_cmd)
> > +/*
> > + * Unregister a shared memory buffer.
> > + * Input:  ctrl_cmd.data[0] = buffer index
> > + */
> > +#define UBLK_U_CMD_UNREG_BUF           \
> > +       _IOWR('u', 0x19, struct ublksrv_ctrl_cmd)
> > +
> > +/* Parameter buffer for UBLK_U_CMD_REG_BUF, pointed to by ctrl_cmd.addr */
> > +struct ublk_shmem_buf_reg {
> > +       __u64   addr;   /* userspace virtual address of shared memory */
> > +       __u32   len;    /* buffer size in bytes (page-aligned, max 4GB) */
> > +       __u32   flags;
> > +};
> > +
> > +/* Pin pages without FOLL_WRITE; usable with write-sealed memfd */
> > +#define UBLK_SHMEM_BUF_READ_ONLY       (1U << 0)
> >  /*
> >   * 64bits are enough now, and it should be easy to extend in case of
> >   * running out of feature flags
> > @@ -370,6 +408,7 @@
> >  /* Disable automatic partition scanning when device is started */
> >  #define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
> >
> > +
> >  /* device state */
> >  #define UBLK_S_DEV_DEAD        0
> >  #define UBLK_S_DEV_LIVE        1
> > @@ -469,6 +508,12 @@ struct ublksrv_ctrl_dev_info {
> >  #define                UBLK_IO_F_NEED_REG_BUF          (1U << 17)
> >  /* Request has an integrity data buffer */
> >  #define                UBLK_IO_F_INTEGRITY             (1UL << 18)
> > +/*
> > + * I/O buffer is in a registered shared memory buffer. When set, the addr
> > + * field in ublksrv_io_desc encodes buffer index and byte offset instead
> > + * of a userspace virtual address.
> > + */
> > +#define                UBLK_IO_F_SHMEM_ZC              (1U << 19)
> >
> >  /*
> >   * io cmd is described by this structure, and stored in share memory, indexed
> > @@ -743,4 +788,31 @@ struct ublk_params {
> >         struct ublk_param_integrity     integrity;
> >  };
> >
> > +/*
> > + * Shared memory zero-copy addr encoding for UBLK_IO_F_SHMEM_ZC.
> > + *
> > + * When UBLK_IO_F_SHMEM_ZC is set, ublksrv_io_desc.addr is encoded as:
> > + *   bits [0:31]  = byte offset within the buffer (up to 4GB)
> > + *   bits [32:47] = buffer index (up to 65536)
> > + *   bits [48:63] = reserved (must be zero)
> 
> I wonder whether the "buffer index" is necessary. Can iod->addr and
> UBLK_U_CMD_UNREG_BUF refer to the buffer by the virtual address used
> with UBLK_U_CMD_REG_BUF? Then struct ublksrv_io_desc's addr field
> would retain its meaning. We would also avoid needing to compare the
> range buf_index values in ublk_try_buf_match(). And the xarray
> wouldn't be necessary to allocate buffer indices.

There are several reasons for choosing "buffer index":

- avoid to add extra storage in `struct ublk_buf_range`, extra
  `vaddr` field is required for returning virtual address; otherwise one extra
  lookup from buffer index is needed in fast path of ublk_try_buf_match()

- I want ublk server to know the difference between shmem_zc buffer and the
  plain IO buffer clearly, both two shouldn't be mixed, otherwise it is easy to
  cause data corruption. For example, client is using buf A, but the
  ublk server fallback code path may be using it at the same time.

- total registered buffers can be limited naturally by `u16` buffer_index

- it is proved that buffer index is one nice pattern wrt. buffer
  registration, such as io_uring fixed buffer; and it helps userspace
  to manage multiple buffers, given each one has unique ID.


Thanks, 
Ming

