Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EE5C04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 10:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbiG1Klo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 06:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiG1Kln (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 06:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E278A3F304
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 03:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659004901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/BKcZDpnrxNFTaRX6b/vnS3jHr1A45AWZ2Jlr2K2lLM=;
        b=EJT+v/ROsZpkVP9Gd9A4bh4oCpHG069y15su7BI1DAIzZr162m2LTJbOMwVobXY7EO8RNG
        oakHUEvWKXwNufkEvYMpwWawzN2Zb6wcr+frAb1IPSaqrVT3i6x6Yuxou7Wrkg5F/uo7V9
        PNNXXU6rt5nBABGi25cbI3vtA38TqCc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-lABF1lslM4iWoMGsaOaUOQ-1; Thu, 28 Jul 2022 06:41:38 -0400
X-MC-Unique: lABF1lslM4iWoMGsaOaUOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6439585A584;
        Thu, 28 Jul 2022 10:41:38 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 311EC18EB7;
        Thu, 28 Jul 2022 10:41:34 +0000 (UTC)
Date:   Thu, 28 Jul 2022 18:41:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
Subject: Re: [PATCH V3 2/2] ublk_drv: add support for UBLK_IO_NEED_GET_DATA
Message-ID: <YuJn2lEMdYGl5An9@T590>
References: <cover.1658999030.git.ZiyangZhang@linux.alibaba.com>
 <925d386f6cfaf7df3221dc7502ca8d9fb7f17538.1658999030.git.ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <925d386f6cfaf7df3221dc7502ca8d9fb7f17538.1658999030.git.ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 28, 2022 at 05:31:24PM +0800, ZiyangZhang wrote:
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
>  drivers/block/ublk_drv.c | 96 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 87 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 255b2de46a24..ea60853d80a1 100644
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
> @@ -168,6 +179,13 @@ static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
>  	return false;
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
> @@ -509,6 +527,21 @@ static void __ublk_fail_req(struct ublk_io *io, struct request *req)
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
> @@ -531,6 +564,20 @@ static inline void __ublk_rq_task_work(struct request *req)
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
> @@ -553,17 +600,13 @@ static inline void __ublk_rq_task_work(struct request *req)
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

Please move clearing UBLK_IO_FLAG_NEED_GET_DATA into ublk_handle_need_get_data().

UBLK_IO_FLAG_NEED_GET_DATA should only be touched in case that UBLK_F_NEED_GET_DATA
is set, also it becomes more readable.

Otherwise, this patch looks fine.


Thanks,
Ming

