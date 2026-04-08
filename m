Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588F37D138
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661627; cv=pass; b=LqyCvzTE/E5EpiKSJ34WRDyO1aOo/ju/7VOZ2W6TPlf8jw00IPYgwtVr0fjkYa5yoTiwkuw1qbh2aG6tQ5/Qr3OPqquRyd67UoKGIj/l8Rn0H/uruHWhiw8A5IKnlBqGjBVs8cVsBkQ/FYYIMLVBYEVFZPP47nluIeuU5DEAnrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661627; c=relaxed/simple;
	bh=tYWTlz+a9WEtcai1Jy5jYX+4rj7za9RjRDy0D4t0WtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tuv0rJoMzRhj97/XasKEm2hGhMWyBMSYEZstLGE5iaTqenR0541CA1FhY4XkBxvMpJMWv14nZeHSFS9/0AQOTLhlmy67aNnQksKS1MhuKtgqCkGcz06j24sEWOeV+1X2e6MU+Wng9aa/CVYbzeIa0Uc5c1CgkQUwsWMNFN+YcfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FoL4ruoN; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FoL4ruoN"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-466db7418b6so222344b6e.2
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 08:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775661624; cv=none;
        d=google.com; s=arc-20240605;
        b=LQEegkVhH3D8rhABYYzb0MWO3j5mXuiy1aLO3quyMgUgniOKmyDvibxFXYzOm5odza
         Clt4B/yYVQzbp2Fwky1V2VN/F5F5JEtIdiC0nurIGipAUkW32IAp1SxUs615QMs65GkI
         uYKQVE+K43OK6TJlLqF/GdlSZ8OKFYzHKKmQ34h50QWv0I9kIXfCaehDHF7a+uV0DzbD
         7uAvVTDzouJfIN6s+jypxwUnJnMTd3zHSfOU6uq2EJ+wFCVHvLKSrrnGc9iJ/iMkovM0
         E0PfucxWqYr6vomFnGoj91qMGFydwPtpXGrDomtNcrro/8HLjzMfak190X58KGK6j0Dw
         4/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v6XrirpwYr8BRzpFVHbVJ/jPW3sVFpvvGRU7AxegilI=;
        fh=EKNAWm5RJyPRdbx/ZNd3godOTKTzHQiqn3ldY/QN+fw=;
        b=e+cOvXWfrXsW8OMEv56aCzSXTgu2Y2JBC/Maq0F0Kzc8/m70AEOHPWPPuSnlzlDb4w
         nVpFTLQzHGr3kLJGdTZlwr74K9CiCfN0PubeJMGrvab+hmFp9rY+Z3gDy8cqoG2Q0zfe
         Ex93EY7qOJTL1dKy+9Guav4IJzusysAnjK67ahei+IK5QVG6hxWlLNWMvm2qYxgfXe3t
         blIziRbAtFYD8enpI/FSy5hDv/evSAUL4dFSupolJxz8UqsKlrK3i50NjNmcHkWsg4el
         1/PqBkWluITU1dUF/bl7RVg6fn3R5NPLmg41GhqHVoU8nkiSrKLIE6ZO5EPHy5vnrqrt
         VZaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775661624; x=1776266424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6XrirpwYr8BRzpFVHbVJ/jPW3sVFpvvGRU7AxegilI=;
        b=FoL4ruoNdxntZp5S/9buO0M+auDiI6ENcpwVIBtIfduxxzAS65jUJ4LGTj1Dh6+81n
         DegYiv/zZ/Ct5U+OsSRzIHNF7k/nLHvPndGT/yM0BQtobjJt6ZOub5rzsNGcIeZPxJND
         m/va21fvvBPVJTOB6/2d3sY/zYndEOkPgtE0THoWsvc96rmfCrGVTbBVXEtu7TdhD+6C
         x8oKSUNIjEYQ03jGKJrZAhKHikjFr6bpwv9b4IZFEykdj0PFlEyNjbYaixKy9ZRTtV1A
         iDixO3f15uTu7F6hhNY+PMC3BexDb+QOhFs91KsEszrcENV1bGkRTbIBL+k7l4NkKlrJ
         5PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661624; x=1776266424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v6XrirpwYr8BRzpFVHbVJ/jPW3sVFpvvGRU7AxegilI=;
        b=p0bs3WGKJ/SNvc3JtGaXkrlCXxfvxuNEU/OuByGDyqJr+pVdF7oajfJcTGZtRHXUI4
         vCcKeCq3NfGB+iTCg2UqBY/XygmPBaOXsBL+Wis0ViN/52XgidEGibUolyojBWDcXHdA
         O1/gSX+S48bAXUHi2oYSh+h8HeEiwD4vifhO5LxP/paWho6Yv++ngENIwulMv+Ze+2OA
         GCOTahIIzXsV6kCh5IAjD+gWUVT63NL/6E2N3nLmUph77JGFymCKAYj8yT+MOtbWk6F5
         adPYElSjxNEFa+EYKAxm4D9P3gJfzqXT2pW1s2RMQ+S5F1ohu+YyrbKYqLlb+Z98kSsT
         Io0g==
