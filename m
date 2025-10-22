Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D502F2916
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120070; cv=none; b=hj4ZW0CZCDHkPfHsi1DXE6V4CcTVeCxigmQw5TfjxpIrLT3fJh9cCjR4yTL0EfPkp2fcVKMZbkyIplV0Z5LIohCpNZTDm8UcCE6KogJRcVBi++ajDsGEmy0ifH1E4wKJW6mP1V+zlgvY5fyT9TfDMsvPJigdb80G/3HqowGUv7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120070; c=relaxed/simple;
	bh=gOnh0bSGk+6j6LPgXci7T5cv0RuRAvqUFSanc6OkQTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3cfZLKNgRM8ObFobut5AZ9fK3bGzw9TcW0hIe5QeD5dl8hVnfmsraoOO4GLwZpLXqveC8sfz72gZNGHpXjEbnFRMkKiPm7/PE6ztOO30/tlqvuLG6xEloENqAZKrmz77K01SZM2qtZL7HX4MNU/uvRKfIoW7kB4Ci243jaOba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GB4Ntb8u; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GB4Ntb8u"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32ebcef552eso1262548a91.0
        for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 01:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761120065; x=1761724865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vlem0OGI/7beq12pkW43PvJ7QzVsNpoW6vhalK5xWV0=;
        b=GB4Ntb8uhCSKZblayI1EciC7DbXO1nuzaFDkxAigwv3gUjBz71N3MkNsSTHNkY6htG
         F9VM8ht9MHMZUQ2eXUSrX4UPjmL+a7lpgR/68cjBnwXtMFoUJJXhV4vSHhTTlxQX8tt+
         eGp5R9z2u2j4QbYAEM5Gqvz02FROnCK8+g+stWvWb0/0WRsMtI09PGPVu8XXHm9qFn18
         4ZCSW8ZsLQodAOeUgGD6ZCo1+7he6SuHL8oRgmXKtyaIiTdJGy4GDhy8FHaLReK8rvMV
         VDRo1pAmWyU7FNIO3k4pclUeebC3Knax0pg77TzC+QZihn+O3g8T+HXK4+Q4rAx7WrOx
         8TYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120065; x=1761724865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vlem0OGI/7beq12pkW43PvJ7QzVsNpoW6vhalK5xWV0=;
        b=V5J3sDQApS7JiZKYlUg5U0hja38/nyMtSkwNICEkoyB/bKxACzAuX44agqWQRP44In
         iO/hUMnFIv/Uf13NUX3wNyXulFy/0tdRWdLvqjTXVQzdEhxvhHccH4nLdSnn8z8RPeIu
         nfgKbaZLhRAF6hU9PygLYA3bSJt9yv2K/Q0GNlbFFGESOzEYq9XSmQfeKqmVMNF+6EvU
         mMqQDYOznsc0WqY98BV/mPvqmwsFBGYHtrZvHQzEUXjq9Ayyw0LBgXfyuVBuBlc0r4KS
         IfLt8/eslr8j0yT4Y9XzN2jIRPt+2J2cpCcgnLtPB5BFFDqFg1jR8OcS7ZQmqvnRN8Rx
         RJxA==
X-Forwarded-Encrypted: i=1; AJvYcCXLacch/OKMRnVLEAVJt7iEBIH0QJw1anX0yeraged3TDWIsDph6C2bgwBBuEb3sXbkACrZU8g35lJoag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0I/mLCzALTLhzWesGvnqxedOP3/MItj4NygbHIOW/xVdoU4Or
	H/9NzjrnUZvtHYwigac66FJJHt5QaokWuATeajB22x/XVDML0uIwRzCsqg+TiaESIybvHrNv4Z8
	KrifCtuFPMDkjcnSxYgXBdnAsGFeK2WWSee/zvvcJOg==
