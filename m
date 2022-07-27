Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31666C00144
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 02:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiG0CFi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 22:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiG0CFh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 22:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 012063120A
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 19:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658887534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NhmINLxqah7ubdIPQrsLCJl+iFle+791nb4zG8AoIMk=;
        b=LBRBEVZcOTviQFr1YsO9r/cCFRGoEy1oYBMDsDOunGiTWkK3S0iRy7Z7pUcornxOekO3LF
        RVso84Sm0PKWx8jNQZL6jPrmKi7lOcH0keUo/pFhgmLqISEF+IJV4RG558/YIUG2feS2dt
        3xoTdfWaP/U/1uPa52sBsgdN0HERN1A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-nWL593S6PLyxJ-9vafi4Rw-1; Tue, 26 Jul 2022 22:05:31 -0400
X-MC-Unique: nWL593S6PLyxJ-9vafi4Rw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D6C985A581;
        Wed, 27 Jul 2022 02:05:31 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 709C540CF8EE;
        Wed, 27 Jul 2022 02:05:26 +0000 (UTC)
Date:   Wed, 27 Jul 2022 10:05:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
Subject: Re: [PATCH V2 2/2] ublk_drv: add support for UBLK_IO_NEED_GET_DATA
Message-ID: <YuCdYsWw9+k7nCAF@T590>
References: <20220726114405.116013-1-ZiyangZhang@linux.alibaba.com>
 <20220726114405.116013-3-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726114405.116013-3-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 26, 2022 at 07:44:05PM +0800, ZiyangZhang wrote:
