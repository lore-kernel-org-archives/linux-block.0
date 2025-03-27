Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA01AA1EC
	for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743066920; cv=none; b=bhT2/xE3temyjVQfa6eQ2V4nnOpdX0ajxrd/+LB8k/YQ1QknYMN4yvtZ16wgzmbsorGjcAB8FDo6KNPR3bzLHwqRasuytsl8RF/O5agRQHzJacBl2jM+UbEraImUfhYZTj5QWtnX6JgiqgJho52C6sRzX7IvoCnyIWG3F09yxaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743066920; c=relaxed/simple;
	bh=djee+di04yZBFwl+F3QWoQdG90JEm9rgGCQOnY6YL+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgzpZneUx2mWiWRnGvoCZ0cIxKmPD+Dz3DcxbyVzAZTk2LYl49+oq+xWGBEjMnR1xx6xTcPqycF/1oFFMhcGnZI5LG6T9CNYkbX5RsVYwbtx6bGetnIVTCX4nuq+wuHLVp7F8zjzTJKErwcU1CiINuIEkzHW6y+UmyVOhZEp+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UiBMXkZm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiBMXkZm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743066917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYpCX3dTRET9uPtyNLxmyLYbWpwbW4iCsKvLSZ78gqE=;
	b=UiBMXkZmnOgvq4moMjoEGsZkh6BIvXiVcK5wzAZVfDE1HagSxbAERdv/LjpEiwa8GsWkHM
	tsq3UYV9MsmcR0ZEP2AiDIKeCb3Rr0NXRdIoTKtIAOky2Pv7w2ga4tzK47c/1jCBWC2Uqw
	7Zu2DRPvbxkBY8ldLALwUOdx7k9j0G8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-gqHyk2_gNk2GsayKaKX25Q-1; Thu,
 27 Mar 2025 05:15:15 -0400
X-MC-Unique: gqHyk2_gNk2GsayKaKX25Q-1
X-Mimecast-MFC-AGG-ID: gqHyk2_gNk2GsayKaKX25Q_1743066913
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 153FC1801A07;
	Thu, 27 Mar 2025 09:15:13 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57ED21955D81;
	Thu, 27 Mar 2025 09:15:07 +0000 (UTC)
Date: Thu, 27 Mar 2025 17:15:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 6/8] ublk: implement ->queue_rqs()
Message-ID: <Z-UXFu6q1apYYUBb@fedora>
References: <20250324134905.766777-1-ming.lei@redhat.com>
 <20250324134905.766777-7-ming.lei@redhat.com>
 <CADUfDZoBTkNypLXsVFMsZLSJGw3i7VxnQ=POodmYm=E4HPU=SA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoBTkNypLXsVFMsZLSJGw3i7VxnQ=POodmYm=E4HPU=SA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Mar 26, 2025 at 02:30:56PM -0700, Caleb Sander Mateos wrote:
