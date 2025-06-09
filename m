Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57AD256C7E
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749472474; cv=none; b=aBeAdw34GOP4t5UFFCbQNuGo/ib89+H/Oj4G5dxrB9WFIWlhxIkIC6TD5SLGkGqbheYMKQA1RS1wzXADfX5Dmvzk8JtxnyxbQAnV8UzWlHl/xm0ng7NMJfdd+vBLIgh4mysKctdJcnf9459qMZQrUme1yFuysQOO024JUCDw9UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749472474; c=relaxed/simple;
	bh=gmAhRQR/FTDMUhFdA2hfL0IqfGi2Msey+YLwq5tRw0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZWMVkrF0LIpcaqw8ER83a2Ogkpr5G2wLtay1vYWu62ChZZB25VoHtHXOOOdp90CZ9qndEJ4gwVCaehYsSVcGApTPab0vI5Rmf1pvunKrILx9Ew8e+LA4yCvwQ+HjHD7QmaKYXGzydGBOACTYEWnGp/AKvh1GLNDdVASnN3Bal8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUEp+F9Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUEp+F9Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749472471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cyl84OY6owBd9abIoWOCou2ET69uVySRRwTbpoB3DdE=;
	b=aUEp+F9ZoXYeD1gdPicnMa97VCx0t2gu4OEH7dZY3D0een2z2vwLMCk1KJfL0QxyD3BfPq
	3jr7di0QIoqj8VwuZvvsIfXOrhrFPEnoAtyif2lRDA4lnhpl29Agh3NfSP2zeu0WQbtvvY
	UfV/uHMc+p3/kuF9m5M/6fXkO3I01sA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-jbo9OVt1OxSi13-m4jAxdA-1; Mon,
 09 Jun 2025 08:34:30 -0400
X-MC-Unique: jbo9OVt1OxSi13-m4jAxdA-1
X-Mimecast-MFC-AGG-ID: jbo9OVt1OxSi13-m4jAxdA_1749472469
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96F22195609D;
	Mon,  9 Jun 2025 12:34:29 +0000 (UTC)
Received: from fedora (unknown [10.72.116.58])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAB43180045B;
	Mon,  9 Jun 2025 12:34:26 +0000 (UTC)
Date: Mon, 9 Jun 2025 20:34:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 6/8] ublk: allow UBLK_IO_(UN)REGISTER_IO_BUF on any task
Message-ID: <aEbUx51iu6oMkPB7@fedora>
References: <20250606214011.2576398-1-csander@purestorage.com>
 <20250606214011.2576398-7-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606214011.2576398-7-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Jun 06, 2025 at 03:40:09PM -0600, Caleb Sander Mateos wrote:
> Currently, UBLK_IO_REGISTER_IO_BUF and UBLK_IO_UNREGISTER_IO_BUF are
> only permitted on the ublk_io's daemon task. But this restriction is
> unnecessary. ublk_register_io_buf() calls __ublk_check_and_get_req() to
> look up the request from the tagset and atomically take a reference on
> the request without accessing the ublk_io. ublk_unregister_io_buf()
> doesn't use the q_id or tag at all.
> 
> So allow these opcodes even on tasks other than io->task.
> 
> Handle UBLK_IO_UNREGISTER_IO_BUF before obtaining the ubq and io since
> the buffer index being unregistered is not necessarily related to the
> specified q_id and tag.
> 
> Add a feature flag UBLK_F_BUF_REG_OFF_DAEMON that userspace can use to
> determine whether the kernel supports off-daemon buffer registration.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c      | 37 +++++++++++++++++++++--------------
>  include/uapi/linux/ublk_cmd.h |  8 ++++++++
>  2 files changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index a8030818f74a..2084bbdd2cbb 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -68,11 +68,12 @@
>  		| UBLK_F_ZONED \
>  		| UBLK_F_USER_RECOVERY_FAIL_IO \
>  		| UBLK_F_UPDATE_SIZE \
>  		| UBLK_F_AUTO_BUF_REG \
>  		| UBLK_F_QUIESCE \
> -		| UBLK_F_PER_IO_DAEMON)
> +		| UBLK_F_PER_IO_DAEMON \
> +		| UBLK_F_BUF_REG_OFF_DAEMON)
>  
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>  		| UBLK_F_USER_RECOVERY_REISSUE \
>  		| UBLK_F_USER_RECOVERY_FAIL_IO)
>  
> @@ -2018,20 +2019,10 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
>  	}
>  
>  	return 0;
>  }
>  
> -static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
> -				  const struct ublk_queue *ubq,
> -				  unsigned int index, unsigned int issue_flags)
> -{
> -	if (!ublk_support_zero_copy(ubq))
> -		return -EINVAL;
> -
> -	return io_buffer_unregister_bvec(cmd, index, issue_flags);
> -}
> -
>  static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
>  		      struct ublk_io *io, __u64 buf_addr)
>  {
>  	struct ublk_device *ub = ubq->dev;
>  	int ret = 0;
> @@ -2184,10 +2175,18 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  
>  	ret = ublk_check_cmd_op(cmd_op);
>  	if (ret)
>  		goto out;
>  
> +	/*
> +	 * io_buffer_unregister_bvec() doesn't access the ubq or io,
> +	 * so no need to validate the q_id, tag, or task
> +	 */
> +	if (_IOC_NR(cmd_op) == UBLK_IO_UNREGISTER_IO_BUF)
> +		return io_buffer_unregister_bvec(cmd, ub_cmd->addr,
> +						 issue_flags);
> +
>  	ret = -EINVAL;
>  	if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
>  		goto out;
>  
>  	ubq = ublk_get_queue(ub, ub_cmd->q_id);
> @@ -2204,12 +2203,21 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  
>  		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
>  		return -EIOCBQUEUED;
>  	}
>  
> -	if (READ_ONCE(io->task) != current)
> +	if (READ_ONCE(io->task) != current) {
> +		/*
> +		 * ublk_register_io_buf() accesses only the request, not io,
> +		 * so can be handled on any task
> +		 */
> +		if (_IOC_NR(cmd_op) == UBLK_IO_REGISTER_IO_BUF)
> +			return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr,
> +						    issue_flags);
> +
>  		goto out;
> +	}
>  
>  	/* there is pending io cmd, something must be wrong */
>  	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)) {
>  		ret = -EBUSY;

It also skips check on UBLK_IO_FLAG_OWNED_BY_SRV for both UBLK_IO_REGISTER_IO_BUF
and UBLK_IO_UNREGISTER_IO_BUF, :-(


thanks,
Ming

