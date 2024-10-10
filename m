Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ED841C6D
	for <linux-block@vger.kernel.org>; Thu, 10 Oct 2024 03:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531922; cv=none; b=F4d/HobHYTyOCWsdPYC/cl35HZwmn9q2krg64lkfLdVBOycbqHXwuX4aZAv+JzDU3DLkEieVyBr1vhOw+mmFKmSef2DH0kiyohT4SzeiHAV73MMg05aVMX4oT+51IYW0cmUEX6Jx08q+EwhfcOKSmKK47vo/EkJIh6H9ve84V1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531922; c=relaxed/simple;
	bh=kn4Wgktj2FvTSyd5R7ibFs3CJ+s8N2XLjPYQSgVt3Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAk7W4jTvRv7A0MGhZ/FoYwrpJIi+QJQg78iDldtOv5tBYk9gh8L25y4HDLR4zT2XM+5U3rMa7CMkAMmx3x9bOysEQi/isXpy6r9mP6m6TkpX8y9S3rCTifYFb97z/hxilX0jJhZYm7Th38VVhp7j5Jq9eWgZwcK5r7mrfx/jYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xfimd90c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xfimd90c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728531916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5sNxcMlIhWGFTrOylTyLDRy3LKoz7v6/OxWv44OoO8=;
	b=Xfimd90cFe1wpXxeVTeJ2BJzmnBVD1YovYDhlDExa+Ynj8pljr9V/ZNzx42E2v1R0r9duT
	Af51RfI2rOkdDISqw3sKtwbyurBdOopXllOoqyZOefs3H/oa0CGVDRxzCLssLPfykfwgnH
	1AwO9wGjEYwNKtndesf6aX5tXBYo7vE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-56GBUZLNPw2Hc8USf_SBFQ-1; Wed,
 09 Oct 2024 23:45:13 -0400
X-MC-Unique: 56GBUZLNPw2Hc8USf_SBFQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FCF11955EE7;
	Thu, 10 Oct 2024 03:45:12 +0000 (UTC)
Received: from fedora (unknown [10.72.116.47])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D9E21956089;
	Thu, 10 Oct 2024 03:45:09 +0000 (UTC)
Date: Thu, 10 Oct 2024 11:45:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: eliminate unnecessary io_cmds queue
Message-ID: <ZwdNvyXdXbsCf9MF@fedora>
References: <20241009193700.3438201-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009193700.3438201-1-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Oct 09, 2024 at 01:37:00PM -0600, Uday Shankar wrote:
> Currently, ublk_drv maintains a per-hctx queue of requests awaiting
> dispatch to the ublk server, and pokes the ubq_daemon to come pick them
> up via the task_work mechanism when needed. But task_work already
> supports internal (lockless) queueing. Reuse this queueing mechanism
> (i.e. have one task_work queue item per request awaiting dispatch)
> instead of maintaining our own queue in ublk_drv.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 34 ++++++----------------------------
>  1 file changed, 6 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 60f6d86ea1e6..2ea108347ec4 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -80,6 +80,7 @@ struct ublk_rq_data {
>  
>  struct ublk_uring_cmd_pdu {
>  	struct ublk_queue *ubq;
> +	struct request *req;
>  	u16 tag;
>  };

I'd suggest to add the following build check in init function since there is
only 32bytes in uring_cmd pdu:

	BUILD_BUG_ON(sizeof(ublk_uring_cmd_pdu) < sizeof_field(io_uring_cmd, pud))

>  
> @@ -141,8 +142,6 @@ struct ublk_queue {
>  	struct task_struct	*ubq_daemon;
>  	char *io_cmd_buf;
>  
> -	struct llist_head	io_cmds;
> -
>  	unsigned long io_addr;	/* mapped vm address */
>  	unsigned int max_io_sz;
>  	bool force_abort;
> @@ -1132,9 +1131,10 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
>  		blk_mq_end_request(rq, BLK_STS_IOERR);
>  }
>  
> -static inline void __ublk_rq_task_work(struct request *req,
> +static inline void __ublk_rq_task_work(struct io_uring_cmd *cmd,
>  				       unsigned issue_flags)

`inline` can be removed and __ublk_rq_task_work() can be named as
ublk_rq_task_work() now.

>  {
> +	struct request *req = ublk_get_uring_cmd_pdu(cmd)->req;
>  	struct ublk_queue *ubq = req->mq_hctx->driver_data;
>  	int tag = req->tag;
>  	struct ublk_io *io = &ubq->ios[tag];
> @@ -1211,34 +1211,12 @@ static inline void __ublk_rq_task_work(struct request *req,
>  	ubq_complete_io_cmd(io, UBLK_IO_RES_OK, issue_flags);
>  }
>  
> -static inline void ublk_forward_io_cmds(struct ublk_queue *ubq,
> -					unsigned issue_flags)
> -{
> -	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
> -	struct ublk_rq_data *data, *tmp;
> -
> -	io_cmds = llist_reverse_order(io_cmds);
> -	llist_for_each_entry_safe(data, tmp, io_cmds, node)
> -		__ublk_rq_task_work(blk_mq_rq_from_pdu(data), issue_flags);
> -}
> -
> -static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd, unsigned issue_flags)
> -{
> -	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> -	struct ublk_queue *ubq = pdu->ubq;
> -
> -	ublk_forward_io_cmds(ubq, issue_flags);
> -}
> -
>  static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
>  {
> -	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
> -
> -	if (llist_add(&data->node, &ubq->io_cmds)) {
> -		struct ublk_io *io = &ubq->ios[rq->tag];
> +	struct ublk_io *io = &ubq->ios[rq->tag];
>  
> -		io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
> -	}
> +	ublk_get_uring_cmd_pdu(io->cmd)->req = rq;
> +	io_uring_cmd_complete_in_task(io->cmd, __ublk_rq_task_work);
>  }

I'd suggest to comment that io_uring_cmd_complete_in_task() needs to
maintain io command order.

Otherwise this patch looks fine.


Thanks,
Ming

