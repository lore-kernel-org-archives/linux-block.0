Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777F33A9DE
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590565; cv=pass; b=u6MICOTZe/FOn18Am6NJ+qaI0jsAImP5E+PTfBz6oCKaodhQZFslF/zuw83iml8jM/dKwjnV9kD8ThYQmGBh+oBY8d5WzOKwEIrkCbsjC4bX6jxq+uCN8XZrWiRxgFLdVEjXxn2Mmwv0sWPE2Kx+s2DBv5WfJNqzsxT2wjquVrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590565; c=relaxed/simple;
	bh=cYJqyBraGHcZi25RWJTLmtcShNRymFygrAQRzVx1RO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTP/q5wU8vCoeSaW5r7DP/yJ58dUkxlUzEeaRKn3C6P5ycf9/rqN9YSupk4Zsf6WEmj66EvD6fvx3jZ9pEwHifWPECaiVDmYA8Z95kbewolAvACh1evkw1+45p/4KYQq3+CXgGf5w7dVIkHI1EDDucYIoCQabsQgK7UlvZ81GI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XZznuVFp; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XZznuVFp"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d7e878a7a9so656077a34.0
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 12:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775590562; cv=none;
        d=google.com; s=arc-20240605;
        b=lqmf5oPxF3ZPZgdpi782rNINMrc8ygxNxD9SZ7vBaeIclZoTO7bQQyxDldHK6e5oQN
         NuF6VV2VaWBjN9L0lGLNKQ8wJReRMZQRmTSEE72Mha6ZwtLmYK+ytoWYm0uE8HhOeKm3
         U3Z1aEK1aQGZrR7I0XWOP6jBwxfVsh7yV0fO1c/51P+WX6gRHFefXc1lyIEz20Aj9zUh
         8ecXSMKw6jevFb9WXkrN8ubfZ624D6UcZ9+9nnLJTpIZYuulJogbbeoWciYoo8ahUaeH
         8q6Jpf8mKZKwhROLMLeNPGJMf52uiDYYIyg/ZH1RNx49OcYFOQJBpRKxv1Tj4/R2gu8f
         Wuhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FRuHLB3U5+hURjqVpSYDo6Y3W9kWy50kWCfy+oWsYx0=;
        fh=yF0hwORKTLjlA2ZD/hCzNewtnhQEhHE3pNr4JS8tm6I=;
        b=UESfCjktbNMH8HNR1UdMyTASlo+eBZOd0UlCrpH4KdLU9uRM5NFp9ZrAD6vedH1K3U
         H5/ilU/qtboI0+rhtsKVryi/9PE7/Xo4pbAmjFSqZgQN3iaFAybtvUPHA/ge6injmxUs
         Ve61MF5oXd1xplKFrFEhNiXdlQcutVwBHbozWpgqCJVpBZO7rYKQ67nYgltyMVvzhiJj
         T1p4llGyKtz7EUm4M5Uh96v6wISk6TSqXxFnWMPDlLY67Gy/iQN2KOwKqFLs9P41nbZt
         dG3rqDqEIQi42P0zHFJowf9CiiPsJ9fZNg9Sl8p19H+tT1yE4cju4HuOrh37L/f21jyf
         YgFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775590562; x=1776195362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRuHLB3U5+hURjqVpSYDo6Y3W9kWy50kWCfy+oWsYx0=;
        b=XZznuVFpgvuONt+eNFN/1XR6Y+OXHNxrSzNqlXJ5+jWoozkJrEGNNNZ65VGtw9zbh4
         frnBvEHJPZyE1mk9vC5gnJ/2IkOgkISWbADB/4QJWvrhFLmqXjGErWDmtz04OPWHPfsc
         +1lmojf1fG1oSrxyL4DUFCFc+/G0ApkeKd7T5aQAkiNDJUYDatXa+fwqXxFhSgGHZI/p
         dj2Mee/5gEKqhzHBrFS1EUrxBnC+i9UZLYri0h++TlVemdrIaChwMnfM1VCmiURXgtpA
         bVCkVg4s+NUT5ZduKizGkm/qpju2b2CMRRseGpOsKjlv6Pz218PBH+t1OujK8LEN/+aS
         lY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775590562; x=1776195362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FRuHLB3U5+hURjqVpSYDo6Y3W9kWy50kWCfy+oWsYx0=;
        b=hkejGndbhxW/CZ9kiFcqiWPfvqZP31II8swO7y/6QunVE+SaDm+cQckeFXIKpBi1Ra
         2IirOHIszUfOK1lRisAqEztmGSVQw363vSt2CKfdk7tMqTTwT4ia8A01GyjY0dPVfV84
         VWk4l/LHi52jEx0CfpfB7TLdT0EqMPZK7KLjPggAMP/+Xic3xCt4xXlpjrUjZPOKG1P/
         2OB4PdiI5d5bP8VnvPxipwsiQM2rkjQp30p140N8tkljDkaFXj8DJsU4NQTsvF/btH+t
         jd0j9hnuh1x1MwRdShaz/5Wq+rHH5Z0urHRIFLxbxxFozYJBThDqrj9ScBpgNTDCYZoi
         zrpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUy8RrukUtQtq7DzBgGTXwWYPyoiNXj/GzB7x6BBFVjqZ1vqt33Ygl/BnDdMMPRaSS/+jlWS+6WGxVTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfmv/9DnCiLk1DcM5533FII36Fgudpum1Te6Vss3gknPlcV4lp
	qqTrK9+o8kyJ0i6UQwWSkYjtwE2vrWnSmscHNgtYSsnRI1LeG4NawP2iCgGMK2m61mSVZ7G4zhX
	6eUkVEWgUUA+ThoLcmALozF2jL+rtQ8bZM1vRxCgEalg3pjK61jeW50WLMQ==
