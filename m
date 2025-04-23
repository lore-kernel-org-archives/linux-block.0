Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C519DF4C
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419953; cv=none; b=VwRKGm3hH8eE6KhQI77qPoL09Jz78FxsMLI2ZbhyF1wB5Rq7GIGNEVfs3KzGdKl4moPR7kZYv42e2ciGcStcjbyOGdDEqNI3brP460khwI0zGyvNQCzU0Y1MB6yWp5a7x7LM3smTw43a75KkwePneNMXg1+4dcW6X/dUMHeRKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419953; c=relaxed/simple;
	bh=O6i14Cb1c2v89kQ8RhE0rMzeP81p8QiwlxO5l5jLtTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlWAHHL6x2UR2b2ilYBjULBKztZkdIykwNr+SSYM1mLnTqlT7pJtFmW+oSOecBjsOn/8yCKJkmuTR9i5Pb06nL9FJ/YCuUMUuQrJAYc9PzF8UCT/LW4cCxQ16ilbPTJHMkDo01MdGNYiwRYQHRBA0f4lb/hMDZdV9MRJsYoz2Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GjlKwsLh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GjlKwsLh"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3087a70557bso972773a91.2
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745419951; x=1746024751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dkyd36uJwtxxb2y0ub+7KV+WHBGpVP2QPWoxV/H/9T4=;
        b=GjlKwsLhCQAeZ3k2BxiqEJERiIjr+E9TeXACFK3g+Q9dgqMEOHGIausAg0DlfgK0/R
         B0NmT1PEqHmmghmXQQbe9/xeqyMangCQcxd2GUpYH68wxze2GhEcxboVYPFXcSjtGVaP
         puSbRbbHP6qINgSXtZ/14Pul02PftlUHSqgzIGVTW2DFei0tuVoqkV/d/Cg0mZjgqyMr
         eqXm6ktpBL1tkuj29DYEUnsGRWbOpIqwCsIkAd9zmKmic3rFrxsNtV2WEKgkkRy1uYxE
         TAYDwdiTvjDGnSZdMoaSqH5KTU641B4bnu+6b/9SMVc3t64MQgLIkyd5nJEaDOK/pHLh
         5b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745419951; x=1746024751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dkyd36uJwtxxb2y0ub+7KV+WHBGpVP2QPWoxV/H/9T4=;
        b=Z03F+DAYGMtuZipTcH4PrL5qC81kdxbE+LvmeeoWhEkkmKwjhNCRFJAb6nHmHbsXzQ
         yI3oXF5O6+RpEVzosbX1u5L0P2nXB2Rv5S9/1FDF7S7DUC9wnlhquc/wG4qy7lnUL0Hb
         E2FbSBSSo+u9+imnN42rOxjaVudhM/wtnZJGYsnq3RnVsHd05FEs5o6ueaR7tI67eONf
         wWwRUsyHqzG1HPmDR55ydxvhmdNi0PPqnUERi2MkoW3nFjx+9F01radZqHY1GnK0kip5
         6kv9nmDD4d7mkI1+LqWDQb0ocCLJZhEmNvoFc6qpRzcH0AuNH6rw/Ft/7J68f6/+CNcK
         8tKw==
X-Forwarded-Encrypted: i=1; AJvYcCWWBCBj1HWK6kwSgfnnXdRc3NtirTbLRjBED2o3ohyZ0hDA0V2UZcHCF33xh1HSpT4aAFvEInUYRen5yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPADeVZixRSWt71m5CzaD5Ozd7q+LiSDPhI/9eEAHg0xX/ltWw
	3443W6E2kc/odoJ+AiC43ujDXEZjvgv5DyVCy6EhZsZdsvFKyN4LQFMIniz4sgr1EjTf8cTIuaY
	bC5G3rBgAIouSx/HjMBG5DV1faNCTUkrElXYGxQ==
X-Gm-Gg: ASbGnctLhx0bHEdpGioMaLyH0d7Y3yyLwTp3oy3n90G0FCxTQw9wajwgZW0MXT/W8fP
	syFAood3lKuRBhRhyXTHbTukqsB189wVox0qiW1BNlajq/XI+f6YCFd0wnHo4KP2a92pnSjxj4I
	uXvA6FP8eLYu+0f6dwhjHR
