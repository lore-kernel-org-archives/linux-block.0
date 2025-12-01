Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A95335BDB
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610663; cv=none; b=qxMaLNCg5WSezJvZ8eldmB1ipStLtrvas4Mmv1FfLY7HLM2h7IAARpnHe+ZRN47BTVrW9UK7Zuou08Qy2hRz9BIJjVUaiTem5kQfoJWzuPizUSzWym56qG53PynMq72yGe+zqKh+h0O8ub+WoHnzYReVrsyF7MoRwpR3wvZKCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610663; c=relaxed/simple;
	bh=XFIJB3ieYC3dJGje6QZA4e81RwLAUtFlhgWolEQSaxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpliBbDGoP+UGC4G8nM0VqGQPSePePsR3GUqB/jSFpmFftG7sxUniS331N1ZZUZ72uGZ5iS+CwZbCr9Ivip9Y2fcQ5V19tBUl7JXo9q0HiNvQz5m6cnN8hX2OikXA2lE2sg0nuLW5K/1Y9Epqt0AaZFnVWO5KI4+/aXZlFGwoao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HBxav6GM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HBxav6GM"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297e2736308so4879915ad.1
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 09:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764610660; x=1765215460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baALTFxUvLx4XVhnWTLHkAujcRY0n/lil6J0VuVZjTA=;
        b=HBxav6GMTjJcOXf1Jp1NfmA3/Ge1Q1cn+ryarLeeka1wnzfHGiyocoZBtR/NiQgpkX
         R9D8MLpY/+sYykV8bMvI6NTEBSz6sPIc0va+kx4iydRn+/LsUkYe0K39aZFedEY2U950
         g8L86rMdKMiOv+zb9hnlHu/krNagrCL9tKKb//FPOESN7ubCsXRn9CItcpQc0kJqrzYM
         5UoUeJnvhP0a5lbI4ab6KOhSKDD5PkPIfkAb+wvNAAmrQsX3dMmm9bPqIDurVHYlkK19
         NcZomml79lRj8nwvhnFiYXolsaItdbjE+fG5JyOPGlwymNHRj2v30MFG9/EeqaOSNBii
         MIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764610660; x=1765215460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=baALTFxUvLx4XVhnWTLHkAujcRY0n/lil6J0VuVZjTA=;
        b=D7loezzb2OblPtf5XcVpRqFAQohhCOKFv+M0gQiPLuBY8PU8jq3BmbAC1yDUQqJEY+
         LWMGQ3IWOmgt60t41nVqnBJMTXujzEU2ypNhQlftv+72sIL21LrgcSQ/yTiIvMOM497b
         z/70STnDKifO4gLJaHhlhP2EN8U/nJYR5EsYegnz214PRz40cv47aqgCbnlViMp3Iwd4
         3Qukq0ICbffl85LFCjzYZyu83PvRMi+iosJDTXsBjQ8VHJ1Pt8pzzg2cyQwGD5lm7cLr
         z/rTOp2Y0UwBWIQN0jShqny8klSBl5CDYxweoOTYKqqa5bwj3PdgLZlBp7aJebr/qab/
         SV+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkEhIoNCWABb94iJ9cZD9JfGd9rOnn543LFtrgL5wiHPc0Tgoh+w/5cxYKsvs786vd6g7A9ZjEqMTpdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw85D9RyZ9IMd8oPybnMjJkYezWnDcijL9ggV+X0BRVEGO73ZjN
	w67a0kJRcSUYrSCJWA2jrNSqf8QXkkiD2SAwvYQ/wjyzsLUKB55yX8JGG6fFAqHn7swEqeys6g+
	AWLysundQhczdairlgq1VgypRNJW2WThkXO2Fj++ezA==
X-Gm-Gg: ASbGncvv7I36bWSLhtI8XLdbIwhMyEDPUajKRcISLH9z+6aR9mE+npDB2gyp7ZIO3qx
	3O9O5PJBCBIWRawZ5/x/2iT+NIIH2rt5sCe8k+wELreUegMoD0xM5dlCDfrm7iobFfgKB6WXJYe
	u3PGF5vcclOEil9NEbhSONrIkua5LvcGCABuww4uwc8ui/GudIDhnjEad+KtVr6Mxm1iTnM+w4s
	3t4ixJ4zxxXWp213231ysQri5rRiD2+XQ8J/ycn4Zw4fw6Hqkz2tK4Qg5NVoYFhFLd/IGe/
