Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A8B666
	for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 01:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742864559; cv=none; b=TK4TqJ0PP5DlEt0S+iYdg48sG4GheMuqmQLVSy8DBObS4nTK5XZyo0H26fMBDM9EH2eQb7qsNdza9svKjGBHrNfLzWcobQ7kSbxcwb3t5NILDCxtaGq0QEgfIF3ZtjWzV1gwaaME8Riukhf/HdfOijsvkCUQeHACO8///Utr+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742864559; c=relaxed/simple;
	bh=+fikGX/cgN2K73aVaeNdJ9Ujvgi4A2aOzjn1P0a6CT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMI6loSQxTHSXdkBKSJLwKKwuGMItWhGhlEGsAJGnl9YEqz/3xaynTsO7VkMCho4em+3FwT9W8k85a4BUuAYxFtTyzO7SHUZnwDtuoPJbG+JJphdTUcifBJ3QqYHBifxD6CGz6hkhZd6qaf8xh6u5gkknrypldoBsUWCPMq3E/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGsPoqF9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGsPoqF9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742864556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lnKWA35KcpTzjG5vcUW4BIybJEyFT4m9c5QHe+twDtU=;
	b=VGsPoqF9mfGYDuNBmOuWEkUwUDi0GTiV8vrJ0hDu2KLPgHZVK/GT0s5rlP5BHwxny+gdBC
	1BtFZ7ekVl29LXyo8PKCJG6P5RzyPu8mUY5UwmhFmnt6Mk+avioZUZpKtq403F1z+M/X2m
	8BbVLwGEy4DEJP4suwrydYSru2YKRJY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-pXO81yzcNC6NxqgD6TZmJw-1; Mon,
 24 Mar 2025 21:02:32 -0400
X-MC-Unique: pXO81yzcNC6NxqgD6TZmJw-1
X-Mimecast-MFC-AGG-ID: pXO81yzcNC6NxqgD6TZmJw_1742864551
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A112196B344;
	Tue, 25 Mar 2025 01:02:31 +0000 (UTC)
Received: from fedora (unknown [10.72.120.10])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 964F21801751;
	Tue, 25 Mar 2025 01:02:26 +0000 (UTC)
Date: Tue, 25 Mar 2025 09:02:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 6/8] ublk: implement ->queue_rqs()
Message-ID: <Z-IAnCMySVuIyRYV@fedora>
References: <20250324134905.766777-1-ming.lei@redhat.com>
 <20250324134905.766777-7-ming.lei@redhat.com>
 <Z+GRSWrSvE+bEq8Q@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+GRSWrSvE+bEq8Q@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Mar 24, 2025 at 11:07:21AM -0600, Uday Shankar wrote:
> On Mon, Mar 24, 2025 at 09:49:01PM +0800, Ming Lei wrote:
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
> > 	tools/testing/selftests/ublk/kublk add -t null -q 2 [-z]
> > 
> > 	fio/t/io_uring -p0 /dev/ublkb0
> > 
> > - results:
> > 
> > 	more than 10% IOPS boost observed
> 
> Nice!
> 
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
> >  	struct ublk_queue *ubq;
> >  	u16 tag;
> > +	struct rq_list list;
> >  };
> 
> I think you'll have a hole after tag here and end up eating the full 32
> bytes on x86_64. Maybe put list before tag to leave a bit of space for
> some small fields?

Actually here the rq_list member can share space with `tag` or even `ubq`,
will do that in next version.

> 
> Separately I think we should try to consolidate all the per-IO state. It
> is currently split across struct io_uring_cmd PDU, struct request and
> its PDU, and struct ublk_io. Maybe we can store everything in struct
> ublk_io and just put pointers to that where needed.

It is two things between uring_cmd and request:

1) io_uring_cmd & ublk_io has longer lifetime than request, since the command
covers both request delivery and notification, for the latter, there isn't
request yet for this slot.

2) in this case, it has to be put into command payload because io_uring
knows nothing about request, we need to retrieve request or ublk_io from
uring_cmd payload

3) both ublk_io and request payload are pre-allocation, which should be
avoided asap, so I think it may not be good to put everything into ublk_io.

