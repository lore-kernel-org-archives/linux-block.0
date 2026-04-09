Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AFE15C14F
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775769759; cv=pass; b=iP4nrlcOvbUuA4Z/psU69FKejBfmxrntuJUiCj3yDxtFOo0fbEHpe2grDwv+okARMCPbAnUe9I19x9CTElM3lBH2O5ZcDceFsF2g1qBcwP+zuF4zX3CvIKmKk84tYhVwZy+tRkwwbTbEZVNoEAc0qaU75EirWiSoYO/6t5preGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775769759; c=relaxed/simple;
	bh=lotGdiOQcxXCIOpvGO0w7p0cgnas83zeh83vDUAs1lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcAjxPsIZdk7Hj3WhgX7ss2bK3PF2gTIO3wWTsi6ENnO0MzNNCtN2RZsHrnD0apkVJEyo/9hQ3hlvXnjD6U9Dr71Tt/pvTLSjAC0x2sog6joW3C/Ggi+N4MuqTa/623T3KJDM+99R05fuAr3ynxkL6K4YuPrnXShR/1SAwKq91I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AHdmSi+4; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AHdmSi+4"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-41540f23deaso123396fac.2
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 14:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775769756; cv=none;
        d=google.com; s=arc-20240605;
        b=Y6lIh9EyQ145BP/MbXj4PgDQR1MIfqNZk+N/ZxY8C0zrIm+xZ9Ugpc6iqbzgdi4rZC
         /nShtcw9QJ+BL0CKhEG4gvT4EPJhcxG+/QNcCGu8JbbycO0T+4SXqBKL3mSfv2502UfG
         XVhUF1yTBBb2YOeEPDE2Eco3QdlmmnKkOlgrDiZ7qw51isrmzm1rD8XvAxIUDS6ypH8V
         uQ7OSIAzJiE1CRc6Zxrc07NuZa/chZ7a2O11N5tSeq1mL/4WzMVO7QvzZ6goBE1bkRlq
         LqY0JOEbNQjJZnRwewp2zm/L3ltSQ68jTPV9KFWNy6PPCf+y+fBnCcp1RfJt7QWPmHLX
         f+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BSsxtWh/1TbRqxO2JNPP1bEQQZaBiMA1ueC/xMWhN4Q=;
        fh=bb6CKnwnOnzKKYOPjEdVCFWRPtu3xt8jYOG3XpL/bYk=;
        b=B2Y1pnA9nYzgDcfET/3nVTvabFAjfOD1GJqwl6Ru+6CGwTpUpLwwVFwDXIt+zAR9Y+
         uY56gGuJAaSiQnceXa2MpPGjdDwsBqKj7Ax+U9gVmCKWpgS7ZD1R0c79e3m7gFbfckvq
         cJ9xujRy34YA5dJhgez2R5CxYQ7pmZG/O/e2De3HvoKLN3tWjxEfaDdIyWMdL+61mSA4
         SBHZD29gL9If2z0a8zlAHFVeOpc4/CuX3dkXfw7C86fuhKKi/6uFr1j1nvld5WIOO02R
         Pc0+2YJSSkkTYeh4CFUaIDcEEzN0L+KYKnYwbMITHJMY989cWk718mQdyehNu7+HfVWU
         pJtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775769756; x=1776374556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSsxtWh/1TbRqxO2JNPP1bEQQZaBiMA1ueC/xMWhN4Q=;
        b=AHdmSi+4ty8ZjDGMBU0kQjNhEDdfQoLj5AyUiXfzEj3ZKQ4EDYmm9Y1/uZYyWCFznj
         WChhaJdTqe1k+FJA6INxmTacf9Bd5PhfYsLT3pd/Rzh4RzncgPZ0vtkl27VedKdxXbF/
         dFZuWbZqHO69ppjej2xZuj1gC2He/mkCOO4klCcKai4y5ffAKBPo2ah56LOagYFGXRP9
         zORIGXCHCDHBp1U6SLidb01+k+Q0OsAFnbp2i3R38l/uoVYghCiQJBOQWa/u8Aqtu6Nx
         UNcf6lzm6khhgOkuaocwQkF/tW4w45iV/FM7nH9jl3fYDwp/u8VoVyPbSwTIjLqG+Ysq
         m3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775769756; x=1776374556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSsxtWh/1TbRqxO2JNPP1bEQQZaBiMA1ueC/xMWhN4Q=;
        b=s76Gu05n7MkfmDN5YjkJcs7VjEZeKvKnDl/8/FxU07kpxoGF/7LYp6jdFg7Gw8EPLi
         MR/SiARliTdBrugxCL1gzfkujTuDb5nHUkIiv9E8+TRvlt26fGxid1+kmOEEnCt8aMvE
         wiyDYwIhxxkpsb1Z6QTQVeWhnvGJAJ6T4/M00XsWgDq4h746BT530wcdDe+xOry8zy/Q
         cgqZqOUjuQJrZP7ULzOk+zly2GIUQcDYf4uNTYJODA8+hPJCQyrgbDdkfTk6AZ/lfLEN
         YGV9aj0tZqNXHLz03F6sDB6ZaCd8EzkzfCQiiEwBAANurxzvyd3Fm8/HSjYxKJ/svpwx
         7jLw==