X-Google-Smtp-Source: AGHT+IEmuIhyhPh2Otk4sdl1ZOi34Bfl2viI/V/VJ+0GVmIRmySyKg7tcEwoiT/skn5+xxbxQrospM24Nxhadyj+HOY=
X-Received: by 2002:a05:7022:69a9:b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-11c9d5538e8mr25123662c88.0.1764610659974; Mon, 01 Dec 2025
 09:37:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-14-ming.lei@redhat.com>
 <CADUfDZrsH_Bhhs_r0YqEU=3i6DcQCWVt-aEmbu1ouzX=e3WqYg@mail.gmail.com> <aSz-J4BhqwrkmGgs@fedora>
In-Reply-To: <aSz-J4BhqwrkmGgs@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 1 Dec 2025 09:37:28 -0800
X-Gm-Features: AWmQ_bk5UA3YZ07ehG1mVhCPkYnnJady_96Ez44pSi8mmq2SAQyN2swcUedWjOo
Message-ID: <CADUfDZqT4ZiFo2XPxhaRevHcYdGKtYzsE+UKr8i8K0PdArYsPg@mail.gmail.com>
Subject: Re: [PATCH V4 13/27] ublk: add batch I/O dispatch infrastructure
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 6:32=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Sun, Nov 30, 2025 at 11:24:12AM -0800, Caleb Sander Mateos wrote:
> > On Thu, Nov 20, 2025 at 6:00=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Add infrastructure for delivering I/O commands to ublk server in batc=
hes,
> > > preparing for the upcoming UBLK_U_IO_FETCH_IO_CMDS feature.
> > >
> > > Key components:
> > >
> > > - struct ublk_batch_fcmd: Represents a batch fetch uring_cmd that wil=
l
> > >   receive multiple I/O tags in a single operation, using io_uring's
> > >   multishot command for efficient ublk IO delivery.
> > >
> > > - ublk_batch_dispatch(): Batch version of ublk_dispatch_req() that:
> > >   * Pulls multiple request tags from the events FIFO (lock-free reade=
r)
> > >   * Prepares each I/O for delivery (including auto buffer registratio=
n)
> > >   * Delivers tags to userspace via single uring_cmd notification
> > >   * Handles partial failures by restoring undelivered tags to FIFO
> > >
> > > The batch approach significantly reduces notification overhead by agg=
regating
> > > multiple I/O completions into single uring_cmd, while maintaining the=
 same
