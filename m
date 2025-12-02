Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B86221F1C
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688859; cv=none; b=rdzKxI3nobbngdyQQWmAYoKrYfEoEi63rbKsStQeWTh6/N39rjg2V7xcaxBPYK5+5omOTtndKP9MktsyS1Jg7T/D1HIjonyDpq1s1fJ7egabjVuwbfxLFmA/gtym97V54ZjhRjFXU7CMNv5bqt6cH/hzI2LaO72rpW4V00KYDQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688859; c=relaxed/simple;
	bh=9mnNPJEc6IXOVCv9KLFtvC+cSz/Yrvzy2MzYwU2eB3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHm3N9QbMeBEvKoGoervGnyxUkk2Wq2DufOZrsA/vP89nhCbAjWAcf8eVFpESj58rMmfDjLKMh2YcAGJaDPUF50JfDXwmjQi6qCP2XVS1pog5rMRTxnL+dsBtaaEvtkH61abVAwjMMUGLq9sRYe1up7c4kGtjqeFegFT//viXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Lcu+2tvG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Lcu+2tvG"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-295351ad2f5so10730855ad.3
        for <linux-block@vger.kernel.org>; Tue, 02 Dec 2025 07:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764688857; x=1765293657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7t+a3O3TyKHqJ5yLqNv4kAhCp5wA+2BawL+Au5Nmng=;
        b=Lcu+2tvGh9sFKo7ModIs3wcWPTNjcdoBH/6uG0ZMh7NOsXHOSksoyeSl0FZl3hNH/u
         /47q0WIfM1+NdlGANDZIxE9KtlJ0VcEw037UWGVvnazCRbXVg1VaHdgpYxk/wwj1z+LX
         LgsEMUS/g0PoMflSRkccEDb4xLRrWlgQTA84Dd4KnkoJQgMm1eKCSPpPfDUbzdJY8r/2
         j3oOrsTL2nHTpRv/Jlb3VfrfhDVmRx7xoG95tH1I3D4UTQpvLQAVzRXsyPsnKmrZ0N/a
         EwEJi2O2mpm722BiLeL2udxn1jOtwdN+mGwjrAubPxljs/3yDwHC+HGNmMv8yHXzcq54
         6Bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764688857; x=1765293657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+7t+a3O3TyKHqJ5yLqNv4kAhCp5wA+2BawL+Au5Nmng=;
        b=NHX7wxpfN86fYVSildrpk4Z+Lr0CNmSXaL4pwkPNfURb+OmE7Rcrev2urQAUVNdGhv
         SN9XdTQxn35mihF0bc7RlGElGd7Mil5c92E15GTrYVn++h5VqFqeVz2gVu+AwurHKap8
         icECq5REEM0gt3NvpGkWRMRkpLdJFlV00/8CsEkJT8vQEQPD0j6GTYyyEjo+et7BFoRE
         RFCNKQ7KyOXw2UMSe84qDfBayh/63MsN68qp5QPyFHync+GVgBcAKt8+EbV5AfDgwX4s
         CPBaUIGNPUzaEK3umvaX39GxG5JJpu458TsE+ccSeQTCucOPX6i18dM1cirD4llDEpFo
         6b8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdTz2o0VGjxKixVGH7ZNJoFq64SEjA8i/jbMF3GOzn/pN+4LKfN5FJ/KM7rUlP+4x964hld8fMmKuFzw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzwwlp7YLPJ/i4Pv990M6F4uFc7IuvBMY1K0vMF0btpsAxIhzm
	yQYWZfmVJzae9Q/b8zUfIOl+/B1fB6xFnrVVFc36KgcSmwODqaxR+LpOE1TH8suZM0ddnfzZVrQ
	F83BNTdclK5PlGlsomR8nzddiv6qCrywRV2hAiYCe5Q==
X-Gm-Gg: ASbGnctPrcUwghdqE7OxGpJpD2aWxWhnrlMDTvmt1Sn8Z0fJ88s2Dr+Gsdk2bJNO7an
	IjyHmaGe3Bdn9/fjb2GXXAowRjgpy0lr09nlKGSn6rJhR5R5ULfrKWwTjPuWuaKul83+zzrxsMp
	3vcgWwmgOmTVbCdrmxUo0Pzihbn4gBaOHVFiBTQu6UNtwIMBQiFBJhFMuMySzhBCKdFSNgi3EhK
	mOzrl2DPozxC5zm351rR2HaEDApDmUwWfgaKtGQJ1/RjmOYhq5Gi0PaN16eHiI7u/iqTQOL
