Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C961519A2
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 01:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744940359; cv=none; b=jl6BsmT2YIQ7ANNW+UanoW7gK0o53bJDt2XJwWwFlIJDC9YRTMX3X4LoMqxQMQSLb0S4UHbDY2rf815pIugVPbZ3ZrjVX2KcOFrB6fwKFdsErOl4rTsIpk0c+DLg80EBFg/BGETK2Pqq89xT1rAC7ZI6XVxA80McuOcr/FTak7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744940359; c=relaxed/simple;
	bh=GOGrc1VKJlw7dp1KxJ/BbP3pgPQiZNtQeL1gdFubgqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fe8e3K5v6EB8OKCtEQTwCE8Y8xTAMCKixxG9Uu+wdyzeNXUBAwSsUwfcxDcUdHK+Gu/JLqqaiDnqN6tPVk2UBuybEVINX6HH6n0owrEo8NHgx53k2aj9YKDvYk/WPm4HpQAtdgj+UAY4UgTvKkdJbn9zgXDzS9/N6thguzLtZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIXTQlWK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIXTQlWK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744940356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8nUbQtZksasEVEl3asuqyPAe8dPoXEkms0wEXBqoY0=;
	b=NIXTQlWKsPPJrtT3lqR8Dr/J4GFS71LlxrUwTSCDqmb/BeYTEZLpgPUydEUt8LSqmXjYHz
	KAINiBNw/h8qXiqLcio/kno8c6YS/D+cOo79DGAxc9wUdHthRjJfDg+4MrPzy8k85SSn1G
	DhdZzVz9pStieXm2qQ3/910NX8K1wMU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-TCbWW2igMmaTsHqXuCxV3w-1; Thu,
 17 Apr 2025 21:39:15 -0400
X-MC-Unique: TCbWW2igMmaTsHqXuCxV3w-1
X-Mimecast-MFC-AGG-ID: TCbWW2igMmaTsHqXuCxV3w_1744940354
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2D161800370;
	Fri, 18 Apr 2025 01:39:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.88])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82081180176F;
	Fri, 18 Apr 2025 01:39:10 +0000 (UTC)
Date: Fri, 18 Apr 2025 09:39:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] ublk: mark ublk_queue as const for
 ublk_handle_need_get_data
Message-ID: <aAGtOYV2lxvu0Zzo@fedora>
References: <20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com>
 <20250416-ublk_task_per_io-v5-4-9261ad7bff20@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-ublk_task_per_io-v5-4-9261ad7bff20@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Apr 16, 2025 at 01:46:08PM -0600, Uday Shankar wrote:
> We now allow multiple tasks to operate on I/Os belonging to the same
> queue concurrently. This means that any writes to ublk_queue in the I/O
> path are potential sources of data races. Try to prevent these by
> marking ublk_queue pointers as const in ublk_handle_need_get_data. Also
> move a bit more of the NEED_GET_DATA-specific logic into
> ublk_handle_need_get_data, to make the pattern in __ublk_ch_uring_cmd
> more uniform.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 215ab45b00e10150e58d7f5ea5b5d13e40a1aa79..5f9679c03305576bee586388cab82a6ea5472f8b 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1291,7 +1291,7 @@ static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
>  	ublk_dispatch_req(ubq, pdu->req, issue_flags);
>  }
>  
> -static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
> +static void ublk_queue_cmd(const struct ublk_queue *ubq, struct request *rq)
>  {
>  	struct io_uring_cmd *cmd = ubq->ios[rq->tag].cmd;
>  	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> @@ -1813,15 +1813,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>  	mutex_unlock(&ub->mutex);
>  }
>  
> -static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
> -		int tag)
> -{
> -	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
> -	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
> -
> -	ublk_queue_cmd(ubq, req);
> -}
> -
>  static inline int ublk_check_cmd_op(u32 cmd_op)
>  {
>  	u32 ioc_type = _IOC_TYPE(cmd_op);
> @@ -1933,6 +1924,20 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
>  	return 0;
>  }
>  
> +static int ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
> +			 struct io_uring_cmd *cmd,
> +			 const struct ublksrv_io_cmd *ub_cmd,
> +			 struct request *req)
> +{
> +	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> +		return -EINVAL;
> +
> +	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> +	ublk_queue_cmd(ubq, req);
> +
> +	return 0;
> +}
> +
>  static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  			       unsigned int issue_flags,
>  			       const struct ublksrv_io_cmd *ub_cmd)
> @@ -2026,10 +2031,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  			goto out;
>  		break;
>  	case UBLK_IO_NEED_GET_DATA:
> -		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> +		ret = ublk_get_data(
> +			ubq, io, cmd, ub_cmd,
> +			blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag));

Same with patch 2, moving request retrieval into ublk_get_data() could be
cleaner and helpful for switching to store request pointer into `ublk_io`.

Otherwise, looks nice cleanup.

Thanks,
Ming