> > > I/O processing semantics as individual operations.
> > >
> > > Error handling ensures system consistency: if buffer selection or CQE
> > > posting fails, undelivered tags are restored to the FIFO for retry,
> > > meantime IO state has to be restored.
> > >
> > > This runs in task work context, scheduled via io_uring_cmd_complete_i=
n_task()
> > > or called directly from ->uring_cmd(), enabling efficient batch proce=
ssing
> > > without blocking the I/O submission path.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 189 +++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 189 insertions(+)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 6ff284243630..cc9c92d97349 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -91,6 +91,12 @@
> > >          UBLK_BATCH_F_HAS_BUF_ADDR | \
> > >          UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK)
> > >
> > > +/* ublk batch fetch uring_cmd */
> > > +struct ublk_batch_fcmd {
> >
> > I would prefer "fetch_cmd" instead of "fcmd" for clarity
> >
> > > +       struct io_uring_cmd *cmd;
> > > +       unsigned short buf_group;
> > > +};
> > > +
> > >  struct ublk_uring_cmd_pdu {
> > >         /*
> > >          * Store requests in same batch temporarily for queuing them =
to
> > > @@ -168,6 +174,9 @@ struct ublk_batch_io_data {
> > >   */
> > >  #define UBLK_REFCOUNT_INIT (REFCOUNT_MAX / 2)
> > >
> > > +/* used for UBLK_F_BATCH_IO only */
> > > +#define UBLK_BATCH_IO_UNUSED_TAG       ((unsigned short)-1)
> > > +
> > >  union ublk_io_buf {
> > >         __u64   addr;
> > >         struct ublk_auto_buf_reg auto_reg;
> > > @@ -616,6 +625,32 @@ static wait_queue_head_t ublk_idr_wq;      /* wa=
it until one idr is freed */
> > >  static DEFINE_MUTEX(ublk_ctl_mutex);
> > >
> > >
> > > +static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_d=
ata *data,
> > > +                                       struct ublk_batch_fcmd *fcmd,
> > > +                                       int res)
> > > +{
> > > +       io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
> > > +       fcmd->cmd =3D NULL;
> > > +}
> > > +
> > > +static int ublk_batch_fetch_post_cqe(struct ublk_batch_fcmd *fcmd,
> > > +                                    struct io_br_sel *sel,
> > > +                                    unsigned int issue_flags)
> > > +{
> > > +       if (io_uring_mshot_cmd_post_cqe(fcmd->cmd, sel, issue_flags))
> > > +               return -ENOBUFS;
> > > +       return 0;
> > > +}
> > > +
> > > +static ssize_t ublk_batch_copy_io_tags(struct ublk_batch_fcmd *fcmd,
> > > +                                      void __user *buf, const u16 *t=
ag_buf,
> > > +                                      unsigned int len)
> > > +{
> > > +       if (copy_to_user(buf, tag_buf, len))
> > > +               return -EFAULT;
> > > +       return len;
> > > +}
> > > +
> > >  #define UBLK_MAX_UBLKS UBLK_MINORS
> > >
> > >  /*
> > > @@ -1378,6 +1413,160 @@ static void ublk_dispatch_req(struct ublk_que=
ue *ubq,
> > >         }
> > >  }
> > >
> > > +static bool __ublk_batch_prep_dispatch(struct ublk_queue *ubq,
> > > +                                      const struct ublk_batch_io_dat=
a *data,
> > > +                                      unsigned short tag)
> > > +{
> > > +       struct ublk_device *ub =3D data->ub;
> > > +       struct ublk_io *io =3D &ubq->ios[tag];
> > > +       struct request *req =3D blk_mq_tag_to_rq(ub->tag_set.tags[ubq=
->q_id], tag);
> > > +       enum auto_buf_reg_res res =3D AUTO_BUF_REG_FALLBACK;
> > > +       struct io_uring_cmd *cmd =3D data->cmd;
> > > +
> > > +       if (!ublk_start_io(ubq, req, io))
> >
> > This doesn't look correct for UBLK_F_NEED_GET_DATA. If that's not
> > supported in batch mode, then it should probably be disallowed when
> > creating a batch-mode ublk device. The ublk_need_get_data() check in
> > ublk_batch_commit_io_check() could also be dropped.
>
> OK.
>
> BTW UBLK_F_NEED_GET_DATA isn't necessary any more since user copy.
>
> It is only for handling WRITE io command, and ublk server can copy data t=
o
> new buffer by user copy.
>
> >
> > > +               return false;
> > > +
> > > +       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
> > > +               res =3D __ublk_do_auto_buf_reg(ubq, req, io, cmd,
> > > +                               data->issue_flags);
> >
> > __ublk_do_auto_buf_reg() reads io->buf.auto_reg. That seems racy
> > without holding the io spinlock.
>
> The io lock isn't needed.  Now the io state is guaranteed to be ACTIVE,
> so UBLK_U_IO_COMMIT_IO_CMDS can't commit anything for this io.

Makes sense.

Thanks,
Caleb

>
> >
> > > +
> > > +       if (res =3D=3D AUTO_BUF_REG_FAIL)
> > > +               return false;
> >
> > Could be moved into the if (ublk_support_auto_buf_reg(ubq) &&
> > ublk_rq_has_data(req)) statement since it won't be true otherwise?
>
> OK.
>
> >
> > > +
> > > +       ublk_io_lock(io);
> > > +       ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res);
> > > +       ublk_io_unlock(io);
> > > +
> > > +       return true;
> > > +}
> > > +
> > > +static bool ublk_batch_prep_dispatch(struct ublk_queue *ubq,
> > > +                                    const struct ublk_batch_io_data =
*data,
> > > +                                    unsigned short *tag_buf,
> > > +                                    unsigned int len)
> > > +{
> > > +       bool has_unused =3D false;
> > > +       int i;
> >
> > unsigned?
> >
> > > +
> > > +       for (i =3D 0; i < len; i +=3D 1) {
> >
> > i++?
> >
> > > +               unsigned short tag =3D tag_buf[i];
> > > +
> > > +               if (!__ublk_batch_prep_dispatch(ubq, data, tag)) {
> > > +                       tag_buf[i] =3D UBLK_BATCH_IO_UNUSED_TAG;
> > > +                       has_unused =3D true;
> > > +               }
> > > +       }
> > > +
> > > +       return has_unused;
> > > +}
> > > +
> > > +/*
> > > + * Filter out UBLK_BATCH_IO_UNUSED_TAG entries from tag_buf.
> > > + * Returns the new length after filtering.
> > > + */
> > > +static unsigned int ublk_filter_unused_tags(unsigned short *tag_buf,
> > > +                                           unsigned int len)
> > > +{
> > > +       unsigned int i, j;
> > > +
> > > +       for (i =3D 0, j =3D 0; i < len; i++) {
> > > +               if (tag_buf[i] !=3D UBLK_BATCH_IO_UNUSED_TAG) {
> > > +                       if (i !=3D j)
> > > +                               tag_buf[j] =3D tag_buf[i];
> > > +                       j++;
> > > +               }
> > > +       }
> > > +
> > > +       return j;
> > > +}
> > > +
> > > +#define MAX_NR_TAG 128
> > > +static int __ublk_batch_dispatch(struct ublk_queue *ubq,
> > > +                                const struct ublk_batch_io_data *dat=
a,
> > > +                                struct ublk_batch_fcmd *fcmd)
> > > +{
> > > +       unsigned short tag_buf[MAX_NR_TAG];
> > > +       struct io_br_sel sel;
> > > +       size_t len =3D 0;
> > > +       bool needs_filter;
> > > +       int ret;
> > > +
> > > +       sel =3D io_uring_cmd_buffer_select(fcmd->cmd, fcmd->buf_group=
, &len,
> > > +                                        data->issue_flags);
> > > +       if (sel.val < 0)
> > > +               return sel.val;
> > > +       if (!sel.addr)
> > > +               return -ENOBUFS;
> > > +
> > > +       /* single reader needn't lock and sizeof(kfifo element) is 2 =
bytes */
> > > +       len =3D min(len, sizeof(tag_buf)) / 2;
> >
> > sizeof(unsigned short) instead of 2?
>
> OK
>
> >
> > > +       len =3D kfifo_out(&ubq->evts_fifo, tag_buf, len);
> > > +
> > > +       needs_filter =3D ublk_batch_prep_dispatch(ubq, data, tag_buf,=
 len);
> > > +       /* Filter out unused tags before posting to userspace */
> > > +       if (unlikely(needs_filter)) {
> > > +               int new_len =3D ublk_filter_unused_tags(tag_buf, len)=
;
> > > +
> > > +               if (!new_len)
> > > +                       return len;
> >
> > Is the purpose of this return value just to make ublk_batch_dispatch()
> > retry __ublk_batch_dispatch()? Otherwise, it seems like a strange
> > value to return.
>
> If `new_len` becomes zero, it means all these requests are handled alread=
y,
> either fail or requeue, so return `len` to tell the caller to move on. I
> can comment this behavior.
>
> >
> > Also, shouldn't this path release the selected buffer to avoid leaking =
it?
>
> Good catch, but io_kbuf_recycle() isn't exported, we may have to call
> io_uring_mshot_cmd_post_cqe() by zeroing sel->val.
>
> >
> > > +               len =3D new_len;
> > > +       }
> > > +
> > > +       sel.val =3D ublk_batch_copy_io_tags(fcmd, sel.addr, tag_buf, =
len * 2);
> >
> > sizeof(unsigned short)?
>
> OK
>
> >
> > > +       ret =3D ublk_batch_fetch_post_cqe(fcmd, &sel, data->issue_fla=
gs);
> > > +       if (unlikely(ret < 0)) {
> > > +               int i, res;
> > > +
> > > +               /*
> > > +                * Undo prep state for all IOs since userspace never =
received them.
> > > +                * This restores IOs to pre-prepared state so they ca=
n be cleanly
> > > +                * re-prepared when tags are pulled from FIFO again.
> > > +                */
> > > +               for (i =3D 0; i < len; i++) {
> > > +                       struct ublk_io *io =3D &ubq->ios[tag_buf[i]];
> > > +                       int index =3D -1;
> > > +
> > > +                       ublk_io_lock(io);
> > > +                       if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
> > > +                               index =3D io->buf.auto_reg.index;
> >
> > This is missing the io->buf_ctx_handle =3D=3D io_uring_cmd_ctx_handle(c=
md)
> > check from ublk_handle_auto_buf_reg().
>
> As you replied, it isn't needed because it is the same multishot command
> for registering bvec buf.
>
> >
> > > +                       io->flags &=3D ~(UBLK_IO_FLAG_OWNED_BY_SRV | =
UBLK_IO_FLAG_AUTO_BUF_REG);
> > > +                       io->flags |=3D UBLK_IO_FLAG_ACTIVE;
> > > +                       ublk_io_unlock(io);
> > > +
> > > +                       if (index !=3D -1)
> > > +                               io_buffer_unregister_bvec(data->cmd, =
index,
> > > +                                               data->issue_flags);
> > > +               }
> > > +
> > > +               res =3D kfifo_in_spinlocked_noirqsave(&ubq->evts_fifo=
,
> > > +                       tag_buf, len, &ubq->evts_lock);
> > > +
> > > +               pr_warn("%s: copy tags or post CQE failure, move back=
 "
> > > +                               "tags(%d %zu) ret %d\n", __func__, re=
s, len,
> > > +                               ret);
> > > +       }
> > > +       return ret;
> > > +}
> > > +
> > > +static __maybe_unused int
> >
> > The return value looks completely unused. Just return void instead?
>
> Yes, looks it is removed in following patch.
>
>
> Thanks,
> Ming
>