> UBLK_IO_NEED_GET_DATA is one ublk IO command. It is designed for a user
> application who wants to allocate IO buffer and set IO buffer address
> only after it receives an IO request from ublksrv. This is a reasonable
> scenario because these users may use a RPC framework as one IO backend
> to handle IO requests passed from ublksrv. And a RPC framework may
> allocate its own buffer(or memory pool).
> 
> This new feature (UBLK_F_NEED_GET_DATA) is optional for ublk users.
> Related userspace code has been added in ublksrv[1] as one pull request.
> 
> Test cases for this feature are added in ublksrv and all the tests pass.
> The performance result shows that this new feature does bring additional
> latency because one IO is issued back to ublk_drv once again to copy data
> from bio vectors to user-provided data buffer. UBLK_IO_NEED_GET_DATA is
> suitable for bigger block size such as 512B or 1MB.
> 
> [1] https://github.com/ming1/ubdsrv
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---
>  drivers/block/ublk_drv.c | 88 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 79 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 255b2de46a24..c2d2cd5ab25c 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -47,7 +47,9 @@
>  #define UBLK_MINORS		(1U << MINORBITS)
>  
>  /* All UBLK_F_* have to be included into UBLK_F_ALL */
> -#define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_URING_CMD_COMP_IN_TASK)
> +#define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY \
> +		| UBLK_F_URING_CMD_COMP_IN_TASK \
> +		| UBLK_F_NEED_GET_DATA)
>  
>  struct ublk_rq_data {
>  	struct callback_head work;
> @@ -86,6 +88,15 @@ struct ublk_uring_cmd_pdu {
>   */
>  #define UBLK_IO_FLAG_ABORTED 0x04
>  
> +/*
> + * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
> + * get data buffer address from ublksrv.
> + *
> + * Then, bio data could be copied into this data buffer for a WRITE request
> + * after the IO command is issued again and UBLK_IO_FLAG_NEED_GET_DATA is unset.
> + */
> +#define UBLK_IO_FLAG_NEED_GET_DATA 0x08
> +
>  struct ublk_io {
>  	/* userspace buffer address from io cmd */
>  	__u64	addr;
> @@ -163,11 +174,19 @@ static struct miscdevice ublk_misc;
>  static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
>  {
>  	if (IS_BUILTIN(CONFIG_BLK_DEV_UBLK) &&
> +			!(ubq->flags & UBLK_F_NEED_GET_DATA) &&
>  			!(ubq->flags & UBLK_F_URING_CMD_COMP_IN_TASK))
>  		return true;
>  	return false;

NEED_GET_DATA isn't related with using task work.

That said if use task work return true, you use task work to handle
GET_DATA, otherwise use io_uring_cmd_complete_in_task() to handle
it, then either we use task work or use io_uring_cmd_complete_in_task,
not mix the two.

BTW, in my test, it is observed reliably that task work can get better iops.

>  }
>  
> +static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
> +{
> +	if (ubq->flags & UBLK_F_NEED_GET_DATA)
> +		return true;
> +	return false;
> +}
> +
>  static struct ublk_device *ublk_get_device(struct ublk_device *ub)
>  {
>  	if (kobject_get_unless_zero(&ub->cdev_dev.kobj))
> @@ -509,6 +528,21 @@ static void __ublk_fail_req(struct ublk_io *io, struct request *req)
>  	}
>  }
>  
> +static void ubq_complete_io_cmd(struct ublk_io *io, int res)
> +{
> +	/* mark this cmd owned by ublksrv */
> +	io->flags |= UBLK_IO_FLAG_OWNED_BY_SRV;
> +
> +	/*
> +	 * clear ACTIVE since we are done with this sqe/cmd slot
> +	 * We can only accept io cmd in case of being not active.
> +	 */
> +	io->flags &= ~UBLK_IO_FLAG_ACTIVE;
> +
> +	/* tell ublksrv one io request is coming */
> +	io_uring_cmd_done(io->cmd, res, 0);
> +}
> +
>  #define UBLK_REQUEUE_DELAY_MS	3
>  
>  static inline void __ublk_rq_task_work(struct request *req)
> @@ -531,6 +565,20 @@ static inline void __ublk_rq_task_work(struct request *req)
>  		return;
>  	}
>  
> +	if (ublk_need_get_data(ubq) &&
> +			(req_op(req) == REQ_OP_WRITE ||
> +			req_op(req) == REQ_OP_FLUSH) &&
> +			!(io->flags & UBLK_IO_FLAG_NEED_GET_DATA)) {
> +
> +		io->flags |= UBLK_IO_FLAG_NEED_GET_DATA;
> +
> +		pr_devel("%s: ublk_need_get_data. op %d, qid %d tag %d io_flags %x\n",
> +				__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags);
> +
> +		ubq_complete_io_cmd(io, UBLK_IO_RES_NEED_GET_DATA);
> +		return;
> +	}
> +
>  	mapped_bytes = ublk_map_io(ubq, req, io);
>  
>  	/* partially mapped, update io descriptor */
> @@ -553,17 +601,13 @@ static inline void __ublk_rq_task_work(struct request *req)
>  			mapped_bytes >> 9;
>  	}
>  
> -	/* mark this cmd owned by ublksrv */
> -	io->flags |= UBLK_IO_FLAG_OWNED_BY_SRV;
> -
>  	/*
> -	 * clear ACTIVE since we are done with this sqe/cmd slot
> -	 * We can only accept io cmd in case of being not active.
> +	 * Anyway, we have handled UBLK_IO_NEED_GET_DATA for WRITE/FLUSH requests,
> +	 * or we did nothing for other types requests.
>  	 */
> -	io->flags &= ~UBLK_IO_FLAG_ACTIVE;
> +	io->flags &= ~UBLK_IO_FLAG_NEED_GET_DATA;
>  
> -	/* tell ublksrv one io request is coming */
> -	io_uring_cmd_done(io->cmd, UBLK_IO_RES_OK, 0);
> +	ubq_complete_io_cmd(io, UBLK_IO_RES_OK);
>  }
>  
>  static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd)
> @@ -846,6 +890,16 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>  	mutex_unlock(&ub->mutex);
>  }
>  
> +static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
> +		int tag, struct io_uring_cmd *cmd)
> +{
> +	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> +	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
> +
> +	pdu->req = req;
> +	io_uring_cmd_complete_in_task(cmd, ublk_rq_task_work_cb);
> +}

Here you can choose to use task work or io_uring_cmd_complete_in_task() by
checking ublk_can_use_task_work(), just like what ublk_queue_rq() does.

> +
>  static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  {
>  	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->cmd;
> @@ -884,6 +938,14 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  		goto out;
>  	}
>  
> +	/*
> +	 * ensure that the user issues UBLK_IO_NEED_GET_DATA
> +	 * iff the driver have set the UBLK_IO_FLAG_NEED_GET_DATA.
> +	 */
> +	if ((!!(io->flags & UBLK_IO_FLAG_NEED_GET_DATA))
> +			^ (cmd_op == UBLK_IO_NEED_GET_DATA))
> +		goto out;
> +
>  	switch (cmd_op) {
>  	case UBLK_IO_FETCH_REQ:
>  		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
> @@ -917,6 +979,14 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  		io->cmd = cmd;
>  		ublk_commit_completion(ub, ub_cmd);
>  		break;
> +	case UBLK_IO_NEED_GET_DATA:
> +		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> +			goto out;
> +		io->addr = ub_cmd->addr;
> +		io->cmd = cmd;
> +		io->flags |= UBLK_IO_FLAG_ACTIVE;
> +		ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag, cmd);

You still need to clear UBLK_IO_FLAG_OWNED_BY_SRV here.

In future, UBLK_IO_FLAG_OWNED_BY_SRV can be removed actually.


Thanks,
Ming