X-Google-Smtp-Source: AGHT+IH897f3FWSMHLvfjgLuZKl6ykkPRIZptK0JDkwKuKf5SSAxKfslM9GYqFjHMslP0I5vjotqh5bn/pvnlWsvfCs=
X-Received: by 2002:a17:90b:1a8b:b0:2ff:78dd:2875 with SMTP id
 98e67ed59e1d1-309dee58e09mr1882682a91.5.1745419950835; Wed, 23 Apr 2025
 07:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423092405.919195-1-ming.lei@redhat.com> <20250423092405.919195-2-ming.lei@redhat.com>
 <CADUfDZrh6pO6rCXN-QbTY3EX+EyYFvRW96o0Lf_kuEBMQ8ysEQ@mail.gmail.com>
In-Reply-To: <CADUfDZrh6pO6rCXN-QbTY3EX+EyYFvRW96o0Lf_kuEBMQ8ysEQ@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 23 Apr 2025 07:52:19 -0700
X-Gm-Features: ATxdqUH_To54WG__n0Hx0175S61K5Qavew_W0lcS8felbjFsQtwkPXEToJa6lvM
Message-ID: <CADUfDZohH1b75w6pnNduEpTCUp6RFbWv0HCoNT-d2k9yUvmCuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Guy Eisenberg <geisenberg@nvidia.com>, 
	Jared Holzman <jholzman@nvidia.com>, Yoav Cohen <yoav@nvidia.com>, Omri Levi <omril@nvidia.com>, 
	Ofer Oshri <ofer@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 7:44=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Wed, Apr 23, 2025 at 2:24=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wr=
ote:
> >
> > The in-tree code calls io_uring_cmd_complete_in_task() to schedule
> > task_work for dispatching this request to handle
> > UBLK_U_IO_NEED_GET_DATA.
> >
> > This ways is really not necessary because the current context is exactl=
y
> > the ublk queue context, so call ublk_dispatch_req() directly for handli=
ng
> > UBLK_U_IO_NEED_GET_DATA.
>
> Indeed, I was planning to make the same change!
>
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 2de7b2bd409d..c4d4be4f6fbd 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1886,15 +1886,6 @@ static void ublk_mark_io_ready(struct ublk_devic=
e *ub, struct ublk_queue *ubq)
> >         }
> >  }
> >
> > -static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id=
,
> > -               int tag)
> > -{
> > -       struct ublk_queue *ubq =3D ublk_get_queue(ub, q_id);
> > -       struct request *req =3D blk_mq_tag_to_rq(ub->tag_set.tags[q_id]=
, tag);
> > -
> > -       ublk_queue_cmd(ubq, req);
> > -}
>
> Looks like this will conflict with Uday's patch:
> https://lore.kernel.org/linux-block/20250421-ublk_constify-v1-3-3371f9e9f=
73c@purestorage.com/
> . Since that series already has reviews, I expect it will land first.
>
> > -
> >  static inline int ublk_check_cmd_op(u32 cmd_op)
> >  {
> >         u32 ioc_type =3D _IOC_TYPE(cmd_op);
> > @@ -2103,8 +2094,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cm=
d *cmd,
> >                 if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> >                         goto out;
> >                 ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> > -               ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag=
);
> > -               break;
> > +               req =3D blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id]=
, tag);
> > +               ublk_dispatch_req(ubq, req, issue_flags);
>
> Maybe it would make sense to factor the UBLK_IO_NEED_GET_DATA handling
> out of ublk_dispatch_req()? Then ublk_dispatch_req() (called only for
> incoming ublk requests) could assume the UBLK_IO_FLAG_NEED_GET_DATA
> flag is not yet set, and this path wouldn't need to pay the cost of
> re-checking current !=3D ubq->ubq_daemon, ublk_need_get_data(ubq) &&
> ublk_need_map_req(req), etc.
>
> > +               return -EIOCBQUEUED;
>
> It's probably possible to return the result here synchronously to
> avoid the small overhead of io_uring_cmd_done(). That may be easier to
> do if the UBLK_IO_NEED_GET_DATA path is separated from
> ublk_dispatch_req().

And if we can avoid using io_uring_cmd_done(), calling
ublk_fill_io_cmd() for UBLK_IO_NEED_GET_DATA would no longer be
necessary. (This was my original motivation to handle
UBLK_IO_NEED_GET_DATA synchronously; UBLK_IO_NEED_GET_DATA overwriting
io->cmd is an obstacle to introducing a struct request * field that
aliases io->cmd.)

Best,
Caleb