X-Forwarded-Encrypted: i=1; AJvYcCUoo6iZCdeaFv9LekxAVLPN/OmE99KhOXY20XQTYWV/pLZ3CGYPrAmnrHMQ/ZJKJZb7UY0TpDfJ2zuIPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJh4czws3EBoeBy+SXzcbp4QVxX1Y+pun3wlrQ9LSfv7Rc3YK
	xK31v9JWF45JQE9pUIHmDuXz3A/zFgzYIbVsxPY+K/e9nvmS4D31JPcXHTjsm17Oq+SFJotjd0N
	1qab4h/p2/KMFlUiwdlWgjey42OAbl4ven3yGXA/+QQ==
X-Gm-Gg: AeBDiespNdTb93m15TrVS4eOBXsgYGNwKHXsytL6Iq/yvs0rXSdW+rhAwv1jBOx/Xij
	As8kKwdyQ7dZ4WiUZozDr4epNtGFL27M95pxU9TMinHrwBd1rDVgxMEq0Apcl4LDb1srcOvx6So
	cFSmI5/Vg+SXq2aX6mHRcNKGB2D7mam6fBFJVS1p2D8DBehnCMzy+QEcHjDHeSsmQFqX+8Ddjaq
	an5cXy8CVisA8JF+bI1rokxTGhOxxYBrkohjdRGej74JFtYdRuJmqaMg37KHygRb5MdKPwUtl7W
	YzbEVExUv3ZzDaCYQw==
X-Received: by 2002:a05:6808:1a21:b0:46a:d50a:734a with SMTP id
 5614622812f47-46efa5935camr7332983b6e.4.1775661623539; Wed, 08 Apr 2026
 08:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153207.3635125-1-ming.lei@redhat.com> <20260331153207.3635125-2-ming.lei@redhat.com>
 <CADUfDZpUbses5NNR19M+81ZwDxSAb6ktz0+2f9GfkOL8yzEh+w@mail.gmail.com> <adW8I8RpSD471iFy@fedora>
