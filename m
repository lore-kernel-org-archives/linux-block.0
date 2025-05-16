Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05153232
	for <linux-block@vger.kernel.org>; Fri, 16 May 2025 02:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747361792; cv=none; b=egGyZiepvPKRebgZ/khE8qV531ORRTVHMahyck1z+iz40zy92ZSUF00fxLgas6Fvy+73ybmeet/mUX89W74SRtCusz6jXhIrG+HDEwGHaJljKiA0HcckIAxDGZKA/IITCg1nKcxAzN+eX9G/7oGQmVdo2NZxFR2CU8qyZLHB5p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747361792; c=relaxed/simple;
	bh=iHebLIXopeHKkBU7TNEq7/6La2D5Rc/29g9yp66VsJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eclOU1k1NCEJMFF8NJySTaRMFEZeX6oEwhUoqqGxc9UKfsHLaxJmhyJ7zicLvFGnmBvIUzkmKRaOdiheCxxWiV2Z4Glx+KilmJ+tGtGfUPfeXyEZQJo+4MyF/xjjtIWBpg6tzJ/dU6zn4Bm/yWKr4oxd+KuDlI8oFKdDaJLXB/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Dffb6dlZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Dffb6dlZ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-231c790d558so1421235ad.2
        for <linux-block@vger.kernel.org>; Thu, 15 May 2025 19:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747361790; x=1747966590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVPLSfmc0os/HPQ/mni5HoLtIlZ3oyybdSI++dqqG8A=;
        b=Dffb6dlZ/KhYZhXwFxOEsdSP21qeyhj6bhW3hdozuSlNhY1MSWC1VlT4maUneUQdBM
         FtZU+ta6Uid+5lq7PCicmpNhq1JxJwcmMdiZVoOwcfsOQLBJp/LlxG8aqjG2GPHKh9H6
         0ds6JSaNkrh1C1W6YtG5bhdDpbFbfHTDe4O1vRqUx8AU3gNylvJ2rq4DJIvQz/2qWSGW
         Wp8wYfRl1wvLuCccUG/tBUE6Sd45JwOt29nmRSqJZe27A6t4buOmvVuT/912zPFuPDSl
         4l8xZIoc/80af1ZWEHyLxOA/1AUeGH8FiZV1DIWDdJ/ggc7RNSvGkSIb/JzpUJfbPVcj
         UWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747361790; x=1747966590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVPLSfmc0os/HPQ/mni5HoLtIlZ3oyybdSI++dqqG8A=;
        b=O5L0j4voXUMi7yfhGV9S2tHTGp5l0rEInieSwV5fK66jjC0WY0zK4Qmal++YEpQ0Nd
         dr+kbuBT/pqYvbWyhQ1fNv0Fv79cgURDTP0ZmVV0XmHnojPOziCmx27znj8ej0J44ud2
         F8wFllahF/wiOTohml11wwF8SrUiMExqhpc91DztNNp+w6SslWL5uoaV9b509Jd8baSw
         inbsxERfElTJyi7hsAbtbeLp+uRaqEpM6gpzNnhzP9YgLkRw3hR19tCyNlfmgmX4SWec
         D+Pj5WQDQMoi1eZppf7n5rzK4sad4ZSpw5r9JZGBr40Vo2f00Vomej6anCZyBFRpZfZD
         u+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUD3qUiLiNte8yEH/cbSjhZJHDgCR0LSWOiY2JhRo9xcFRXH8jRUmJZi16xbDtVf4TcnAlvS0TElNRp9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT0FUJEUpaBM2Y24jIacz69weSuhku5QJhlo/HI/G8iV3Z58Sp
	rhN04cXhcYhbV50upIPhm9r1/UKqUqCKioM7hFmEWeXBPzbL7Dsq57QGFQPgAZ2kq1NuiUF4Hqk
	ej7i52peMxxentp6GK1pYUIZFPBzM91jug8ZVe+I8IA==
X-Gm-Gg: ASbGncuETVompAFDQCepJELHZ8M0zAX9FXzoZF3Il0nq5p2G3eZKbOouB3PhqmE8klh
	jgG3szAIWMIDkCQPL46qhpxduQNrNjZu1e+Fahy9qhws580fkV/2lIHBcxGI1UtwDlkcxuQnc1C
	fPZ1z4hcDurMfRrCyCUrH9LSlSFy5suZY=