X-Google-Smtp-Source: AGHT+IGBkCvdMVIRiqZF/ryLNKlFbJyIs+HMQdLCQ6lENEQKeYNXO000MxiZlsa860HW2fEjYJx59YHULivs4TnsTrc=
X-Received: by 2002:a05:7022:ea46:10b0:11b:acd7:4e48 with SMTP id
 a92af1059eb24-11c9f2fcd10mr22194771c88.2.1764688856940; Tue, 02 Dec 2025
 07:20:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-15-ming.lei@redhat.com>
 <CADUfDZqOHRxnNjeb064XGOH-EqLgp2XCiHiRNTzxYCQuihx90Q@mail.gmail.com>
 <aS1i4RoP_mJXQiXk@fedora> <CADUfDZo0N22fp5+Si8eBE5SgRkCMsMa1VDTiLO_+zLWfUOVc9g@mail.gmail.com>
 <aS5AZjizRDt7ql3T@fedora> <CADUfDZomo+Jz5oiQkU99+RZhxDqAjdt8B1tg_gj-O7thzqVbhw@mail.gmail.com>
 <aS6f68KVuyRxZitY@fedora>
In-Reply-To: <aS6f68KVuyRxZitY@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 2 Dec 2025 07:20:45 -0800
X-Gm-Features: AWmQ_bkG-2_LAfMyGdb8T6qujP37I277h4DL8J2WnvujDrnWdW6mMuaDQIQqrsQ
Message-ID: <CADUfDZp35yHxh3_4BQP=3_-vYxZuQ52RLf_UyJRDGH+f4OWGKQ@mail.gmail.com>
Subject: Re: [PATCH V4 14/27] ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 12:14=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Dec 01, 2025 at 05:39:29PM -0800, Caleb Sander Mateos wrote:
> > On Mon, Dec 1, 2025 at 5:27=E2=80=AFPM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > On Mon, Dec 01, 2025 at 09:51:59AM -0800, Caleb Sander Mateos wrote:
> > > > On Mon, Dec 1, 2025 at 1:42=E2=80=AFAM Ming Lei <ming.lei@redhat.co=
m> wrote:
> > > > >
> > > > > On Sun, Nov 30, 2025 at 09:55:47PM -0800, Caleb Sander Mateos wro=
te:
> > > > > > On Thu, Nov 20, 2025 at 6:00=E2=80=AFPM Ming Lei <ming.lei@redh=
at.com> wrote:
> > > > > > >
> > > > > > > Add UBLK_U_IO_FETCH_IO_CMDS command to enable efficient batch=
 processing
> > > > > > > of I/O requests. This multishot uring_cmd allows the ublk ser=
ver to fetch
> > > > > > > multiple I/O commands in a single operation, significantly re=
ducing
> > > > > > > submission overhead compared to individual FETCH_REQ* command=
s.
> > > > > > >
> > > > > > > Key Design Features:
> > > > > > >
> > > > > > > 1. Multishot Operation: One UBLK_U_IO_FETCH_IO_CMDS can fetch=
 many I/O
> > > > > > >    commands, with the batch size limited by the provided buff=
er length.
> > > > > > >
> > > > > > > 2. Dynamic Load Balancing: Multiple fetch commands can be sub=
mitted
> > > > > > >    simultaneously, but only one is active at any time. This e=
nables
> > > > > > >    efficient load distribution across multiple server task co=
ntexts.
> > > > > > >
> > > > > > > 3. Implicit State Management: The implementation uses three k=
ey variables
> > > > > > >    to track state:
> > > > > > >    - evts_fifo: Queue of request tags awaiting processing
> > > > > > >    - fcmd_head: List of available fetch commands
> > > > > > >    - active_fcmd: Currently active fetch command (NULL =3D no=
ne active)
> > > > > > >
> > > > > > >    States are derived implicitly:
> > > > > > >    - IDLE: No fetch commands available
> > > > > > >    - READY: Fetch commands available, none active
> > > > > > >    - ACTIVE: One fetch command processing events
> > > > > > >
> > > > > > > 4. Lockless Reader Optimization: The active fetch command can=
 read from
> > > > > > >    evts_fifo without locking (single reader guarantee), while=
 writers
