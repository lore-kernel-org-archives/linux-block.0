Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B03AC39
	for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764538661; cv=none; b=rkhie+x4GC+eHbds0TRau6bFJU+A3TBa5XejQOWZzXk3EnCHWeSlcCn6fgfkZyYeC/9+/p5rcz01xhn1GbMmjmW4CCvHomcINlOVE5mBlhRzjGznM3MBty0IK/ynnQ6dMuG1nrRf8Y2CGbVE/kzTocRF7zQy6qn4APaGk1/WJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764538661; c=relaxed/simple;
	bh=VscPSMv0Z8sCcs7gJeCgBXr3C1tTQD3B9zotCiAn8gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwxiQ6OaimdKqzMHs3ZZU32YjUuBMChQITpLladL8CneGpC28gsognELDLPROSYqcZSVeTvJKLcV/qsQoLaft2x/vO/hBv0xCtXRl7XXO0paIWwLjBMdDaPS3wK1AYM0WTL7o0Ki4U4GUUaUjjHxPRRuAANmSLgwCKcnXOtUH4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DZCeItBa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DZCeItBa"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297f6ccc890so5347735ad.2
        for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 13:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764538657; x=1765143457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwrJQQje7bos+W7DH+W0BND1jRf7XUevCuoQKIbEsjs=;
        b=DZCeItBaDj1EGDRizI55Avvj199yYAD8OYuPn4wB33OGESNk7P2tR+9cLiDAPqFGiO
         xyiNUv1nFzQi9mBwrcNmwk3pUmlIojFAYjRfS7WTyCA+QuyF7nUeVoaxrLgztbQl50cL
         9nAHeY7FiwvD0LsEbBxPH/GrGcTvLGR0hJNfEZGtzfayrwNfd9q6y12c0TBLKBGOsDfq
         3rHYIj3lSTZQLGQ6QWTsuzakRArQvsW+UdDU7FqsvY2+qsBF6rjbBIqvWy05bM9C7OH1
         BeioTTDHQVIDh4Wz4VOwMJEWQ7wx8rREulMApjicJtiuGAzp90KkHjllJIbC+eMhHIfr
         EhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764538657; x=1765143457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HwrJQQje7bos+W7DH+W0BND1jRf7XUevCuoQKIbEsjs=;
        b=IO3Uqx8cqkhuvYyMDiugDpO3J0H4rfkm5mUArBXGDCTJx6fo0BadlucNmczmVtQ/RU
         B3OXLvTFXyFa8L1lcZ86gqrkeR1hCLC8ibSr51XAA9Wfa/pP9tUZZ7EVdbyX0XaH9XVS
         xd01vjabcO0wm6ja0nBePnMRdNJVxX25OPRZv4CXjiNHWeg5ce6bPXiWyr6OlyTUwkzy
         qzueZS0PXcxHKBZJD3/ikYLtJWksrWi9Umwy8ADp3mdasB+m+QEmgcRmd/ctViNpNM6V
         6fbCuBO4nUYsFkoNzivah4e80I+AxrGLGggbHkImySJjYxLE0trF7PG96OMEcHxfoMi4
         h8jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrzKzAUHFCLEioWQLBPjkABEeMgP9Yn96w0UeXJuEnNWJMFrIFRPUKTNlg+ZeF2ADwG6btZ9UibLYnSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWLi05QwIsRg4E2pZVoWPDUitLRZODTz8gSc1sawIQZFCmIzn7
	W2GaTWW1+AGtC8PJ7dkxaGd9WxHzbZcFdm4VO5F3RVJxgUsQKbzYOIZjkMWwSuvkNKER4s2/suy
	wLcTVSybQeh732WdvYVDKr42DpJsKjEmdU0rfUYt3QA==
X-Gm-Gg: ASbGncvLV1lB9yU87G54X5HGSspXaVtCC9tTpTCqC4xy5qbrEnSykujRmfBrpOg4biG
	hbn4ifQxnFRWwH8rH2DO9KzdbBRToikQXgYjgKuJKwhNgKUPVXd32pEuVk+nm0x/SHsZdyJ5/bE
	qN0BCW/cNoyFTmlXgYCxknt0Oo8ZijQBEiETnbOLdmvwoJsY/XcalkRJP6vZVYhHkCWG5HeiKKV
	4ops1/Td0z7zJEvxSp7KCpn/7ua5XXD551EJ8W7dspSgv1SFiIBUHBDWVn/3MM4ZMk3Zzap
