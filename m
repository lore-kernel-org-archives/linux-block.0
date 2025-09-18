Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0E34BA57
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219135; cv=none; b=MvkcWYXTyaEuxNogdjMKk6/WWCawY5zWrjpjJjez16TjzWcK/0LMsdtb0V3twBhtg31REytdOjuMgvmp8hNHYd0Rlr0UP02sbDOIw1DuVtQ1Qh4JJ4HoFhZdP5Ma/DXgvcTI8U0ZknsQLa3x0ZDPZ1Jl5XbCm7pXYZoH14yjCV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219135; c=relaxed/simple;
	bh=cGompN9Yw2mhxPlj225Xl1W8mMjbHPudXvrUNTKseIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4thYE00V36LkSSGRDMkfVBLFn7pAIaYVt7jExhfjkfsGaAusx7tMWLSW4uCEdzX4Dq25kdc+YZu4CXYAIka9mzZ+1UzTqGXXDWhyncD/1Uetu4V9g82ziZ7A5MOkGa4cpKD1B5QEZ7lYPgofq5uyceTfzlsJcVIzTooecJX1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QvY51xx+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QvY51xx+"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3308f6093beso34324a91.3
        for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758219132; x=1758823932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmAZtU1d/A64k+qdnfEh8Id93O36dYtwCQvpre3N+lk=;
        b=QvY51xx+6ZpqLowrG/IWTrmosOTEZq9lf3ETjRdX9HaTqm42nOMpBw/2qcr7gcNRbt
         BNIgUbwI0/v0wbZ66KGqfqRDbUWO6HEILli5OjVBnMJXWbjmcmK6S6H6LllNKQP7lgkH
         6i9rYHeYhr4YwcKNAvLh9MiC3gBrOT8YIUKp+NA7yPuP1BBFroJ847K18Bk0EYawNi1d
         Lb89+8GsQPVfYeZ+6DqHvrVeYfuz1e0cIR6dwNa/zSrF9JrRErYuX8GyDEFkhqHp9g/l
         321urNWMoaua2WUbCTPg83sb+kvmlpagK28d747I1ins9RZy/cbOECISwica4c7nn2sr
         8NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758219132; x=1758823932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmAZtU1d/A64k+qdnfEh8Id93O36dYtwCQvpre3N+lk=;
        b=iMRfO3WBWxmccg6vE1qMVopULtzOcgU9GHNtjdZS5t0jT8dTC01mNbf9UwYp85VDmy
         FiCqpvOAF7EJvbHjEEWGOEKQroti5PMKN/61iEW0Rj0j7JQXfTa481EOuSL05zq8elmr
         DziNG6JqcBUcWmkexnRKuQ+gEFEfMyJ0V08JnnuDPW7PnI09Yo/sh7jdnh1P09s8N55x
         2tyNnjTRsYG4z16IS+J4NWl74wbLolPmajsyMRgCcbaf57gWvK5uPtNIWHskcDBlR/yM
         9HZHnPavpvJ+EgvV4Ecftu5ikP7vZDFSNHd2/L+HG2odpfo94G8PHiX/VewzGVq5UASN
         7jvw==
X-Forwarded-Encrypted: i=1; AJvYcCWd82qXNnFBfHuia1qRKebkuPXDPIxGMCCOWad3xDLn3H0VVI0Fi+5ebf91YDhQ5iAAYG8SK22P+mG7uA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywix63VPDu8YUYstXnDfEyvBT1wxIE3jImV5gcjn22SunCivTXJ
	AarQBkZT+M1l3jtO49QfQ4W6+lHvpmpMSAYqifcsM8yT6qrnWNU9ilJmu3VFoQRN/5JZ65FF6dC
	vZ7ATcFdQvecs72/qP8tSfKRIdRRC1/GlQRPjAz/nHg==
X-Gm-Gg: ASbGncuLW1BcEVoar24kK8cCb/NHI8+Ln3GPD8Rq9cBWYcwjY77ndslAZh62vNH9uby
	Nz1gouVtKfrHqMwBxpimtDjt2ZekNH7YSrdBgziPhNK8rF9T8+f8gpKeYYZA832zTncOgPM4Fzb
	FPdkrJMpSRo0WfM/TipNYt6PzSbrQZbO+SVjJFyfycivyiIT5/FnUfEN2Di/weNW9W50dPH/eJf
	44l7dgo82lS3lab2OhE48WsORIbn1POqJKoDVhO4uqpZwA6lhmNt7UgNA==