X-Gm-Gg: ASbGnctTIS2nqVzwPxJYR1nRwtbA6lAulkFMeFq/f3IR5atISftZrTiiNcIioWKs2yE
	JIVlr6aaT9LrXW/WSyK65UaXOarEG9Grck7WxiAQnbJNmXufIr02xgH5cwF37MgBqYNdhziqeu2
	jH5fGHxjzK4T0PltAMO0rM4PS9SRP8ycG+1ngy5ePIt+mnfOnu1a6DOIjNyoZP2lxJFLepDu8KK
	Kow9qGZ3b3N+PLGu5vq0z8y4F2KlCz/cKnV+psI9QfazXxZnVsikVaedanOQcp3c9swbciucapF
	nn1RX+tLFFGy93v829snPndG9TjG
X-Google-Smtp-Source: AGHT+IFxHDCz6OF3IFt6fXhs4Sg/JMKR5f8xvZdvxD0572lQOyNLXXeWEekC4MhMrsIc4vKj5ysmDZb/xbdKG6Yd1io=
X-Received: by 2002:a17:90b:4b8b:b0:338:3156:fc3f with SMTP id
 98e67ed59e1d1-33dfabd6e2emr4494411a91.4.1761120064818; Wed, 22 Oct 2025
 01:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901100242.3231000-1-ming.lei@redhat.com> <20250901100242.3231000-9-ming.lei@redhat.com>
 <CADUfDZr6QLHHaM=LJfRKXKGyE+2Emzhvkab53Yen1Cyinp21hg@mail.gmail.com>
 <aMD27G9-rwJpU49_@fedora> <CADUfDZoQwNhQncLYi-AZZGpPSackgKejXYoBZh43sciCAUDGCg@mail.gmail.com>
 <aPDELNXqlckznZJI@fedora>
In-Reply-To: <aPDELNXqlckznZJI@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 22 Oct 2025 01:00:53 -0700
X-Gm-Features: AS18NWDvQ9PNlR4z22xbNOG8QkmNHgUYIcOjoIN6-qQUI2R_eLEm9xmhJbOEDmM
Message-ID: <CADUfDZqCo2O0toQ0M=RBDLnYkANJJ3iQkFmpD_QDbbimx6egRg@mail.gmail.com>
Subject: Re: [PATCH 08/23] ublk: handle UBLK_U_IO_PREP_IO_CMDS
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 3:08=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Sep 18, 2025 at 11:12:00AM -0700, Caleb Sander Mateos wrote:
> > On Tue, Sep 9, 2025 at 8:56=E2=80=AFPM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > On Sat, Sep 06, 2025 at 12:48:41PM -0700, Caleb Sander Mateos wrote:
> > > > On Mon, Sep 1, 2025 at 3:03=E2=80=AFAM Ming Lei <ming.lei@redhat.co=
m> wrote:
> > > > >
> > > > > This commit implements the handling of the UBLK_U_IO_PREP_IO_CMDS=
 command,
> > > > > which allows userspace to prepare a batch of I/O requests.
> > > > >
> > > > > The core of this change is the `ublk_walk_cmd_buf` function, whic=
h iterates
> > > > > over the elements in the uring_cmd fixed buffer. For each element=
, it parses
> > > > > the I/O details, finds the corresponding `ublk_io` structure, and=
 prepares it