X-Google-Smtp-Source: AGHT+IHaavun9biqiisLX/X/GWYgvk61vzZdoTTK1C8F9A/b6Tsf3PBtWj8zisG9vkVtwF41f5pziKHAfnUOONt9mzA=
X-Received: by 2002:a05:7022:68a1:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-11c9f216eccmr22903370c88.0.1764538657134; Sun, 30 Nov 2025
 13:37:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-14-ming.lei@redhat.com>
 <CADUfDZrsH_Bhhs_r0YqEU=3i6DcQCWVt-aEmbu1ouzX=e3WqYg@mail.gmail.com>
In-Reply-To: <CADUfDZrsH_Bhhs_r0YqEU=3i6DcQCWVt-aEmbu1ouzX=e3WqYg@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sun, 30 Nov 2025 13:37:25 -0800
X-Gm-Features: AWmQ_bkmhLFGO2OTsSsu4PTj2JgFU1fgtbwuz9TUqGc2FpMwZvpdqYlUEA4Bk1I
Message-ID: <CADUfDZpOgmUXev5i187MOSmt46hLT=vsGi27-SW9VaDV7g3jkg@mail.gmail.com>
Subject: Re: [PATCH V4 13/27] ublk: add batch I/O dispatch infrastructure
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 11:24=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Thu, Nov 20, 2025 at 6:00=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wr=
ote:
> >
> > Add infrastructure for delivering I/O commands to ublk server in batche=
s,
> > preparing for the upcoming UBLK_U_IO_FETCH_IO_CMDS feature.
> >
> > Key components:
> >
> > - struct ublk_batch_fcmd: Represents a batch fetch uring_cmd that will
> >   receive multiple I/O tags in a single operation, using io_uring's
> >   multishot command for efficient ublk IO delivery.
> >
> > - ublk_batch_dispatch(): Batch version of ublk_dispatch_req() that:
> >   * Pulls multiple request tags from the events FIFO (lock-free reader)
> >   * Prepares each I/O for delivery (including auto buffer registration)
> >   * Delivers tags to userspace via single uring_cmd notification
> >   * Handles partial failures by restoring undelivered tags to FIFO
> >
> > The batch approach significantly reduces notification overhead by aggre=
gating
> > multiple I/O completions into single uring_cmd, while maintaining the s=
ame
> > I/O processing semantics as individual operations.
> >
> > Error handling ensures system consistency: if buffer selection or CQE
> > posting fails, undelivered tags are restored to the FIFO for retry,
> > meantime IO state has to be restored.
> >
> > This runs in task work context, scheduled via io_uring_cmd_complete_in_=
task()
> > or called directly from ->uring_cmd(), enabling efficient batch process=
ing
> > without blocking the I/O submission path.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 189 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 189 insertions(+)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 6ff284243630..cc9c92d97349 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -91,6 +91,12 @@
> >          UBLK_BATCH_F_HAS_BUF_ADDR | \
> >          UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK)
> >
> > +/* ublk batch fetch uring_cmd */
> > +struct ublk_batch_fcmd {
>
> I would prefer "fetch_cmd" instead of "fcmd" for clarity
>
> > +       struct io_uring_cmd *cmd;
> > +       unsigned short buf_group;
> > +};
> > +
> >  struct ublk_uring_cmd_pdu {
> >         /*
> >          * Store requests in same batch temporarily for queuing them to
> > @@ -168,6 +174,9 @@ struct ublk_batch_io_data {
> >   */
> >  #define UBLK_REFCOUNT_INIT (REFCOUNT_MAX / 2)
> >
> > +/* used for UBLK_F_BATCH_IO only */
> > +#define UBLK_BATCH_IO_UNUSED_TAG       ((unsigned short)-1)
> > +
> >  union ublk_io_buf {
> >         __u64   addr;
> >         struct ublk_auto_buf_reg auto_reg;
> > @@ -616,6 +625,32 @@ static wait_queue_head_t ublk_idr_wq;      /* wait=
 until one idr is freed */
> >  static DEFINE_MUTEX(ublk_ctl_mutex);
> >
> >
> > +static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_dat=
a *data,
> > +                                       struct ublk_batch_fcmd *fcmd,
> > +                                       int res)
> > +{
> > +       io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
> > +       fcmd->cmd =3D NULL;
> > +}
> > +
> > +static int ublk_batch_fetch_post_cqe(struct ublk_batch_fcmd *fcmd,
> > +                                    struct io_br_sel *sel,
> > +                                    unsigned int issue_flags)
> > +{
> > +       if (io_uring_mshot_cmd_post_cqe(fcmd->cmd, sel, issue_flags))
> > +               return -ENOBUFS;
> > +       return 0;
> > +}
> > +
> > +static ssize_t ublk_batch_copy_io_tags(struct ublk_batch_fcmd *fcmd,
> > +                                      void __user *buf, const u16 *tag=
_buf,
> > +                                      unsigned int len)
> > +{
> > +       if (copy_to_user(buf, tag_buf, len))
> > +               return -EFAULT;
> > +       return len;
> > +}
> > +
> >  #define UBLK_MAX_UBLKS UBLK_MINORS
> >
> >  /*
> > @@ -1378,6 +1413,160 @@ static void ublk_dispatch_req(struct ublk_queue=
 *ubq,
> >         }
> >  }
> >
> > +static bool __ublk_batch_prep_dispatch(struct ublk_queue *ubq,
> > +                                      const struct ublk_batch_io_data =
*data,
> > +                                      unsigned short tag)
> > +{
> > +       struct ublk_device *ub =3D data->ub;
> > +       struct ublk_io *io =3D &ubq->ios[tag];
> > +       struct request *req =3D blk_mq_tag_to_rq(ub->tag_set.tags[ubq->=
q_id], tag);
> > +       enum auto_buf_reg_res res =3D AUTO_BUF_REG_FALLBACK;
> > +       struct io_uring_cmd *cmd =3D data->cmd;
> > +
> > +       if (!ublk_start_io(ubq, req, io))
>
> This doesn't look correct for UBLK_F_NEED_GET_DATA. If that's not
> supported in batch mode, then it should probably be disallowed when
> creating a batch-mode ublk device. The ublk_need_get_data() check in
> ublk_batch_commit_io_check() could also be dropped.
>
> > +               return false;
> > +
> > +       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
> > +               res =3D __ublk_do_auto_buf_reg(ubq, req, io, cmd,
> > +                               data->issue_flags);
>
> __ublk_do_auto_buf_reg() reads io->buf.auto_reg. That seems racy
> without holding the io spinlock.
>
> > +
> > +       if (res =3D=3D AUTO_BUF_REG_FAIL)
> > +               return false;
>
> Could be moved into the if (ublk_support_auto_buf_reg(ubq) &&
> ublk_rq_has_data(req)) statement since it won't be true otherwise?
>
> > +
> > +       ublk_io_lock(io);
> > +       ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res);
> > +       ublk_io_unlock(io);
> > +
> > +       return true;
> > +}
> > +
> > +static bool ublk_batch_prep_dispatch(struct ublk_queue *ubq,
> > +                                    const struct ublk_batch_io_data *d=
ata,
> > +                                    unsigned short *tag_buf,
> > +                                    unsigned int len)
> > +{
> > +       bool has_unused =3D false;
> > +       int i;
>
> unsigned?
>
> > +
> > +       for (i =3D 0; i < len; i +=3D 1) {
>
> i++?
>
> > +               unsigned short tag =3D tag_buf[i];
> > +
> > +               if (!__ublk_batch_prep_dispatch(ubq, data, tag)) {
> > +                       tag_buf[i] =3D UBLK_BATCH_IO_UNUSED_TAG;
> > +                       has_unused =3D true;
> > +               }
> > +       }
> > +
> > +       return has_unused;
> > +}
> > +
> > +/*
> > + * Filter out UBLK_BATCH_IO_UNUSED_TAG entries from tag_buf.
> > + * Returns the new length after filtering.
> > + */
> > +static unsigned int ublk_filter_unused_tags(unsigned short *tag_buf,
> > +                                           unsigned int len)
> > +{
> > +       unsigned int i, j;
> > +
> > +       for (i =3D 0, j =3D 0; i < len; i++) {
> > +               if (tag_buf[i] !=3D UBLK_BATCH_IO_UNUSED_TAG) {
> > +                       if (i !=3D j)
> > +                               tag_buf[j] =3D tag_buf[i];
> > +                       j++;
> > +               }
> > +       }
> > +
> > +       return j;
> > +}
> > +
> > +#define MAX_NR_TAG 128
> > +static int __ublk_batch_dispatch(struct ublk_queue *ubq,
> > +                                const struct ublk_batch_io_data *data,
> > +                                struct ublk_batch_fcmd *fcmd)
> > +{
> > +       unsigned short tag_buf[MAX_NR_TAG];
> > +       struct io_br_sel sel;
> > +       size_t len =3D 0;
> > +       bool needs_filter;
> > +       int ret;
> > +
> > +       sel =3D io_uring_cmd_buffer_select(fcmd->cmd, fcmd->buf_group, =
&len,
> > +                                        data->issue_flags);
> > +       if (sel.val < 0)
> > +               return sel.val;
> > +       if (!sel.addr)
> > +               return -ENOBUFS;
> > +
> > +       /* single reader needn't lock and sizeof(kfifo element) is 2 by=
tes */
> > +       len =3D min(len, sizeof(tag_buf)) / 2;
>
> sizeof(unsigned short) instead of 2?
>
> > +       len =3D kfifo_out(&ubq->evts_fifo, tag_buf, len);
> > +
> > +       needs_filter =3D ublk_batch_prep_dispatch(ubq, data, tag_buf, l=
en);
> > +       /* Filter out unused tags before posting to userspace */
> > +       if (unlikely(needs_filter)) {
> > +               int new_len =3D ublk_filter_unused_tags(tag_buf, len);
> > +
> > +               if (!new_len)
> > +                       return len;
>
> Is the purpose of this return value just to make ublk_batch_dispatch()
> retry __ublk_batch_dispatch()? Otherwise, it seems like a strange
> value to return.
>
> Also, shouldn't this path release the selected buffer to avoid leaking it=
?
>
> > +               len =3D new_len;
> > +       }
> > +
> > +       sel.val =3D ublk_batch_copy_io_tags(fcmd, sel.addr, tag_buf, le=
n * 2);
>
> sizeof(unsigned short)?
>
> > +       ret =3D ublk_batch_fetch_post_cqe(fcmd, &sel, data->issue_flags=
);
> > +       if (unlikely(ret < 0)) {
> > +               int i, res;
> > +
> > +               /*
> > +                * Undo prep state for all IOs since userspace never re=
ceived them.
> > +                * This restores IOs to pre-prepared state so they can =
be cleanly
> > +                * re-prepared when tags are pulled from FIFO again.
> > +                */
> > +               for (i =3D 0; i < len; i++) {
> > +                       struct ublk_io *io =3D &ubq->ios[tag_buf[i]];
> > +                       int index =3D -1;
> > +
> > +                       ublk_io_lock(io);
> > +                       if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
> > +                               index =3D io->buf.auto_reg.index;
>
> This is missing the io->buf_ctx_handle =3D=3D io_uring_cmd_ctx_handle(cmd=
)
> check from ublk_handle_auto_buf_reg().

Never mind, I guess that's okay because both the register and register
are using data->cmd as the io_uring_cmd.

>
> > +                       io->flags &=3D ~(UBLK_IO_FLAG_OWNED_BY_SRV | UB=
LK_IO_FLAG_AUTO_BUF_REG);
> > +                       io->flags |=3D UBLK_IO_FLAG_ACTIVE;
> > +                       ublk_io_unlock(io);
> > +
> > +                       if (index !=3D -1)
> > +                               io_buffer_unregister_bvec(data->cmd, in=
dex,
> > +                                               data->issue_flags);
> > +               }
> > +
> > +               res =3D kfifo_in_spinlocked_noirqsave(&ubq->evts_fifo,
> > +                       tag_buf, len, &ubq->evts_lock);
> > +
> > +               pr_warn("%s: copy tags or post CQE failure, move back "
> > +                               "tags(%d %zu) ret %d\n", __func__, res,=
 len,
> > +                               ret);
> > +       }
> > +       return ret;
> > +}
> > +
> > +static __maybe_unused int
>
> The return value looks completely unused. Just return void instead?
>
> Best,
> Caleb
>
> > +ublk_batch_dispatch(struct ublk_queue *ubq,
> > +                   const struct ublk_batch_io_data *data,
> > +                   struct ublk_batch_fcmd *fcmd)
> > +{
> > +       int ret =3D 0;
> > +
> > +       while (!ublk_io_evts_empty(ubq)) {
> > +               ret =3D __ublk_batch_dispatch(ubq, data, fcmd);
> > +               if (ret <=3D 0)
> > +                       break;
> > +       }
> > +
> > +       if (ret < 0)
> > +               ublk_batch_deinit_fetch_buf(data, fcmd, ret);
> > +
> > +       return ret;
> > +}
> > +
> >  static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
> >                            unsigned int issue_flags)
> >  {
> > --
> > 2.47.0
> >