X-Google-Smtp-Source: AGHT+IHq+9WkGptVcpGkEdWEAup6XDXBtjslo7Hh3G6n3R3Qgf8m0OJhttwt5M1rHieT5qqf7MnGrdOkvOY/aEvaP7Q=
X-Received: by 2002:a17:90b:1e53:b0:32e:64e8:3f8c with SMTP id
 98e67ed59e1d1-33097fd4f25mr239665a91.1.1758219131939; Thu, 18 Sep 2025
 11:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901100242.3231000-1-ming.lei@redhat.com> <20250901100242.3231000-9-ming.lei@redhat.com>
 <CADUfDZr6QLHHaM=LJfRKXKGyE+2Emzhvkab53Yen1Cyinp21hg@mail.gmail.com> <aMD27G9-rwJpU49_@fedora>
In-Reply-To: <aMD27G9-rwJpU49_@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 18 Sep 2025 11:12:00 -0700
X-Gm-Features: AS18NWC980QrYUfG0fNuAgWHncP4rC-A8UQAxq6CRmfwughPa-jv6tC-fa2_o-0
Message-ID: <CADUfDZoQwNhQncLYi-AZZGpPSackgKejXYoBZh43sciCAUDGCg@mail.gmail.com>
Subject: Re: [PATCH 08/23] ublk: handle UBLK_U_IO_PREP_IO_CMDS
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 8:56=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Sat, Sep 06, 2025 at 12:48:41PM -0700, Caleb Sander Mateos wrote:
> > On Mon, Sep 1, 2025 at 3:03=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > This commit implements the handling of the UBLK_U_IO_PREP_IO_CMDS com=
mand,
> > > which allows userspace to prepare a batch of I/O requests.
> > >
> > > The core of this change is the `ublk_walk_cmd_buf` function, which it=
erates
> > > over the elements in the uring_cmd fixed buffer. For each element, it=
 parses