X-Forwarded-Encrypted: i=1; AJvYcCVHd2jPDZbGQF/aODT7UZIcsrnCbAuDw8msJIHlQ2k+AcjGEsQjKR89KupowEsHMXX8Ga/FAuXPoQ2jKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEm+yFqNnjLD1eBv5ICEoPnlFzgUGc9NCPX5cI3tCTKtWWh/lt
	gvImJC2CYYTCqMY5/iYsGaLwVgGA4C9BTXS8KupaZ9GsSa44hrmLD7+NjMp8OVFBQRRNIPNwKlS
	qGnUEOHEtc9rV1E1PlYHcbQfotXR8hUdTZNfjrpn5+w==
X-Gm-Gg: AeBDiesSEwzdUgfErf/1reMLNI4z5SaqoUSJaHgyDyjPoEUdQFmbWl+tW3GuCicH9gy
	3PVffCEM8754mWkhXHAzJaIcNUGdKybJKwdlJX5vqkg3ygTMGoS63zDX7pNnvT681eovIWXD8/T
	2Slck3gZa7str7cQ6XGtsk0hf1KJBFdOTBKxKPIme0nl8OhwwDuXeGC5K+rEOl7LKwXzhUOTnBc
	vIOeBUDf3ablefxJVI3M/PpAMsjpM/J1FLN0naR7IHkSaZeTOCV3hDyLBNbpQ2nl/7yGCO3ZGvh
	nphe3ro09eZ4cdyMfw==
X-Received: by 2002:a05:6808:1907:b0:467:27d9:88de with SMTP id
 5614622812f47-4789f9007b9mr262278b6e.8.1775769755528; Thu, 09 Apr 2026
 14:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153207.3635125-1-ming.lei@redhat.com> <20260331153207.3635125-2-ming.lei@redhat.com>
 <CADUfDZpUbses5NNR19M+81ZwDxSAb6ktz0+2f9GfkOL8yzEh+w@mail.gmail.com>
 <adW8I8RpSD471iFy@fedora> <CADUfDZrs=6srDdL15KG-uL2PX9p5_piJVU0GZZTYjE0VfDQJKw@mail.gmail.com>
 <adeZKBrNEX7vx7O3@fedora>
