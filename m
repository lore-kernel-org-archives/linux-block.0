Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD30AD55
	for <linux-block@vger.kernel.org>; Sun,  6 Oct 2024 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728206423; cv=none; b=JSLvk+0G70/vAc/KEigFNkFC1Z61GvX342w3zJVegR8z+nGeUt/Sxc/hSkHrBKs6aoALqbg3UB8RFf6MKNB/fhb5lU8MrcipaRgPiAvWWf8a3OcYu4V2fZaNaB8kA/03qqeTjlmY+eu5TXvtyIkpaPsQm+2xLSpXoW5UIeZYR1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728206423; c=relaxed/simple;
	bh=Y3c0u/i3lr4uuuTlQB559jEQPsXE4LfQN7zr7ELsmuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3qY0vFcjUlonbKlHAFnWFP59qhM3RC4jZ/iEvKklvKn0BTjUns5rvalLZxpnVYc3ehG2hSJOikq4K8vHFXgFYo0EgEoyUK5/GZOOcJCz/uTWpk2iY69NJeltT0XnhYqF82WPpulCweM+VRnu50StLJKq5yHPJVBVWoCfNI7HVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GdhIIdQ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdhIIdQ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728206419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZuyYwPp3wvMN5nhY7zUJBn2onf2TTorcSDP1HlwOoM8=;
	b=GdhIIdQ6to5vcMN0yGCDoa/QyiocjnlRUlslRCYY+IAHUm1t9irlgcSyOtP+DNgBcT5mbD
	34aITouBnDztxpNQQMyFfhumLRIAn+tAJWJonPeMO4AZb5nJjNOXOxOPhyEZ2ClWk5XvA4
	snKcvpEgZUWgawe1m30ur7wNeUMlF+g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-RuUSzXAFNGu0g-pGa2_87w-1; Sun,
 06 Oct 2024 05:20:17 -0400
X-MC-Unique: RuUSzXAFNGu0g-pGa2_87w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E475F195FE07;
	Sun,  6 Oct 2024 09:20:15 +0000 (UTC)