X-Gm-Gg: AeBDievBOxLgAZqZFkDLrEGIOXUmpTymCdV/tm0V359TAYzqzBp/V8J4IuKuZrYNPfp
	yqRNOyGtfm3tqYatG7iCaiLMF92uR096duzCCD2lmt+IjLFHle3QWpzcc3042IqDwkCcFA4LYk/
	63UmfXHK/zSK6EU1vJT3BiSCXXjFRe1jusQhdUN1r3+KUocjtLp6AWGziVBECV/Z9ZSDKd5fblx
	JZTcCqy3+s9XS4g1oDkivNk6Oc1vuKxUac6hUpIG99NVmTZrPQ54whs49b9H5BPznLSfFYU2V82
	pMbtY+GWd/DlSkAhBtc=
X-Received: by 2002:a05:6808:2387:b0:467:df85:e243 with SMTP id
 5614622812f47-46efadbe526mr6381622b6e.5.1775590561811; Tue, 07 Apr 2026
 12:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153207.3635125-1-ming.lei@redhat.com> <20260331153207.3635125-2-ming.lei@redhat.com>
In-Reply-To: <20260331153207.3635125-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 7 Apr 2026 12:35:49 -0700
X-Gm-Features: AQROBzB8-I_N_44DiDqIVesxMi1gblyLcHQjaT16skcpfkhbqjWucBG8v2xW3zU
Message-ID: <CADUfDZpUbses5NNR19M+81ZwDxSAb6ktz0+2f9GfkOL8yzEh+w@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] ublk: add UBLK_U_CMD_REG_BUF/UNREG_BUF control commands
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 8:32=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add control commands for registering and unregistering shared memory
> buffers for zero-copy I/O:
>
> - UBLK_U_CMD_REG_BUF (0x18): pins pages from userspace, inserts PFN
>   ranges into a per-device maple tree for O(log n) lookup during I/O.
>   Buffer pointers are tracked in a per-device xarray. Returns the
>   assigned buffer index.
>
> - UBLK_U_CMD_UNREG_BUF (0x19): removes PFN entries and unpins pages.
>
> Queue freeze/unfreeze is handled internally so userspace need not
> quiesce the device during registration.
>
> Also adds:
> - UBLK_IO_F_SHMEM_ZC flag and addr encoding helpers in UAPI header
>   (16-bit buffer index supporting up to 65536 buffers)
> - Data structures (ublk_buf, ublk_buf_range) and xarray/maple tree
> - __ublk_ctrl_reg_buf() helper for PFN insertion with error unwinding
> - __ublk_ctrl_unreg_buf() helper for cleanup reuse
> - ublk_support_shmem_zc() / ublk_dev_support_shmem_zc() stubs
>   (returning false =E2=80=94 feature not enabled yet)
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 300 ++++++++++++++++++++++++++++++++++
>  include/uapi/linux/ublk_cmd.h |  72 ++++++++
>  2 files changed, 372 insertions(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 71c7c56b38ca..ac6ccc174d44 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -46,6 +46,8 @@
>  #include <linux/kref.h>
>  #include <linux/kfifo.h>
>  #include <linux/blk-integrity.h>
> +#include <linux/maple_tree.h>
> +#include <linux/xarray.h>
>  #include <uapi/linux/fs.h>
>  #include <uapi/linux/ublk_cmd.h>
>
> @@ -58,6 +60,8 @@
>  #define UBLK_CMD_UPDATE_SIZE   _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
>  #define UBLK_CMD_QUIESCE_DEV   _IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
>  #define UBLK_CMD_TRY_STOP_DEV  _IOC_NR(UBLK_U_CMD_TRY_STOP_DEV)
> +#define UBLK_CMD_REG_BUF       _IOC_NR(UBLK_U_CMD_REG_BUF)
> +#define UBLK_CMD_UNREG_BUF     _IOC_NR(UBLK_U_CMD_UNREG_BUF)
>
>  #define UBLK_IO_REGISTER_IO_BUF                _IOC_NR(UBLK_U_IO_REGISTE=
R_IO_BUF)
>  #define UBLK_IO_UNREGISTER_IO_BUF      _IOC_NR(UBLK_U_IO_UNREGISTER_IO_B=
UF)
> @@ -289,6 +293,20 @@ struct ublk_queue {
>         struct ublk_io ios[] __counted_by(q_depth);
>  };
>
> +/* Per-registered shared memory buffer */
> +struct ublk_buf {
> +       struct page **pages;
> +       unsigned int nr_pages;
> +};
> +
> +/* Maple tree value: maps a PFN range to buffer location */
> +struct ublk_buf_range {
> +       unsigned long base_pfn;
> +       unsigned short buf_index;
> +       unsigned short flags;
> +       unsigned int base_offset;       /* byte offset within buffer */
> +};
> +
>  struct ublk_device {
>         struct gendisk          *ub_disk;
>
> @@ -323,6 +341,10 @@ struct ublk_device {
>
>         bool                    block_open; /* protected by open_mutex */
>
> +       /* shared memory zero copy */
> +       struct maple_tree       buf_tree;
> +       struct xarray           bufs_xa;
> +
>         struct ublk_queue       *queues[];
>  };
>
> @@ -334,6 +356,7 @@ struct ublk_params_header {
>
>  static void ublk_io_release(void *priv);
>  static void ublk_stop_dev_unlocked(struct ublk_device *ub);
> +static void ublk_buf_cleanup(struct ublk_device *ub);
>  static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *=
ubq);
>  static inline struct request *__ublk_check_and_get_req(struct ublk_devic=
e *ub,
>                 u16 q_id, u16 tag, struct ublk_io *io);
> @@ -398,6 +421,16 @@ static inline bool ublk_dev_support_zero_copy(const =
struct ublk_device *ub)
>         return ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY;
>  }
>
> +static inline bool ublk_support_shmem_zc(const struct ublk_queue *ubq)
> +{
> +       return false;
> +}
> +
> +static inline bool ublk_dev_support_shmem_zc(const struct ublk_device *u=
b)
> +{
> +       return false;
> +}
> +
>  static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ub=
q)
>  {
>         return ubq->flags & UBLK_F_AUTO_BUF_REG;
> @@ -1460,6 +1493,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queu=
e *ubq, struct request *req)
>         iod->op_flags =3D ublk_op | ublk_req_build_flags(req);
>         iod->nr_sectors =3D blk_rq_sectors(req);
>         iod->start_sector =3D blk_rq_pos(req);
> +

