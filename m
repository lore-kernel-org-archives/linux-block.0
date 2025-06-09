Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62730280CFC
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749454487; cv=none; b=kQimWuP3MHDufbP+M6DIrxBik4l0mNz+zp+oyF9RQA1RNSYMJvl82VvJ//zLs38jNWUYS0+CYbof8nVOTgDkhs9DrZ4i9C0Iv/5LdEiOIlobtVY89P/eJONwFcyOLF2bO2o67ZqJNjPAjUP+31NmrbbtyxP4aAlKCQDelG9c10U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749454487; c=relaxed/simple;
	bh=rMwG/VF1pIUbgJklj0TXzQCNW5kFzd+4LioRCQBma/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJTJZgUBLHwNVmvd1CdJDPNFY6fBsNeNNCF3ovAi4vrmczxrOR2YvRhaVPS/aHD0yHwg5QW26/NE023T/pBelMwTSuZ4QMQqoAFw+sP6XRn6Q3n70LUtOU+U3uosO97mPu7fBeUYv0XIzmIsS61hJvY+S/S5VACtq52z17wVpng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4U43pUU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4U43pUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749454483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DY8MSc65FVK3o9QuSU57y41EYwt0GBkJUnP3i1gOZJ8=;
	b=c4U43pUUvHIjyez8GFc3uv4nzxGmsoxvbeO7MZV4Fuk1LeamDlj7oMDKdYjKzZ6GsDHzAc
	ZTruMyd+omxViRlyTMltcBU3tARum96D2LFXpir8X1henDqsKucNPc8XeCnWIwdVDy6EjS
	aGGNOomDjKouzlZy0wBPDTGI3kgmspM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-K88MKwqOOMCZOXFE86MJYA-1; Mon,
 09 Jun 2025 03:34:40 -0400
X-MC-Unique: K88MKwqOOMCZOXFE86MJYA-1
X-Mimecast-MFC-AGG-ID: K88MKwqOOMCZOXFE86MJYA_1749454479
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 126FC195608C;
	Mon,  9 Jun 2025 07:34:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61315195608D;
	Mon,  9 Jun 2025 07:34:35 +0000 (UTC)
Date: Mon, 9 Jun 2025 15:34:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 6/8] ublk: allow UBLK_IO_(UN)REGISTER_IO_BUF on any task
Message-ID: <aEaOh5R_FyMzPNIJ@fedora>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

Yeah, the behavior looks correct, but I'd suggest to validate the q_id
too for making code more robust.

Also you removed ublk_support_zero_copy() check for unregistering io buffer
command, which isn't expected for this patch.

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

Maybe you can move UBLK_IO_UNREGISTER_IO_BUF handling here, which seems
more readable.

Thanks,
Ming