Received: from fedora (unknown [10.72.116.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36BB919560A2;
	Sun,  6 Oct 2024 09:20:11 +0000 (UTC)
Date: Sun, 6 Oct 2024 17:20:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH] ublk: decouple hctx and ublk server threads
Message-ID: <ZwJWRSBnH7Cm3djA@fedora>
References: <20241002224437.3088981-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002224437.3088981-1-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Oct 02, 2024 at 04:44:37PM -0600, Uday Shankar wrote:
> Currently, ublk_drv associates to each hardware queue (hctx) a unique
> task (called the queue's ubq_daemon) which is allowed to issue
> COMMIT_AND_FETCH commands against the hctx. If any other task attempts
> to do so, the command fails immediately with EINVAL. When considered
> together with the block layer architecture, the result is that for each
> CPU C on the system, there is a unique ublk server thread which is
> allowed to handle I/O submitted on CPU C. This can lead to suboptimal
> performance under imbalanced load generation. For an extreme example,
> suppose all the load is generated on CPUs mapping to a single ublk
> server thread. Then that thread may be fully utilized and become the
> bottleneck in the system, while other ublk server threads are totally
> idle.

I am wondering why the problem can't be avoided by setting ublk server's
thread affinity manually.

> 
> This issue can also be addressed directly in the ublk server without
> kernel support by having threads dequeue I/Os and pass them around to
> ensure even load. But this solution involves moving I/Os between threads
> several times. This is a bad pattern for performance, and we observed a
> significant regression in peak bandwidth with this solution.
> 
> Therefore, address this issue by removing the association of a unique
> ubq_daemon to each hctx. This association is fairly artificial anyways,
> and removing it results in simpler driver code. Imbalanced load can then

I did consider to remove the association from simplifying design &
implementation viewpoint, but there are some problems which are hard to solve.

> be balanced across all ublk server threads by having the threads fetch
> I/Os for the same QID in a round robin manner. For example, in a system
> with 4 ublk server threads, 2 hctxs, and a queue depth of 4, the threads
> could issue fetch requests as follows (where each entry is of the form
> qid, tag):
> 
> poller thread:	T0	T1	T2	T3
> 		0,0	0,1	0,2	0,3
> 		1,3	1,0	1,1	1,2

How many ublk devices there are? If it is 1, just wondering why you use
4 threads? Usually one thread is enough to drive one queue, and the
actually io command handling can be moved to new work thread if the queue
thread is saturated.

> 
> Since tags appear to be allocated in sequential chunks, this provides a
> rough approximation to distributing I/Os round-robin across all ublk
> server threads, while letting I/Os stay fully thread-local.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 105 ++++++++++++---------------------------
>  1 file changed, 33 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index a6c8e5cc6051..7e0ce35dbc6f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -68,12 +68,12 @@
>  	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
>  
>  struct ublk_rq_data {
> -	struct llist_node node;
> -
> +	struct task_struct *task;
>  	struct kref ref;
>  };
>  
>  struct ublk_uring_cmd_pdu {
> +	struct request *req;
>  	struct ublk_queue *ubq;
>  	u16 tag;
>  };
> @@ -133,15 +133,11 @@ struct ublk_queue {
>  	int q_depth;
>  
>  	unsigned long flags;
> -	struct task_struct	*ubq_daemon;
>  	char *io_cmd_buf;
>  
> -	struct llist_head	io_cmds;
> -
>  	unsigned long io_addr;	/* mapped vm address */
>  	unsigned int max_io_sz;
>  	bool force_abort;
> -	bool timeout;
>  	bool canceling;
>  	unsigned short nr_io_ready;	/* how many ios setup */
>  	spinlock_t		cancel_lock;
> @@ -982,16 +978,12 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
>  	return (struct ublk_uring_cmd_pdu *)&ioucmd->pdu;
>  }
>  
> -static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
> -{
> -	return ubq->ubq_daemon->flags & PF_EXITING;
> -}
> -
>  /* todo: handle partial completion */
>  static inline void __ublk_complete_rq(struct request *req)
>  {
>  	struct ublk_queue *ubq = req->mq_hctx->driver_data;
>  	struct ublk_io *io = &ubq->ios[req->tag];
> +	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
>  	unsigned int unmapped_bytes;
>  	blk_status_t res = BLK_STS_OK;
>  
> @@ -1036,9 +1028,13 @@ static inline void __ublk_complete_rq(struct request *req)
>  	else
>  		__blk_mq_end_request(req, BLK_STS_OK);
>  
> -	return;
> +	goto put_task;
>  exit:
>  	blk_mq_end_request(req, res);
> +put_task:
> +	WARN_ON_ONCE(!data->task);
> +	put_task_struct(data->task);
> +	data->task = NULL;
>  }
>  
>  static void ublk_complete_rq(struct kref *ref)
> @@ -1097,13 +1093,16 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
>  		blk_mq_end_request(rq, BLK_STS_IOERR);
>  }
>  
> -static inline void __ublk_rq_task_work(struct request *req,
> +static inline void __ublk_rq_task_work(struct io_uring_cmd *cmd,
>  				       unsigned issue_flags)
>  {
> +	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> +	struct request *req = pdu->req;
>  	struct ublk_queue *ubq = req->mq_hctx->driver_data;
>  	int tag = req->tag;
>  	struct ublk_io *io = &ubq->ios[tag];
>  	unsigned int mapped_bytes;
> +	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
>  
>  	pr_devel("%s: complete: op %d, qid %d tag %d io_flags %x addr %llx\n",
>  			__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags,
> @@ -1112,13 +1111,14 @@ static inline void __ublk_rq_task_work(struct request *req,
>  	/*
>  	 * Task is exiting if either:
>  	 *
> -	 * (1) current != ubq_daemon.
> +	 * (1) current != io_uring_get_cmd_task(io->cmd).
>  	 * io_uring_cmd_complete_in_task() tries to run task_work
> -	 * in a workqueue if ubq_daemon(cmd's task) is PF_EXITING.
> +	 * in a workqueue if cmd's task is PF_EXITING.
>  	 *
>  	 * (2) current->flags & PF_EXITING.
>  	 */
> -	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
> +	if (unlikely(current != io_uring_cmd_get_task(io->cmd) ||
> +		     current->flags & PF_EXITING)) {
>  		__ublk_abort_rq(ubq, req);
>  		return;
>  	}
> @@ -1173,55 +1173,32 @@ static inline void __ublk_rq_task_work(struct request *req,
>  	}
>  
>  	ublk_init_req_ref(ubq, req);
> +	WARN_ON_ONCE(data->task);
> +	data->task = get_task_struct(current);

If queue/task association is killed, it doesn't make sense to record the
->task any more, cause this io command can be handled by another thread
in userspace, then UBLK_IO_COMMIT_AND_FETCH_REQ for this io request may
be issued from task which isn't same with data->task.

The main trouble is that error handling can't be done easily.

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
> -
> -		io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
> -	}
> +	struct ublk_io *io = &ubq->ios[rq->tag];
> +	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(io->cmd);
> +	pdu->req = rq;
> +	io_uring_cmd_complete_in_task(io->cmd, __ublk_rq_task_work);
>  }

It should be fine to convert to io_uring_cmd_complete_in_task() since
the callback list is re-ordered in io_uring.

>  
>  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  {
>  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> +	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
>  	unsigned int nr_inflight = 0;
>  	int i;
>  
>  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> -		if (!ubq->timeout) {
> -			send_sig(SIGKILL, ubq->ubq_daemon, 0);
> -			ubq->timeout = true;
> -		}
> -
> +		send_sig(SIGKILL, data->task, 0);
>  		return BLK_EH_DONE;
>  	}
>  
> -	if (!ubq_daemon_is_dying(ubq))
> +	if (!(data->task->flags & PF_EXITING))
>  		return BLK_EH_RESET_TIMER;

->task is only for error handling, but it may not work any more since
who knows which task is for handling the io command actually.


Thanks, 
Ming