> > > > > for future dispatch.
> > > > >
> > > > > Add per-io lock for protecting concurrent delivery and committing=
.
> > > > >
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > ---
> > > > >  drivers/block/ublk_drv.c      | 191 ++++++++++++++++++++++++++++=
+++++-
> > > > >  include/uapi/linux/ublk_cmd.h |   5 +
> > > > >  2 files changed, 195 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > index 4da0dbbd7e16..a4bae3d1562a 100644
> > > > > --- a/drivers/block/ublk_drv.c
> > > > > +++ b/drivers/block/ublk_drv.c
> > > > > @@ -116,6 +116,10 @@ struct ublk_uring_cmd_pdu {
> > > > >  struct ublk_batch_io_data {
> > > > >         struct ublk_queue *ubq;
> > > > >         struct io_uring_cmd *cmd;
> > > > > +       unsigned int issue_flags;
> > > > > +
> > > > > +       /* set when walking the element buffer */
> > > > > +       const struct ublk_elem_header *elem;
> > > > >  };
> > > > >
> > > > >  /*
> > > > > @@ -200,6 +204,7 @@ struct ublk_io {
> > > > >         unsigned task_registered_buffers;
> > > > >
> > > > >         void *buf_ctx_handle;
> > > > > +       spinlock_t lock;
> > > >
> > > > From our experience writing a high-throughput ublk server, the
> > > > spinlocks and mutexes in the kernel are some of the largest CPU
> > > > hotspots. We have spent a lot of effort working to avoid locking wh=
ere
> > > > possible or shard data structures to reduce contention on the locks=
.
> > > > Even uncontended locks are still very expensive to acquire and rele=
ase
> > > > on machines with many CPUs due to the cache coherency overhead. ubl=
k's
> > > > per-io daemon architecture is great for performance by removing the
> > >
> > > io-uring highly depends on batch submission and completion, but per-i=
o daemon
> > > may break the batch easily, because it doesn't guarantee that one bat=
ch IOs
> > > can be forwarded in single io task/io_uring when static tag mapping p=
olicy is
> > > taken, for example:
> >
> > That's a good point. We've mainly focused on optimizing the ublk
> > server side, but it's true that distributing incoming ublk I/Os to
> > more ublk server threads adds overhead on the submitting side. One
> > idea we had but haven't experimented with much is for the ublk server
> > to perform the round-robin assignment of tags within each queue to
>
> round-robin often hurts perf, and it isn't enabled yet.

I don't mean BLK_MQ_F_TAG_RR. I thought even the default tag
allocation scheme resulted in approximately round-robin tag
allocation, right? __sbitmap_queue_get_batch() will attempt to
allocate contiguous bits from the map, so a batch of queued requests
will likely be assigned sequential tags (or a couple sequential runs
of tags) in the queue. I guess that's only true if the queue is mostly
empty; if many tags are in use, it will be harder to allocate
contiguous sets of tags.

>
> > threads in larger chunks. For example, with a chunk size of 4, tags 0
> > to 3 would be assigned to thread 0, tags 4 to 7 would be assigned to
> > thread 1, etc. That would improve the batching of ublk I/Os when
> > dispatching them from the submitting CPU to the ublk server thread.
> > There's an inherent tradeoff where distributing tags to ublk server
> > threads in larger chunks makes the distribution less balanced for
> > small numbers of I/Os, but it will be balanced when averaged over
> > large numbers of I/Os.
>
> How can fixed chunk size work generically? It depends on workload batch
> size on /dev/ublkbN, and different workload takes different batch size.

Yes, that's a good point. It requires pretty specific knowledge of the
workload to optimize the tag assignment to ublk server threads like
this.

>
> >
> > >
> > > ```
> > > [root@ktest-40 ublk]# ./kublk add -t null  --nthreads 8 -q 4 --per_io=
_tasks
> > > dev id 0: nr_hw_queues 4 queue_depth 128 block size 512 dev_capacity =
524288000
> > >         max rq size 1048576 daemon pid 89975 flags 0x6042 state LIVE
> > >         queue 0: affinity(0 )
> > >         queue 1: affinity(4 )
> > >         queue 2: affinity(8 )
> > >         queue 3: affinity(12 )
> > > [root@ktest-40 ublk]#
> > > [root@ktest-40 ublk]# ./kublk add -t null  -q 4
> > > dev id 1: nr_hw_queues 4 queue_depth 128 block size 512 dev_capacity =
524288000
> > >         max rq size 1048576 daemon pid 90002 flags 0x6042 state LIVE
> > >         queue 0: affinity(0 )
> > >         queue 1: affinity(4 )
> > >         queue 2: affinity(8 )
> > >         queue 3: affinity(12 )
> > > [root@ktest-40 ublk]#
> > > [root@ktest-40 ublk]# ~/git/fio/t/io_uring -p0 /dev/ublkb0
> > > submitter=3D0, tid=3D90024, file=3D/dev/ublkb0, nfiles=3D1, node=3D-1
> > > polled=3D0, fixedbufs=3D1, register_files=3D1, buffered=3D0, QD=3D128
> > > Engine=3Dio_uring, sq_ring=3D128, cq_ring=3D128
> > > IOPS=3D188.54K, BW=3D736MiB/s, IOS/call=3D32/31
> > > IOPS=3D187.90K, BW=3D734MiB/s, IOS/call=3D32/32
> > > IOPS=3D195.39K, BW=3D763MiB/s, IOS/call=3D32/32
> > > ^CExiting on signal
> > > Maximum IOPS=3D195.39K
> > >
> > > [root@ktest-40 ublk]# ~/git/fio/t/io_uring -p0 /dev/ublkb1
> > > submitter=3D0, tid=3D90026, file=3D/dev/ublkb1, nfiles=3D1, node=3D-1
> > > polled=3D0, fixedbufs=3D1, register_files=3D1, buffered=3D0, QD=3D128
> > > Engine=3Dio_uring, sq_ring=3D128, cq_ring=3D128
> > > IOPS=3D608.26K, BW=3D2.38GiB/s, IOS/call=3D32/31
> > > IOPS=3D586.59K, BW=3D2.29GiB/s, IOS/call=3D32/31
> > > IOPS=3D599.62K, BW=3D2.34GiB/s, IOS/call=3D32/32
> > > ^CExiting on signal
> > > Maximum IOPS=3D608.26K
> > >
> > > ```
> > >
> > >
> > > > need for locks in the I/O path. I can't really see us adopting this
> > > > ublk batching feature; adding a spin_lock() + spin_unlock() to ever=
y
> > > > ublk commit operation is not worth the reduction in io_uring SQEs a=
nd
> > > > uring_cmds.
> > >
> > > As I mentioned in cover letter, the per-io lock can be avoided for UB=
LK_F_PER_IO_DAEMON
> > > as one follow-up, since io->task is still there for helping to track =
task context.
> > >
> > > Just want to avoid too much features in enablement stage, that is als=
o
> > > why the spin lock is wrapped in helper.
> >
> > Okay, good to know there's at least an idea for how to avoid the
> > spinlock. Makes sense to defer it to follow-on work.
> >
> > >
> > > >
> > > > >  } ____cacheline_aligned_in_smp;
> > > > >
> > > > >  struct ublk_queue {
> > > > > @@ -276,6 +281,16 @@ static inline bool ublk_support_batch_io(con=
st struct ublk_queue *ubq)
> > > > >         return false;
> > > > >  }
> > > > >
> > > > > +static inline void ublk_io_lock(struct ublk_io *io)
> > > > > +{
> > > > > +       spin_lock(&io->lock);
> > > > > +}
> > > > > +
> > > > > +static inline void ublk_io_unlock(struct ublk_io *io)
> > > > > +{
> > > > > +       spin_unlock(&io->lock);
> > > > > +}
> > > > > +
> > > > >  static inline struct ublksrv_io_desc *
> > > > >  ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
> > > > >  {
> > > > > @@ -2538,6 +2553,171 @@ static int ublk_ch_uring_cmd(struct io_ur=
ing_cmd *cmd, unsigned int issue_flags)
> > > > >         return ublk_ch_uring_cmd_local(cmd, issue_flags);
> > > > >  }
> > > > >
> > > > > +static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_=
io *uc,
> > > > > +                                       const struct ublk_elem_he=
ader *elem)
> > > > > +{
> > > > > +       const void *buf =3D (const void *)elem;
> > > >
> > > > Don't need an explicit cast in order to cast to void *.
> > >
> > > OK.
> > >
> > > >
> > > >
> > > > > +
> > > > > +       if (uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR)
> > > > > +               return *(__u64 *)(buf + sizeof(*elem));
> > > > > +       return -1;
> > > >
> > > > Why -1 and not 0? ublk_check_fetch_buf() is expecting a 0 buf_addr =
to
> > > > indicate the lack
> > >
> > > Good catch, it needs to return 0.
> > >
> > > >
> > > > > +}
> > > > > +
> > > > > +static struct ublk_auto_buf_reg
> > > > > +ublk_batch_auto_buf_reg(const struct ublk_batch_io *uc,
> > > > > +                       const struct ublk_elem_header *elem)
> > > > > +{
> > > > > +       struct ublk_auto_buf_reg reg =3D {
> > > > > +               .index =3D elem->buf_index,
> > > > > +               .flags =3D (uc->flags & UBLK_BATCH_F_AUTO_BUF_REG=
_FALLBACK) ?
> > > > > +                       UBLK_AUTO_BUF_REG_FALLBACK : 0,
> > > > > +       };
> > > > > +
> > > > > +       return reg;
> > > > > +}
> > > > > +
> > > > > +/* 48 can cover any type of buffer element(8, 16 and 24 bytes) *=
/
> > > >
> > > > "can cover" is a bit vague. Can you be explicit that the buffer siz=
e
> > > > needs to be a multiple of any possible buffer element size?
> > >
> > > I should have documented that 48 is least common multiple(LCM) of (8,=
 16 and
> > > 24)
> > >
> > > >
> > > > > +#define UBLK_CMD_BATCH_TMP_BUF_SZ  (48 * 10)
> > > > > +struct ublk_batch_io_iter {
> > > > > +       /* copy to this buffer from iterator first */
> > > > > +       unsigned char buf[UBLK_CMD_BATCH_TMP_BUF_SZ];
> > > > > +       struct iov_iter iter;
> > > > > +       unsigned done, total;
> > > > > +       unsigned char elem_bytes;
> > > > > +};
> > > > > +
> > > > > +static int __ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
> > > > > +                               struct ublk_batch_io_data *data,
> > > > > +                               unsigned bytes,
> > > > > +                               int (*cb)(struct ublk_io *io,
> > > > > +                                       const struct ublk_batch_i=
o_data *data))
> > > > > +{
> > > > > +       int i, ret =3D 0;
> > > > > +
> > > > > +       for (i =3D 0; i < bytes; i +=3D iter->elem_bytes) {
> > > > > +               const struct ublk_elem_header *elem =3D
> > > > > +                       (const struct ublk_elem_header *)&iter->b=
uf[i];
> > > > > +               struct ublk_io *io;
> > > > > +
> > > > > +               if (unlikely(elem->tag >=3D data->ubq->q_depth)) =
{
> > > > > +                       ret =3D -EINVAL;
> > > > > +                       break;
> > > > > +               }
> > > > > +
> > > > > +               io =3D &data->ubq->ios[elem->tag];
> > > > > +               data->elem =3D elem;
> > > > > +               ret =3D cb(io, data);
> > > >
> > > > Why not just pas elem as a separate argument to the callback?
> > >
> > > One reason is that we don't have complete type for 'elem' since its s=
ize
> > > is a variable.
> >
> > I didn't mean to pass ublk_elem_header by value, still by pointer.
> > Just that you could pass const struct ublk_elem_header *elem as an
> > additional parameter to the callback. I think that would make the code
> > a bit easier to follow than passing it via data->elem.
>
> OK.
>
> >
> > >
> > > >
> > > > > +               if (unlikely(ret))
> > > > > +                       break;
> > > > > +       }
> > > > > +       iter->done +=3D i;
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +static int ublk_walk_cmd_buf(struct ublk_batch_io_iter *iter,
> > > > > +                            struct ublk_batch_io_data *data,
> > > > > +                            int (*cb)(struct ublk_io *io,
> > > > > +                                    const struct ublk_batch_io_d=
ata *data))
> > > > > +{
> > > > > +       int ret =3D 0;
> > > > > +
> > > > > +       while (iter->done < iter->total) {
> > > > > +               unsigned int len =3D min(sizeof(iter->buf), iter-=
>total - iter->done);
> > > > > +
> > > > > +               ret =3D copy_from_iter(iter->buf, len, &iter->ite=
r);
> > > > > +               if (ret !=3D len) {
> > > >
> > > > How would this be possible? The iterator comes from an io_uring
> > > > registered buffer with at least the requested length, so the user
> > > > addresses should have been validated when the buffer was registered=
.
> > > > Should this just be a WARN_ON()?
> > >
> > > yes, that is why pr_warn() is used, I remember that WARN_ON() isn't
> > > encouraged in user code path.
> > >
> > > >
> > > > > +                       pr_warn("ublk%d: read batch cmd buffer fa=
iled %u/%u\n",
> > > > > +                                       data->ubq->dev->dev_info.=
dev_id, ret, len);
> > > > > +                       ret =3D -EINVAL;
> > > > > +                       break;
> > > > > +               }
> > > > > +
> > > > > +               ret =3D __ublk_walk_cmd_buf(iter, data, len, cb);
> > > > > +               if (ret)
> > > > > +                       break;
> > > > > +       }
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +static int ublk_batch_unprep_io(struct ublk_io *io,
> > > > > +                               const struct ublk_batch_io_data *=
data)
> > > > > +{
> > > > > +       if (ublk_queue_ready(data->ubq))
> > > > > +               data->ubq->dev->nr_queues_ready--;
> > > > > +
> > > > > +       ublk_io_lock(io);
> > > > > +       io->flags =3D 0;
> > > > > +       ublk_io_unlock(io);
> > > > > +       data->ubq->nr_io_ready--;
> > > > > +       return 0;
> > > >
> > > > This "unprep" looks very subtle and fairly complicated. Is it reall=
y
> > > > necessary? What's wrong with leaving the I/Os that were successfull=
y
> > > > prepped? It also looks racy to clear io->flags after the queue is
> > > > ready, as the io may already be in use by some I/O request.
> > >
> > > ublk_batch_unprep_io() is called in partial completion of UBLK_U_IO_P=
REP_IO_CMDS,
> > > when START_DEV can't succeed, so there can't be any IO.
> >
> > Isn't it possible that the UBLK_U_IO_PREP_IO_CMDS batch contains all
> > the I/Os not yet prepped followed by some duplicates? Then the device
> > could be started following the successful completion of all the newly
> > prepped I/Os, but the batch would fail on the following duplicate
> > I/Os, causing the successfully prepped I/Os to be unprepped?
>
> It can be avoided easily because ub->mutex is required for UBLK_U_IO_PREP=
_IO_CMDS,
> such as, ub->dev_info.state can be set to UBLK_S_DEV_DEAD in case of any =
failure.

Are you saying that the situation I described isn't possible, or that
it can be prevented with an additional state check?
I don't think the mutex alone prevents this situation. The mutex
guards against concurrent UBLK_U_IO_PREP_IO_CMDS, but it doesn't
prevent requests from being queued concurrently to the ublk device
once it's ready. And __ublk_fetch() will mark the ublk device as ready
as soon as all the tags have been fetched/prepped, when there could
still be more commands in the UBLK_U_IO_PREP_IO_CMDS batch.
I think to fix the issue, you'd need to wait to mark the ublk device
ready until the end of the UBLK_U_IO_PREP_IO_CMDS batch.

Best,
Caleb

>
> >
> > >
> > > >
> > > > > +}
> > > > > +
> > > > > +static void ublk_batch_revert_prep_cmd(struct ublk_batch_io_iter=
 *iter,
> > > > > +                                      struct ublk_batch_io_data =
*data)
> > > > > +{
> > > > > +       int ret;
> > > > > +
> > > > > +       if (!iter->done)
> > > > > +               return;
> > > > > +
> > > > > +       iov_iter_revert(&iter->iter, iter->done);
> > > >
> > > > Shouldn't the iterator be reverted by the total number of bytes
> > > > copied, which may be more than iter->done?
> > >
> > > ->done is exactly the total bytes handled.
> >
> > But the number of bytes "handled" is not the same as the number of
> > bytes the iterator was advanced by, right? The copy_from_iter() is
> > responsible for advancing the iterator, but __ublk_walk_cmd_buf() may
> > break early before processing all those elements. iter->done would
> > only be set to the number of bytes processed by __ublk_walk_cmd_buf(),
> > which may be less than the bytes obtained from the iterator.
>
> Good catch, it could be handled by reverting the unhandled bytes manually
> in __ublk_walk_cmd_buf().
>
> >
> > >
> > > >
> > > > > +       iter->total =3D iter->done;
> > > > > +       iter->done =3D 0;
> > > > > +
> > > > > +       ret =3D ublk_walk_cmd_buf(iter, data, ublk_batch_unprep_i=
o);
> > > > > +       WARN_ON_ONCE(ret);
> > > > > +}
> > > > > +
> > > > > +static int ublk_batch_prep_io(struct ublk_io *io,
> > > > > +                             const struct ublk_batch_io_data *da=
ta)
> > > > > +{
> > > > > +       const struct ublk_batch_io *uc =3D io_uring_sqe_cmd(data-=
>cmd->sqe);
> > > > > +       union ublk_io_buf buf =3D { 0 };
> > > > > +       int ret;
> > > > > +
> > > > > +       if (ublk_support_auto_buf_reg(data->ubq))
> > > > > +               buf.auto_reg =3D ublk_batch_auto_buf_reg(uc, data=
->elem);
> > > > > +       else if (ublk_need_map_io(data->ubq)) {
> > > > > +               buf.addr =3D ublk_batch_buf_addr(uc, data->elem);
> > > > > +
> > > > > +               ret =3D ublk_check_fetch_buf(data->ubq, buf.addr)=
;
> > > > > +               if (ret)
> > > > > +                       return ret;
> > > > > +       }
> > > > > +
> > > > > +       ublk_io_lock(io);
> > > > > +       ret =3D __ublk_fetch(data->cmd, data->ubq, io);
> > > > > +       if (!ret)
> > > > > +               io->buf =3D buf;
> > > > > +       ublk_io_unlock(io);
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +static int ublk_handle_batch_prep_cmd(struct ublk_batch_io_data =
*data)
> > > > > +{
> > > > > +       struct io_uring_cmd *cmd =3D data->cmd;
> > > > > +       const struct ublk_batch_io *uc =3D io_uring_sqe_cmd(cmd->=
sqe);
> > > > > +       struct ublk_batch_io_iter iter =3D {
> > > > > +               .total =3D uc->nr_elem * uc->elem_bytes,
> > > > > +               .elem_bytes =3D uc->elem_bytes,
> > > > > +       };
> > > > > +       int ret;
> > > > > +
> > > > > +       ret =3D io_uring_cmd_import_fixed(cmd->sqe->addr, cmd->sq=
e->len,
> > > >
> > > > Could iter.total be used in place of cmd->sqe->len? That way usersp=
ace
> > > > wouldn't have to specify a redundant value in the SQE len field.
> > >
> > > This way follows how buffer is used in io_uring/rw.c, but looks it ca=
n be saved.
> > > But benefit is cross-verify, cause io-uring sqe user interface is com=
plicated.
> >
> > In a IORING_OP_{READ,WRITE}{,V} operation, there aren't other fields
> > that can be used to determine the length of data that will be
> > accessed. I would rather not require userspace to pass a redundant
> > value, this makes the UAPI even more complicated.
>
> Fair enough, will drop the sqe->len use.
>
>
> Thanks,
> Ming
>
