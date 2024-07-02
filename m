Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D187514F135
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927133; cv=none; b=YBOzVM6fRMatFWgF+O0bnVW/CIoAk883djp3MDUsR5hfgKBX1JlawB89Fv55WYYaX5r6CCa8jcVn/loLSxHTBmeXIgOOFrZICJeQjHARy2I1XmxcPtsDMbmNlQqjyqgNdWB3vAaejy205wMviTVMqLgKbT7ET5dzsUeyE28oytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927133; c=relaxed/simple;
	bh=92Sshi6elouS8qxYeLbmVAftJN/zqgkXdul5MG9dQgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XADsIahHEluYO80DQ1gQWk491mtrorvrBR2huRbn/p/J+zKnrwFAq+3nnsVhNwyF6xHBPf3no5i7N/tP34Vvxmqkkr9Ul4qIJeB6gGIOY/v7mlOpaKnELnfGsDe5erfGhneGhteUnx/cJkL4TZgZTXtDwRaTQwRZ1vTvToRjQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I2qaVjDL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2qaVjDL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719927130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FFunfCe9BcELvajEq/rBWLDTaDnh1oIULg3piUDALP8=;
	b=I2qaVjDL0GIQSQZBkEDWcy4/S8hXlKfSN3y6wrT4hlniC+wjAKpMqMJxXVxL3k4JwzvgvU
	JnPaYjeQVflgwCDnClZpIFbI7fL2PFkU1ieyG1ofGSwwsa0KIpkEpc7ncsMu9EU9P+wefy
	OXf4sw2yzNRDpVq6Oy0uhMfpVW+7M0Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-sNgZJB0ZPgSyP6L1iD3ZMw-1; Tue,
 02 Jul 2024 09:32:07 -0400
X-MC-Unique: sNgZJB0ZPgSyP6L1iD3ZMw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DDA8195C272;
	Tue,  2 Jul 2024 13:32:06 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2F0B19560A3;
	Tue,  2 Jul 2024 13:32:02 +0000 (UTC)
Date: Tue, 2 Jul 2024 21:31:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] ublk: merge stop_work and quiesce_work
Message-ID: <ZoQBTFph6X0y8Ry3@fedora>
References: <20240617194451.435445-1-ushankar@purestorage.com>
 <20240617194451.435445-4-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617194451.435445-4-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jun 17, 2024 at 01:44:50PM -0600, Uday Shankar wrote:
> Save some lines by merging stop_work and quiesce_work into nosrv_work,
> which looks at the recovery flags and does the right thing when the "no
> ublk server" condition is detected.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 64 ++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index e8cca58a71bc..0496fa372cc1 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -182,8 +182,7 @@ struct ublk_device {
>  	unsigned int		nr_queues_ready;
>  	unsigned int		nr_privileged_daemon;
>  
> -	struct work_struct	quiesce_work;
> -	struct work_struct	stop_work;
> +	struct work_struct	nosrv_work;
>  };
>  
>  /* header of ublk_params */
> @@ -1229,10 +1228,7 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  		struct ublk_device *ub = ubq->dev;
>  
>  		if (ublk_abort_requests(ub, ubq)) {
> -			if (ublk_nosrv_should_stop_dev(ub))
> -				schedule_work(&ub->stop_work);
> -			else
> -				schedule_work(&ub->quiesce_work);
> +			schedule_work(&ub->nosrv_work);
>  		}
>  		return BLK_EH_DONE;
>  	}
> @@ -1482,10 +1478,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
>  	ublk_cancel_cmd(ubq, io, issue_flags);
>  
>  	if (need_schedule) {
> -		if (ublk_nosrv_should_stop_dev(ub))
> -			schedule_work(&ub->stop_work);
> -		else
> -			schedule_work(&ub->quiesce_work);
> +		schedule_work(&ub->nosrv_work);
>  	}
>  }
>  
> @@ -1548,20 +1541,6 @@ static void __ublk_quiesce_dev(struct ublk_device *ub)
>  	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
>  }
>  
> -static void ublk_quiesce_work_fn(struct work_struct *work)
> -{
> -	struct ublk_device *ub =
> -		container_of(work, struct ublk_device, quiesce_work);
> -
> -	mutex_lock(&ub->mutex);
> -	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
> -		goto unlock;
> -	__ublk_quiesce_dev(ub);
> - unlock:
> -	mutex_unlock(&ub->mutex);
> -	ublk_cancel_dev(ub);
> -}
> -
>  static void ublk_unquiesce_dev(struct ublk_device *ub)
>  {
>  	int i;
> @@ -1610,6 +1589,25 @@ static void ublk_stop_dev(struct ublk_device *ub)
>  	ublk_cancel_dev(ub);
>  }
>  
> +static void ublk_nosrv_work(struct work_struct *work)
> +{
> +	struct ublk_device *ub =
> +		container_of(work, struct ublk_device, nosrv_work);
> +
> +	if (ublk_nosrv_should_stop_dev(ub)) {
> +		ublk_stop_dev(ub);
> +		return;
> +	}
> +
> +	mutex_lock(&ub->mutex);
> +	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
> +		goto unlock;
> +	__ublk_quiesce_dev(ub);
> + unlock:
> +	mutex_unlock(&ub->mutex);
> +	ublk_cancel_dev(ub);
> +}
> +
>  /* device can only be started after all IOs are ready */
>  static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>  {
> @@ -2124,14 +2122,6 @@ static int ublk_add_chdev(struct ublk_device *ub)
>  	return ret;
>  }
>  
> -static void ublk_stop_work_fn(struct work_struct *work)
> -{
> -	struct ublk_device *ub =
> -		container_of(work, struct ublk_device, stop_work);
> -
> -	ublk_stop_dev(ub);
> -}
> -
>  /* align max io buffer size with PAGE_SIZE */
>  static void ublk_align_max_io_size(struct ublk_device *ub)
>  {
> @@ -2156,8 +2146,7 @@ static int ublk_add_tag_set(struct ublk_device *ub)
>  static void ublk_remove(struct ublk_device *ub)
>  {
>  	ublk_stop_dev(ub);
> -	cancel_work_sync(&ub->stop_work);
> -	cancel_work_sync(&ub->quiesce_work);
> +	cancel_work_sync(&ub->nosrv_work);
>  	cdev_device_del(&ub->cdev, &ub->cdev_dev);
>  	ublk_put_device(ub);
>  	ublks_added--;
> @@ -2412,8 +2401,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>  		goto out_unlock;
>  	mutex_init(&ub->mutex);
>  	spin_lock_init(&ub->lock);
> -	INIT_WORK(&ub->quiesce_work, ublk_quiesce_work_fn);
> -	INIT_WORK(&ub->stop_work, ublk_stop_work_fn);
> +	INIT_WORK(&ub->nosrv_work, ublk_nosrv_work);
>  
>  	ret = ublk_alloc_dev_number(ub, header->dev_id);
>  	if (ret < 0)
> @@ -2548,9 +2536,7 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
>  static int ublk_ctrl_stop_dev(struct ublk_device *ub)
>  {
>  	ublk_stop_dev(ub);
> -	cancel_work_sync(&ub->stop_work);
> -	cancel_work_sync(&ub->quiesce_work);
> -
> +	cancel_work_sync(&ub->nosrv_work);
>  	return 0;
>  }

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

