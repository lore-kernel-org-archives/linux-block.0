Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26937383983
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426766; cv=pass; b=ZJie/zvBGhD8bwlIReDti8h+KCbqKMjrjxWajA7Ea/eB/lXPT6R5TfHe/DgMD3taVPmnNM0V85Iy2A7wbBbE3CJbAC9n/QU7WlPcEk9p9GHFBcXn3vpLnfLlS7YahHQgIJNAyzz4fkasv0Q7/x6T94/Ypo2VvACil9l1QQaeaAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426766; c=relaxed/simple;
	bh=1nkCNatkcbM50/Lck8HLLy4VazX2RWXIsNQzBeBazuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbk2rk8ripNHvkd87lKOki8bQayu03//fNwU6+6gGDqex5FAEZpZ2+acW6FgPjF02/Ume39zkgZE7Pk5ZvD3b7is++OrM9T9TV/GlTMeqihNhHZpZZSVbDquRtVM4ZJoXM6qOV1dbNM/F0FUamKndvZ/xEX94Qvl+vnTsz6sZzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CDat3tV8; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CDat3tV8"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9b24c46caso507a34.0
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 08:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785426763; cv=none;
        d=google.com; s=arc-20260327;
        b=suls/mz0PbGlnhyeY7LHoE46hMORiHdqJ2w3allGvprr/kOUjBbvPC9r5eIfd7h+xy
         rrRr4L83ixh6yMxx9HInXY54I9M5N+0mfz9Kd5WuhijuAISgwirtDwU2rbQXSjDaGxBw
         rWI/bGNQOfyB3r+KNoUgqjipKLkukQFvrw9L4kIoJyzxxXpf0ACOghHDn/KLPbZFYtxJ
         q1qitZYxQCaE2DCFB9TpFL/qLfeTXeTIq41YIEwzkDNQNjDuzvQ+clez0z6c3OIkwRCq
         E2lvaoZKmwsTSsZIJaAC7yvTbmArIjcLNeT5vHDlOaQZoT/RE5hy8dMQy1kmuLgEQtoW
         bFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zsyXVbTIYT70zuauHkpk0VaQYJxegYxbd+fpCHdBJwg=;
        fh=+UFrU8sfztI9fINdHpZBgqtQ1dss7eAgWFdcXyuYrXk=;
        b=dLwBTFiQPWP+YASquNAHP4+6kkev4nTT/kDaF8gqP66Tkfxa7mZEY77EWI7h0fr+US
         hd9qR2RwY/GaGDf1QfaBFjxc+rxIk1WQaYgsKI60P+bvjBfWvnCSsM5pWZK2fJiDtfkb
         F+0tBTHyQBcMrteelJzbNTKOxdE6gcs5Tp8DCjQ8hmru9/5oEs4IjsysRBOQBw3MFu+V
         BEb9fnkvY/eSC3gYUWH9rL34m2Y0K8bK/T619O6FzTnvvGtVlhDKtZrSEDpJdKWCQGtp
         1KtSvIjMcS8+dvcAItfKtcbXBhuIZXAkS9PMxONdtuSsxuTPjyp7LmTPXOC6KO6hVLK2
         zKxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785426763; x=1786031563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zsyXVbTIYT70zuauHkpk0VaQYJxegYxbd+fpCHdBJwg=;
        b=CDat3tV8Ry8VNM9dFO9TOcYr3/+X+DEidxLPfr0wIZh6nGMCaE9vDgIIRGzNyScO8T
         IvPf/mLS0choGJzfJ69S8urOlr/RB+FdH7JeOSQy6K7iJMQ/4h1ZN2oVs7PAcNM1Ke9A
         Tv53b2P1hE2ezA/epDdRIwFuKVWEDkgZZ+SekxazFKxORyPQGYwaI6/YMWgN3kqSKP6B
         p3gvWa1i5PVVDAPIP3MN8lnnkNI86PVWnVV+ISzo9QSBhKNZChkvW/2l65ZXhrIOHTNX
         3t7uLf3OjkLAOjf52emdOMLgHLUm9rIXqDzg8RQEPf1omkCKzUZrIijrvyRNqwAydpG9
         eYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785426763; x=1786031563;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zsyXVbTIYT70zuauHkpk0VaQYJxegYxbd+fpCHdBJwg=;
        b=EGRJ08I/0pJ0LXAIClyTnJKSn5cFMejoV+WU6pfCwMdbIMu+wLTLvH2csK8JKoUTGq
         q1nS0ySj87CUjB0IxFZVx4BZrEOOc9OFrcIsg4tjYkH2Tvm/j7n6yCjPKAWlfywti01Z
         hAhYgGizFX00R0Y04ElwShLxTDYc6ufgBMeZ+MGBM83o8miiXa4A/k6nEDTPtmaDacWi
         PcUwWcPK67LNOMzRAkME9xHlhsmXKYN2LbXTQPocqGEgynSZVMvDrxGDdsEihCFMtUAo
         JQT7XOBVWDal3fRqHFo2rXaV4ywr7WI4nk8LHPLglnLHz56y+MOixX4RN6Thd14z8S73
         QWQA==