> > > > > > >    (ublk_queue_rq/ublk_queue_rqs) use evts_lock protection. T=
he memory
> > > > > > >    barrier pairing plays key role for the single lockless rea=
der
> > > > > > >    optimization.
> > > > > > >
> > > > > > > Implementation Details:
> > > > > > >
> > > > > > > - ublk_queue_rq() and ublk_queue_rqs() save request tags to e=
vts_fifo
> > > > > > > - __ublk_pick_active_fcmd() selects an available fetch comman=
d when
> > > > > > >   events arrive and no command is currently active
> > > > > >
> > > > > > What is __ublk_pick_active_fcmd()? I don't see a function with =
that name.
> > > > >
> > > > > It is renamed as __ublk_acquire_fcmd(), and its counter pair is
> > > > > __ublk_release_fcmd().
> > > >
> > > > Okay, update the commit message then?
> > > >
> > > > >
> > > > > >
> > > > > > > - ublk_batch_dispatch() moves tags from evts_fifo to the fetc=
h command's
> > > > > > >   buffer and posts completion via io_uring_mshot_cmd_post_cqe=
()
> > > > > > > - State transitions are coordinated via evts_lock to maintain=
 consistency
> > > > > > >
> > > > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > > > ---
> > > > > > >  drivers/block/ublk_drv.c      | 412 ++++++++++++++++++++++++=
+++++++---
> > > > > > >  include/uapi/linux/ublk_cmd.h |   7 +
> > > > > > >  2 files changed, 388 insertions(+), 31 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_dr=
v.c
> > > > > > > index cc9c92d97349..2e5e392c939e 100644
> > > > > > > --- a/drivers/block/ublk_drv.c
> > > > > > > +++ b/drivers/block/ublk_drv.c
> > > > > > > @@ -93,6 +93,7 @@
> > > > > > >
> > > > > > >  /* ublk batch fetch uring_cmd */
> > > > > > >  struct ublk_batch_fcmd {
> > > > > > > +       struct list_head node;
> > > > > > >         struct io_uring_cmd *cmd;
> > > > > > >         unsigned short buf_group;
> > > > > > >  };
> > > > > > > @@ -117,7 +118,10 @@ struct ublk_uring_cmd_pdu {
> > > > > > >          */
> > > > > > >         struct ublk_queue *ubq;
> > > > > > >
> > > > > > > -       u16 tag;
> > > > > > > +       union {
> > > > > > > +               u16 tag;
> > > > > > > +               struct ublk_batch_fcmd *fcmd; /* batch io onl=
y */
> > > > > > > +       };
> > > > > > >  };
> > > > > > >
> > > > > > >  struct ublk_batch_io_data {
> > > > > > > @@ -229,18 +233,36 @@ struct ublk_queue {
> > > > > > >         struct ublk_device *dev;
> > > > > > >
> > > > > > >         /*
> > > > > > > -        * Inflight ublk request tag is saved in this fifo
> > > > > > > +        * Batch I/O State Management:
> > > > > > > +        *
> > > > > > > +        * The batch I/O system uses implicit state managemen=
t based on the
> > > > > > > +        * combination of three key variables below.
> > > > > > > +        *
> > > > > > > +        * - IDLE: list_empty(&fcmd_head) && !active_fcmd
> > > > > > > +        *   No fetch commands available, events queue in evt=
s_fifo
> > > > > > > +        *
> > > > > > > +        * - READY: !list_empty(&fcmd_head) && !active_fcmd
> > > > > > > +        *   Fetch commands available but none processing eve=
nts
> > > > > > >          *
> > > > > > > -        * There are multiple writer from ublk_queue_rq() or =
ublk_queue_rqs(),
> > > > > > > -        * so lock is required for storing request tag to fif=
o
> > > > > > > +        * - ACTIVE: active_fcmd
> > > > > > > +        *   One fetch command actively processing events fro=
m evts_fifo
> > > > > > >          *
> > > > > > > -        * Make sure just one reader for fetching request fro=
m task work
> > > > > > > -        * function to ublk server, so no need to grab the lo=
ck in reader
> > > > > > > -        * side.
> > > > > > > +        * Key Invariants:
> > > > > > > +        * - At most one active_fcmd at any time (single read=
er)
> > > > > > > +        * - active_fcmd is always from fcmd_head list when n=
on-NULL
> > > > > > > +        * - evts_fifo can be read locklessly by the single a=
ctive reader
> > > > > > > +        * - All state transitions require evts_lock protecti=
on
> > > > > > > +        * - Multiple writers to evts_fifo require lock prote=
ction
> > > > > > >          */
> > > > > > >         struct {
> > > > > > >                 DECLARE_KFIFO_PTR(evts_fifo, unsigned short);
> > > > > > >                 spinlock_t evts_lock;
> > > > > > > +
> > > > > > > +               /* List of fetch commands available to proces=
s events */
> > > > > > > +               struct list_head fcmd_head;
> > > > > > > +
> > > > > > > +               /* Currently active fetch command (NULL =3D n=
one active) */
> > > > > > > +               struct ublk_batch_fcmd  *active_fcmd;
> > > > > > >         }____cacheline_aligned_in_smp;
> > > > > > >
> > > > > > >         struct ublk_io ios[] __counted_by(q_depth);
> > > > > > > @@ -292,12 +314,20 @@ static void ublk_abort_queue(struct ubl=
k_device *ub, struct ublk_queue *ubq);
> > > > > > >  static inline struct request *__ublk_check_and_get_req(struc=
t ublk_device *ub,
> > > > > > >                 u16 q_id, u16 tag, struct ublk_io *io, size_t=
 offset);
> > > > > > >  static inline unsigned int ublk_req_build_flags(struct reque=
st *req);
> > > > > > > +static void ublk_batch_dispatch(struct ublk_queue *ubq,
> > > > > > > +                               struct ublk_batch_io_data *da=
ta,
> > > > > > > +                               struct ublk_batch_fcmd *fcmd)=
;
> > > > > > >
> > > > > > >  static inline bool ublk_dev_support_batch_io(const struct ub=
lk_device *ub)
> > > > > > >  {
> > > > > > >         return false;
> > > > > > >  }
> > > > > > >
> > > > > > > +static inline bool ublk_support_batch_io(const struct ublk_q=
ueue *ubq)
> > > > > > > +{
> > > > > > > +       return false;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static inline void ublk_io_lock(struct ublk_io *io)
> > > > > > >  {
> > > > > > >         spin_lock(&io->lock);
> > > > > > > @@ -624,13 +654,45 @@ static wait_queue_head_t ublk_idr_wq;  =
   /* wait until one idr is freed */
> > > > > > >
> > > > > > >  static DEFINE_MUTEX(ublk_ctl_mutex);
> > > > > > >
> > > > > > > +static struct ublk_batch_fcmd *
> > > > > > > +ublk_batch_alloc_fcmd(struct io_uring_cmd *cmd)
> > > > > > > +{
> > > > > > > +       struct ublk_batch_fcmd *fcmd =3D kzalloc(sizeof(*fcmd=
), GFP_NOIO);
> > > > > >
> > > > > > An allocation in the I/O path seems unfortunate. Is there not r=
oom to
> > > > > > store the struct ublk_batch_fcmd in the io_uring_cmd pdu?
> > > > >
> > > > > It is allocated once for one mshot request, which covers many IOs=
.
> > > > >
> > > > > It can't be held in uring_cmd pdu, but the allocation can be opti=
mized in
> > > > > future. Not a big deal in enablement stage.
> > > >
> > > > Okay, seems fine to optimize it in the future.
> > > >
> > > > >
> > > > > > > +
> > > > > > > +       if (fcmd) {
> > > > > > > +               fcmd->cmd =3D cmd;
> > > > > > > +               fcmd->buf_group =3D READ_ONCE(cmd->sqe->buf_i=
ndex);
> > > > > >
> > > > > > Is it necessary to store sample this here just to pass it back =
to the
> > > > > > io_uring layer? Wouldn't the io_uring layer already have access=
 to it
> > > > > > in struct io_kiocb's buf_index field?
> > > > >
> > > > > ->buf_group is used by io_uring_cmd_buffer_select(), and this way=
 also
> > > > > follows ->buf_index uses in both io_uring/net.c and io_uring/rw.c=
.
> > > > >
> > > > >
> > > > > io_ring_buffer_select(), so we can't reuse req->buf_index here.
> > > >
> > > > But io_uring/net.c and io_uring/rw.c both retrieve the buf_group va=
lue
> > > > from req->buf_index instead of the SQE, for example:
> > > > if (req->flags & REQ_F_BUFFER_SELECT)
> > > >         sr->buf_group =3D req->buf_index;
> > > >
> > > > Seems like it would make sense to do the same for
> > > > UBLK_U_IO_FETCH_IO_CMDS. That also saves one pointer dereference he=
re.
> > >
> > > IMO we shouldn't encourage driver to access `io_kiocb`, however, cmd-=
>sqe
> > > is exposed to driver explicitly.
> >
> > Right, but we can add a helper in include/linux/io_uring/cmd.h to
> > encapsulate accessing the io_kiocb field.
>
> OK, however I'd suggest to do it as one followup optimization for avoidin=
g
> cross-tree change.

Fair enough
