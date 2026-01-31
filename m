Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217263191D6
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769825297; cv=none; b=OT9wSXCgD3nHWFr/RA8gM+W9hY0ldIo02dBUcU7Mhgkt4YiGLg+1B3RY2qW7pCWG/tORHrihgA8wXAa2UQ/5JLRLLSCJIFQVDJPw84ArpNhQEVBFzhAtt2CG7K+8wqCntsb6uWUgQeOy9w0GefFUTMn5BBsO6QouXFotteAmdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769825297; c=relaxed/simple;
	bh=WKnVPao76QuG2NRWlY7KosnPQ33pnpdz80uEMOlqTYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lxt/9pQ9QJ4fKUpxJTlX7k4eTkq2LeLMHxKh7RZXREV9W7kv+AyR6LvfrBQ37TGpg8lfrBoNBJbG1M4DkYRuhMpTHZRWaPqfccnALfanGSdYX7IPN11sL2WgyaQdO8x+9rqs6hwqyPteCdH/PP56uhqFxZU+kb3/vGVli/pt7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQ6WpqAk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQ6WpqAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769825295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UvPHH4lVSXeYVbDAOBl5lsQhSqePUDzG9GTzrOGOWlA=;
	b=jQ6WpqAkYJXOZnPeJncGqGQHTOyiU2RUOra19+s4xuoD375xb9mGZYrGH2dEhslSAuFQfl
	/cdAhCVmVDSNATUIFnr+5dHhIzIkT5xVoO5wFj6GaP75qzjEE19XuYpysjww0UfYWJKycL
	uoBZCbQWEF55I2abdFkeAWMYjE5BSpI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-4IA52BIuOe6fELRNoQFeuw-1; Fri,
 30 Jan 2026 21:08:11 -0500
X-MC-Unique: 4IA52BIuOe6fELRNoQFeuw-1
X-Mimecast-MFC-AGG-ID: 4IA52BIuOe6fELRNoQFeuw_1769825290
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FB6F1800447;
	Sat, 31 Jan 2026 02:08:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 880491800840;
	Sat, 31 Jan 2026 02:08:06 +0000 (UTC)
Date: Sat, 31 Jan 2026 10:08:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Govindarajulu Varadarajan <govind.varadar@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ublk: use READ_ONCE() to read struct
 ublksrv_ctrl_cmd
Message-ID: <aX1kAVu7gqM4zI-D@fedora>
References: <20260130171414.1376543-1-csander@purestorage.com>
 <20260130171414.1376543-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130171414.1376543-3-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Jan 30, 2026 at 10:14:13AM -0700, Caleb Sander Mateos wrote:
> struct ublksrv_ctrl_cmd is part of the io_uring_sqe, which may lie in
> userspace-mapped memory. It's racy to access its fields with normal
> loads, as userspace may write to them concurrently. Use READ_ONCE() to
> copy the ublksrv_ctrl_cmd from the io_uring_sqe to the stack. Use the
> local copy in place of the one in the io_uring_sqe.
> 
> Fixes: 87213b0d847c ("ublk: allow non-blocking ctrl cmds in IO_URING_F_NONBLOCK issue")
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 56 ++++++++++++++++++++++------------------
>  1 file changed, 31 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 01088194c8d3..8122b012a7ae 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -4729,16 +4729,15 @@ static int ublk_ctrl_del_dev(struct ublk_device **p_ub, bool wait)
>  	if (wait && wait_event_interruptible(ublk_idr_wq, ublk_idr_freed(idx)))
>  		return -EINTR;
>  	return 0;
>  }
>  
> -static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
> +static inline void ublk_ctrl_cmd_dump(u32 cmd_op,
> +				      const struct ublksrv_ctrl_cmd *header)
>  {
> -	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
> -
>  	pr_devel("%s: cmd_op %x, dev id %d qid %d data %llx buf %llx len %u\n",
> -			__func__, cmd->cmd_op, header->dev_id, header->queue_id,
> +			__func__, cmd_op, header->dev_id, header->queue_id,
>  			header->data[0], header->addr, header->len);
>  }
>  
>  static void ublk_ctrl_stop_dev(struct ublk_device *ub)
>  {
> @@ -5117,13 +5116,12 @@ static int ublk_char_dev_permission(struct ublk_device *ub,
>  	path_put(&path);
>  	return err;
>  }
>  
>  static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
> -		struct io_uring_cmd *cmd)
> +		u32 cmd_op, struct ublksrv_ctrl_cmd *header)
>  {
> -	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)io_uring_sqe_cmd(cmd->sqe);
>  	bool unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
>  	void __user *argp = (void __user *)(unsigned long)header->addr;
>  	char *dev_path = NULL;
>  	int ret = 0;
>  	int mask;
> @@ -5135,11 +5133,11 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
>  		 * The new added command of UBLK_CMD_GET_DEV_INFO2 includes
>  		 * char_dev_path in payload too, since userspace may not
>  		 * know if the specified device is created as unprivileged
>  		 * mode.
>  		 */
> -		if (_IOC_NR(cmd->cmd_op) != UBLK_CMD_GET_DEV_INFO2)
> +		if (_IOC_NR(cmd_op) != UBLK_CMD_GET_DEV_INFO2)
>  			return 0;
>  	}
>  
>  	/*
>  	 * User has to provide the char device path for unprivileged ublk
> @@ -5156,11 +5154,11 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
>  	dev_path = memdup_user_nul(argp, header->dev_path_len);
>  	if (IS_ERR(dev_path))
>  		return PTR_ERR(dev_path);
>  
>  	ret = -EINVAL;
> -	switch (_IOC_NR(cmd->cmd_op)) {
> +	switch (_IOC_NR(cmd_op)) {
>  	case UBLK_CMD_GET_DEV_INFO:
>  	case UBLK_CMD_GET_DEV_INFO2:
>  	case UBLK_CMD_GET_QUEUE_AFFINITY:
>  	case UBLK_CMD_GET_PARAMS:
>  	case (_IOC_NR(UBLK_U_CMD_GET_FEATURES)):
> @@ -5186,11 +5184,11 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
>  	if (!ret) {
>  		header->len -= header->dev_path_len;
>  		header->addr += header->dev_path_len;
>  	}
>  	pr_devel("%s: dev id %d cmd_op %x uid %d gid %d path %s ret %d\n",
> -			__func__, ub->ub_number, cmd->cmd_op,
> +			__func__, ub->ub_number, cmd_op,
>  			ub->dev_info.owner_uid, ub->dev_info.owner_gid,
>  			dev_path, ret);
>  exit:
>  	kfree(dev_path);
>  	return ret;
> @@ -5210,11 +5208,13 @@ static bool ublk_ctrl_uring_cmd_may_sleep(u32 cmd_op)
>  }
>  
>  static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
>  		unsigned int issue_flags)
>  {
> -	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
> +	/* May point to userspace-mapped memory */
> +	const struct ublksrv_ctrl_cmd *ub_src = io_uring_sqe_cmd(cmd->sqe);
> +	struct ublksrv_ctrl_cmd header;

It is cleaner to initialize header variable here, otherwise this patch
looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks, 
Ming