> 
> >  
> >  /*
> > @@ -1258,6 +1259,32 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
> >  	io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
> >  }
> >  
> > +static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
> > +		unsigned int issue_flags)
> > +{
> > +	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > +	struct ublk_queue *ubq = pdu->ubq;
> > +	struct request *rq;
> > +
> > +	while ((rq = rq_list_pop(&pdu->list))) {
> > +		struct ublk_io *io = &ubq->ios[rq->tag];
> > +
> > +		ublk_rq_task_work_cb(io->cmd, issue_flags);
> 
> Maybe rename to ublk_dispatch_one_rq or similar?

ublk_rq_task_work_cb() is used as uring_cmd callback in case
of ->queue_rq()...

> 
> > +	}
> > +}
> > +
> > +static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
> > +{
> > +	struct request *rq = l->head;
> > +	struct ublk_io *io = &ubq->ios[rq->tag];
> > +	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(io->cmd);
> > +
> > +	pdu->ubq = ubq;
> > +	pdu->list = *l;
> > +	rq_list_init(l);
> > +	io_uring_cmd_complete_in_task(io->cmd, ublk_cmd_list_tw_cb);
> > +}
> > +
> >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> >  {
> >  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> > @@ -1296,16 +1323,13 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> >  	return BLK_EH_RESET_TIMER;
> >  }
> >  
> > -static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> > -		const struct blk_mq_queue_data *bd)
> > +static blk_status_t ublk_prep_rq_batch(struct request *rq)
> >  {
> > -	struct ublk_queue *ubq = hctx->driver_data;
> > -	struct request *rq = bd->rq;
> > +	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> >  	blk_status_t res;
> >  
> > -	if (unlikely(ubq->fail_io)) {
> > +	if (unlikely(ubq->fail_io))
> >  		return BLK_STS_TARGET;
> > -	}
> >  
> >  	/* fill iod to slot in io cmd buffer */
> >  	res = ublk_setup_iod(ubq, rq);
> > @@ -1324,17 +1348,58 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> >  	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
> >  		return BLK_STS_IOERR;
> >  
> > +	if (unlikely(ubq->canceling))
> > +		return BLK_STS_IOERR;
> > +
> > +	blk_mq_start_request(rq);
> > +	return BLK_STS_OK;
> > +}
> > +
> > +static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> > +		const struct blk_mq_queue_data *bd)
> > +{
> > +	struct ublk_queue *ubq = hctx->driver_data;
> > +	struct request *rq = bd->rq;
> > +	blk_status_t res;
> > +
> >  	if (unlikely(ubq->canceling)) {
> >  		__ublk_abort_rq(ubq, rq);
> >  		return BLK_STS_OK;
> >  	}
> >  
> > -	blk_mq_start_request(bd->rq);
> > -	ublk_queue_cmd(ubq, rq);
> > +	res = ublk_prep_rq_batch(rq);
> > +	if (res != BLK_STS_OK)
> > +		return res;
> >  
> > +	ublk_queue_cmd(ubq, rq);
> >  	return BLK_STS_OK;
> >  }
> >  
> > +static void ublk_queue_rqs(struct rq_list *rqlist)
> > +{
> > +	struct rq_list requeue_list = { };
> > +	struct rq_list submit_list = { };
> > +	struct ublk_queue *ubq = NULL;
> > +	struct request *req;
> > +
> > +	while ((req = rq_list_pop(rqlist))) {
> > +		struct ublk_queue *this_q = req->mq_hctx->driver_data;
> > +
> > +		if (ubq && ubq != this_q && !rq_list_empty(&submit_list))
> > +			ublk_queue_cmd_list(ubq, &submit_list);
> > +		ubq = this_q;
> > +
> > +		if (ublk_prep_rq_batch(req) == BLK_STS_OK)
> > +			rq_list_add_tail(&submit_list, req);
> > +		else
> > +			rq_list_add_tail(&requeue_list, req);
> > +	}
> > +
> > +	if (ubq && !rq_list_empty(&submit_list))
> > +		ublk_queue_cmd_list(ubq, &submit_list);
> > +	*rqlist = requeue_list;
> > +}
> > +
> >  static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
> >  		unsigned int hctx_idx)
> >  {
> > @@ -1347,6 +1412,7 @@ static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
> >  
> >  static const struct blk_mq_ops ublk_mq_ops = {
> >  	.queue_rq       = ublk_queue_rq,
> > +	.queue_rqs      = ublk_queue_rqs,
> >  	.init_hctx	= ublk_init_hctx,
> >  	.timeout	= ublk_timeout,
> >  };
> > @@ -3147,6 +3213,9 @@ static int __init ublk_init(void)
> >  	BUILD_BUG_ON((u64)UBLKSRV_IO_BUF_OFFSET +
> >  			UBLKSRV_IO_BUF_TOTAL_SIZE < UBLKSRV_IO_BUF_OFFSET);
> >  
> > +	BUILD_BUG_ON(sizeof(struct ublk_uring_cmd_pdu) >
> > +			sizeof_field(struct io_uring_cmd, pdu));
> > +
> 
> Consider putting this near the struct ublk_uring_cmd_pdu definition or
> in ublk_get_uring_cmd_pdu. There are helpers provided by io_uring
> (io_uring_cmd_private_sz_check and io_uring_cmd_to_pdu) you can use.

Yeah, we can do it, but looks the practice is to add build check in
init fn.

Thanks,
Ming