> On Mon, Mar 24, 2025 at 6:49 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Implement ->queue_rqs() for improving perf in case of MQ.
> >
> > In this way, we just need to call io_uring_cmd_complete_in_task() once for
> > one batch, then both io_uring and ublk server can get exact batch from
> > client side.
> >
> > Follows IOPS improvement:
> >
> > - tests
> >
> >         tools/testing/selftests/ublk/kublk add -t null -q 2 [-z]
> >
> >         fio/t/io_uring -p0 /dev/ublkb0
> >
> > - results:
> >
> >         more than 10% IOPS boost observed
> >
> > Pass all ublk selftests, especially the io dispatch order test.
> >
> > Cc: Uday Shankar <ushankar@purestorage.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 85 ++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 77 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 53a463681a41..86621fde7fde 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -83,6 +83,7 @@ struct ublk_rq_data {
> >  struct ublk_uring_cmd_pdu {
> >         struct ublk_queue *ubq;
> >         u16 tag;
> > +       struct rq_list list;
> >  };
> >
> >  /*
> > @@ -1258,6 +1259,32 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
> >         io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
> >  }
> >
> > +static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
> > +               unsigned int issue_flags)
> > +{
> > +       struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > +       struct ublk_queue *ubq = pdu->ubq;
> > +       struct request *rq;
> > +
> > +       while ((rq = rq_list_pop(&pdu->list))) {
> > +               struct ublk_io *io = &ubq->ios[rq->tag];
> > +
> > +               ublk_rq_task_work_cb(io->cmd, issue_flags);
> 
> ublk_rq_task_work_cb() is duplicating the lookup of ubq, rq, and io.
> Could you factor out a helper that takes those values instead of cmd?
> 
> > +       }
> > +}
> > +
> > +static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
> > +{
> > +       struct request *rq = l->head;
> > +       struct ublk_io *io = &ubq->ios[rq->tag];
> > +       struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(io->cmd);
> > +
> > +       pdu->ubq = ubq;
> 
> Why does pdu->ubq need to be set here but not in ublk_queue_cmd()? I
> would have thought it would already be set to ubq because pdu comes
> from a rq belonging to this ubq.
> 
> > +       pdu->list = *l;
> > +       rq_list_init(l);
> > +       io_uring_cmd_complete_in_task(io->cmd, ublk_cmd_list_tw_cb);
> 
> Could store io->cmd in a variable to avoid looking it up twice.
> 
> > +}
> > +
> >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> >  {
> >         struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> > @@ -1296,16 +1323,13 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> >         return BLK_EH_RESET_TIMER;
> >  }
> >
> > -static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> > -               const struct blk_mq_queue_data *bd)
> > +static blk_status_t ublk_prep_rq_batch(struct request *rq)
> 
> naming nit: why "batch"?

All were handled in my local version.

> 
> >  {
> > -       struct ublk_queue *ubq = hctx->driver_data;
> > -       struct request *rq = bd->rq;
> > +       struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> >         blk_status_t res;
> >
> > -       if (unlikely(ubq->fail_io)) {
> > +       if (unlikely(ubq->fail_io))
> >                 return BLK_STS_TARGET;
> > -       }
> >
> >         /* fill iod to slot in io cmd buffer */
> >         res = ublk_setup_iod(ubq, rq);
> > @@ -1324,17 +1348,58 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> >         if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
> >                 return BLK_STS_IOERR;
> >
> > +       if (unlikely(ubq->canceling))
> > +               return BLK_STS_IOERR;
> 
> Why is ubq->cancelling treated differently for ->queue_rq() vs. ->queue_rqs()?

It is same, just ublk_queue_rqs() becomes simpler by letting ->queue_rqs()
to handle ubq->canceling.

Here it is really something which need to comment for ubq->canceling
handling, which has to be done after ->fail_io/->force_abort is dealt
with, otherwise IO hang is caused when removing disk.

That is one bug introduced in this patch.

> 
> > +
> > +       blk_mq_start_request(rq);
> > +       return BLK_STS_OK;
> > +}
> > +
> > +static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> > +               const struct blk_mq_queue_data *bd)
> > +{
> > +       struct ublk_queue *ubq = hctx->driver_data;
> > +       struct request *rq = bd->rq;
> > +       blk_status_t res;
> > +
> >         if (unlikely(ubq->canceling)) {
> >                 __ublk_abort_rq(ubq, rq);
> >                 return BLK_STS_OK;
> >         }
> >
> > -       blk_mq_start_request(bd->rq);
> > -       ublk_queue_cmd(ubq, rq);
> > +       res = ublk_prep_rq_batch(rq);
> > +       if (res != BLK_STS_OK)
> > +               return res;
> >
> > +       ublk_queue_cmd(ubq, rq);
> >         return BLK_STS_OK;
> >  }
> >
> > +static void ublk_queue_rqs(struct rq_list *rqlist)
> > +{
> > +       struct rq_list requeue_list = { };
> > +       struct rq_list submit_list = { };
> > +       struct ublk_queue *ubq = NULL;
> > +       struct request *req;
> > +
> > +       while ((req = rq_list_pop(rqlist))) {
> > +               struct ublk_queue *this_q = req->mq_hctx->driver_data;
> > +
> > +               if (ubq && ubq != this_q && !rq_list_empty(&submit_list))
> > +                       ublk_queue_cmd_list(ubq, &submit_list);
> > +               ubq = this_q;
> 
> Probably could avoid the extra ->driver_data dereference on every rq
> by comparing the mq_hctx pointers instead. The ->driver_data
> dereference could be moved to the ublk_queue_cmd_list() calls.

Yes.

> 
> > +
> > +               if (ublk_prep_rq_batch(req) == BLK_STS_OK)
> > +                       rq_list_add_tail(&submit_list, req);
> > +               else
> > +                       rq_list_add_tail(&requeue_list, req);
> > +       }
> > +
> > +       if (ubq && !rq_list_empty(&submit_list))
> > +               ublk_queue_cmd_list(ubq, &submit_list);
> > +       *rqlist = requeue_list;
> > +}
> > +
> >  static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
> >                 unsigned int hctx_idx)
> >  {
> > @@ -1347,6 +1412,7 @@ static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
> >
> >  static const struct blk_mq_ops ublk_mq_ops = {
> >         .queue_rq       = ublk_queue_rq,
> > +       .queue_rqs      = ublk_queue_rqs,
> >         .init_hctx      = ublk_init_hctx,
> >         .timeout        = ublk_timeout,
> >  };
> > @@ -3147,6 +3213,9 @@ static int __init ublk_init(void)
> >         BUILD_BUG_ON((u64)UBLKSRV_IO_BUF_OFFSET +
> >                         UBLKSRV_IO_BUF_TOTAL_SIZE < UBLKSRV_IO_BUF_OFFSET);
> >
> > +       BUILD_BUG_ON(sizeof(struct ublk_uring_cmd_pdu) >
> > +                       sizeof_field(struct io_uring_cmd, pdu));
> 
> Looks like Uday also suggested this, but if you change
> ublk_get_uring_cmd_pdu() to use io_uring_cmd_to_pdu(), you get this
> check for free.

I have followed Uday's suggestion to patch ublk_get_uring_cmd_pdu(),
and will send out v2 soon.

Thanks,
Ming

