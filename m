Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7913C290BBB
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360190; cv=none; b=R9GzK/94eVFs2ai71StKF0R4TQ8N7tE64eZefI3zwW6Z1LWDf0jIQRgOaywkK+oqdSNE5hbEMpsu/X8DZzNZf1b9iNm/sL4pbjGErZOILN21zxfn3cY7DwRzK97aYdVDE2TXrCXqFsYGyGd7sKrM/z/BN5ELBYiDuwHp54Mo1ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360190; c=relaxed/simple;
	bh=7ssNupDgU8vmevJCxD5GdD5tPQfJ3L2pItFyCooetGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWQUM2liQGFfn4TNl7Ibhf7TkVqOwos1VeYMh/jdGso3N4B15v2JzdtqqGFANY9TRGPqWwn0DQ99Vweqocrf4L/bntrwrv5zP2BMOwu6+p9ZDk3WxUspYLE8E6rhWOKzPpQKwzua//JWBq8v4iN7zvc2LjPg/d/XiDRvNlHpfb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwN3KqoT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwN3KqoT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744360187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0lPuDrrquqV/HjuED3BRdmAd5birwzsFY9dj2LQ0vk=;
	b=RwN3KqoTPSivpf4Sxsz4PgCfePmxeJRIpSOVuDxDiXrZZIhNYSjiWy96zc6p76So+d/f7U
	GG79Ha9YEIRSVjxyrVb/yGjwilFvH4mxTkD/tUMnwq7ZiYS8CopoEwDaxF93ltNoHRWMs8
	B0MMWm3vrVgcZuDOj6oCOMr9piedDSQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-QcxjdXmHNKWdtPw3iJ6LPw-1; Fri,
 11 Apr 2025 04:29:42 -0400
X-MC-Unique: QcxjdXmHNKWdtPw3iJ6LPw-1
X-Mimecast-MFC-AGG-ID: QcxjdXmHNKWdtPw3iJ6LPw_1744360181
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E01F41955DC5;
	Fri, 11 Apr 2025 08:29:40 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03ED91955DCE;
	Fri, 11 Apr 2025 08:29:35 +0000 (UTC)
Date: Fri, 11 Apr 2025 16:29:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH v3 1/2] ublk: properly serialize all FETCH_REQs
Message-ID: <Z_jS6cdN074Z_j4Q@fedora>
References: <20250410-ublk_task_per_io-v3-0-b811e8f4554a@purestorage.com>
 <20250410-ublk_task_per_io-v3-1-b811e8f4554a@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-ublk_task_per_io-v3-1-b811e8f4554a@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Apr 10, 2025 at 06:17:50PM -0600, Uday Shankar wrote:
> Most uring_cmds issued against ublk character devices are serialized
> because each command affects only one queue, and there is an early check
> which only allows a single task (the queue's ubq_daemon) to issue
> uring_cmds against that queue. However, this mechanism does not work for
> FETCH_REQs, since they are expected before ubq_daemon is set. Since
> FETCH_REQs are only used at initialization and not in the fast path,
> serialize them using the per-ublk-device mutex. This fixes a number of
> data races that were previously possible if a badly behaved ublk server
> decided to issue multiple FETCH_REQs against the same qid/tag
> concurrently.
> 
> Reported-by: Caleb Sander Mateos <csander@purestorage.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2fd05c1bd30b03343cb6f357f8c08dd92ff47af9..812789f58704cece9b661713cd0107807c789531 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1809,8 +1809,8 @@ static void ublk_nosrv_work(struct work_struct *work)
>  
>  /* device can only be started after all IOs are ready */
>  static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
> +	__must_hold(&ub->mutex)
>  {
> -	mutex_lock(&ub->mutex);
>  	ubq->nr_io_ready++;
>  	if (ublk_queue_ready(ubq)) {
>  		ubq->ubq_daemon = current;
> @@ -1822,7 +1822,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>  	}
>  	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
>  		complete_all(&ub->completion);
> -	mutex_unlock(&ub->mutex);
>  }
>  
>  static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
> @@ -1962,17 +1961,25 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  	case UBLK_IO_UNREGISTER_IO_BUF:
>  		return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_flags);
>  	case UBLK_IO_FETCH_REQ:
> +		mutex_lock(&ub->mutex);
>  		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
>  		if (ublk_queue_ready(ubq)) {
>  			ret = -EBUSY;
> -			goto out;
> +			goto out_unlock;
>  		}
>  		/*
>  		 * The io is being handled by server, so COMMIT_RQ is expected
>  		 * instead of FETCH_REQ
>  		 */
>  		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
> -			goto out;
> +			goto out_unlock;
> +
> +		/*
> +		 * Check again (with mutex held) that the I/O is not
> +		 * active - if so, someone may have already fetched it
> +		 */
> +		if (io->flags & UBLK_IO_FLAG_ACTIVE)
> +			goto out_unlock;
>  
>  		if (ublk_need_map_io(ubq)) {
>  			/*
> @@ -1980,15 +1987,16 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  			 * DATA is not enabled
>  			 */
>  			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
> -				goto out;
> +				goto out_unlock;
>  		} else if (ub_cmd->addr) {
>  			/* User copy requires addr to be unset */
>  			ret = -EINVAL;
> -			goto out;
> +			goto out_unlock;
>  		}
>  
>  		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
>  		ublk_mark_io_ready(ub, ubq);
> +		mutex_unlock(&ub->mutex);
>  		break;
>  	case UBLK_IO_COMMIT_AND_FETCH_REQ:
>  		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
> @@ -2028,7 +2036,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  	ublk_prep_cancel(cmd, issue_flags, ubq, tag);
>  	return -EIOCBQUEUED;
>  
> - out:
> +out_unlock:
> +	mutex_unlock(&ub->mutex);
> +out:
>  	pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
>  			__func__, cmd_op, tag, ret, io->flags);
>  	return ret;

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

BTW, FETCH_REQ could be put into one single function, so it will become
cleaner.

Thanks,
Ming