nit: unrelated whitespace change?

>         iod->addr =3D io->buf.addr;
>
>         return BLK_STS_OK;
> @@ -1665,6 +1699,7 @@ static bool ublk_start_io(const struct ublk_queue *=
ubq, struct request *req,
>  {
>         unsigned mapped_bytes =3D ublk_map_io(ubq, req, io);
>
> +

nit: unrelated whitespace change?

>         /* partially mapped, update io descriptor */
>         if (unlikely(mapped_bytes !=3D blk_rq_bytes(req))) {
>                 /*
> @@ -4206,6 +4241,7 @@ static void ublk_cdev_rel(struct device *dev)
>  {
>         struct ublk_device *ub =3D container_of(dev, struct ublk_device, =
cdev_dev);
>
> +       ublk_buf_cleanup(ub);
>         blk_mq_free_tag_set(&ub->tag_set);
>         ublk_deinit_queues(ub);
>         ublk_free_dev_number(ub);
> @@ -4625,6 +4661,8 @@ static int ublk_ctrl_add_dev(const struct ublksrv_c=
trl_cmd *header)
>         mutex_init(&ub->mutex);
>         spin_lock_init(&ub->lock);
>         mutex_init(&ub->cancel_mutex);
> +       mt_init(&ub->buf_tree);
> +       xa_init_flags(&ub->bufs_xa, XA_FLAGS_ALLOC);
>         INIT_WORK(&ub->partition_scan_work, ublk_partition_scan_work);
>
>         ret =3D ublk_alloc_dev_number(ub, header->dev_id);
> @@ -5168,6 +5206,260 @@ static int ublk_char_dev_permission(struct ublk_d=
evice *ub,
>         return err;
>  }
>
> +/*
> + * Drain inflight I/O and quiesce the queue. Freeze drains all inflight
> + * requests, quiesce_nowait marks the queue so no new requests dispatch,
> + * then unfreeze allows new submissions (which won't dispatch due to
> + * quiesce). This keeps freeze and ub->mutex non-nested.
> + */
> +static void ublk_quiesce_and_release(struct gendisk *disk)
> +{
> +       unsigned int memflags;
> +
> +       memflags =3D blk_mq_freeze_queue(disk->queue);
> +       blk_mq_quiesce_queue_nowait(disk->queue);
> +       blk_mq_unfreeze_queue(disk->queue, memflags);
> +}
> +
> +static void ublk_unquiesce_and_resume(struct gendisk *disk)
> +{
> +       blk_mq_unquiesce_queue(disk->queue);
> +}
> +
> +/*
> + * Insert PFN ranges of a registered buffer into the maple tree,
> + * coalescing consecutive PFNs into single range entries.
> + * Returns 0 on success, negative error with partial insertions unwound.
> + */
> +/* Erase coalesced PFN ranges from the maple tree for pages [0, nr_pages=
) */
> +static void ublk_buf_erase_ranges(struct ublk_device *ub,
> +                                 struct ublk_buf *ubuf,
> +                                 unsigned long nr_pages)
> +{
> +       unsigned long i;
> +
> +       for (i =3D 0; i < nr_pages; ) {
> +               unsigned long pfn =3D page_to_pfn(ubuf->pages[i]);
> +               unsigned long start =3D i;
> +
> +               while (i + 1 < nr_pages &&
> +                      page_to_pfn(ubuf->pages[i + 1]) =3D=3D pfn + (i - =
start) + 1)
> +                       i++;
> +               i++;
> +               kfree(mtree_erase(&ub->buf_tree, pfn));
> +       }
> +}
> +
> +static int __ublk_ctrl_reg_buf(struct ublk_device *ub,
> +                              struct ublk_buf *ubuf, int index,
> +                              unsigned short flags)
> +{
> +       unsigned long nr_pages =3D ubuf->nr_pages;
> +       unsigned long i;
> +       int ret;
> +
> +       for (i =3D 0; i < nr_pages; ) {
> +               unsigned long pfn =3D page_to_pfn(ubuf->pages[i]);
> +               unsigned long start =3D i;
> +               struct ublk_buf_range *range;
> +
> +               /* Find run of consecutive PFNs */
> +               while (i + 1 < nr_pages &&
> +                      page_to_pfn(ubuf->pages[i + 1]) =3D=3D pfn + (i - =
start) + 1)
> +                       i++;
> +               i++;    /* past the last page in this run */

Move this increment to the for loop so you don't need the "- 1" in the
mtree_insert_range() call?

> +
> +               range =3D kzalloc(sizeof(*range), GFP_KERNEL);

Not sure kzalloc() is necessary; all the fields are initialized below

> +               if (!range) {
> +                       ret =3D -ENOMEM;
> +                       goto unwind;
> +               }
> +               range->buf_index =3D index;
> +               range->flags =3D flags;
> +               range->base_pfn =3D pfn;
> +               range->base_offset =3D start << PAGE_SHIFT;
> +
> +               ret =3D mtree_insert_range(&ub->buf_tree, pfn,
> +                                        pfn + (i - start) - 1,
> +                                        range, GFP_KERNEL);
> +               if (ret) {
> +                       kfree(range);
> +                       goto unwind;
> +               }
> +       }
> +       return 0;
> +
> +unwind:
> +       ublk_buf_erase_ranges(ub, ubuf, i);
> +       return ret;
> +}
> +
> +/*
> + * Register a shared memory buffer for zero-copy I/O.
> + * Pins pages, builds PFN maple tree, freezes/unfreezes the queue
> + * internally. Returns buffer index (>=3D 0) on success.
> + */
> +static int ublk_ctrl_reg_buf(struct ublk_device *ub,
> +                            struct ublksrv_ctrl_cmd *header)
> +{
> +       void __user *argp =3D (void __user *)(unsigned long)header->addr;
> +       struct ublk_shmem_buf_reg buf_reg;
> +       unsigned long addr, size, nr_pages;

size and nr_pages could be u32

> +       unsigned int gup_flags;
> +       struct gendisk *disk;
> +       struct ublk_buf *ubuf;
> +       long pinned;

pinned could be int to match the return type of pin_user_pages_fast()

> +       u32 index;
> +       int ret;
> +
> +       if (!ublk_dev_support_shmem_zc(ub))
> +               return -EOPNOTSUPP;
> +
> +       memset(&buf_reg, 0, sizeof(buf_reg));
> +       if (copy_from_user(&buf_reg, argp,
> +                          min_t(size_t, header->len, sizeof(buf_reg))))
> +               return -EFAULT;
> +
> +       if (buf_reg.flags & ~UBLK_SHMEM_BUF_READ_ONLY)
> +               return -EINVAL;
> +
> +       addr =3D buf_reg.addr;
> +       size =3D buf_reg.len;

nit: don't see much value in these additional variables that are just
copies of buf_reg fields

> +       nr_pages =3D size >> PAGE_SHIFT;
> +
> +       if (!size || !PAGE_ALIGNED(size) || !PAGE_ALIGNED(addr))
> +               return -EINVAL;
> +
> +       disk =3D ublk_get_disk(ub);
> +       if (!disk)
> +               return -ENODEV;

So buffers can't be registered before the ublk device is started? Is
there a reason why that's not possible? Could we just make the
ublk_quiesce_and_release() and ublk_unquiesce_and_resume() conditional
on disk being non-NULL? I guess we'd have to hold the ublk_device
mutex before calling ublk_get_disk() to prevent it from being assigned
concurrently.

> +
> +       /* Pin pages before quiescing (may sleep) */
> +       ubuf =3D kzalloc(sizeof(*ubuf), GFP_KERNEL);
> +       if (!ubuf) {
> +               ret =3D -ENOMEM;
> +               goto put_disk;
> +       }
> +
> +       ubuf->pages =3D kvmalloc_array(nr_pages, sizeof(*ubuf->pages),
> +                                    GFP_KERNEL);
> +       if (!ubuf->pages) {
> +               ret =3D -ENOMEM;
> +               goto err_free;
> +       }
> +
> +       gup_flags =3D FOLL_LONGTERM;
> +       if (!(buf_reg.flags & UBLK_SHMEM_BUF_READ_ONLY))
> +               gup_flags |=3D FOLL_WRITE;
> +
> +       pinned =3D pin_user_pages_fast(addr, nr_pages, gup_flags, ubuf->p=
ages);
> +       if (pinned < 0) {
> +               ret =3D pinned;
> +               goto err_free_pages;
> +       }
> +       if (pinned !=3D nr_pages) {
> +               ret =3D -EFAULT;
> +               goto err_unpin;
> +       }
> +       ubuf->nr_pages =3D nr_pages;
> +
> +       /*
> +        * Drain inflight I/O and quiesce the queue so no new requests
> +        * are dispatched while we modify the maple tree. Keep freeze
> +        * and mutex non-nested to avoid lock dependency.
> +        */
> +       ublk_quiesce_and_release(disk);
> +
> +       mutex_lock(&ub->mutex);

Looks like the xarray and maple tree do their own spinlocking, is this need=
ed?

> +
> +       ret =3D xa_alloc(&ub->bufs_xa, &index, ubuf, xa_limit_16b, GFP_KE=
RNEL);
> +       if (ret)
> +               goto err_unlock;
> +
> +       ret =3D __ublk_ctrl_reg_buf(ub, ubuf, index, buf_reg.flags);
> +       if (ret) {
> +               xa_erase(&ub->bufs_xa, index);
> +               goto err_unlock;
> +       }
> +
> +       mutex_unlock(&ub->mutex);
> +
> +       ublk_unquiesce_and_resume(disk);
> +       ublk_put_disk(disk);
> +       return index;
> +
> +err_unlock:
> +       mutex_unlock(&ub->mutex);
> +       ublk_unquiesce_and_resume(disk);
> +err_unpin:
> +       unpin_user_pages(ubuf->pages, pinned);
> +err_free_pages:
> +       kvfree(ubuf->pages);
> +err_free:
> +       kfree(ubuf);
> +put_disk:
> +       ublk_put_disk(disk);
> +       return ret;
> +}
> +
> +static void __ublk_ctrl_unreg_buf(struct ublk_device *ub,
> +                                 struct ublk_buf *ubuf)
> +{
> +       ublk_buf_erase_ranges(ub, ubuf, ubuf->nr_pages);
> +       unpin_user_pages(ubuf->pages, ubuf->nr_pages);
> +       kvfree(ubuf->pages);
> +       kfree(ubuf);
> +}
> +
> +static int ublk_ctrl_unreg_buf(struct ublk_device *ub,
> +                              struct ublksrv_ctrl_cmd *header)
> +{
> +       int index =3D (int)header->data[0];
> +       struct gendisk *disk;
> +       struct ublk_buf *ubuf;
> +
> +       if (!ublk_dev_support_shmem_zc(ub))
> +               return -EOPNOTSUPP;
> +
> +       disk =3D ublk_get_disk(ub);
> +       if (!disk)
> +               return -ENODEV;
> +
> +       /* Drain inflight I/O before modifying the maple tree */
> +       ublk_quiesce_and_release(disk);
> +
> +       mutex_lock(&ub->mutex);
> +
> +       ubuf =3D xa_erase(&ub->bufs_xa, index);
> +       if (!ubuf) {
> +               mutex_unlock(&ub->mutex);
> +               ublk_unquiesce_and_resume(disk);
> +               ublk_put_disk(disk);
> +               return -ENOENT;
> +       }
> +
> +       __ublk_ctrl_unreg_buf(ub, ubuf);
> +
> +       mutex_unlock(&ub->mutex);
> +
> +       ublk_unquiesce_and_resume(disk);
> +       ublk_put_disk(disk);
> +       return 0;
> +}
> +
> +static void ublk_buf_cleanup(struct ublk_device *ub)
> +{
> +       struct ublk_buf *ubuf;
> +       unsigned long index;
> +
> +       xa_for_each(&ub->bufs_xa, index, ubuf)
> +               __ublk_ctrl_unreg_buf(ub, ubuf);

This looks quadratic in the number of registered buffers. Can we do a
single pass over the xarray  and the maple tree?

> +       xa_destroy(&ub->bufs_xa);
> +       mtree_destroy(&ub->buf_tree);
> +}
> +
> +
> +
>  static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
>                 u32 cmd_op, struct ublksrv_ctrl_cmd *header)
>  {
> @@ -5225,6 +5517,8 @@ static int ublk_ctrl_uring_cmd_permission(struct ub=
lk_device *ub,
>         case UBLK_CMD_UPDATE_SIZE:
>         case UBLK_CMD_QUIESCE_DEV:
>         case UBLK_CMD_TRY_STOP_DEV:
> +       case UBLK_CMD_REG_BUF:
> +       case UBLK_CMD_UNREG_BUF:
>                 mask =3D MAY_READ | MAY_WRITE;
>                 break;
>         default:
> @@ -5350,6 +5644,12 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd=
 *cmd,
>         case UBLK_CMD_TRY_STOP_DEV:
>                 ret =3D ublk_ctrl_try_stop_dev(ub);
>                 break;
> +       case UBLK_CMD_REG_BUF:
> +               ret =3D ublk_ctrl_reg_buf(ub, &header);
> +               break;
> +       case UBLK_CMD_UNREG_BUF:
> +               ret =3D ublk_ctrl_unreg_buf(ub, &header);
> +               break;
>         default:
>                 ret =3D -EOPNOTSUPP;
>                 break;
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index a88876756805..52bb9b843d73 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -57,6 +57,44 @@
>         _IOWR('u', 0x16, struct ublksrv_ctrl_cmd)
>  #define UBLK_U_CMD_TRY_STOP_DEV                \
>         _IOWR('u', 0x17, struct ublksrv_ctrl_cmd)
> +/*
> + * Register a shared memory buffer for zero-copy I/O.
> + * Input:  ctrl_cmd.addr points to struct ublk_buf_reg (buffer VA + size=
)
> + *         ctrl_cmd.len  =3D sizeof(struct ublk_buf_reg)
> + * Result: >=3D 0 is the assigned buffer index, < 0 is error
> + *
> + * The kernel pins pages from the calling process's address space
> + * and inserts PFN ranges into a per-device maple tree. When a block
> + * request's pages match registered pages, the driver sets
> + * UBLK_IO_F_SHMEM_ZC and encodes the buffer index + offset in addr,
> + * allowing the server to access the data via its own mapping of the
> + * same shared memory =E2=80=94 true zero copy.
> + *
> + * The memory can be backed by memfd, hugetlbfs, or any GUP-compatible
> + * shared mapping. Queue freeze is handled internally.
> + *
> + * The buffer VA and size are passed via a user buffer (not inline in
> + * ctrl_cmd) so that unprivileged devices can prepend the device path
> + * to ctrl_cmd.addr without corrupting the VA.
> + */
> +#define UBLK_U_CMD_REG_BUF             \
> +       _IOWR('u', 0x18, struct ublksrv_ctrl_cmd)
> +/*
> + * Unregister a shared memory buffer.
> + * Input:  ctrl_cmd.data[0] =3D buffer index
> + */
> +#define UBLK_U_CMD_UNREG_BUF           \
> +       _IOWR('u', 0x19, struct ublksrv_ctrl_cmd)
> +
> +/* Parameter buffer for UBLK_U_CMD_REG_BUF, pointed to by ctrl_cmd.addr =
*/
> +struct ublk_shmem_buf_reg {
> +       __u64   addr;   /* userspace virtual address of shared memory */
> +       __u32   len;    /* buffer size in bytes (page-aligned, max 4GB) *=
/
> +       __u32   flags;
> +};
> +
> +/* Pin pages without FOLL_WRITE; usable with write-sealed memfd */
> +#define UBLK_SHMEM_BUF_READ_ONLY       (1U << 0)
>  /*
>   * 64bits are enough now, and it should be easy to extend in case of
>   * running out of feature flags
> @@ -370,6 +408,7 @@
>  /* Disable automatic partition scanning when device is started */
>  #define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
>
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
>  #define UBLK_S_DEV_LIVE        1
> @@ -469,6 +508,12 @@ struct ublksrv_ctrl_dev_info {
>  #define                UBLK_IO_F_NEED_REG_BUF          (1U << 17)
>  /* Request has an integrity data buffer */
>  #define                UBLK_IO_F_INTEGRITY             (1UL << 18)
> +/*
> + * I/O buffer is in a registered shared memory buffer. When set, the add=
r
> + * field in ublksrv_io_desc encodes buffer index and byte offset instead
> + * of a userspace virtual address.
> + */
> +#define                UBLK_IO_F_SHMEM_ZC              (1U << 19)
>
>  /*
>   * io cmd is described by this structure, and stored in share memory, in=
dexed
> @@ -743,4 +788,31 @@ struct ublk_params {
>         struct ublk_param_integrity     integrity;
>  };
>
> +/*
> + * Shared memory zero-copy addr encoding for UBLK_IO_F_SHMEM_ZC.
> + *
> + * When UBLK_IO_F_SHMEM_ZC is set, ublksrv_io_desc.addr is encoded as:
> + *   bits [0:31]  =3D byte offset within the buffer (up to 4GB)
> + *   bits [32:47] =3D buffer index (up to 65536)
> + *   bits [48:63] =3D reserved (must be zero)

I wonder whether the "buffer index" is necessary. Can iod->addr and
UBLK_U_CMD_UNREG_BUF refer to the buffer by the virtual address used
with UBLK_U_CMD_REG_BUF? Then struct ublksrv_io_desc's addr field
would retain its meaning. We would also avoid needing to compare the
range buf_index values in ublk_try_buf_match(). And the xarray
wouldn't be necessary to allocate buffer indices.

> + */
> +#define UBLK_SHMEM_ZC_OFF_MASK         0xffffffffULL
> +#define UBLK_SHMEM_ZC_IDX_OFF          32
> +#define UBLK_SHMEM_ZC_IDX_MASK         0xffffULL
> +
> +static inline __u64 ublk_shmem_zc_addr(__u16 index, __u32 offset)
> +{
> +       return ((__u64)index << UBLK_SHMEM_ZC_IDX_OFF) | offset;
> +}
> +
> +static inline __u16 ublk_shmem_zc_index(__u64 addr)
> +{
> +       return (addr >> UBLK_SHMEM_ZC_IDX_OFF) & UBLK_SHMEM_ZC_IDX_MASK;

nit: the mask looks redundant with the u16 cast

> +}
> +
> +static inline __u32 ublk_shmem_zc_offset(__u64 addr)
> +{
> +       return (__u32)(addr & UBLK_SHMEM_ZC_OFF_MASK);

Same here

Best,
Caleb

> +}
> +
>  #endif
> --
> 2.53.0
>
