Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FBB433AD
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213670; cv=none; b=XmSVGCV5lsdaHNBitHB2Ih6moWc8FTZWRRnrjIkvjRl8S+Fg0m5B7kC/0Uq3t9n52kcoCoMycyfOdBf4PjRIjDCxwEUqx/k3meNOJluBRZv5+jX5bDk3oK7PutZoOoKTZlEx6+RLQgE5BxEjdBJRVw9J2kkakLsRt2apVg6Xp40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213670; c=relaxed/simple;
	bh=g+tdXtEwwqPMrAKGV11L5FqKvaEZKCkWyGY7qKK1d58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUPccfPod7Ebr//znRIwhie9/8j59Cy+FmGSj6cBIYrg51SnSFWT46wl0tFKvTQLfX9dRduhdPcws6Do13rzm+zVx5zIKONAWE2tuHdm6sdsmb+h9R9rH1ThdssXa8+4BaSvHZULe35I4iI+Z6SnftBZfIV93jM7KQFfjP+moLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=X3hAlaXB; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="X3hAlaXB"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af5499ca131so652279a12.3
        for <linux-block@vger.kernel.org>; Wed, 09 Apr 2025 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744213667; x=1744818467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HTHtEpFjo2m0eJzF/EuCO3IQhHVWLhk6Qnz8Y7uEIM=;
        b=X3hAlaXBSSiqaYgqeyuPXj4B+0EhaQ9Z8z48rvxivg95/G/hql5DjBBx2SCg6r4fbT
         8x6SGiOa5xdohQ5OEW0FdYMhIP0d7O8MdmSYSqSZZ3Zb8BhLejz4kg4BLopYVNaQuDGO
         Dqj+4ijuq4SV2EcksYRadLYk7fimHhxB4YIdJ4IyZkEWYCH/3TSwmdSbisdvhGyPVkNP
         /s+Lm31wsH2Xa8Z63faA2UP52AWhNu0eV2HpEXKeKqE6vlW/LPqnGpdI/z/UObjGKAw9
         Trm1pCXo7gaPhJ5F/S7Yg4MpyjRT77AiY495JGPCCTWnLpiNqcYvtEWEsGxHjlt3v8D6
         OxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213667; x=1744818467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HTHtEpFjo2m0eJzF/EuCO3IQhHVWLhk6Qnz8Y7uEIM=;
        b=MN45eH9Itx6fz2KPPppHei1LiLz77mlBncVV362q6xSFMRKZ0N65Re4gWO/za37cfq
         JAjesT8d2W+Ft5YIRkhau2ogLGzR81dkaghEtlH3I3p9XRoMXSgIHLDZ01D431nNK96f
         W7Rg0KC4v3t5CAE1jzSJMbi+e7URhte49noYxOBd0YkTVmtvtN02+GTcIIruMD0dJuFc
         oGwKiKk+9B+cTjUVaimjpTeMf9nSgeyq+rvuLv3f/0ogMBUWYAlK7qhNyAq4oCObmHxD
         pKI7CnmHjuZwiFwEsAzqFh4mdf7tr1JCfQHZE5dEjU+ZhuvJWuHTdKHNMCgVio7cax3d
         ax6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQhyDZbYYhF+yr9EvLLwcRs6N7hZU8p3iq0NDop3kjNzqFptz5lH5X9pD/AJGWRFo8PdLv67IAFmagvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2an7LmYuDuetbfL0sZN28n/lxPS84rIznedIPklcB0RgNnmsD
	WbgGsYTi4rIS4OPo1WhqkNvytHYQtCoaALME6VvUtSz11hoHn6qQe7xofWYlfrAYofXUIBurHjX
	SZt3h786um+6Vg4qcgv3HHjFq0qzKEPTVeldRXA==
X-Gm-Gg: ASbGncug+zCuXqN0u8mkXDeS+09ATIyq4L2GYXgrk4pwTpqoHsoaOOa99YQh3Zy7pDA
	H0xXNWiMbdd5npdN0m0o8k92i5sh7Clph3Qqlm4v8TWXych8+Jre/IZfSSEtdayj0hZu9OKUq8U
	bNstOVrGzTydALO3fAbJk9
X-Google-Smtp-Source: AGHT+IEyA5C6ajWyb35/HG+Ns6579RrrTEi2LjEIYSj1HOMSeHdKq15lijX5BtroS2ltrolmjDZVOqSekVPAopzRFKw=
X-Received: by 2002:a17:90b:1d12:b0:305:5f31:6c63 with SMTP id
 98e67ed59e1d1-306dbc308dbmr2110246a91.6.1744213667246; Wed, 09 Apr 2025
 08:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408072440.1977943-1-ming.lei@redhat.com> <20250408072440.1977943-2-ming.lei@redhat.com>
 <CADUfDZrHu=8Muss4zSvdLqq-EVoOE9t9PtqYEm343bTWaA-80g@mail.gmail.com> <Z_Xm2DBIaVrpjwNO@fedora>