In-Reply-To: <adeZKBrNEX7vx7O3@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 9 Apr 2026 14:22:24 -0700
X-Gm-Features: AQROBzA9mo3vXFXOt4xHoLHcEjMNNdRRmzurPJ_7LScbPw9tI3VDn0etyaeASuI
Message-ID: <CADUfDZqnq1Ls9NdcBXgbAJymPNvcUOa883zSTNMNcaXODGEEEg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] ublk: add UBLK_U_CMD_REG_BUF/UNREG_BUF control commands
To: Ming Lei <tom.leiming@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 5:18=E2=80=AFAM Ming Lei <tom.leiming@gmail.com> wro=
te:
>
> On Wed, Apr 08, 2026 at 08:20:12AM -0700, Caleb Sander Mateos wrote:
> > On Tue, Apr 7, 2026 at 7:23=E2=80=AFPM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > On Tue, Apr 07, 2026 at 12:35:49PM -0700, Caleb Sander Mateos wrote:
> > > > On Tue, Mar 31, 2026 at 8:32=E2=80=AFAM Ming Lei <ming.lei@redhat.c=
om> wrote:
> > > > >
> > > > > Add control commands for registering and unregistering shared mem=
ory
> > > > > buffers for zero-copy I/O:
> > > > >
> > > > > - UBLK_U_CMD_REG_BUF (0x18): pins pages from userspace, inserts P=
FN
> > > > >   ranges into a per-device maple tree for O(log n) lookup during =
I/O.
> > > > >   Buffer pointers are tracked in a per-device xarray. Returns the
> > > > >   assigned buffer index.
> > > > >
> > > > > - UBLK_U_CMD_UNREG_BUF (0x19): removes PFN entries and unpins pag=
es.
> > > > >
> > > > > Queue freeze/unfreeze is handled internally so userspace need not
> > > > > quiesce the device during registration.
> > > > >
> > > > > Also adds:
> > > > > - UBLK_IO_F_SHMEM_ZC flag and addr encoding helpers in UAPI heade=
r
> > > > >   (16-bit buffer index supporting up to 65536 buffers)
> > > > > - Data structures (ublk_buf, ublk_buf_range) and xarray/maple tre=
e
> > > > > - __ublk_ctrl_reg_buf() helper for PFN insertion with error unwin=
ding
> > > > > - __ublk_ctrl_unreg_buf() helper for cleanup reuse
> > > > > - ublk_support_shmem_zc() / ublk_dev_support_shmem_zc() stubs
> > > > >   (returning false =E2=80=94 feature not enabled yet)
> > > > >
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > ---
> > > > >  drivers/block/ublk_drv.c      | 300 ++++++++++++++++++++++++++++=
++++++
> > > > >  include/uapi/linux/ublk_cmd.h |  72 ++++++++
> > > > >  2 files changed, 372 insertions(+)
> > > > >
> > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > index 71c7c56b38ca..ac6ccc174d44 100644
> > > > > --- a/drivers/block/ublk_drv.c
> > > > > +++ b/drivers/block/ublk_drv.c
> > > > > @@ -46,6 +46,8 @@
> > > > >  #include <linux/kref.h>
> > > > >  #include <linux/kfifo.h>
> > > > >  #include <linux/blk-integrity.h>
> > > > > +#include <linux/maple_tree.h>
> > > > > +#include <linux/xarray.h>
> > > > >  #include <uapi/linux/fs.h>
> > > > >  #include <uapi/linux/ublk_cmd.h>
> > > > >
> > > > > @@ -58,6 +60,8 @@
> > > > >  #define UBLK_CMD_UPDATE_SIZE   _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
> > > > >  #define UBLK_CMD_QUIESCE_DEV   _IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
> > > > >  #define UBLK_CMD_TRY_STOP_DEV  _IOC_NR(UBLK_U_CMD_TRY_STOP_DEV)
> > > > > +#define UBLK_CMD_REG_BUF       _IOC_NR(UBLK_U_CMD_REG_BUF)
> > > > > +#define UBLK_CMD_UNREG_BUF     _IOC_NR(UBLK_U_CMD_UNREG_BUF)
> > > > >
> > > > >  #define UBLK_IO_REGISTER_IO_BUF                _IOC_NR(UBLK_U_IO=
_REGISTER_IO_BUF)
> > > > >  #define UBLK_IO_UNREGISTER_IO_BUF      _IOC_NR(UBLK_U_IO_UNREGIS=
TER_IO_BUF)
> > > > > @@ -289,6 +293,20 @@ struct ublk_queue {
> > > > >         struct ublk_io ios[] __counted_by(q_depth);
> > > > >  };
> > > > >
> > > > > +/* Per-registered shared memory buffer */
> > > > > +struct ublk_buf {
> > > > > +       struct page **pages;
> > > > > +       unsigned int nr_pages;
> > > > > +};
> > > > > +
> > > > > +/* Maple tree value: maps a PFN range to buffer location */
> > > > > +struct ublk_buf_range {
> > > > > +       unsigned long base_pfn;
> > > > > +       unsigned short buf_index;
> > > > > +       unsigned short flags;
> > > > > +       unsigned int base_offset;       /* byte offset within buf=
fer */
> > > > > +};
> > > > > +
> > > > >  struct ublk_device {
> > > > >         struct gendisk          *ub_disk;
> > > > >
> > > > > @@ -323,6 +341,10 @@ struct ublk_device {
> > > > >
> > > > >         bool                    block_open; /* protected by open_=
mutex */
> > > > >
> > > > > +       /* shared memory zero copy */
> > > > > +       struct maple_tree       buf_tree;
> > > > > +       struct xarray           bufs_xa;
> > > > > +
> > > > >         struct ublk_queue       *queues[];
> > > > >  };
> > > > >
> > > > > @@ -334,6 +356,7 @@ struct ublk_params_header {
> > > > >
> > > > >  static void ublk_io_release(void *priv);
> > > > >  static void ublk_stop_dev_unlocked(struct ublk_device *ub);
> > > > > +static void ublk_buf_cleanup(struct ublk_device *ub);
> > > > >  static void ublk_abort_queue(struct ublk_device *ub, struct ublk=
_queue *ubq);
> > > > >  static inline struct request *__ublk_check_and_get_req(struct ub=
lk_device *ub,
> > > > >                 u16 q_id, u16 tag, struct ublk_io *io);
> > > > > @@ -398,6 +421,16 @@ static inline bool ublk_dev_support_zero_cop=
y(const struct ublk_device *ub)
> > > > >         return ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY;
> > > > >  }
> > > > >
> > > > > +static inline bool ublk_support_shmem_zc(const struct ublk_queue=
 *ubq)
> > > > > +{
> > > > > +       return false;
> > > > > +}
> > > > > +
> > > > > +static inline bool ublk_dev_support_shmem_zc(const struct ublk_d=
evice *ub)
> > > > > +{
> > > > > +       return false;
> > > > > +}
> > > > > +
> > > > >  static inline bool ublk_support_auto_buf_reg(const struct ublk_q=
ueue *ubq)
> > > > >  {
> > > > >         return ubq->flags & UBLK_F_AUTO_BUF_REG;
> > > > > @@ -1460,6 +1493,7 @@ static blk_status_t ublk_setup_iod(struct u=
blk_queue *ubq, struct request *req)
> > > > >         iod->op_flags =3D ublk_op | ublk_req_build_flags(req);
> > > > >         iod->nr_sectors =3D blk_rq_sectors(req);
> > > > >         iod->start_sector =3D blk_rq_pos(req);
> > > > > +
> > > >
> > > > nit: unrelated whitespace change?
> > > >
> > > > >         iod->addr =3D io->buf.addr;
> > > > >
> > > > >         return BLK_STS_OK;
> > > > > @@ -1665,6 +1699,7 @@ static bool ublk_start_io(const struct ublk=
_queue *ubq, struct request *req,
> > > > >  {
> > > > >         unsigned mapped_bytes =3D ublk_map_io(ubq, req, io);
> > > > >
> > > > > +
> > > >
> > > > nit: unrelated whitespace change?
> > > >
> > > > >         /* partially mapped, update io descriptor */
> > > > >         if (unlikely(mapped_bytes !=3D blk_rq_bytes(req))) {
> > > > >                 /*
> > > > > @@ -4206,6 +4241,7 @@ static void ublk_cdev_rel(struct device *de=
v)
> > > > >  {
> > > > >         struct ublk_device *ub =3D container_of(dev, struct ublk_=
device, cdev_dev);
> > > > >
> > > > > +       ublk_buf_cleanup(ub);
> > > > >         blk_mq_free_tag_set(&ub->tag_set);
> > > > >         ublk_deinit_queues(ub);
> > > > >         ublk_free_dev_number(ub);
> > > > > @@ -4625,6 +4661,8 @@ static int ublk_ctrl_add_dev(const struct u=
blksrv_ctrl_cmd *header)
> > > > >         mutex_init(&ub->mutex);
> > > > >         spin_lock_init(&ub->lock);
> > > > >         mutex_init(&ub->cancel_mutex);
> > > > > +       mt_init(&ub->buf_tree);
> > > > > +       xa_init_flags(&ub->bufs_xa, XA_FLAGS_ALLOC);
> > > > >         INIT_WORK(&ub->partition_scan_work, ublk_partition_scan_w=
ork);
> > > > >
> > > > >         ret =3D ublk_alloc_dev_number(ub, header->dev_id);
> > > > > @@ -5168,6 +5206,260 @@ static int ublk_char_dev_permission(struc=
t ublk_device *ub,
> > > > >         return err;
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + * Drain inflight I/O and quiesce the queue. Freeze drains all i=
nflight
> > > > > + * requests, quiesce_nowait marks the queue so no new requests d=
ispatch,
> > > > > + * then unfreeze allows new submissions (which won't dispatch du=
e to
> > > > > + * quiesce). This keeps freeze and ub->mutex non-nested.
> > > > > + */
> > > > > +static void ublk_quiesce_and_release(struct gendisk *disk)
> > > > > +{
> > > > > +       unsigned int memflags;
> > > > > +
> > > > > +       memflags =3D blk_mq_freeze_queue(disk->queue);
> > > > > +       blk_mq_quiesce_queue_nowait(disk->queue);
> > > > > +       blk_mq_unfreeze_queue(disk->queue, memflags);
> > > > > +}
> > > > > +
> > > > > +static void ublk_unquiesce_and_resume(struct gendisk *disk)
> > > > > +{
> > > > > +       blk_mq_unquiesce_queue(disk->queue);
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * Insert PFN ranges of a registered buffer into the maple tree,
> > > > > + * coalescing consecutive PFNs into single range entries.
> > > > > + * Returns 0 on success, negative error with partial insertions =
unwound.
> > > > > + */
> > > > > +/* Erase coalesced PFN ranges from the maple tree for pages [0, =
nr_pages) */
> > > > > +static void ublk_buf_erase_ranges(struct ublk_device *ub,
> > > > > +                                 struct ublk_buf *ubuf,
> > > > > +                                 unsigned long nr_pages)
> > > > > +{
> > > > > +       unsigned long i;
> > > > > +
> > > > > +       for (i =3D 0; i < nr_pages; ) {
> > > > > +               unsigned long pfn =3D page_to_pfn(ubuf->pages[i])=
;
> > > > > +               unsigned long start =3D i;
> > > > > +
> > > > > +               while (i + 1 < nr_pages &&
> > > > > +                      page_to_pfn(ubuf->pages[i + 1]) =3D=3D pfn=
 + (i - start) + 1)
> > > > > +                       i++;
> > > > > +               i++;
> > > > > +               kfree(mtree_erase(&ub->buf_tree, pfn));
> > > > > +       }
> > > > > +}
> > > > > +
> > > > > +static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
> > > > > +                              struct ublk_buf *ubuf, int index,
> > > > > +                              unsigned short flags)
> > > > > +{
> > > > > +       unsigned long nr_pages =3D ubuf->nr_pages;
> > > > > +       unsigned long i;
> > > > > +       int ret;
> > > > > +
> > > > > +       for (i =3D 0; i < nr_pages; ) {
> > > > > +               unsigned long pfn =3D page_to_pfn(ubuf->pages[i])=
;
> > > > > +               unsigned long start =3D i;
> > > > > +               struct ublk_buf_range *range;
> > > > > +
> > > > > +               /* Find run of consecutive PFNs */
> > > > > +               while (i + 1 < nr_pages &&
> > > > > +                      page_to_pfn(ubuf->pages[i + 1]) =3D=3D pfn=
 + (i - start) + 1)
> > > > > +                       i++;
> > > > > +               i++;    /* past the last page in this run */
> > > >
> > > > Move this increment to the for loop so you don't need the "- 1" in =
the
> > > > mtree_insert_range() call?
> > >
> > > Good catch!
> > >
> > > >
> > > > > +
> > > > > +               range =3D kzalloc(sizeof(*range), GFP_KERNEL);
> > > >
> > > > Not sure kzalloc() is necessary; all the fields are initialized bel=
ow
> > >
> > > Yeah, kmalloc() is fine, and we shouldn't add more fields to `range` =
in
> > > future.
> > >
> > > >
> > > > > +               if (!range) {
> > > > > +                       ret =3D -ENOMEM;
> > > > > +                       goto unwind;
> > > > > +               }
> > > > > +               range->buf_index =3D index;
> > > > > +               range->flags =3D flags;
> > > > > +               range->base_pfn =3D pfn;
> > > > > +               range->base_offset =3D start << PAGE_SHIFT;
> > > > > +
> > > > > +               ret =3D mtree_insert_range(&ub->buf_tree, pfn,
> > > > > +                                        pfn + (i - start) - 1,
> > > > > +                                        range, GFP_KERNEL);
> > > > > +               if (ret) {
> > > > > +                       kfree(range);
> > > > > +                       goto unwind;
> > > > > +               }
> > > > > +       }
> > > > > +       return 0;
> > > > > +
> > > > > +unwind:
> > > > > +       ublk_buf_erase_ranges(ub, ubuf, i);
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * Register a shared memory buffer for zero-copy I/O.
> > > > > + * Pins pages, builds PFN maple tree, freezes/unfreezes the queu=
e
> > > > > + * internally. Returns buffer index (>=3D 0) on success.
> > > > > + */
> > > > > +static int ublk_ctrl_reg_buf(struct ublk_device *ub,
> > > > > +                            struct ublksrv_ctrl_cmd *header)
> > > > > +{
> > > > > +       void __user *argp =3D (void __user *)(unsigned long)heade=
r->addr;
> > > > > +       struct ublk_shmem_buf_reg buf_reg;
> > > > > +       unsigned long addr, size, nr_pages;
> > > >
> > > > size and nr_pages could be u32
> > >
> > > Yeah, it was caused by internal change on `ublk_shmem_buf_reg`.
> > >
> > > >
> > > > > +       unsigned int gup_flags;
> > > > > +       struct gendisk *disk;
> > > > > +       struct ublk_buf *ubuf;
> > > > > +       long pinned;
> > > >
> > > > pinned could be int to match the return type of pin_user_pages_fast=
()
> > >
> > > OK.
> > >
> > > >
> > > > > +       u32 index;
> > > > > +       int ret;
> > > > > +
> > > > > +       if (!ublk_dev_support_shmem_zc(ub))
> > > > > +               return -EOPNOTSUPP;
> > > > > +
> > > > > +       memset(&buf_reg, 0, sizeof(buf_reg));
> > > > > +       if (copy_from_user(&buf_reg, argp,
> > > > > +                          min_t(size_t, header->len, sizeof(buf_=
reg))))
> > > > > +               return -EFAULT;
> > > > > +
> > > > > +       if (buf_reg.flags & ~UBLK_SHMEM_BUF_READ_ONLY)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       addr =3D buf_reg.addr;
> > > > > +       size =3D buf_reg.len;
> > > >
> > > > nit: don't see much value in these additional variables that are ju=
st
> > > > copies of buf_reg fields
> > > >
> > > > > +       nr_pages =3D size >> PAGE_SHIFT;
> > > > > +
> > > > > +       if (!size || !PAGE_ALIGNED(size) || !PAGE_ALIGNED(addr))
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       disk =3D ublk_get_disk(ub);
> > > > > +       if (!disk)
> > > > > +               return -ENODEV;
> > > >
> > > > So buffers can't be registered before the ublk device is started? I=
s
> > > > there a reason why that's not possible? Could we just make the
> > > > ublk_quiesce_and_release() and ublk_unquiesce_and_resume() conditio=
nal
> > > > on disk being non-NULL? I guess we'd have to hold the ublk_device
> > > > mutex before calling ublk_get_disk() to prevent it from being assig=
ned
> > > > concurrently.
> > >
> > > Here `disk` is used for freeze & quiesce queue.
> > >
> > > But the implementation can be a bit more complicated given the depend=
ency
> > > between ub->mutex and freeze queue should be avoided.
> > >
> > > Anyway, it is one nice requirement, I will try to relax the constrain=
t.
> > >
> > > >
> > > > > +
> > > > > +       /* Pin pages before quiescing (may sleep) */
> > > > > +       ubuf =3D kzalloc(sizeof(*ubuf), GFP_KERNEL);
> > > > > +       if (!ubuf) {
> > > > > +               ret =3D -ENOMEM;
> > > > > +               goto put_disk;
> > > > > +       }
> > > > > +
> > > > > +       ubuf->pages =3D kvmalloc_array(nr_pages, sizeof(*ubuf->pa=
ges),
> > > > > +                                    GFP_KERNEL);
> > > > > +       if (!ubuf->pages) {
> > > > > +               ret =3D -ENOMEM;
> > > > > +               goto err_free;
> > > > > +       }
> > > > > +
> > > > > +       gup_flags =3D FOLL_LONGTERM;
> > > > > +       if (!(buf_reg.flags & UBLK_SHMEM_BUF_READ_ONLY))
> > > > > +               gup_flags |=3D FOLL_WRITE;
> > > > > +
> > > > > +       pinned =3D pin_user_pages_fast(addr, nr_pages, gup_flags,=
 ubuf->pages);
> > > > > +       if (pinned < 0) {
> > > > > +               ret =3D pinned;
> > > > > +               goto err_free_pages;
> > > > > +       }
> > > > > +       if (pinned !=3D nr_pages) {
> > > > > +               ret =3D -EFAULT;
> > > > > +               goto err_unpin;
> > > > > +       }
> > > > > +       ubuf->nr_pages =3D nr_pages;
> > > > > +
> > > > > +       /*
> > > > > +        * Drain inflight I/O and quiesce the queue so no new req=
uests
> > > > > +        * are dispatched while we modify the maple tree. Keep fr=
eeze
> > > > > +        * and mutex non-nested to avoid lock dependency.
> > > > > +        */
> > > > > +       ublk_quiesce_and_release(disk);
> > > > > +
> > > > > +       mutex_lock(&ub->mutex);
> > > >
> > > > Looks like the xarray and maple tree do their own spinlocking, is t=
his needed?
> > >
> > > Right, looks it isn't needed now, and it was added from beginning wit=
h plain
> > > array.
> > >
> > > >
> > > > > +
> > > > > +       ret =3D xa_alloc(&ub->bufs_xa, &index, ubuf, xa_limit_16b=
, GFP_KERNEL);
> > > > > +       if (ret)
> > > > > +               goto err_unlock;
> > > > > +
> > > > > +       ret =3D __ublk_ctrl_reg_buf(ub, ubuf, index, buf_reg.flag=
s);
> > > > > +       if (ret) {
> > > > > +               xa_erase(&ub->bufs_xa, index);
> > > > > +               goto err_unlock;
> > > > > +       }
> > > > > +
> > > > > +       mutex_unlock(&ub->mutex);
> > > > > +
> > > > > +       ublk_unquiesce_and_resume(disk);
> > > > > +       ublk_put_disk(disk);
> > > > > +       return index;
> > > > > +
> > > > > +err_unlock:
> > > > > +       mutex_unlock(&ub->mutex);
> > > > > +       ublk_unquiesce_and_resume(disk);
> > > > > +err_unpin:
> > > > > +       unpin_user_pages(ubuf->pages, pinned);
> > > > > +err_free_pages:
> > > > > +       kvfree(ubuf->pages);
> > > > > +err_free:
> > > > > +       kfree(ubuf);
> > > > > +put_disk:
> > > > > +       ublk_put_disk(disk);
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +static void __ublk_ctrl_unreg_buf(struct ublk_device *ub,
> > > > > +                                 struct ublk_buf *ubuf)
> > > > > +{
> > > > > +       ublk_buf_erase_ranges(ub, ubuf, ubuf->nr_pages);
> > > > > +       unpin_user_pages(ubuf->pages, ubuf->nr_pages);
> > > > > +       kvfree(ubuf->pages);
> > > > > +       kfree(ubuf);
> > > > > +}
> > > > > +
> > > > > +static int ublk_ctrl_unreg_buf(struct ublk_device *ub,
> > > > > +                              struct ublksrv_ctrl_cmd *header)
> > > > > +{
> > > > > +       int index =3D (int)header->data[0];
> > > > > +       struct gendisk *disk;
> > > > > +       struct ublk_buf *ubuf;
> > > > > +
> > > > > +       if (!ublk_dev_support_shmem_zc(ub))
> > > > > +               return -EOPNOTSUPP;
> > > > > +
> > > > > +       disk =3D ublk_get_disk(ub);
> > > > > +       if (!disk)
> > > > > +               return -ENODEV;
> > > > > +
> > > > > +       /* Drain inflight I/O before modifying the maple tree */
> > > > > +       ublk_quiesce_and_release(disk);
> > > > > +
> > > > > +       mutex_lock(&ub->mutex);
> > > > > +
> > > > > +       ubuf =3D xa_erase(&ub->bufs_xa, index);
> > > > > +       if (!ubuf) {
> > > > > +               mutex_unlock(&ub->mutex);
> > > > > +               ublk_unquiesce_and_resume(disk);
> > > > > +               ublk_put_disk(disk);
> > > > > +               return -ENOENT;
> > > > > +       }
> > > > > +
> > > > > +       __ublk_ctrl_unreg_buf(ub, ubuf);
> > > > > +
> > > > > +       mutex_unlock(&ub->mutex);
> > > > > +
> > > > > +       ublk_unquiesce_and_resume(disk);
> > > > > +       ublk_put_disk(disk);
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static void ublk_buf_cleanup(struct ublk_device *ub)
> > > > > +{
> > > > > +       struct ublk_buf *ubuf;
> > > > > +       unsigned long index;
> > > > > +
> > > > > +       xa_for_each(&ub->bufs_xa, index, ubuf)
> > > > > +               __ublk_ctrl_unreg_buf(ub, ubuf);
> > > >
> > > > This looks quadratic in the number of registered buffers. Can we do=
 a
> > > > single pass over the xarray  and the maple tree?
> > >
> > > It can be done two passes: first pass walks maple tree for unpinning
> > > pages, the 2nd pass is for freeing buffers in xarray, which looks mor=
e
> > > clean.
> > >
> > > But the current way can reuse __ublk_ctrl_unreg_buf(), also
> > > ublk_buf_cleanup() is only called one-shot in device release handler,=
 so we can
> > > leave it for future optimization.
> > >
> > > >
> > > > > +       xa_destroy(&ub->bufs_xa);
> > > > > +       mtree_destroy(&ub->buf_tree);
> > > > > +}
> > > > > +
> > > > > +
> > > > > +
> > > > >  static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub=
,
> > > > >                 u32 cmd_op, struct ublksrv_ctrl_cmd *header)
> > > > >  {
> > > > > @@ -5225,6 +5517,8 @@ static int ublk_ctrl_uring_cmd_permission(s=
truct ublk_device *ub,
> > > > >         case UBLK_CMD_UPDATE_SIZE:
> > > > >         case UBLK_CMD_QUIESCE_DEV:
> > > > >         case UBLK_CMD_TRY_STOP_DEV:
> > > > > +       case UBLK_CMD_REG_BUF:
> > > > > +       case UBLK_CMD_UNREG_BUF:
> > > > >                 mask =3D MAY_READ | MAY_WRITE;
> > > > >                 break;
> > > > >         default:
> > > > > @@ -5350,6 +5644,12 @@ static int ublk_ctrl_uring_cmd(struct io_u=
ring_cmd *cmd,
> > > > >         case UBLK_CMD_TRY_STOP_DEV:
> > > > >                 ret =3D ublk_ctrl_try_stop_dev(ub);
> > > > >                 break;
> > > > > +       case UBLK_CMD_REG_BUF:
> > > > > +               ret =3D ublk_ctrl_reg_buf(ub, &header);
> > > > > +               break;
> > > > > +       case UBLK_CMD_UNREG_BUF:
> > > > > +               ret =3D ublk_ctrl_unreg_buf(ub, &header);
> > > > > +               break;
> > > > >         default:
> > > > >                 ret =3D -EOPNOTSUPP;
> > > > >                 break;
> > > > > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/u=
blk_cmd.h
> > > > > index a88876756805..52bb9b843d73 100644
> > > > > --- a/include/uapi/linux/ublk_cmd.h
> > > > > +++ b/include/uapi/linux/ublk_cmd.h
> > > > > @@ -57,6 +57,44 @@
> > > > >         _IOWR('u', 0x16, struct ublksrv_ctrl_cmd)
> > > > >  #define UBLK_U_CMD_TRY_STOP_DEV                \
> > > > >         _IOWR('u', 0x17, struct ublksrv_ctrl_cmd)
> > > > > +/*
> > > > > + * Register a shared memory buffer for zero-copy I/O.
> > > > > + * Input:  ctrl_cmd.addr points to struct ublk_buf_reg (buffer V=
A + size)
> > > > > + *         ctrl_cmd.len  =3D sizeof(struct ublk_buf_reg)
> > > > > + * Result: >=3D 0 is the assigned buffer index, < 0 is error
> > > > > + *
> > > > > + * The kernel pins pages from the calling process's address spac=
e
> > > > > + * and inserts PFN ranges into a per-device maple tree. When a b=
lock
> > > > > + * request's pages match registered pages, the driver sets
> > > > > + * UBLK_IO_F_SHMEM_ZC and encodes the buffer index + offset in a=
ddr,
> > > > > + * allowing the server to access the data via its own mapping of=
 the
> > > > > + * same shared memory =E2=80=94 true zero copy.
> > > > > + *
> > > > > + * The memory can be backed by memfd, hugetlbfs, or any GUP-comp=
atible
> > > > > + * shared mapping. Queue freeze is handled internally.
> > > > > + *
> > > > > + * The buffer VA and size are passed via a user buffer (not inli=
ne in
> > > > > + * ctrl_cmd) so that unprivileged devices can prepend the device=
 path
> > > > > + * to ctrl_cmd.addr without corrupting the VA.
> > > > > + */
> > > > > +#define UBLK_U_CMD_REG_BUF             \
> > > > > +       _IOWR('u', 0x18, struct ublksrv_ctrl_cmd)
> > > > > +/*
> > > > > + * Unregister a shared memory buffer.
> > > > > + * Input:  ctrl_cmd.data[0] =3D buffer index
> > > > > + */
> > > > > +#define UBLK_U_CMD_UNREG_BUF           \
> > > > > +       _IOWR('u', 0x19, struct ublksrv_ctrl_cmd)
> > > > > +
> > > > > +/* Parameter buffer for UBLK_U_CMD_REG_BUF, pointed to by ctrl_c=
md.addr */
> > > > > +struct ublk_shmem_buf_reg {
> > > > > +       __u64   addr;   /* userspace virtual address of shared me=
mory */
> > > > > +       __u32   len;    /* buffer size in bytes (page-aligned, ma=
x 4GB) */
> > > > > +       __u32   flags;
> > > > > +};
> > > > > +
> > > > > +/* Pin pages without FOLL_WRITE; usable with write-sealed memfd =
*/
> > > > > +#define UBLK_SHMEM_BUF_READ_ONLY       (1U << 0)
> > > > >  /*
> > > > >   * 64bits are enough now, and it should be easy to extend in cas=
e of
> > > > >   * running out of feature flags
> > > > > @@ -370,6 +408,7 @@
> > > > >  /* Disable automatic partition scanning when device is started *=
/
> > > > >  #define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
> > > > >
> > > > > +
> > > > >  /* device state */
> > > > >  #define UBLK_S_DEV_DEAD        0
> > > > >  #define UBLK_S_DEV_LIVE        1
> > > > > @@ -469,6 +508,12 @@ struct ublksrv_ctrl_dev_info {
> > > > >  #define                UBLK_IO_F_NEED_REG_BUF          (1U << 17=
)
> > > > >  /* Request has an integrity data buffer */
> > > > >  #define                UBLK_IO_F_INTEGRITY             (1UL << 1=
8)
> > > > > +/*
> > > > > + * I/O buffer is in a registered shared memory buffer. When set,=
 the addr
> > > > > + * field in ublksrv_io_desc encodes buffer index and byte offset=
 instead
> > > > > + * of a userspace virtual address.
> > > > > + */
> > > > > +#define                UBLK_IO_F_SHMEM_ZC              (1U << 19=
)
> > > > >
> > > > >  /*
> > > > >   * io cmd is described by this structure, and stored in share me=
mory, indexed
> > > > > @@ -743,4 +788,31 @@ struct ublk_params {
> > > > >         struct ublk_param_integrity     integrity;
> > > > >  };
> > > > >
> > > > > +/*
> > > > > + * Shared memory zero-copy addr encoding for UBLK_IO_F_SHMEM_ZC.
> > > > > + *
> > > > > + * When UBLK_IO_F_SHMEM_ZC is set, ublksrv_io_desc.addr is encod=
ed as:
> > > > > + *   bits [0:31]  =3D byte offset within the buffer (up to 4GB)
> > > > > + *   bits [32:47] =3D buffer index (up to 65536)
> > > > > + *   bits [48:63] =3D reserved (must be zero)
> > > >
> > > > I wonder whether the "buffer index" is necessary. Can iod->addr and
> > > > UBLK_U_CMD_UNREG_BUF refer to the buffer by the virtual address use=
d
> > > > with UBLK_U_CMD_REG_BUF? Then struct ublksrv_io_desc's addr field
> > > > would retain its meaning. We would also avoid needing to compare th=
e
> > > > range buf_index values in ublk_try_buf_match(). And the xarray
> > > > wouldn't be necessary to allocate buffer indices.
> > >
> > > There are several reasons for choosing "buffer index":
> > >
> > > - avoid to add extra storage in `struct ublk_buf_range`, extra
> > >   `vaddr` field is required for returning virtual address; otherwise =
one extra
> > >   lookup from buffer index is needed in fast path of ublk_try_buf_mat=
ch()
> >
> > Yes, struct ublk_buf_range would have to track the virtual address,
> > but that would replace both buf_index and base_offset. And you could
> > store flags in the lower bits of the virtual address (since it has to
> > be page-aligned) if you want to keep it as 16 bytes. I'm not sure what
> > you mean about "one extra lookup from buffer index"; I was thinking it
> > would be possible to get rid of buffer indices entirely.
> >
> > >
> > > - I want ublk server to know the difference between shmem_zc buffer a=
nd the
> > >   plain IO buffer clearly, both two shouldn't be mixed, otherwise it =
is easy to
> > >   cause data corruption. For example, client is using buf A, but the
> > >   ublk server fallback code path may be using it at the same time.
> >
> > Yes, certainly the ublk server should only use a shared-memory buffer
> > when an incoming UBLK_IO_F_SHMEM_ZC request specifies it. I don't see
> > the connection to referring to buffers by virtual address instead of
> > buffer index, though. The kernel can't prevent the ublk server from
> > writing to a registered shared memory region it has mapped into its
> > address space.
> >
> > It seems like a simpler interface if iod->addr indicates the virtual
> > address of the data buffer regardless of the UBLK_IO_F_SHMEM_ZC flag.
> > Then the ublk server doesn't have to care whether the data is in
> > shared memory or was copied automatically by the
> > ublk_map_io()/ublk_unmap_io() fallback path; it just accesses the
> > memory at iod->addr and lets the kernel take care of the copying (if
> > necessary).
> >
> > >
> > > - total registered buffers can be limited naturally by `u16` buffer_i=
ndex
> >
> > I don't really see a reason to limit the number of SHMEM_ZC buffers if
> > they don't consume any per-buffer resources. I think it would make
> > more sense to limit it based on the _total size_ of registered
> > buffers, but the page pinning should already provide that.
> >
> > >
> > > - it is proved that buffer index is one nice pattern wrt. buffer
> > >   registration, such as io_uring fixed buffer; and it helps userspace
> > >   to manage multiple buffers, given each one has unique ID.
> >
> > If you really prefer the (buf_index, buf_offset) interface, I won't
> > stand in the way. It just seems to me like the only thing the ublk
> > server cares about a shared memory buffer is its virtual address, so
> > that's a more natural way to refer to it.
>
> It looks a little simpler from UAPI viewpoint, but storing vaddr in maple
> tree introduces some implementation issues:
>
> - vaddr is bound with task, so ublk device has to track task context, suc=
h
>   as, when we allow to register buffer before adding device, the buffer h=
as
>   to be guaranteed to belong to ublk daemon(tracked in future)

Don't all tasks within a process share the same virtual address space?
Then the threads in the ublk server process should all have the same
virtual address for the registered buffer. I guess it's theoretically
possible that a different process would register a shared memory
region on behalf of the ublk server, and then they could have
different virtual addresses for it, but that seems like a bizarre use
case.

>
> - not like the plain page copy code path, in which the buffer vaddr is
>   always passed in daemon context; but buffer register can be done in any
>   task context.
>
> - not get ID for buffer, it could become a bit complicated to handle
>   recover if we store vaddr in mapple tree; vaddr can become invalid in
>   device lifetime, but buf index is device-wide, which can't become obsol=
ete.

Fair point, though I'm not even sure how the new ublk server process
would be aware of the shared memory regions that belonged to the
previous process. If they were mapped from an anonymous memfd, the new
process wouldn't have any way to access them. I think it probably
makes more sense to unregister the shared memory regions when the ublk
server process exits.

>
> Anyway, I don't object to switch to vaddr based UAPI, and we have enough
> time to think it though and take it before 7.1 release.
>
> I will send patchset to cover other review comments first.

Sure, I think you have good reasons for the buf_index representation
and it doesn't really matter either way. I'm fine keeping this
interface.

Best,
Caleb