X-Google-Smtp-Source: AGHT+IFaiwhjP5aT+J0sYDy75ZBwmNVHs5l9bRXJIep8bvyvVkGcYHMZBbFJnSHBlaam6Ttd4w5hNUo+9kmzV4Wnnwc=
X-Received: by 2002:a17:903:41d0:b0:224:1005:7281 with SMTP id
 d9443c01a7336-231d43c3d88mr7205945ad.7.1747361789820; Thu, 15 May 2025
 19:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515162601.77346-1-ming.lei@redhat.com> <CADUfDZocCU0NL6HZ+nd5VRkrKyJMNcU-xDBsvq99FiSJ=Lk90A@mail.gmail.com>
In-Reply-To: <CADUfDZocCU0NL6HZ+nd5VRkrKyJMNcU-xDBsvq99FiSJ=Lk90A@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 15 May 2025 19:16:18 -0700
X-Gm-Features: AX0GCFssJpS1DS7FuEXQebJXbjAb69-if30W23VG0_j88fFTeWItkjR6o_n6E90
Message-ID: <CADUfDZqg5g-MoG5F8OeeZSndUnFr9At=naZP6mobXdNdPExF5w@mail.gmail.com>
Subject: Re: [PATCH] ublk: fix dead loop when canceling io command
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 6:51=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Thu, May 15, 2025 at 9:26=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wr=
ote:
> >
> > Commit f40139fde527 ("ublk: fix race between io_uring_cmd_complete_in_t=
ask and ublk_cancel_cmd")
> > adds request state check in ublk_cancel_cmd(), and if the request is
> > started, skip canceling this uring_cmd.
> >
> > However, the current uring_cmd may be in ACTIVE state, without block
> > request coming to the uring command. Meantime, the cached request in
> > tag_set.tags[tag] is recycled and has been delivered to ublk server,
> > then this uring_cmd can't be canceled.
>
> To check my understanding, the scenario you're describing is that the
> request has started but also has already been completed by the ublk
> server? And this can happen because tag_set.tags[q_id]->rqs[tag] still
> points to the old request even after it has completed? Reading through
> blk-mq.c, that does seem possible since rqs[tag] is set in
> blk_mq_start_request() but not cleared in __blk_mq_end_request().
>
> >
> > ublk requests are aborted in ublk char device release handler, which
> > depends on canceling all ACTIVE uring_cmd. So cause dead loop.
>
> Do you mean "deadlock"?
>
> >
> > Fix this issue by not taking stale request into account when canceling
> > uring_cmd in ublk_cancel_cmd().
> >
> > Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Closes: https://lore.kernel.org/linux-block/mruqwpf4tqenkbtgezv5oxwq7ng=
yq24jzeyqy4ixzvivatbbxv@4oh2wzz4e6qn/
> > Fixes: f40139fde527 ("ublk: fix race between io_uring_cmd_complete_in_t=
ask and ublk_cancel_cmd")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index f9032076bc06..dc104c025cd5 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1708,7 +1708,7 @@ static void ublk_cancel_cmd(struct ublk_queue *ub=
q, unsigned tag,
> >          * that ublk_dispatch_req() is always called
> >          */
> >         req =3D blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
> > -       if (req && blk_mq_request_started(req))
> > +       if (req && blk_mq_request_started(req) && req->tag =3D=3D tag)
>
> Is it possible that req now belongs to a different hctx (q_id)? From a
> quick reading of blk-mq.c, it looks like the hctx's requests are
> always allocated from the hctx's static_rqs, so I don't think that
> should be a problem. Reading req->tag here is probably racy though, as
> it's written by blk_mq_rq_ctx_init(), called from
> *blk_mq_alloc_request*() on the submitting task. How about checking
> blk_mq_rq_state(req) =3D=3D MQ_RQ_IN_FLIGHT instead of
> blk_mq_request_started(req) && req->tag =3D=3D tag?

Ah, never mind, I see what you mean. The struct request could have
already been reused for a new I/O to the ublk queue and associated
with a different tag. And that new request could be inflight even
though the old one has completed. Really this condition intends to ask
"is this tag active?" I guess you could use
sbitmap_test_bit(&tag_set.tags[q_id].bitmap_tags, tag) (exposed
through a blk-mq helper) to determine that more directly. But the
quick fix probably makes sense. It's technically racy, as the load and
store of req->state need to use acquire and release ordering to
synchronize the accesses to req->tag, but it's probably unlikely to
observe that reordering in practice.

Best,
Caleb