> > > the I/O details, finds the corresponding `ublk_io` structure, and pre=
pares it
> > > for future dispatch.
> > >
> > > Add per-io lock for protecting concurrent delivery and committing.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 191 ++++++++++++++++++++++++++++++++=
+-
> > >  include/uapi/linux/ublk_cmd.h |   5 +
> > >  2 files changed, 195 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 4da0dbbd7e16..a4bae3d1562a 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -116,6 +116,10 @@ struct ublk_uring_cmd_pdu {
> > >  struct ublk_batch_io_data {
> > >         struct ublk_queue *ubq;
> > >         struct io_uring_cmd *cmd;
> > > +       unsigned int issue_flags;
> > > +
> > > +       /* set when walking the element buffer */
> > > +       const struct ublk_elem_header *elem;
> > >  };
> > >
> > >  /*
> > > @@ -200,6 +204,7 @@ struct ublk_io {
> > >         unsigned task_registered_buffers;
> > >
> > >         void *buf_ctx_handle;
> > > +       spinlock_t lock;
> >
> > From our experience writing a high-throughput ublk server, the
> > spinlocks and mutexes in the kernel are some of the largest CPU
> > hotspots. We have spent a lot of effort working to avoid locking where
> > possible or shard data structures to reduce contention on the locks.
> > Even uncontended locks are still very expensive to acquire and release
> > on machines with many CPUs due to the cache coherency overhead. ublk's
> > per-io daemon architecture is great for performance by removing the
>
> io-uring highly depends on batch submission and completion, but per-io da=
emon
> may break the batch easily, because it doesn't guarantee that one batch I=
Os
> can be forwarded in single io task/io_uring when static tag mapping polic=
y is
> taken, for example:

That's a good point. We've mainly focused on optimizing the ublk
server side, but it's true that distributing incoming ublk I/Os to
more ublk server threads adds overhead on the submitting side. One
idea we had but haven't experimented with much is for the ublk server
to perform the round-robin assignment of tags within each queue to
threads in larger chunks. For example, with a chunk size of 4, tags 0
to 3 would be assigned to thread 0, tags 4 to 7 would be assigned to
thread 1, etc. That would improve the batching of ublk I/Os when
dispatching them from the submitting CPU to the ublk server thread.
There's an inherent tradeoff where distributing tags to ublk server
threads in larger chunks makes the distribution less balanced for
small numbers of I/Os, but it will be balanced when averaged over
large numbers of I/Os.

>
> ```
> [root@ktest-40 ublk]# ./kublk add -t null  --nthreads 8 -q 4 --per_io_tas=
ks
> dev id 0: nr_hw_queues 4 queue_depth 128 block size 512 dev_capacity 5242=
88000
>         max rq size 1048576 daemon pid 89975 flags 0x6042 state LIVE
>         queue 0: affinity(0 )
>         queue 1: affinity(4 )
>         queue 2: affinity(8 )
>         queue 3: affinity(12 )
> [root@ktest-40 ublk]#
> [root@ktest-40 ublk]# ./kublk add -t null  -q 4
> dev id 1: nr_hw_queues 4 queue_depth 128 block size 512 dev_capacity 5242=
88000
>         max rq size 1048576 daemon pid 90002 flags 0x6042 state LIVE
>         queue 0: affinity(0 )
>         queue 1: affinity(4 )
>         queue 2: affinity(8 )
>         queue 3: affinity(12 )
> [root@ktest-40 ublk]#
> [root@ktest-40 ublk]# ~/git/fio/t/io_uring -p0 /dev/ublkb0
> submitter=3D0, tid=3D90024, file=3D/dev/ublkb0, nfiles=3D1, node=3D-1
> polled=3D0, fixedbufs=3D1, register_files=3D1, buffered=3D0, QD=3D128
> Engine=3Dio_uring, sq_ring=3D128, cq_ring=3D128
> IOPS=3D188.54K, BW=3D736MiB/s, IOS/call=3D32/31
> IOPS=3D187.90K, BW=3D734MiB/s, IOS/call=3D32/32
> IOPS=3D195.39K, BW=3D763MiB/s, IOS/call=3D32/32
> ^CExiting on signal
> Maximum IOPS=3D195.39K
>
> [root@ktest-40 ublk]# ~/git/fio/t/io_uring -p0 /dev/ublkb1
> submitter=3D0, tid=3D90026, file=3D/dev/ublkb1, nfiles=3D1, node=3D-1
> polled=3D0, fixedbufs=3D1, register_files=3D1, buffered=3D0, QD=3D128
> Engine=3Dio_uring, sq_ring=3D128, cq_ring=3D128
> IOPS=3D608.26K, BW=3D2.38GiB/s, IOS/call=3D32/31
> IOPS=3D586.59K, BW=3D2.29GiB/s, IOS/call=3D32/31
> IOPS=3D599.62K, BW=3D2.34GiB/s, IOS/call=3D32/32
> ^CExiting on signal
> Maximum IOPS=3D608.26K
>
> ```
>
>
> > need for locks in the I/O path. I can't really see us adopting this
> > ublk batching feature; adding a spin_lock() + spin_unlock() to every
> > ublk commit operation is not worth the reduction in io_uring SQEs and
> > uring_cmds.
>
> As I mentioned in cover letter, the per-io lock can be avoided for UBLK_F=
_PER_IO_DAEMON
> as one follow-up, since io->task is still there for helping to track task=
 context.
>
> Just want to avoid too much features in enablement stage, that is also
> why the spin lock is wrapped in helper.

Okay, good to know there's at least an idea for how to avoid the
spinlock. Makes sense to defer it to follow-on work.

>
> >
> > >  } ____cacheline_aligned_in_smp;
> > >
> > >  struct ublk_queue {
> > > @@ -276,6 +281,16 @@ static inline bool ublk_support_batch_io(const s=
truct ublk_queue *ubq)
> > >         return false;
> > >  }
> > >
> > > +static inline void ublk_io_lock(struct ublk_io *io)
> > > +{
> > > +       spin_lock(&io->lock);
> > > +}
> > > +
> > > +static inline void ublk_io_unlock(struct ublk_io *io)
> > > +{
> > > +       spin_unlock(&io->lock);
> > > +}
> > > +
> > >  static inline struct ublksrv_io_desc *
> > >  ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
> > >  {
> > > @@ -2538,6 +2553,171 @@ static int ublk_ch_uring_cmd(struct io_uring_=
cmd *cmd, unsigned int issue_flags)
> > >         return ublk_ch_uring_cmd_local(cmd, issue_flags);
> > >  }
> > >
> > > +static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_io *=
uc,
> > > +                                       const struct ublk_elem_header=
 *elem)
> > > +{
> > > +       const void *buf =3D (const void *)elem;
> >
> > Don't need an explicit cast in order to cast to void *.
>
> OK.
>
> >
> >
> > > +
> > > +       if (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR)
> > > +               return *(__u64 *)(buf + sizeof(*elem));
> > > +       return -1;
> >
> > Why -1 and not 0? ublk_check_fetch_buf() is expecting a 0 buf_addr to
> > indicate the lack
>
> Good catch, it needs to return 0.
>
> >
> > > +}
> > > +
> > > +static struct ublk_auto_buf_reg
> > > +ublk_batch_auto_buf_reg(const struct ublk_batch_io *uc,
> > > +                       const struct ublk_elem_header *elem)
> > > +{
> > > +       struct ublk_auto_buf_reg reg =3D {
> > > +               .index =3D elem->buf_index,
> > > +               .flags =3D (uc->flags & UBLK_BATCH_F_AUTO_BUF_REG_FAL=
LBACK) ?
> > > +                       UBLK_AUTO_BUF_REG_FALLBACK : 0,
> > > +       };
> > > +
> > > +       return reg;
> > > +}
> > > +
> > > +/* 48 can cover any type of buffer element(8, 16 and 24 bytes) */
> >
> > "can cover" is a bit vague. Can you be explicit that the buffer size
> > needs to be a multiple of any possible buffer element size?
>
> I should have documented that 48 is least common multiple(LCM) of (8, 16 =
and
> 24)
>
> >
> > > +#define UBLK_CMD_BATCH_TMP_BUF_SZ  (48 * 10)
> > > +struct ublk_batch_io_iter {
> > > +       /* copy to this buffer from iterator first */
> > > +       unsigned char buf[UBLK_CMD_BATCH_TMP_BUF_SZ];
> > > +       struct iov_iter iter;
> > > +       unsigned done, total;
> > > +       unsigned char elem_bytes;
> > > +};
> > > +
> > > +static int __ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
> > > +                               struct ublk_batch_io_data *data,
> > > +                               unsigned bytes,
> > > +                               int (*cb)(struct ublk_io *io,
> > > +                                       const struct ublk_batch_io_da=
ta *data))
> > > +{
> > > +       int i, ret =3D 0;
> > > +
> > > +       for (i =3D 0; i < bytes; i +=3D iter->elem_bytes) {
> > > +               const struct ublk_elem_header *elem =3D
> > > +                       (const struct ublk_elem_header *)&iter->buf[i=
];
> > > +               struct ublk_io *io;
> > > +
> > > +               if (unlikely(elem->tag >=3D data->ubq->q_depth)) {
> > > +                       ret =3D -EINVAL;
> > > +                       break;
> > > +               }
> > > +
> > > +               io =3D &data->ubq->ios[elem->tag];
> > > +               data->elem =3D elem;
> > > +               ret =3D cb(io, data);
> >
> > Why not just pas elem as a separate argument to the callback?
>
> One reason is that we don't have complete type for 'elem' since its size
> is a variable.

I didn't mean to pass ublk_elem_header by value, still by pointer.
Just that you could pass const struct ublk_elem_header *elem as an
additional parameter to the callback. I think that would make the code
a bit easier to follow than passing it via data->elem.

>
> >
> > > +               if (unlikely(ret))
> > > +                       break;
> > > +       }
> > > +       iter->done +=3D i;
> > > +       return ret;
> > > +}
> > > +
> > > +static int ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
> > > +                            struct ublk_batch_io_data *data,
> > > +                            int (*cb)(struct ublk_io *io,
> > > +                                    const struct ublk_batch_io_data =
*data))
> > > +{
> > > +       int ret =3D 0;
> > > +
> > > +       while (iter->done < iter->total) {
> > > +               unsigned int len =3D min(sizeof(iter->buf), iter->tot=
al - iter->done);
> > > +
> > > +               ret =3D copy_from_iter(iter->buf, len, &iter->iter);
> > > +               if (ret !=3D len) {
> >
> > How would this be possible? The iterator comes from an io_uring
> > registered buffer with at least the requested length, so the user
> > addresses should have been validated when the buffer was registered.
> > Should this just be a WARN_ON()?
>
> yes, that is why pr_warn() is used, I remember that WARN_ON() isn't
> encouraged in user code path.
>
> >
> > > +                       pr_warn("ublk%d: read batch cmd buffer failed=
 %u/%u\n",
> > > +                                       data->ubq->dev->dev_info.dev_=
id, ret, len);
> > > +                       ret =3D -EINVAL;
> > > +                       break;
> > > +               }
> > > +
> > > +               ret =3D __ublk_walk_cmd_buf(iter, data, len, cb);
> > > +               if (ret)
> > > +                       break;
> > > +       }
> > > +       return ret;
> > > +}
> > > +
> > > +static int ublk_batch_unprep_io(struct ublk_io *io,
> > > +                               const struct ublk_batch_io_data *data=
)
> > > +{
> > > +       if (ublk_queue_ready(data->ubq))
> > > +               data->ubq->dev->nr_queues_ready--;
> > > +
> > > +       ublk_io_lock(io);
> > > +       io->flags =3D 0;
> > > +       ublk_io_unlock(io);
> > > +       data->ubq->nr_io_ready--;
> > > +       return 0;
> >
> > This "unprep" looks very subtle and fairly complicated. Is it really
> > necessary? What's wrong with leaving the I/Os that were successfully
> > prepped? It also looks racy to clear io->flags after the queue is
> > ready, as the io may already be in use by some I/O request.
>
> ublk_batch_unprep_io() is called in partial completion of UBLK_U_IO_PREP_=
IO_CMDS,
> when START_DEV can't succeed, so there can't be any IO.

Isn't it possible that the UBLK_U_IO_PREP_IO_CMDS batch contains all
the I/Os not yet prepped followed by some duplicates? Then the device
could be started following the successful completion of all the newly
prepped I/Os, but the batch would fail on the following duplicate
I/Os, causing the successfully prepped I/Os to be unprepped?

>
> >
> > > +}
> > > +
> > > +static void ublk_batch_revert_prep_cmd(struct ublk_batch_io_iter *it=
er,
> > > +                                      struct ublk_batch_io_data *dat=
a)
> > > +{
> > > +       int ret;
> > > +
> > > +       if (!iter->done)
> > > +               return;
> > > +
> > > +       iov_iter_revert(&iter->iter, iter->done);
> >
> > Shouldn't the iterator be reverted by the total number of bytes
> > copied, which may be more than iter->done?
>
> ->done is exactly the total bytes handled.

But the number of bytes "handled" is not the same as the number of
bytes the iterator was advanced by, right? The copy_from_iter() is
responsible for advancing the iterator, but __ublk_walk_cmd_buf() may
break early before processing all those elements. iter->done would
only be set to the number of bytes processed by __ublk_walk_cmd_buf(),
which may be less than the bytes obtained from the iterator.

>
> >
> > > +       iter->total =3D iter->done;
> > > +       iter->done =3D 0;
> > > +
> > > +       ret =3D ublk_walk_cmd_buf(iter, data, ublk_batch_unprep_io);
> > > +       WARN_ON_ONCE(ret);
> > > +}
> > > +
> > > +static int ublk_batch_prep_io(struct ublk_io *io,
> > > +                             const struct ublk_batch_io_data *data)
> > > +{
> > > +       const struct ublk_batch_io *uc =3D io_uring_sqe_cmd(data->cmd=
->sqe);
> > > +       union ublk_io_buf buf =3D { 0 };
> > > +       int ret;
> > > +
> > > +       if (ublk_support_auto_buf_reg(data->ubq))
> > > +               buf.auto_reg =3D ublk_batch_auto_buf_reg(uc, data->el=
em);
> > > +       else if (ublk_need_map_io(data->ubq)) {
> > > +               buf.addr =3D ublk_batch_buf_addr(uc, data->elem);
> > > +
> > > +               ret =3D ublk_check_fetch_buf(data->ubq, buf.addr);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > > +
> > > +       ublk_io_lock(io);
> > > +       ret =3D __ublk_fetch(data->cmd, data->ubq, io);
> > > +       if (!ret)
> > > +               io->buf =3D buf;
> > > +       ublk_io_unlock(io);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +static int ublk_handle_batch_prep_cmd(struct ublk_batch_io_data *dat=
a)
> > > +{
> > > +       struct io_uring_cmd *cmd =3D data->cmd;
> > > +       const struct ublk_batch_io *uc =3D io_uring_sqe_cmd(cmd->sqe)=
;
> > > +       struct ublk_batch_io_iter iter =3D {
> > > +               .total =3D uc->nr_elem * uc->elem_bytes,
> > > +               .elem_bytes =3D uc->elem_bytes,
> > > +       };
> > > +       int ret;
> > > +
> > > +       ret =3D io_uring_cmd_import_fixed(cmd->sqe->addr, cmd->sqe->l=
en,
> >
> > Could iter.total be used in place of cmd->sqe->len? That way userspace
> > wouldn't have to specify a redundant value in the SQE len field.
>
> This way follows how buffer is used in io_uring/rw.c, but looks it can be=
 saved.
> But benefit is cross-verify, cause io-uring sqe user interface is complic=
ated.

In a IORING_OP_{READ,WRITE}{,V} operation, there aren't other fields
that can be used to determine the length of data that will be
accessed. I would rather not require userspace to pass a redundant
value, this makes the UAPI even more complicated.

Best,
Caleb

>
> >
> > > +                       WRITE, &iter.iter, cmd, data->issue_flags);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       mutex_lock(&data->ubq->dev->mutex);
> > > +       ret =3D ublk_walk_cmd_buf(&iter, data, ublk_batch_prep_io);
> > > +
> > > +       if (ret && iter.done)
> > > +               ublk_batch_revert_prep_cmd(&iter, data);
> >
> > The iter.done check is duplicated in ublk_batch_revert_prep_cmd().
>
> OK, we can remove the check in ublk_batch_revert_prep_cmd().
>
> >
> > > +       mutex_unlock(&data->ubq->dev->mutex);
> > > +       return ret;
> > > +}
> > > +
> > >  static int ublk_check_batch_cmd_flags(const struct ublk_batch_io *uc=
)
> > >  {
> > >         const unsigned short mask =3D UBLK_BATCH_F_HAS_BUF_ADDR |
> > > @@ -2609,6 +2789,7 @@ static int ublk_ch_batch_io_uring_cmd(struct io=
_uring_cmd *cmd,
> > >         struct ublk_device *ub =3D cmd->file->private_data;
> > >         struct ublk_batch_io_data data =3D {
> > >                 .cmd =3D cmd,
> > > +               .issue_flags =3D issue_flags,
> > >         };
> > >         u32 cmd_op =3D cmd->cmd_op;
> > >         int ret =3D -EINVAL;
> > > @@ -2619,6 +2800,11 @@ static int ublk_ch_batch_io_uring_cmd(struct i=
o_uring_cmd *cmd,
> > >
> > >         switch (cmd_op) {
> > >         case UBLK_U_IO_PREP_IO_CMDS:
> > > +               ret =3D ublk_check_batch_cmd(&data, uc);
> > > +               if (ret)
> > > +                       goto out;
> > > +               ret =3D ublk_handle_batch_prep_cmd(&data);
> > > +               break;
> > >         case UBLK_U_IO_COMMIT_IO_CMDS:
> > >                 ret =3D ublk_check_batch_cmd(&data, uc);
> > >                 if (ret)
> > > @@ -2780,7 +2966,7 @@ static int ublk_init_queue(struct ublk_device *=
ub, int q_id)
> > >         struct ublk_queue *ubq =3D ublk_get_queue(ub, q_id);
> > >         gfp_t gfp_flags =3D GFP_KERNEL | __GFP_ZERO;
> > >         void *ptr;
> > > -       int size;
> > > +       int size, i;
> > >
> > >         spin_lock_init(&ubq->cancel_lock);
> > >         ubq->flags =3D ub->dev_info.flags;
> > > @@ -2792,6 +2978,9 @@ static int ublk_init_queue(struct ublk_device *=
ub, int q_id)
> > >         if (!ptr)
> > >                 return -ENOMEM;
> > >
> > > +       for (i =3D 0; i < ubq->q_depth; i++)
> > > +               spin_lock_init(&ubq->ios[i].lock);
> > > +
> > >         ubq->io_cmd_buf =3D ptr;
> > >         ubq->dev =3D ub;
> > >         return 0;
> > > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_=
cmd.h
> > > index 01d3af52cfb4..38c8cc10d694 100644
> > > --- a/include/uapi/linux/ublk_cmd.h
> > > +++ b/include/uapi/linux/ublk_cmd.h
> > > @@ -102,6 +102,11 @@
> > >         _IOWR('u', 0x23, struct ublksrv_io_cmd)
> > >  #define        UBLK_U_IO_UNREGISTER_IO_BUF     \
> > >         _IOWR('u', 0x24, struct ublksrv_io_cmd)
> > > +
> > > +/*
> > > + * return 0 if the command is run successfully, otherwise failure co=
de
> > > + * is returned
> > > + */
> >
> > Not sure this is really necessary to comment, that's pretty standard
> > for syscalls and uring_cmds.
>
> OK, I think it is for showing the difference with UBLK_U_IO_COMMIT_IO_CMD=
S,
> which has to support partial commit, however UBLK_U_IO_PREP_IO_CMDS
> need to be all or nothing.
>
>
> Thanks,
> Ming
>
