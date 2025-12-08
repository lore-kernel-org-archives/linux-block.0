Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8D258CDA
	for <linux-block@vger.kernel.org>; Mon,  8 Dec 2025 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213472; cv=none; b=T3pdOiOrYERl2gQ2/t0ShHf7vGgmdjrRrFZoLq6KnXLhzgr2R+ZirrNmNVjNU32F/dM3hnhk+Z7nheKQrpdOonQkZd3RXxTpEVK+eiQ1dSWBzclwq+cEf6E1Z9ggmZ2LTqHaC4XpDKVjLlUSei85aC9M21lenj0YF7e+sa+zxgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213472; c=relaxed/simple;
	bh=SSavx46nhYd8bvr+1LYFHtm4VsDj0pDbmDz6rylnsQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQydAkwLLb4f1uiqX21ltAs1VLqjWYlNH7ochWWABTHnVYZT8+PIFV8TyVOkPg/uPo1IMcI6PNnPEhmwb4sf/BIu80qT0Q81KuhOYMuk7CV0/9lBRvQvgR4Os6CRutI8hvaVYUiAd68hiF16ZvWQvtcj0zd0rnArSuOaZXTf3bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LhcwRehb; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LhcwRehb"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b9a2e3c4afcso533296a12.1
        for <linux-block@vger.kernel.org>; Mon, 08 Dec 2025 09:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765213470; x=1765818270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7b0lESfE9jBAsha6oX/+HF9pOrJ800vfQhX4Pf6Epc=;
        b=LhcwRehbfd25D/VGYjJGU9fJaGkYZiRGKdzu/gjwUrKhUtkbxHMPOZGVYeuLBt+a+7
         ecaDHct2ZnaUyQYvKJ33nisgN1hWYSL+OueirE23BJNJEcXqOtrf43WdkCxU+2boixNK
         wPCrUM72NeCC7cvgR/CJY98l5PJHp3737JknJMa5Jjlnm4elLj6LbSyfy4xxIE0pcwMV
         vtiAQMlqIjshyT+jnYjM+IDiiVtmJJzaP90VoRm6oDWE871UhAVElrfKYETJDh8XJ9Ds
         ewcN3AxXsUCTr1XW9dauvJ8Jo3lLYseXPx+6EVwhWN2l/HYLrQEcHjnOlUalWRWNfWa8
         NUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765213470; x=1765818270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p7b0lESfE9jBAsha6oX/+HF9pOrJ800vfQhX4Pf6Epc=;
        b=vSRaAFJ02MF4F5S0QJpA+ZOqsu7AbZxpwxK/JosOeKVfjTMTnaGZL+N8sdg6m+6i4g
         W63dXejUM0hF8zIXUoSrSWrAu5P4I40pBzmGM9yEEKmH4O00un3e8Nh3E94GIvI7dJsv
         LXE3GS1ESjxdAOv7Vl717OrXzhD5Y3vzytiIcswCdEhXLo/qtgt0mxHHcRCq52qJ0PyE
         8x63Uc8igdWFIAKwr/4DfVC0XxG1jwKDxeBdvn/Iu/6R8zOicQC9XDxe9v1J0DBQPeoh
         SAy9rDueryP3j+iffip0u+v9PSgni8VlAp6KkyS4HCVObg6nZXexmFicww7Q3xyIbfZj
         QQuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJksAyh++vEsw2J/GwUNRY8CLGM0yoZiKQeDl/3NUKY6fJpAjWAoP8KhxFw5pv2bW3DNWEONpDKBb2xg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg1i4xFSGK9YVWTPSI5tuvweTz/D6BZErm1XzIT4Nr3msZsF0n
	hZVZURoHqsBsq/HeUKMOseM/CW4aoUR92w4SPfLmY4i8FF/iTkJonA759mPBVNJtequmrUKkVAN
	Ufh7/Ctnlgw/8ULxtixVbcDM3aK6uQdBy6lGfU8Ld9w==
X-Gm-Gg: ASbGncvcWfXIEU7THH6Gir0OUxe8NNAeqMFMvTT5W22rmd+S63UBCx7+5Q81ESG7WnQ
	WW8iwoHaGjoiGIStoQ0K3X9FcV7ey38Nr/SlXlEVExDoa2HQreXBVraY586jloDKHhpDNXNiOIW
	sBrHICDcpfoy7lelsT15TBQnRP8pLhbMp3yh43KSR0lDdzAxZiiRLhxz+3P1F52jJcbXSOrt0Ac
	3OEYfwXVLZnJcTkVsBB2gVN3VpYsjTAiT58ktbtZelgONA5vTRQmL4ACM27lYKMJY95F9kv
X-Google-Smtp-Source: AGHT+IFW1cRJrBNFueneiyVSq4K60uSunkF1hjNnQ92gSSCnPRrA/e9P0PlYOBzZoSSL3oOry/taagXdGxWTEtVQozM=
X-Received: by 2002:a05:7022:4591:b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-11e0310861amr3950018c88.0.1765213469928; Mon, 08 Dec 2025
 09:04:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202121917.1412280-1-ming.lei@redhat.com> <20251202121917.1412280-9-ming.lei@redhat.com>
 <CADUfDZpJu+wQWWq2-GJm+ZN-wX3dcb_AYQhJ9ikwGjMEPCqh+w@mail.gmail.com> <aTWHn9Jw2RuXdD8A@fedora>
