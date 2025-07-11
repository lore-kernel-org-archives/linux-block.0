Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE314884C
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242729; cv=none; b=kPxM+vPkxZWjPdrpZ3T/An1r4C5c10zlqjhDug44VYqlroqlhUah/V4CvMDQOFrLE8SX670GWk9gEn8+YUNnIhwmWtd18uZGYeeGXEHku8YK/8Ao/0UxfzOjB1KKrglPOUtG4008GbY9YUEmmcDwgXp88vHzHxkXMYmX7GQzOQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242729; c=relaxed/simple;
	bh=r4Rx0weCAJ7smCkxDnjDcem1HVO4AVjLCMhaZ5L/Zto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwbApjHIPflHKp5C5eeMaP+QmVpDhnrZxsxE+zbvVmvbJE+3qUTpq2ilxcpBnwa/ARSM0Gub28uDnlZ5pF1Z+K51Y4L+voDl4LZYQrt3SdhYQoY4IglWltr1GnVnRbLelT+o6jeZru37NieMogUTPfj+aThl4roxKYywEGedY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=F2l08PFH; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="F2l08PFH"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3138e64fc73so424975a91.2
        for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 07:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752242726; x=1752847526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4UwXN044zBdobgM0lj4Ah3z7ceZOrspTx1KMW5YBto=;
        b=F2l08PFHmxIVg4kaOsHH3ir+D2NDdDucp/KRDl7tYEzgCQZZLeoQDdeFDn1fYlBfjv
         RYcp4alxReC7NOGOOOEOFbosyPbPBPnEu+Dmo15NS6MNpvjKwVTn5CdwjqB0UPi0pjd0
         4O4Gfubdtw9vY66AF15siFQF+iw7hF4deLhMxiv5e5JeHIC99L4VvzRxukHDIuqBj6xR
         SKOuAKb7A50z9tg5r8FFGQsbFLfRaK2YK/Vi3L6ryFzUHE8c6sqaGMUlGvezR6Hr5xWw
         YNdwHIFAtqJ3RXSO9JpUDiHtaCBMkw/y+DCfYf4DnLBvaLpGScp+ZXq3MbOwNQABIVvr
         4g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752242726; x=1752847526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4UwXN044zBdobgM0lj4Ah3z7ceZOrspTx1KMW5YBto=;
        b=fySxdI5ob0J0InE+ZOnOQNdDiul3Mg2xCldJK7uYZ/dgMAOUwuHbRGeQTYyjHs/REH
         PMzArYnw6d/1FmhMu2Y+ZR9Hg7m8COoeiwU3RQsP8KTIAJ+hedfUd+VwWvtikeWvmocS
         VylSDh8Ozm0RPvz8efujbsWEkWkaXUZRyZhdiZ0zM6/cdSXQuNtxPuD9QerlMWKKcrI/
         pnspLJzi0s4G0f727Yo0Da1VnCBBTKMrYsmtpgXa0Y6QAipumsCVFM+EYasIUmIh4JMb
         in8+0NANe1/xMPEClnSmzpRlHn0O6B9QDUJbBnYrxJja/4xtGEcT+GLLkHMeupBuueWI
         hg/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyCxW71ik3fsGgAmvnHEbK8XUyhW9PiiPreBeyXxNAhKhku3YQs/daWqCGp4zed6NRDdtUPEy5VxCiIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxklIDCP4s/fJDkG9gfSu54AnGveVbhLl7uyY26Mi/phVGbbTjL
	NvoDxaeR6MGLM2SgsMMb0TimWg3a0/eU22bIAZ2+KGJ8ZYM8+uqjPGeYhL4HU3AOuKt0U965tfX
	2HQDJ7CSCveumwL0pr7j/ZsvfGzC6iiGzQeC4di+hdw==
X-Gm-Gg: ASbGnctd5+47BSvk3OQ3sLPKS+Ak5gg6gWynyrpw5jeFOfiYwH6bmAyYhQFw9ti9BWi
	kuQrob7oKwY0IGydDKotLuIfzSgYN7ZWECKClWHDDNE+biBsj2ybw12OESaj9cl+oUsSpE87TKK
	3sfpH6uUF+fILgTYtYcDe3Ag9DvuReHVPhUyGkBVJxt/LQUgeL/lPuoUWxFsITexd4dhfBLUKIN
	Lv3TMOT
X-Google-Smtp-Source: AGHT+IF9X40jmbcqkIn2T8sYLKC4Djucdbv5o7p4J7kJFzqmcnQMu1brqAx7eWlzfjAzmKXzB/T1GFoIHX3nYRGX3MQ=
X-Received: by 2002:a17:90a:e7d0:b0:311:c939:c842 with SMTP id
 98e67ed59e1d1-31c4cd1cd40mr1684304a91.7.1752242726261; Fri, 11 Jul 2025
 07:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702040344.1544077-1-ming.lei@redhat.com> <20250702040344.1544077-9-ming.lei@redhat.com>
 <CADUfDZo9SADywa6a_D5ZjwoU+3Y14CTg7Y1Ywhf-5Hsnu=fCyQ@mail.gmail.com> <aG5ZAQs4TSHovUyd@fedora>