X-Forwarded-Encrypted: i=1; AHgh+RppyJupJc/6mBU0EEndWLz0PR2gzFMb7ssK7mBtTPKxd0rJQpIwYFpF88kNd3Z+gcCSpKGgvsaL47ADxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YypLj3Cj1y5m5vm/oYFPn605UNwp/bEuken4Ry4dVrwi8LC9g1Q
	ifdArGprmce846wKmS/6Qbxpkq0/GvkhuPngTAJFHnjO7q7TMV5uWsVQrHBs7aSWGPsEQsmXolk
	it+Qdlb+QaptZ94VEbwnsYS++R1be8q+EZxLhPki3vA==
X-Gm-Gg: AR+sD12P5psjAUSY1fwmjeQD2GFzGAjSX37BMS70dQw3sx67tP5c8DraTRUauE3/pgZ
	vMQk+1eZL8/LZq2IWZgMwGe6OvFX0VQSPbuuD5ZYQwYBvEhFRxXKNo136Nitjm4Gwx3WTNJQzt4
	yvhGdEj7O2jP8a/d0bZ4aLfXuVjUvGWqSAcS+Sz/MIs2Yzh7MZULhBkw/QM+kbVZqUcADQGIAiL
	7SZe/RbzzMWgil4KeVliJ48aEGlplgDr+XP7zgAdgu081n7O0w5Io8uuvBcpQoVCQNVDAXOSXdL
	ikVZO6N4Q7H5ZLEtvfAiJisyzwjskjU5A3ykP2cisCZy
X-Received: by 2002:a05:6830:6b03:b0:7ee:5693:c7ce with SMTP id
 46e09a7af769-7f0392c3cc4mr984926a34.2.1785426762761; Thu, 30 Jul 2026
 08:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729012951.3744582-1-csander@purestorage.com>
 <20260729012951.3744582-6-csander@purestorage.com> <amtqTIZiUgOrSJmg@fedora-laptop>