In-Reply-To: <Z_Xm2DBIaVrpjwNO@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 9 Apr 2025 08:47:34 -0700
X-Gm-Features: ATxdqUGmWoicc3L1mMv5qsyNfqAuzp1U5abAFuA7HVuHJnbRQ7DapHSHcLRZAQs
Message-ID: <CADUfDZrOp82XKdgSEgpsWgVkyxfH+QT7aQ4z8rekSSfURLx0OQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ublk: fix handling recovery & reissue in ublk_abort_queue()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 8:17=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Tue, Apr 08, 2025 at 06:47:20PM -0700, Caleb Sander Mateos wrote:
> > On Tue, Apr 8, 2025 at 12:25=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Commit 8284066946e6 ("ublk: grab request reference when the request i=
s handled
> > > by userspace") doesn't grab request reference in case of recovery rei=
ssue.
> > > Then the request can be requeued & re-dispatch & failed when cancelin=
g
> > > uring command.
> > >
> > > If it is one zc request, the request can be freed before io_uring
> > > returns the zc buffer back, then cause kernel panic:
> > >
> > > [  126.773061] BUG: kernel NULL pointer dereference, address: 0000000=
0000000c8
> > > [  126.773657] #PF: supervisor read access in kernel mode
> > > [  126.774052] #PF: error_code(0x0000) - not-present page
> > > [  126.774455] PGD 0 P4D 0
> > > [  126.774698] Oops: Oops: 0000 [#1] SMP NOPTI
> > > [  126.775034] CPU: 13 UID: 0 PID: 1612 Comm: kworker/u64:55 Not tain=
ted 6.14.0_blk+ #182 PREEMPT(full)
> > > [  126.775676] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BI=
OS 1.16.3-1.fc39 04/01/2014
> > > [  126.776275] Workqueue: iou_exit io_ring_exit_work
> > > [  126.776651] RIP: 0010:ublk_io_release+0x14/0x130 [ublk_drv]
> > >
> > > Fixes it by always grabbing request reference for aborting the reques=
t.
> > >
> > > Reported-by: Caleb Sander Mateos <csander@purestorage.com>
> > > Closes: https://lore.kernel.org/linux-block/CADUfDZodKfOGUeWrnAxcZiLT=
+puaZX8jDHoj_sfHZCOZwhzz6A@mail.gmail.com/
> > > Fixes: 8284066946e6 ("ublk: grab request reference when the request i=
s handled by userspace")
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/block/ublk_drv.c | 30 ++++++++++++++++++++++++++----
> > >  1 file changed, 26 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index 2fd05c1bd30b..41bed67508f2 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -1140,6 +1140,25 @@ static void ublk_complete_rq(struct kref *ref)
> > >         __ublk_complete_rq(req);
> > >  }
> > >
> > > +static void ublk_do_fail_rq(struct request *req)
> > > +{
> > > +       struct ublk_queue *ubq =3D req->mq_hctx->driver_data;
> > > +
> > > +       if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
> > > +               blk_mq_requeue_request(req, false);
> > > +       else
> > > +               __ublk_complete_rq(req);
> > > +}
> > > +
> > > +static void ublk_fail_rq_fn(struct kref *ref)
> > > +{
> > > +       struct ublk_rq_data *data =3D container_of(ref, struct ublk_r=
q_data,
> > > +                       ref);
> > > +       struct request *req =3D blk_mq_rq_from_pdu(data);
> > > +
> > > +       ublk_do_fail_rq(req);
> > > +}
> > > +
> > >  /*
> > >   * Since ublk_rq_task_work_cb always fails requests immediately duri=
ng
> > >   * exiting, __ublk_fail_req() is only called from abort context duri=
ng
> > > @@ -1153,10 +1172,13 @@ static void __ublk_fail_req(struct ublk_queue=
 *ubq, struct ublk_io *io,
> > >  {
> > >         WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
> > >
> > > -       if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
> > > -               blk_mq_requeue_request(req, false);
> > > -       else
> > > -               ublk_put_req_ref(ubq, req);
> > > +       if (ublk_need_req_ref(ubq)) {
> > > +               struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > > +
> > > +               kref_put(&data->ref, ublk_fail_rq_fn);
> >
> > I think this looks good, just a small question. If __ublk_fail_req()
> > is called but there is at least 1 other reference, ublk_do_fail_rq()
> > won't get called here. When the last reference is dropped, it will
> > call __ublk_complete_rq() instead. That checks for io->flags &
> > UBLK_IO_FLAG_ABORTED and will terminate the I/O with BLK_STS_IOERR.
> > But is that the desired behavior in the
> > ublk_nosrv_should_reissue_outstanding() case? I would think it should
> > call blk_mq_requeue_request() instead.
>
> Good catch, I'd suggest to fix the kernel panic first, and this behavior
> for ublk_nosrv_should_reissue_outstanding() is less serious and can be
> fixed as one followup.
>
> Especially, Uday's approach "[PATCH v3] ublk: improve detection and handl=
ing of ublk server exit"[1]
> may simplify this area lot, with which requests aborting is moved to
> ublk_ch_release() after all uring_cmd are completed. Then we can get
> correct behavior for ublk_nosrv_should_reissue_outstanding() without any
> change basically.

Sounds like a good plan to me.

Thanks,
Caleb