In-Reply-To: <aG5ZAQs4TSHovUyd@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 11 Jul 2025 10:05:13 -0400
X-Gm-Features: Ac12FXz6j45wwcJ_aKjvpvpX1vT6sGkGYBdKh0O38Ecgiu9M7rawBMYU80YxYog
Message-ID: <CADUfDZoEKtuLoh2rKrFP2TnEadd5U2jtmb5WPtdP27-0HhNHXg@mail.gmail.com>
Subject: Re: [PATCH 08/16] ublk: remove ublk_commit_and_fetch()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 7:57=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Tue, Jul 08, 2025 at 09:27:57AM -0400, Caleb Sander Mateos wrote:
> > On Wed, Jul 2, 2025 at 12:04=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Remove ublk_commit_and_fetch() and open code request completion.
> > >
> > > Now request reference is stored in 'ublk_io', which becomes one globa=
l
> > > variable, the motivation is to centralize access 'struct ublk_io' ref=
erence,
> > > then we can introduce lock to protect `ublk_io` in future for support=
ing
> > > io batch.
> >
> > I didn't follow this. What do you mean by "global variable"?
>
> ublk server can send anything to driver with specified tag if batch io
> extension is added and per-io task is relaxed, then 'ublk_io' instance ca=
n be
> visible to any userpsace command, which needs protection, looks like one
> global variable.
>
> If reference is stored in request pdu, things becomes more like local
> variable, since the early ublk_io flag check guarantees that concurrent
> access can't reach 'request'.

"global variable" means something specific in C, so I would avoid
using it here to refer to something else. How about something like the
following?

Consolidate accesses to struct ublk_io in
UBLK_IO_COMMIT_AND_FETCH_REQ. When the ublk_io daemon task restriction
is relaxed in the future, ublk_io will need to be protected by a lock.
Unregister the auto-registered buffer and complete the request last,
as these don't need to happen under the lock.

Best,
Caleb

>
> >
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 36 ++++++++++++++++++------------------
> > >  1 file changed, 18 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 7fd2fa493d6a..13c6b1e0e1ef 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -711,13 +711,12 @@ static inline void ublk_put_req_ref(struct ublk=
_io *io, struct request *req)
> > >                 __ublk_complete_rq(req);
> > >  }
> > >
> > > -static inline void ublk_sub_req_ref(struct ublk_io *io, struct reque=
st *req)
> > > +static inline bool ublk_sub_req_ref(struct ublk_io *io, struct reque=
st *req)
> > >  {
> > >         unsigned sub_refs =3D UBLK_REFCOUNT_INIT - io->task_registere=
d_buffers;
> > >
> > >         io->task_registered_buffers =3D 0;
> > > -       if (refcount_sub_and_test(sub_refs, &io->ref))
> > > -               __ublk_complete_rq(req);
> > > +       return refcount_sub_and_test(sub_refs, &io->ref);
> >
> > The struct request *req parameter can be removed now. Looks like it
> > can be removed from ublk_need_complete_req() too.
>
> Good catch!
>
> >
> > >  }
> > >
> > >  static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
> > > @@ -2224,21 +2223,13 @@ static int ublk_check_commit_and_fetch(const =
struct ublk_queue *ubq,
> > >         return 0;
> > >  }
> > >
> > > -static void ublk_commit_and_fetch(const struct ublk_queue *ubq,
> > > -                                 struct ublk_io *io, struct io_uring=
_cmd *cmd,
> > > -                                 struct request *req, unsigned int i=
ssue_flags,
> > > -                                 __u64 zone_append_lba, u16 buf_idx)
> > > +static bool ublk_need_complete_req(const struct ublk_queue *ubq,
> > > +                                  struct ublk_io *io,
> > > +                                  struct request *req)
> > >  {
> > > -       if (buf_idx !=3D UBLK_INVALID_BUF_IDX)
> > > -               io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
> > > -
> > > -       if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> > > -               req->__sector =3D zone_append_lba;
> > > -
> > >         if (ublk_need_req_ref(ubq))
> > > -               ublk_sub_req_ref(io, req);
> > > -       else
> > > -               __ublk_complete_rq(req);
> > > +               return ublk_sub_req_ref(io, req);
> > > +       return true;
> > >  }
> > >
> > >  static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_=
io *io,
> > > @@ -2271,6 +2262,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_=
cmd *cmd,
> > >         unsigned tag =3D ub_cmd->tag;
> > >         struct request *req;
> > >         int ret;
> > > +       bool compl;
> > >
> > >         pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n=
",
> > >                         __func__, cmd->cmd_op, ub_cmd->q_id, tag,
> > > @@ -2347,8 +2339,16 @@ static int __ublk_ch_uring_cmd(struct io_uring=
_cmd *cmd,
> > >                         goto out;
> > >                 req =3D ublk_fill_io_cmd(io, cmd, ub_cmd->result);
> > >                 ret =3D ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr=
, &buf_idx);
> > > -               ublk_commit_and_fetch(ubq, io, cmd, req, issue_flags,
> > > -                                     ub_cmd->zone_append_lba, buf_id=
x);
> > > +               compl =3D ublk_need_complete_req(ubq, io, req);
> > > +
> > > +               /* can't touch 'ublk_io' any more */
> > > +               if (buf_idx !=3D UBLK_INVALID_BUF_IDX)
> > > +                       io_buffer_unregister_bvec(cmd, buf_idx, issue=
_flags);
> > > +               if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> > > +                       req->__sector =3D ub_cmd->zone_append_lba;
> > > +               if (compl)
> > > +                       __ublk_complete_rq(req);
> >
> > What is the benefit of separating the reference count decrement from
> > the call to __ublk_complete_rq()? I can understand if you want to keep
> > the code manipulating ublk_io separate from the code dispatching the
> > completed request. But it seems like this could be written more simply
> > as
> >
> > if (ublk_need_complete_req(ubq, io, req))
> >         __ublk_complete_rq(req);
>
> ublk_need_complete_req() has to be protected, but the following code
> (buffer unregister, complete req needn't and can't be covered with spin l=
ock).
>
> It is for putting anything needing protection in future together.
>
>
> Thanks,
> Ming
>