In-Reply-To: <amtqTIZiUgOrSJmg@fedora-laptop>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 30 Jul 2026 08:52:32 -0700
X-Gm-Features: AUfX_mwknbtUOrnoMHCS1IEF8IEZywZ11nBX6umLQV-2WqYy7eH_bBXONQqtitw
Message-ID: <CADUfDZooDW2xd6ovtLZF8GGOZQCwkROjo30Vank5Oee6shKXHg@mail.gmail.com>
Subject: Re: [PATCH 5/6] ublk: add UBLK_F_IO_DESC_SIZE
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 8:14=E2=80=AFAM Ming Lei <tom.leiming@gmail.com> wr=
ote:
>
> On Tue, Jul 28, 2026 at 07:29:50PM -0600, Caleb Sander Mateos wrote:
> > ublk passes the parameters of incoming I/O in memory shared between the
> > kernel ublk driver and userspace ublk server in struct ublksrv_io_desc.
> > The size of this struct is currently fixed to 24 bytes, which has been
> > an obstacle to extending it with additional fields [1]. Additionally,
> > with multiple ublk server threads handling I/Os from the same ublk queu=
e
> > (possible with UBLK_F_PER_IO_DAEMON or UBLK_F_BATCH_IO), false sharing
> > results from adjacent io_descs sharing the same cache line.
> >
> > Add a ublk feature UBLK_F_IO_DESC_SIZE to allow a ublk server to
> > override the size of each io_desc. The size must be at least 24 and a
> > multiple of 8 to store a properly-aligned struct ublksrv_io_desc. The
> > struct ublksrv_io_desc is located at the beginning of each io_desc and
> > the remainder is padding. The mmap() performed for each queue must have
> > a length of queue_depth * io_desc_size, rounded up to the page size. Th=
e
> > mmap() offset must be q_id * UBLK_MAX_QUEUE_DEPTH * io_desc_size, also
> > rounded up to the page size.
> >
> > [1]: https://lore.kernel.org/linux-block/aV8QfvaNO5P6vOs6@fedora/
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c      | 35 ++++++++++++++++++++++++-----------
> >  include/uapi/linux/ublk_cmd.h |  5 ++++-
> >  2 files changed, 28 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 46f5ab13f87e..1da45e382253 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -87,11 +87,12 @@
> >               | UBLK_F_BUF_REG_OFF_DAEMON \
> >               | (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRIT=
Y : 0) \
> >               | UBLK_F_SAFE_STOP_DEV \
> >               | UBLK_F_BATCH_IO \
> >               | UBLK_F_NO_AUTO_PART_SCAN \
> > -             | UBLK_F_SHMEM_ZC)
> > +             | UBLK_F_SHMEM_ZC \
> > +             | UBLK_F_IO_DESC_SIZE)
> >
> >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> >               | UBLK_F_USER_RECOVERY_REISSUE \
> >               | UBLK_F_USER_RECOVERY_FAIL_IO)
> >
> > @@ -237,10 +238,11 @@ struct ublk_io {
> >  } ____cacheline_aligned_in_smp;
> >
> >  struct ublk_queue {
> >       u16 q_id;
> >       u16 q_depth;
> > +     u16 io_desc_size;
> >
> >       unsigned long flags;
> >       struct ublksrv_io_desc *io_cmd_buf;
> >
> >       bool force_abort;
> > @@ -403,11 +405,11 @@ static inline void ublk_io_evts_deinit(struct ubl=
k_queue *q)
> >  }
> >
> >  static inline struct ublksrv_io_desc *
> >  ublk_get_iod(const struct ublk_queue *ubq, u16 tag)
> >  {
> > -     return &ubq->io_cmd_buf[tag];
> > +     return (void *)ubq->io_cmd_buf + tag * (size_t)ubq->io_desc_size;
> >  }
> >
> >  static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq=
)
> >  {
> >       return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
> > @@ -1246,23 +1248,24 @@ static inline struct ublksrv_io_desc *
> >  ublk_queue_cmd_buf(struct ublk_device *ub, u16 q_id)
> >  {
> >       return ublk_get_queue(ub, q_id)->io_cmd_buf;
> >  }
> >
> > -static inline int __ublk_queue_cmd_buf_size(u16 depth)
> > +static inline size_t __ublk_queue_cmd_buf_size(const struct ublk_devic=
e *ub,
> > +                                            u16 depth)
> >  {
> > -     return round_up(depth * sizeof(struct ublksrv_io_desc), PAGE_SIZE=
);
> > +     return round_up(depth * (size_t)ub->dev_info.io_desc_size, PAGE_S=
IZE);
> >  }
> >
> > -static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub)
> > +static inline size_t ublk_queue_cmd_buf_size(const struct ublk_device =
*ub)
> >  {
> > -     return __ublk_queue_cmd_buf_size(ub->dev_info.queue_depth);
> > +     return __ublk_queue_cmd_buf_size(ub, ub->dev_info.queue_depth);
> >  }
> >
> > -static int ublk_max_cmd_buf_size(void)
> > +static size_t ublk_max_cmd_buf_size(const struct ublk_device *ub)
> >  {
> > -     return __ublk_queue_cmd_buf_size(UBLK_MAX_QUEUE_DEPTH);
> > +     return __ublk_queue_cmd_buf_size(ub, UBLK_MAX_QUEUE_DEPTH);
> >  }
> >
> >  /*
> >   * Should I/O outstanding to the ublk server when it exits be reissued=
?
> >   * If not, outstanding I/O will get errors.
> > @@ -2648,11 +2651,11 @@ static int ublk_ch_release(struct inode *inode,=
 struct file *filp)
> >  /* map pre-allocated per-queue cmd buffer to ublksrv daemon */
> >  static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
> >  {
> >       struct ublk_device *ub =3D filp->private_data;
> >       size_t sz =3D vma->vm_end - vma->vm_start;
> > -     unsigned max_sz =3D ublk_max_cmd_buf_size();
> > +     size_t max_sz =3D ublk_max_cmd_buf_size(ub);
> >       unsigned long pfn, end, phys_off =3D vma->vm_pgoff << PAGE_SHIFT;
> >       int ret =3D 0;
> >       u16 q_id;
> >
> >       spin_lock(&ub->lock);
> > @@ -4174,11 +4177,11 @@ static const struct file_operations ublk_ch_bat=
ch_io_fops =3D {
> >       .mmap =3D ublk_ch_mmap,
> >  };
> >
> >  static void __ublk_deinit_queue(struct ublk_device *ub, struct ublk_qu=
eue *ubq)
> >  {
> > -     int size;
> > +     size_t size;
> >       u16 i;
> >
> >       size =3D ublk_queue_cmd_buf_size(ub);
> >
> >       for (i =3D 0; i < ubq->q_depth; i++) {
> > @@ -4227,11 +4230,12 @@ static int ublk_init_queue(struct ublk_device *=
ub, u16 q_id)
> >       u16 depth =3D ub->dev_info.queue_depth;
> >       gfp_t gfp_flags =3D GFP_KERNEL | __GFP_ZERO;
> >       struct ublk_queue *ubq;
> >       struct page *page;
> >       int numa_node;
> > -     int size, ret;
> > +     size_t size;
> > +     int ret;
> >       u16 i;
> >
> >       /* Determine NUMA node based on queue's CPU affinity */
> >       numa_node =3D ublk_get_queue_numa_node(ub, q_id);
> >
> > @@ -4252,10 +4256,11 @@ static int ublk_init_queue(struct ublk_device *=
ub, u16 q_id)
> >       if (!page) {
> >               kvfree(ubq);
> >               return -ENOMEM;
> >       }
> >       ubq->io_cmd_buf =3D page_address(page);
> > +     ubq->io_desc_size =3D ub->dev_info.io_desc_size;
> >
> >       for (i =3D 0; i < ubq->q_depth; i++)
> >               spin_lock_init(&ubq->ios[i].lock);
> >
> >       if (ublk_dev_support_batch_io(ub)) {
> > @@ -4736,10 +4741,18 @@ static int ublk_ctrl_add_dev(const struct ublks=
rv_ctrl_cmd *header)
> >
> >       /* User copy is required to access integrity buffer */
> >       if (info.flags & UBLK_F_INTEGRITY && !(info.flags & UBLK_F_USER_C=
OPY))
> >               return -EINVAL;
> >
> > +     if (info.flags & UBLK_F_IO_DESC_SIZE) {
> > +             if (info.io_desc_size < sizeof(struct ublksrv_io_desc) ||
> > +                 info.io_desc_size % _Alignof(struct ublksrv_io_desc))
> > +                     return -EINVAL;
> > +     } else {
> > +             info.io_desc_size =3D sizeof(struct ublksrv_io_desc);
> > +     }
> > +
>
> No upper bound on io_desc_size.

What upper bound would you suggest?

>
> Also Missing selftest update =E2=80=94 this causes generic_13 failure.
>
> New feature needs sanity test to show it working at least.

Okay, will add a test.

Thanks,
Caleb