In-Reply-To: <adW8I8RpSD471iFy@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 8 Apr 2026 08:20:12 -0700
X-Gm-Features: AQROBzBSpa7cxJjBJ7IPbO5arsblRBcua_eKxs4mWQOK46NHihmJDdI56oUmdrM
Message-ID: <CADUfDZrs=6srDdL15KG-uL2PX9p5_piJVU0GZZTYjE0VfDQJKw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] ublk: add UBLK_U_CMD_REG_BUF/UNREG_BUF control commands
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 7:23=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Tue, Apr 07, 2026 at 12:35:49PM -0700, Caleb Sander Mateos wrote:
> > On Tue, Mar 31, 2026 at 8:32=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Add control commands for registering and unregistering shared memory
> > > buffers for zero-copy I/O:
> > >
> > > - UBLK_U_CMD_REG_BUF (0x18): pins pages from userspace, inserts PFN
> > >   ranges into a per-device maple tree for O(log n) lookup during I/O.
> > >   Buffer pointers are tracked in a per-device xarray. Returns the
> > >   assigned buffer index.
> > >
> > > - UBLK_U_CMD_UNREG_BUF (0x19): removes PFN entries and unpins pages.
> > >
> > > Queue freeze/unfreeze is handled internally so userspace need not
> > > quiesce the device during registration.
> > >
> > > Also adds:
> > > - UBLK_IO_F_SHMEM_ZC flag and addr encoding helpers in UAPI header
> > >   (16-bit buffer index supporting up to 65536 buffers)
> > > - Data structures (ublk_buf, ublk_buf_range) and xarray/maple tree
> > > - __ublk_ctrl_reg_buf() helper for PFN insertion with error unwinding
> > > - __ublk_ctrl_unreg_buf() helper for cleanup reuse
> > > - ublk_support_shmem_zc() / ublk_dev_support_shmem_zc() stubs
> > >   (returning false =E2=80=94 feature not enabled yet)
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 300 ++++++++++++++++++++++++++++++++=
++
> > >  include/uapi/linux/ublk_cmd.h |  72 ++++++++
> > >  2 files changed, 372 insertions(+)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 71c7c56b38ca..ac6ccc174d44 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -46,6 +46,8 @@
> > >  #include <linux/kref.h>
> > >  #include <linux/kfifo.h>
> > >  #include <linux/blk-integrity.h>
> > > +#include <linux/maple_tree.h>
> > > +#include <linux/xarray.h>
> > >  #include <uapi/linux/fs.h>
> > >  #include <uapi/linux/ublk_cmd.h>
> > >
> > > @@ -58,6 +60,8 @@
> > >  #define UBLK_CMD_UPDATE_SIZE   _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
> > >  #define UBLK_CMD_QUIESCE_DEV   _IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
> > >  #define UBLK_CMD_TRY_STOP_DEV  _IOC_NR(UBLK_U_CMD_TRY_STOP_DEV)
> > > +#define UBLK_CMD_REG_BUF       _IOC_NR(UBLK_U_CMD_REG_BUF)
> > > +#define UBLK_CMD_UNREG_BUF     _IOC_NR(UBLK_U_CMD_UNREG_BUF)
> > >
> > >  #define UBLK_IO_REGISTER_IO_BUF                _IOC_NR(UBLK_U_IO_REG=
ISTER_IO_BUF)
> > >  #define UBLK_IO_UNREGISTER_IO_BUF      _IOC_NR(UBLK_U_IO_UNREGISTER_=
IO_BUF)
> > > @@ -289,6 +293,20 @@ struct ublk_queue {
> > >         struct ublk_io ios[] __counted_by(q_depth);
> > >  };
> > >
> > > +/* Per-registered shared memory buffer */
> > > +struct ublk_buf {
> > > +       struct page **pages;
> > > +       unsigned int nr_pages;
> > > +};
> > > +
> > > +/* Maple tree value: maps a PFN range to buffer location */
> > > +struct ublk_buf_range {
> > > +       unsigned long base_pfn;
> > > +       unsigned short buf_index;
> > > +       unsigned short flags;
> > > +       unsigned int base_offset;       /* byte offset within buffer =
*/
> > > +};
> > > +
> > >  struct ublk_device {
> > >         struct gendisk          *ub_disk;
> > >
> > > @@ -323,6 +341,10 @@ struct ublk_device {
> > >
> > >         bool                    block_open; /* protected by open_mute=
x */
> > >
> > > +       /* shared memory zero copy */
> > > +       struct maple_tree       buf_tree;
> > > +       struct xarray           bufs_xa;
> > > +
> > >         struct ublk_queue       *queues[];
> > >  };
> > >
> > > @@ -334,6 +356,7 @@ struct ublk_params_header {
> > >
> > >  static void ublk_io_release(void *priv);
> > >  static void ublk_stop_dev_unlocked(struct ublk_device *ub);
> > > +static void ublk_buf_cleanup(struct ublk_device *ub);
> > >  static void ublk_abort_queue(struct ublk_device *ub, struct ublk_que=
ue *ubq);
> > >  static inline struct request *__ublk_check_and_get_req(struct ublk_d=
evice *ub,
> > >                 u16 q_id, u16 tag, struct ublk_io *io);
> > > @@ -398,6 +421,16 @@ static inline bool ublk_dev_support_zero_copy(co=
nst struct ublk_device *ub)
> > >         return ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY;
> > >  }
> > >
> > > +static inline bool ublk_support_shmem_zc(const struct ublk_queue *ub=
q)
> > > +{
> > > +       return false;
> > > +}
> > > +
> > > +static inline bool ublk_dev_support_shmem_zc(const struct ublk_devic=
e *ub)
> > > +{
> > > +       return false;
> > > +}
> > > +
> > >  static inline bool ublk_support_auto_buf_reg(const struct ublk_queue=
 *ubq)
> > >  {
> > >         return ubq->flags & UBLK_F_AUTO_BUF_REG;
> > > @@ -1460,6 +1493,7 @@ static blk_status_t ublk_setup_iod(struct ublk_=
queue *ubq, struct request *req)
> > >         iod->op_flags =3D ublk_op | ublk_req_build_flags(req);
> > >         iod->nr_sectors =3D blk_rq_sectors(req);
> > >         iod->start_sector =3D blk_rq_pos(req);
> > > +
> >
> > nit: unrelated whitespace change?
> >
> > >         iod->addr =3D io->buf.addr;
> > >
> > >         return BLK_STS_OK;
> > > @@ -1665,6 +1699,7 @@ static bool ublk_start_io(const struct ublk_que=
ue *ubq, struct request *req,
> > >  {
> > >         unsigned mapped_bytes =3D ublk_map_io(ubq, req, io);
> > >
> > > +
> >
> > nit: unrelated whitespace change?
> >
> > >         /* partially mapped, update io descriptor */
> > >         if (unlikely(mapped_bytes !=3D blk_rq_bytes(req))) {
> > >                 /*
> > > @@ -4206,6 +4241,7 @@ static void ublk_cdev_rel(struct device *dev)
> > >  {
> > >         struct ublk_device *ub =3D container_of(dev, struct ublk_devi=
ce, cdev_dev);
> > >
> > > +       ublk_buf_cleanup(ub);
> > >         blk_mq_free_tag_set(&ub->tag_set);
> > >         ublk_deinit_queues(ub);
> > >         ublk_free_dev_number(ub);
> > > @@ -4625,6 +4661,8 @@ static int ublk_ctrl_add_dev(const struct ublks=
rv_ctrl_cmd *header)
> > >         mutex_init(&ub->mutex);
> > >         spin_lock_init(&ub->lock);
> > >         mutex_init(&ub->cancel_mutex);
> > > +       mt_init(&ub->buf_tree);
> > > +       xa_init_flags(&ub->bufs_xa, XA_FLAGS_ALLOC);
> > >         INIT_WORK(&ub->partition_scan_work, ublk_partition_scan_work)=
;
> > >
> > >         ret =3D ublk_alloc_dev_number(ub, header->dev_id);
> > > @@ -5168,6 +5206,260 @@ static int ublk_char_dev_permission(struct ub=
lk_device *ub,
> > >         return err;
> > >  }
> > >
> > > +/*
> > > + * Drain inflight I/O and quiesce the queue. Freeze drains all infli=
ght
> > > + * requests, quiesce_nowait marks the queue so no new requests dispa=
tch,
> > > + * then unfreeze allows new submissions (which won't dispatch due to
> > > + * quiesce). This keeps freeze and ub->mutex non-nested.
> > > + */
> > > +static void ublk_quiesce_and_release(struct gendisk *disk)
> > > +{
> > > +       unsigned int memflags;
> > > +
> > > +       memflags =3D blk_mq_freeze_queue(disk->queue);
> > > +       blk_mq_quiesce_queue_nowait(disk->queue);
> > > +       blk_mq_unfreeze_queue(disk->queue, memflags);
> > > +}
> > > +
> > > +static void ublk_unquiesce_and_resume(struct gendisk *disk)
> > > +{
> > > +       blk_mq_unquiesce_queue(disk->queue);
> > > +}
> > > +
> > > +/*
> > > + * Insert PFN ranges of a registered buffer into the maple tree,
> > > + * coalescing consecutive PFNs into single range entries.
> > > + * Returns 0 on success, negative error with partial insertions unwo=
und.
> > > + */
> > > +/* Erase coalesced PFN ranges from the maple tree for pages [0, nr_p=
ages) */
> > > +static void ublk_buf_erase_ranges(struct ublk_device *ub,
> > > +                                 struct ublk_buf *ubuf,
> > > +                                 unsigned long nr_pages)
> > > +{
> > > +       unsigned long i;
> > > +
> > > +       for (i =3D 0; i < nr_pages; ) {
> > > +               unsigned long pfn =3D page_to_pfn(ubuf->pages[i]);
> > > +               unsigned long start =3D i;
> > > +
> > > +               while (i + 1 < nr_pages &&
> > > +                      page_to_pfn(ubuf->pages[i + 1]) =3D=3D pfn + (=
i - start) + 1)
> > > +                       i++;
> > > +               i++;
> > > +               kfree(mtree_erase(&ub->buf_tree, pfn));
> > > +       }
> > > +}
> > > +
> > > +static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
> > > +                              struct ublk_buf *ubuf, int index,
> > > +                              unsigned short flags)
> > > +{
> > > +       unsigned long nr_pages =3D ubuf->nr_pages;
> > > +       unsigned long i;
> > > +       int ret;
> > > +
> > > +       for (i =3D 0; i < nr_pages; ) {
> > > +               unsigned long pfn =3D page_to_pfn(ubuf->pages[i]);
> > > +               unsigned long start =3D i;
> > > +               struct ublk_buf_range *range;
> > > +
> > > +               /* Find run of consecutive PFNs */
> > > +               while (i + 1 < nr_pages &&
> > > +                      page_to_pfn(ubuf->pages[i + 1]) =3D=3D pfn + (=
i - start) + 1)
> > > +                       i++;
> > > +               i++;    /* past the last page in this run */
> >
> > Move this increment to the for loop so you don't need the "- 1" in the
> > mtree_insert_range() call?
>
> Good catch!
>
> >
> > > +
> > > +               range =3D kzalloc(sizeof(*range), GFP_KERNEL);
> >
> > Not sure kzalloc() is necessary; all the fields are initialized below
>
> Yeah, kmalloc() is fine, and we shouldn't add more fields to `range` in
> future.
>
> >
> > > +               if (!range) {
> > > +                       ret =3D -ENOMEM;
> > > +                       goto unwind;
> > > +               }
> > > +               range->buf_index =3D index;
> > > +               range->flags =3D flags;
> > > +               range->base_pfn =3D pfn;
> > > +               range->base_offset =3D start << PAGE_SHIFT;
> > > +
> > > +               ret =3D mtree_insert_range(&ub->buf_tree, pfn,
> > > +                                        pfn + (i - start) - 1,
> > > +                                        range, GFP_KERNEL);
> > > +               if (ret) {
> > > +                       kfree(range);
> > > +                       goto unwind;
> > > +               }
> > > +       }
> > > +       return 0;
> > > +
> > > +unwind:
> > > +       ublk_buf_erase_ranges(ub, ubuf, i);
> > > +       return ret;
> > > +}
> > > +
> > > +/*
> > > + * Register a shared memory buffer for zero-copy I/O.
> > > + * Pins pages, builds PFN maple tree, freezes/unfreezes the queue
> > > + * internally. Returns buffer index (>=3D 0) on success.
> > > + */
> > > +static int ublk_ctrl_reg_buf(struct ublk_device *ub,
> > > +                            struct ublksrv_ctrl_cmd *header)
> > > +{
> > > +       void __user *argp =3D (void __user *)(unsigned long)header->a=
ddr;
> > > +       struct ublk_shmem_buf_reg buf_reg;
> > > +       unsigned long addr, size, nr_pages;
> >
> > size and nr_pages could be u32
>
> Yeah, it was caused by internal change on `ublk_shmem_buf_reg`.
>
> >
> > > +       unsigned int gup_flags;
> > > +       struct gendisk *disk;
> > > +       struct ublk_buf *ubuf;
> > > +       long pinned;
> >
> > pinned could be int to match the return type of pin_user_pages_fast()
>
> OK.
>
> >
> > > +       u32 index;
> > > +       int ret;
> > > +
> > > +       if (!ublk_dev_support_shmem_zc(ub))
> > > +               return -EOPNOTSUPP;
> > > +
> > > +       memset(&buf_reg, 0, sizeof(buf_reg));
> > > +       if (copy_from_user(&buf_reg, argp,
> > > +                          min_t(size_t, header->len, sizeof(buf_reg)=
)))
> > > +               return -EFAULT;
> > > +
> > > +       if (buf_reg.flags & ~UBLK_SHMEM_BUF_READ_ONLY)
> > > +               return -EINVAL;
> > > +
> > > +       addr =3D buf_reg.addr;
> > > +       size =3D buf_reg.len;
> >
> > nit: don't see much value in these additional variables that are just
> > copies of buf_reg fields
> >
> > > +       nr_pages =3D size >> PAGE_SHIFT;
> > > +
> > > +       if (!size || !PAGE_ALIGNED(size) || !PAGE_ALIGNED(addr))
> > > +               return -EINVAL;
> > > +
> > > +       disk =3D ublk_get_disk(ub);
> > > +       if (!disk)
> > > +               return -ENODEV;
> >
> > So buffers can't be registered before the ublk device is started? Is
> > there a reason why that's not possible? Could we just make the
> > ublk_quiesce_and_release() and ublk_unquiesce_and_resume() conditional
> > on disk being non-NULL? I guess we'd have to hold the ublk_device
> > mutex before calling ublk_get_disk() to prevent it from being assigned
> > concurrently.
>
> Here `disk` is used for freeze & quiesce queue.
>
> But the implementation can be a bit more complicated given the dependency
> between ub->mutex and freeze queue should be avoided.
>
> Anyway, it is one nice requirement, I will try to relax the constraint.
>
> >
> > > +
> > > +       /* Pin pages before quiescing (may sleep) */
> > > +       ubuf =3D kzalloc(sizeof(*ubuf), GFP_KERNEL);
> > > +       if (!ubuf) {
> > > +               ret =3D -ENOMEM;
> > > +               goto put_disk;
> > > +       }
> > > +
> > > +       ubuf->pages =3D kvmalloc_array(nr_pages, sizeof(*ubuf->pages)=
,
> > > +                                    GFP_KERNEL);
> > > +       if (!ubuf->pages) {
> > > +               ret =3D -ENOMEM;
> > > +               goto err_free;
> > > +       }
> > > +
> > > +       gup_flags =3D FOLL_LONGTERM;
> > > +       if (!(buf_reg.flags & UBLK_SHMEM_BUF_READ_ONLY))
> > > +               gup_flags |=3D FOLL_WRITE;
> > > +
> > > +       pinned =3D pin_user_pages_fast(addr, nr_pages, gup_flags, ubu=
f->pages);
> > > +       if (pinned < 0) {
> > > +               ret =3D pinned;
> > > +               goto err_free_pages;
> > > +       }
> > > +       if (pinned !=3D nr_pages) {
> > > +               ret =3D -EFAULT;
> > > +               goto err_unpin;
> > > +       }
> > > +       ubuf->nr_pages =3D nr_pages;
> > > +
> > > +       /*
> > > +        * Drain inflight I/O and quiesce the queue so no new request=
s
> > > +        * are dispatched while we modify the maple tree. Keep freeze
> > > +        * and mutex non-nested to avoid lock dependency.
> > > +        */
> > > +       ublk_quiesce_and_release(disk);
> > > +
> > > +       mutex_lock(&ub->mutex);
> >
> > Looks like the xarray and maple tree do their own spinlocking, is this =
needed?
>
> Right, looks it isn't needed now, and it was added from beginning with pl=
ain
> array.
>
> >
> > > +
> > > +       ret =3D xa_alloc(&ub->bufs_xa, &index, ubuf, xa_limit_16b, GF=
P_KERNEL);
> > > +       if (ret)
> > > +               goto err_unlock;
> > > +
> > > +       ret =3D __ublk_ctrl_reg_buf(ub, ubuf, index, buf_reg.flags);
> > > +       if (ret) {
> > > +               xa_erase(&ub->bufs_xa, index);
> > > +               goto err_unlock;
> > > +       }
> > > +
> > > +       mutex_unlock(&ub->mutex);
> > > +
> > > +       ublk_unquiesce_and_resume(disk);
> > > +       ublk_put_disk(disk);
> > > +       return index;
> > > +
> > > +err_unlock:
> > > +       mutex_unlock(&ub->mutex);
> > > +       ublk_unquiesce_and_resume(disk);
> > > +err_unpin:
> > > +       unpin_user_pages(ubuf->pages, pinned);
> > > +err_free_pages:
> > > +       kvfree(ubuf->pages);
> > > +err_free:
> > > +       kfree(ubuf);
> > > +put_disk:
> > > +       ublk_put_disk(disk);
> > > +       return ret;
> > > +}
> > > +
> > > +static void __ublk_ctrl_unreg_buf(struct ublk_device *ub,
> > > +                                 struct ublk_buf *ubuf)
> > > +{
> > > +       ublk_buf_erase_ranges(ub, ubuf, ubuf->nr_pages);
> > > +       unpin_user_pages(ubuf->pages, ubuf->nr_pages);
> > > +       kvfree(ubuf->pages);
> > > +       kfree(ubuf);
> > > +}
> > > +
> > > +static int ublk_ctrl_unreg_buf(struct ublk_device *ub,
> > > +                              struct ublksrv_ctrl_cmd *header)
> > > +{
> > > +       int index =3D (int)header->data[0];
> > > +       struct gendisk *disk;
> > > +       struct ublk_buf *ubuf;
> > > +
> > > +       if (!ublk_dev_support_shmem_zc(ub))
> > > +               return -EOPNOTSUPP;
> > > +
> > > +       disk =3D ublk_get_disk(ub);
> > > +       if (!disk)
> > > +               return -ENODEV;
> > > +
> > > +       /* Drain inflight I/O before modifying the maple tree */
> > > +       ublk_quiesce_and_release(disk);
> > > +
> > > +       mutex_lock(&ub->mutex);
> > > +
> > > +       ubuf =3D xa_erase(&ub->bufs_xa, index);
> > > +       if (!ubuf) {
> > > +               mutex_unlock(&ub->mutex);
> > > +               ublk_unquiesce_and_resume(disk);
> > > +               ublk_put_disk(disk);
> > > +               return -ENOENT;
> > > +       }
> > > +
> > > +       __ublk_ctrl_unreg_buf(ub, ubuf);
> > > +
> > > +       mutex_unlock(&ub->mutex);
> > > +
> > > +       ublk_unquiesce_and_resume(disk);
> > > +       ublk_put_disk(disk);
> > > +       return 0;
> > > +}
> > > +
> > > +static void ublk_buf_cleanup(struct ublk_device *ub)
> > > +{
> > > +       struct ublk_buf *ubuf;
> > > +       unsigned long index;
> > > +
> > > +       xa_for_each(&ub->bufs_xa, index, ubuf)
> > > +               __ublk_ctrl_unreg_buf(ub, ubuf);
> >
> > This looks quadratic in the number of registered buffers. Can we do a
> > single pass over the xarray  and the maple tree?
>
> It can be done two passes: first pass walks maple tree for unpinning
> pages, the 2nd pass is for freeing buffers in xarray, which looks more
> clean.
>
> But the current way can reuse __ublk_ctrl_unreg_buf(), also
> ublk_buf_cleanup() is only called one-shot in device release handler, so =
we can
> leave it for future optimization.
>
> >
> > > +       xa_destroy(&ub->bufs_xa);
> > > +       mtree_destroy(&ub->buf_tree);
> > > +}
> > > +
> > > +
> > > +
> > >  static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
> > >                 u32 cmd_op, struct ublksrv_ctrl_cmd *header)
> > >  {
> > > @@ -5225,6 +5517,8 @@ static int ublk_ctrl_uring_cmd_permission(struc=
t ublk_device *ub,
> > >         case UBLK_CMD_UPDATE_SIZE:
> > >         case UBLK_CMD_QUIESCE_DEV:
> > >         case UBLK_CMD_TRY_STOP_DEV:
> > > +       case UBLK_CMD_REG_BUF:
> > > +       case UBLK_CMD_UNREG_BUF:
> > >                 mask =3D MAY_READ | MAY_WRITE;
> > >                 break;
> > >         default:
> > > @@ -5350,6 +5644,12 @@ static int ublk_ctrl_uring_cmd(struct io_uring=
_cmd *cmd,
> > >         case UBLK_CMD_TRY_STOP_DEV:
> > >                 ret =3D ublk_ctrl_try_stop_dev(ub);
> > >                 break;
> > > +       case UBLK_CMD_REG_BUF:
> > > +               ret =3D ublk_ctrl_reg_buf(ub, &header);
> > > +               break;
> > > +       case UBLK_CMD_UNREG_BUF:
> > > +               ret =3D ublk_ctrl_unreg_buf(ub, &header);
> > > +               break;
> > >         default:
> > >                 ret =3D -EOPNOTSUPP;
> > >                 break;
> > > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_=
cmd.h
> > > index a88876756805..52bb9b843d73 100644
> > > --- a/include/uapi/linux/ublk_cmd.h
> > > +++ b/include/uapi/linux/ublk_cmd.h
> > > @@ -57,6 +57,44 @@
> > >         _IOWR('u', 0x16, struct ublksrv_ctrl_cmd)
> > >  #define UBLK_U_CMD_TRY_STOP_DEV                \
> > >         _IOWR('u', 0x17, struct ublksrv_ctrl_cmd)
> > > +/*
> > > + * Register a shared memory buffer for zero-copy I/O.
> > > + * Input:  ctrl_cmd.addr points to struct ublk_buf_reg (buffer VA + =
size)
> > > + *         ctrl_cmd.len  =3D sizeof(struct ublk_buf_reg)
> > > + * Result: >=3D 0 is the assigned buffer index, < 0 is error
> > > + *
> > > + * The kernel pins pages from the calling process's address space
> > > + * and inserts PFN ranges into a per-device maple tree. When a block
> > > + * request's pages match registered pages, the driver sets
> > > + * UBLK_IO_F_SHMEM_ZC and encodes the buffer index + offset in addr,
> > > + * allowing the server to access the data via its own mapping of the
> > > + * same shared memory =E2=80=94 true zero copy.
> > > + *
> > > + * The memory can be backed by memfd, hugetlbfs, or any GUP-compatib=
le
> > > + * shared mapping. Queue freeze is handled internally.
> > > + *
> > > + * The buffer VA and size are passed via a user buffer (not inline i=
n
> > > + * ctrl_cmd) so that unprivileged devices can prepend the device pat=
h
> > > + * to ctrl_cmd.addr without corrupting the VA.
> > > + */
> > > +#define UBLK_U_CMD_REG_BUF             \
> > > +       _IOWR('u', 0x18, struct ublksrv_ctrl_cmd)
> > > +/*
> > > + * Unregister a shared memory buffer.
> > > + * Input:  ctrl_cmd.data[0] =3D buffer index
> > > + */
> > > +#define UBLK_U_CMD_UNREG_BUF           \
> > > +       _IOWR('u', 0x19, struct ublksrv_ctrl_cmd)
> > > +
> > > +/* Parameter buffer for UBLK_U_CMD_REG_BUF, pointed to by ctrl_cmd.a=
ddr */
> > > +struct ublk_shmem_buf_reg {
> > > +       __u64   addr;   /* userspace virtual address of shared memory=
 */
> > > +       __u32   len;    /* buffer size in bytes (page-aligned, max 4G=
B) */
> > > +       __u32   flags;
> > > +};
> > > +
> > > +/* Pin pages without FOLL_WRITE; usable with write-sealed memfd */
> > > +#define UBLK_SHMEM_BUF_READ_ONLY       (1U << 0)
> > >  /*
> > >   * 64bits are enough now, and it should be easy to extend in case of
> > >   * running out of feature flags
> > > @@ -370,6 +408,7 @@
> > >  /* Disable automatic partition scanning when device is started */
> > >  #define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
> > >
> > > +
> > >  /* device state */
> > >  #define UBLK_S_DEV_DEAD        0
> > >  #define UBLK_S_DEV_LIVE        1
> > > @@ -469,6 +508,12 @@ struct ublksrv_ctrl_dev_info {
> > >  #define                UBLK_IO_F_NEED_REG_BUF          (1U << 17)
> > >  /* Request has an integrity data buffer */
> > >  #define                UBLK_IO_F_INTEGRITY             (1UL << 18)
> > > +/*
> > > + * I/O buffer is in a registered shared memory buffer. When set, the=
 addr
> > > + * field in ublksrv_io_desc encodes buffer index and byte offset ins=
tead
> > > + * of a userspace virtual address.
> > > + */
> > > +#define                UBLK_IO_F_SHMEM_ZC              (1U << 19)
> > >
> > >  /*
> > >   * io cmd is described by this structure, and stored in share memory=
, indexed
> > > @@ -743,4 +788,31 @@ struct ublk_params {
> > >         struct ublk_param_integrity     integrity;
> > >  };
> > >
> > > +/*
> > > + * Shared memory zero-copy addr encoding for UBLK_IO_F_SHMEM_ZC.
> > > + *
> > > + * When UBLK_IO_F_SHMEM_ZC is set, ublksrv_io_desc.addr is encoded a=
s:
> > > + *   bits [0:31]  =3D byte offset within the buffer (up to 4GB)
> > > + *   bits [32:47] =3D buffer index (up to 65536)
> > > + *   bits [48:63] =3D reserved (must be zero)
> >
> > I wonder whether the "buffer index" is necessary. Can iod->addr and
> > UBLK_U_CMD_UNREG_BUF refer to the buffer by the virtual address used
> > with UBLK_U_CMD_REG_BUF? Then struct ublksrv_io_desc's addr field
> > would retain its meaning. We would also avoid needing to compare the
> > range buf_index values in ublk_try_buf_match(). And the xarray
> > wouldn't be necessary to allocate buffer indices.
>
> There are several reasons for choosing "buffer index":
>
> - avoid to add extra storage in `struct ublk_buf_range`, extra
>   `vaddr` field is required for returning virtual address; otherwise one =
extra
>   lookup from buffer index is needed in fast path of ublk_try_buf_match()

Yes, struct ublk_buf_range would have to track the virtual address,
but that would replace both buf_index and base_offset. And you could
store flags in the lower bits of the virtual address (since it has to
be page-aligned) if you want to keep it as 16 bytes. I'm not sure what
you mean about "one extra lookup from buffer index"; I was thinking it
would be possible to get rid of buffer indices entirely.

>
> - I want ublk server to know the difference between shmem_zc buffer and t=
he
>   plain IO buffer clearly, both two shouldn't be mixed, otherwise it is e=
asy to
>   cause data corruption. For example, client is using buf A, but the
>   ublk server fallback code path may be using it at the same time.

Yes, certainly the ublk server should only use a shared-memory buffer
when an incoming UBLK_IO_F_SHMEM_ZC request specifies it. I don't see
the connection to referring to buffers by virtual address instead of
buffer index, though. The kernel can't prevent the ublk server from
writing to a registered shared memory region it has mapped into its
address space.

It seems like a simpler interface if iod->addr indicates the virtual
address of the data buffer regardless of the UBLK_IO_F_SHMEM_ZC flag.
Then the ublk server doesn't have to care whether the data is in
shared memory or was copied automatically by the
ublk_map_io()/ublk_unmap_io() fallback path; it just accesses the
memory at iod->addr and lets the kernel take care of the copying (if
necessary).

>
> - total registered buffers can be limited naturally by `u16` buffer_index

I don't really see a reason to limit the number of SHMEM_ZC buffers if
they don't consume any per-buffer resources. I think it would make
more sense to limit it based on the _total size_ of registered
buffers, but the page pinning should already provide that.

>
> - it is proved that buffer index is one nice pattern wrt. buffer
>   registration, such as io_uring fixed buffer; and it helps userspace
>   to manage multiple buffers, given each one has unique ID.

If you really prefer the (buf_index, buf_offset) interface, I won't
stand in the way. It just seems to me like the only thing the ublk
server cares about a shared memory buffer is its virtual address, so
that's a more natural way to refer to it.

Best,
Caleb