In-Reply-To: <aTWHn9Jw2RuXdD8A@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 8 Dec 2025 09:04:18 -0800
X-Gm-Features: AQt7F2qJBWQCsvIJq0U6OI7KzBLgNr9p3V__gmnY7plsNEQlueQCaj6MfRJshO4
Message-ID: <CADUfDZpJ-e3q282eiY+dwCZquZOQ1OW9AKce7n7kaYRXihQJxQ@mail.gmail.com>
Subject: Re: [PATCH V5 08/21] ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 5:57=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Sat, Dec 06, 2025 at 11:38:39PM -0800, Caleb Sander Mateos wrote:
> > On Tue, Dec 2, 2025 at 4:21=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > Add UBLK_U_IO_FETCH_IO_CMDS command to enable efficient batch process=
ing
> > > of I/O requests. This multishot uring_cmd allows the ublk server to f=
etch
> > > multiple I/O commands in a single operation, significantly reducing
> > > submission overhead compared to individual FETCH_REQ* commands.
> > >
> > > Key Design Features:
> > >
> > > 1. Multishot Operation: One UBLK_U_IO_FETCH_IO_CMDS can fetch many I/=
O
> > >    commands, with the batch size limited by the provided buffer lengt=
h.
> > >
> > > 2. Dynamic Load Balancing: Multiple fetch commands can be submitted
> > >    simultaneously, but only one is active at any time. This enables
> > >    efficient load distribution across multiple server task contexts.
> > >
> > > 3. Implicit State Management: The implementation uses three key varia=
bles
> > >    to track state:
> > >    - evts_fifo: Queue of request tags awaiting processing
> > >    - fcmd_head: List of available fetch commands
> > >    - active_fcmd: Currently active fetch command (NULL =3D none activ=
e)
> > >
> > >    States are derived implicitly:
> > >    - IDLE: No fetch commands available
> > >    - READY: Fetch commands available, none active
> > >    - ACTIVE: One fetch command processing events
> > >
> > > 4. Lockless Reader Optimization: The active fetch command can read fr=
om
> > >    evts_fifo without locking (single reader guarantee), while writers
> > >    (ublk_queue_rq/ublk_queue_rqs) use evts_lock protection. The memor=
y
> > >    barrier pairing plays key role for the single lockless reader
> > >    optimization.
> > >
> > > Implementation Details:
> > >
> > > - ublk_queue_rq() and ublk_queue_rqs() save request tags to evts_fifo
> > > - __ublk_acquire_fcmd() selects an available fetch command when
> > >   events arrive and no command is currently active
> > > - ublk_batch_dispatch() moves tags from evts_fifo to the fetch comman=
d's
> > >   buffer and posts completion via io_uring_mshot_cmd_post_cqe()
> > > - State transitions are coordinated via evts_lock to maintain consist=
ency
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c      | 392 ++++++++++++++++++++++++++++++++=
+-
> > >  include/uapi/linux/ublk_cmd.h |   7 +
> > >  2 files changed, 391 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 05bf9786751f..de6ce0e17b1b 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -93,6 +93,7 @@
> > >
> > >  /* ublk batch fetch uring_cmd */
> > >  struct ublk_batch_fetch_cmd {
> > > +       struct list_head node;
> > >         struct io_uring_cmd *cmd;
> > >         unsigned short buf_group;
> > >  };
> > > @@ -117,7 +118,10 @@ struct ublk_uring_cmd_pdu {
> > >          */
> > >         struct ublk_queue *ubq;
> > >
> > > -       u16 tag;
> > > +       union {
> > > +               u16 tag;
> > > +               struct ublk_batch_fetch_cmd *fcmd; /* batch io only *=
/
> > > +       };
> > >  };
> > >
> > >  struct ublk_batch_io_data {
> > > @@ -239,10 +243,37 @@ struct ublk_queue {
> > >          * Make sure just one reader for fetching request from task w=
ork
> > >          * function to ublk server, so no need to grab the lock in re=
ader
> > >          * side.
> > > +        *
> > > +        * Batch I/O State Management:
> > > +        *
> > > +        * The batch I/O system uses implicit state management based =
on the
> > > +        * combination of three key variables below.
> > > +        *
> > > +        * - IDLE: list_empty(&fcmd_head) && !active_fcmd
> > > +        *   No fetch commands available, events queue in evts_fifo
> > > +        *
> > > +        * - READY: !list_empty(&fcmd_head) && !active_fcmd
> > > +        *   Fetch commands available but none processing events
> > > +        *
> > > +        * - ACTIVE: active_fcmd
> > > +        *   One fetch command actively processing events from evts_f=
ifo
> > > +        *
> > > +        * Key Invariants:
> > > +        * - At most one active_fcmd at any time (single reader)
> > > +        * - active_fcmd is always from fcmd_head list when non-NULL
> > > +        * - evts_fifo can be read locklessly by the single active re=
ader
> > > +        * - All state transitions require evts_lock protection
> > > +        * - Multiple writers to evts_fifo require lock protection
> > >          */
> > >         struct {
> > >                 DECLARE_KFIFO_PTR(evts_fifo, unsigned short);
> > >                 spinlock_t evts_lock;
> > > +
> > > +               /* List of fetch commands available to process events=
 */
> > > +               struct list_head fcmd_head;
> > > +
> > > +               /* Currently active fetch command (NULL =3D none acti=
ve) */
> > > +               struct ublk_batch_fetch_cmd  *active_fcmd;
> > >         }____cacheline_aligned_in_smp;
> > >
> > >         struct ublk_io ios[] __counted_by(q_depth);
> > > @@ -294,12 +325,20 @@ static void ublk_abort_queue(struct ublk_device=
 *ub, struct ublk_queue *ubq);
> > >  static inline struct request *__ublk_check_and_get_req(struct ublk_d=
evice *ub,
> > >                 u16 q_id, u16 tag, struct ublk_io *io, size_t offset)=
;
> > >  static inline unsigned int ublk_req_build_flags(struct request *req)=
;
> > > +static void ublk_batch_dispatch(struct ublk_queue *ubq,
> > > +                               const struct ublk_batch_io_data *data=
,
> > > +                               struct ublk_batch_fetch_cmd *fcmd);
> > >
> > >  static inline bool ublk_dev_support_batch_io(const struct ublk_devic=
e *ub)
> > >  {
> > >         return false;
> > >  }
> > >
> > > +static inline bool ublk_support_batch_io(const struct ublk_queue *ub=
q)
> > > +{
> > > +       return false;
> > > +}
> > > +
> > >  static inline void ublk_io_lock(struct ublk_io *io)
> > >  {
> > >         spin_lock(&io->lock);
> > > @@ -620,13 +659,45 @@ static wait_queue_head_t ublk_idr_wq;     /* wa=
it until one idr is freed */
> > >
> > >  static DEFINE_MUTEX(ublk_ctl_mutex);
> > >
> > > +static struct ublk_batch_fetch_cmd *
> > > +ublk_batch_alloc_fcmd(struct io_uring_cmd *cmd)
> > > +{
> > > +       struct ublk_batch_fetch_cmd *fcmd =3D kzalloc(sizeof(*fcmd), =
GFP_NOIO);
> > >
> > > -static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_d=
ata *data,
> > > +       if (fcmd) {
> > > +               fcmd->cmd =3D cmd;
> > > +               fcmd->buf_group =3D READ_ONCE(cmd->sqe->buf_index);
> > > +       }
> > > +       return fcmd;
> > > +}
> > > +
> > > +static void ublk_batch_free_fcmd(struct ublk_batch_fetch_cmd *fcmd)
> > > +{
> > > +       kfree(fcmd);
> > > +}
> > > +
> > > +static void __ublk_release_fcmd(struct ublk_queue *ubq)
> > > +{
> > > +       WRITE_ONCE(ubq->active_fcmd, NULL);
> > > +}
> > > +
> > > +/*
> > > + * Nothing can move on, so clear ->active_fcmd, and the caller shoul=
d stop
> > > + * dispatching
> > > + */
> > > +static void ublk_batch_deinit_fetch_buf(struct ublk_queue *ubq,
> > > +                                       const struct ublk_batch_io_da=
ta *data,
> > >                                         struct ublk_batch_fetch_cmd *=
fcmd,
> > >                                         int res)
> > >  {
> > > +       spin_lock(&ubq->evts_lock);
> > > +       list_del(&fcmd->node);
> > > +       WARN_ON_ONCE(fcmd !=3D ubq->active_fcmd);
> > > +       __ublk_release_fcmd(ubq);
> > > +       spin_unlock(&ubq->evts_lock);
> > > +
> > >         io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
> > > -       fcmd->cmd =3D NULL;
> > > +       ublk_batch_free_fcmd(fcmd);
> > >  }
> > >
> > >  static int ublk_batch_fetch_post_cqe(struct ublk_batch_fetch_cmd *fc=
md,
> > > @@ -1489,6 +1560,8 @@ static int __ublk_batch_dispatch(struct ublk_qu=
eue *ubq,
> > >         bool needs_filter;
> > >         int ret;
> > >
> > > +       WARN_ON_ONCE(data->cmd !=3D fcmd->cmd);
> > > +
> > >         sel =3D io_uring_cmd_buffer_select(fcmd->cmd, fcmd->buf_group=
, &len,
> > >                                          data->issue_flags);
> > >         if (sel.val < 0)
> > > @@ -1552,21 +1625,92 @@ static int __ublk_batch_dispatch(struct ublk_=
queue *ubq,
> > >         return ret;
> > >  }
> > >
> > > -static __maybe_unused void
> >
> > Drop the __maybe_unused in the previous commit that introduced it?
>
> Yes, it can't be avoided, because the previous commit just adds this
> helpers without caller. Otherwise putting the two into one can become too=
 big.

Ah, I confused whether __maybe_unused was applied to the return type
or the function. Makes sense.

Thanks,
Caleb
