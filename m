Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438284A04
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744168683; cv=none; b=VfpiI/19qyDBm6KlWC4x4NXtCEV5TsStfct4e9Hj+Kj3IrD20u/9cA6YvNQky2aweE4UrY6wEN1zUISfbHRfs/2nm9k0SXfh8Ymny28WhmeaYtD+AAFBjQGMljAkD4poHCy56qcF8Czd3ZQqA8mPbldR39YBuIgkNaA6Ui5dhOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744168683; c=relaxed/simple;
	bh=i6uliZuGLnCdftmAl8vCOOI9pHuBtlxN4LHLgspC24o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LB/I/K6vPlknn9Semfw67vAOfZ1u04wLl5PIGKTxchDwdbJKKMw/VnVV3tMwQkW21P6HKTFVZm+xcE+gg5HVFw+me1Q1A6kfRDD0YEMd4ONuJy6ctLCJjU1VAVpPtnHow2Hk3DeKCzprNE9Myli1L/r/Wk/8shSGaZNGg++q2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCyS0wty; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCyS0wty"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744168679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YEuET2gm+SF2jpfT+HdOpASrOTd1i+kK8LlJweev2iE=;
	b=HCyS0wtykXp7oOHYVKiR6QPyA+FTPSEdF/mX4pa9p5XLPOo/RQL/nv7YFZxXGIrCkX+Hki
	03+Ij8o4htgHQxcapNrZ2ZTWY2dnX4lB7Bwj6pnahQOk4BA9Rdjgugrz8vPAgZmKq6cl05
	vCNqaa2YUfTKcE8QrMa65c9fvhzxv9o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-ZGnN1FdLNxitZACoDL-9wA-1; Tue,
 08 Apr 2025 23:17:55 -0400
X-MC-Unique: ZGnN1FdLNxitZACoDL-9wA-1
X-Mimecast-MFC-AGG-ID: ZGnN1FdLNxitZACoDL-9wA_1744168674
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 861DB1800349;
	Wed,  9 Apr 2025 03:17:54 +0000 (UTC)
Received: from fedora (unknown [10.72.120.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 759CF180175B;
	Wed,  9 Apr 2025 03:17:49 +0000 (UTC)
Date: Wed, 9 Apr 2025 11:17:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 1/2] ublk: fix handling recovery & reissue in
 ublk_abort_queue()
Message-ID: <Z_Xm2DBIaVrpjwNO@fedora>
References: <20250408072440.1977943-1-ming.lei@redhat.com>
 <20250408072440.1977943-2-ming.lei@redhat.com>
 <CADUfDZrHu=8Muss4zSvdLqq-EVoOE9t9PtqYEm343bTWaA-80g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrHu=8Muss4zSvdLqq-EVoOE9t9PtqYEm343bTWaA-80g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Apr 08, 2025 at 06:47:20PM -0700, Caleb Sander Mateos wrote:
> On Tue, Apr 8, 2025 at 12:25 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Commit 8284066946e6 ("ublk: grab request reference when the request is handled
> > by userspace") doesn't grab request reference in case of recovery reissue.
> > Then the request can be requeued & re-dispatch & failed when canceling
> > uring command.
> >
> > If it is one zc request, the request can be freed before io_uring
> > returns the zc buffer back, then cause kernel panic:
> >
> > [  126.773061] BUG: kernel NULL pointer dereference, address: 00000000000000c8
> > [  126.773657] #PF: supervisor read access in kernel mode
> > [  126.774052] #PF: error_code(0x0000) - not-present page
> > [  126.774455] PGD 0 P4D 0
> > [  126.774698] Oops: Oops: 0000 [#1] SMP NOPTI
> > [  126.775034] CPU: 13 UID: 0 PID: 1612 Comm: kworker/u64:55 Not tainted 6.14.0_blk+ #182 PREEMPT(full)
> > [  126.775676] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39 04/01/2014
> > [  126.776275] Workqueue: iou_exit io_ring_exit_work
> > [  126.776651] RIP: 0010:ublk_io_release+0x14/0x130 [ublk_drv]
> >
> > Fixes it by always grabbing request reference for aborting the request.
> >
> > Reported-by: Caleb Sander Mateos <csander@purestorage.com>
> > Closes: https://lore.kernel.org/linux-block/CADUfDZodKfOGUeWrnAxcZiLT+puaZX8jDHoj_sfHZCOZwhzz6A@mail.gmail.com/
> > Fixes: 8284066946e6 ("ublk: grab request reference when the request is handled by userspace")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 30 ++++++++++++++++++++++++++----
> >  1 file changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 2fd05c1bd30b..41bed67508f2 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1140,6 +1140,25 @@ static void ublk_complete_rq(struct kref *ref)
> >         __ublk_complete_rq(req);
> >  }
> >
> > +static void ublk_do_fail_rq(struct request *req)
> > +{
> > +       struct ublk_queue *ubq = req->mq_hctx->driver_data;
> > +
> > +       if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
> > +               blk_mq_requeue_request(req, false);
> > +       else
> > +               __ublk_complete_rq(req);
> > +}
> > +
> > +static void ublk_fail_rq_fn(struct kref *ref)
> > +{
> > +       struct ublk_rq_data *data = container_of(ref, struct ublk_rq_data,
> > +                       ref);
> > +       struct request *req = blk_mq_rq_from_pdu(data);
> > +
> > +       ublk_do_fail_rq(req);
> > +}
> > +
> >  /*
> >   * Since ublk_rq_task_work_cb always fails requests immediately during
> >   * exiting, __ublk_fail_req() is only called from abort context during
> > @@ -1153,10 +1172,13 @@ static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
> >  {
> >         WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
> >
> > -       if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
> > -               blk_mq_requeue_request(req, false);
> > -       else
> > -               ublk_put_req_ref(ubq, req);
> > +       if (ublk_need_req_ref(ubq)) {
> > +               struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
> > +
> > +               kref_put(&data->ref, ublk_fail_rq_fn);
> 
> I think this looks good, just a small question. If __ublk_fail_req()
> is called but there is at least 1 other reference, ublk_do_fail_rq()
> won't get called here. When the last reference is dropped, it will
> call __ublk_complete_rq() instead. That checks for io->flags &
> UBLK_IO_FLAG_ABORTED and will terminate the I/O with BLK_STS_IOERR.
> But is that the desired behavior in the
> ublk_nosrv_should_reissue_outstanding() case? I would think it should
> call blk_mq_requeue_request() instead.

Good catch, I'd suggest to fix the kernel panic first, and this behavior
for ublk_nosrv_should_reissue_outstanding() is less serious and can be
fixed as one followup.

Especially, Uday's approach "[PATCH v3] ublk: improve detection and handling of ublk server exit"[1]
may simplify this area lot, with which requests aborting is moved to
ublk_ch_release() after all uring_cmd are completed. Then we can get
correct behavior for ublk_nosrv_should_reissue_outstanding() without any
change basically.


[1] https://lore.kernel.org/linux-block/20250403-ublk_timeout-v3-1-aa09f76c7451@purestorage.com/


thanks,
Ming

