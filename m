Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760C2F4A
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830165; cv=none; b=gnbb+biz/MJMqg/eBnhW9z3DafwSVWn1h9bZd7bIqW3zA/jG9jRYon/TieYYD4s/a+ahP0pWNTdor48CVvC0nMt3JjFmKa6dQPM2sLz3CedTWC6KFgXQ1Z9NYOuAHLkD6n2qoiaBSgKaShoY7yYWMQqYl6xyyHZapGSyX0egcMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830165; c=relaxed/simple;
	bh=MERT2tbKPV9U8QPd8TEOl3ysUWqjusJzfGgCk0BTr8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7LOULJVfVO/8BxVuVTAvgIwt+agcXohM9mCApnItTVsGqLZkQpBu3c6trwwDtWabGW7YRDmHeRPdg9VIhw35LFisEPpYm2kzXDWfJ2VOXFUxM7drR5DhpPX3EoH+JZHPwAlUh14NzHI3F9BkFq7/LGWUCc5/Mmrx8i7Ir0fMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GeHzHi9+; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GeHzHi9+"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-22c33ac23edso368555ad.0
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744830163; x=1745434963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ymqval34ciZax6YQ7XbnVZOYDGiXYXI2RH1W3fiKfg4=;
        b=GeHzHi9+dDD1S7btgB8XplF3Q7qjPG5M7zAyVRlfdw/NEtHMYIZB6fVcYgmE4noTBY
         qLUWh7ChlPhDnBYwmL9ITrGiv2UEo6LIi6/AocQ29AZdiRlM6zdQBYdpjgr7XHwv547c
         yDHuGSXn6H8WadUHFRVZ4Y0PS49fsKCam9zfgQfB2J63eYDL/EX1GaMLBfjhp3rafbVc
         r4HEYdGkYsy3dgC112JAajzpO8n3Rm7ZcRGuBOFvl1PjjKSBZIIs4z1btLxJh406wlTu
         Y82dl3g+kyyzn8yoXUJr7Ict2dp5afN9mqJZ3o4njHCvWVeyTdZEXnhKZfXFtOQDEaAA
         Ytcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744830163; x=1745434963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ymqval34ciZax6YQ7XbnVZOYDGiXYXI2RH1W3fiKfg4=;
        b=Yehh3eY/Py1KD4LVRt3EEh2AEH111ZAXVZpXXU4WTz9C0X+oHBVBJZE2rNcSEJpfLa
         x/4MgpIKICWSg8I2pzRzhWpfKCZPnVUawQxuAwHpJ0I0L04EFdrdMtRHCgWIYTIcoI3m
         hrd7awTTLynNarUVS5OaQLG9s2ELmK16ibbWjdx+gbuRpr2ylzJLfxle9Fn217k0TPwe
         bnCaeGyPcb1q1xz+OG5JmZH397oNtAyhhsxgXo9918gukivkCePA7/pzTE1pgTwaWunx
         Tv86F/bzEHleVK/7v0S1MFXmPL3xgogKLh/gNnb1IVXSHwDXRK2sX/FMlgql4i3z/+Ji
         5aCg==
X-Forwarded-Encrypted: i=1; AJvYcCUfIDsgkLdG9FJu81tNG6cdUY7+BDwo3KLX+aUOY3XX8a4Fc8Fe71kRNVIGrAbR4zKVg4wUzGkBl1efzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtDHC+XuHhhr0ntUJNtwMsrnBznAIZY8vtxAAv8Jg28Ls+WIP
	fOX2LzLf3J1gMV8xQhNmKDyjezF240/vinIVaO44qrtmniwmAEfgZTsZ2YMXkKiFn4maXSiWcH1
	/+luzvrX7Zxf0fXND80UQC3xUSzXGwhFdk3QYT+NBOeA6jr1s
X-Gm-Gg: ASbGncvB4wkkDVFhC1BAbJGEvrWNpEWFGSy9OLVg2Ay2cghfAWpUcA2RhRQjyoNK4yd
	CJlVKQXytXXHNgkPERvBLh35RBT7XfEt0/fCdmJxBe/Ck4iEl0egTsGRB6QueU/dNgq1bt3wzUr
	ynVprvqwkWr9CCEfEGpL+dnq61DoS9yk+D/WHy4NhrIdeThFP0GA2HLQzfOGXgwoXM9g1VI8Wgm
	CGvakzUEab8EurnjTATuO/5UG6bGNOSpFcMnUS458wdaCQopUN7kxxJ/YpgdRL5pasa0XHP9hcs
	utMMvYBPGRva+hm2Ttog620Q5GcbyaI=
X-Google-Smtp-Source: AGHT+IGdJWklYNTnq62MwonXc1jf11lSw0hrcOSMRuxP9eJiAEtfij48iSJVuJcepv4jMSYht8DByWZdEClm
X-Received: by 2002:a17:902:d48d:b0:224:10a2:cad9 with SMTP id d9443c01a7336-22c3596bf3emr42312815ad.41.1744830162973;
        Wed, 16 Apr 2025 12:02:42 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22c33fe4d35sm907425ad.119.2025.04.16.12.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 12:02:42 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 274A6340424;
	Wed, 16 Apr 2025 13:02:42 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 1E090E40318; Wed, 16 Apr 2025 13:02:42 -0600 (MDT)
Date: Wed, 16 Apr 2025 13:02:42 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH V2 4/8] ublk: move device reset into ublk_ch_release()
Message-ID: <Z//+0vPyo1/4spfx@dev-ushankar.dev.purestorage.com>
References: <20250416035444.99569-1-ming.lei@redhat.com>
 <20250416035444.99569-5-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416035444.99569-5-ming.lei@redhat.com>

On Wed, Apr 16, 2025 at 11:54:38AM +0800, Ming Lei wrote:
> ublk_ch_release() is called after ublk char device is closed, when all
> uring_cmd are done, so it is perfect fine to move ublk device reset to
> ublk_ch_release() from ublk_ctrl_start_recovery().
> 
> This way can avoid to grab the exiting daemon task_struct too long.
> 
> However, reset of the following ublk IO flags has to be moved until ublk
> io_uring queues are ready:
> 
> - ubq->canceling
> 
> For requeuing IO in case of ublk_nosrv_dev_should_queue_io() before device
> is recovered
> 
> - ubq->fail_io
> 
> For failing IO in case of UBLK_F_USER_RECOVERY_FAIL_IO before device is
> recovered
> 
> - ublk_io->flags
> 
> For preventing using io->cmd
> 
> With this way, recovery is simplified a lot.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 121 +++++++++++++++++++++++----------------
>  1 file changed, 72 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index a479969fd77e..1fe39cf85b2f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1074,7 +1074,7 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
>  
>  static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
>  {
> -	return ubq->ubq_daemon->flags & PF_EXITING;
> +	return !ubq->ubq_daemon || ubq->ubq_daemon->flags & PF_EXITING;
>  }
>  
>  /* todo: handle partial completion */
> @@ -1470,6 +1470,37 @@ static const struct blk_mq_ops ublk_mq_ops = {
>  	.timeout	= ublk_timeout,
>  };
>  
> +static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
> +{
> +	int i;
> +
> +	/* All old ioucmds have to be completed */
> +	ubq->nr_io_ready = 0;
> +
> +	/*
> +	 * old daemon is PF_EXITING, put it now
> +	 *
> +	 * It could be NULL in case of closing one quisced device.
> +	 */
> +	if (ubq->ubq_daemon)
> +		put_task_struct(ubq->ubq_daemon);
> +	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
> +	ubq->ubq_daemon = NULL;
> +	ubq->timeout = false;
> +
> +	for (i = 0; i < ubq->q_depth; i++) {
> +		struct ublk_io *io = &ubq->ios[i];
> +
> +		/*
> +		 * UBLK_IO_FLAG_CANCELED is kept for avoiding to touch
> +		 * io->cmd
> +		 */
> +		io->flags &= UBLK_IO_FLAG_CANCELED;
> +		io->cmd = NULL;
> +		io->addr = 0;
> +	}
> +}
> +
>  static int ublk_ch_open(struct inode *inode, struct file *filp)
>  {
>  	struct ublk_device *ub = container_of(inode->i_cdev,
> @@ -1481,10 +1512,26 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +static void ublk_reset_ch_dev(struct ublk_device *ub)
> +{
> +	int i;
> +
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
> +
> +	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
> +	ub->mm = NULL;
> +	ub->nr_queues_ready = 0;
> +	ub->nr_privileged_daemon = 0;
> +}
> +
>  static int ublk_ch_release(struct inode *inode, struct file *filp)
>  {
>  	struct ublk_device *ub = filp->private_data;
>  
> +	/* all uring_cmd has been done now, reset device & ubq */
> +	ublk_reset_ch_dev(ub);

Can we take the ub->mutex here? I can't see a concrete data race but I
feel there is lots of potential for one since the device still may be
concurrently accessed via ctrl commands.

> +
>  	clear_bit(UB_STATE_OPEN, &ub->state);
>  	return 0;
>  }
> @@ -1831,6 +1878,24 @@ static void ublk_nosrv_work(struct work_struct *work)
>  	ublk_cancel_dev(ub);
>  }
>  
> +/* reset ublk io_uring queue & io flags */
> +static void ublk_reset_io_flags(struct ublk_device *ub)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> +		struct ublk_queue *ubq = ublk_get_queue(ub, i);
> +
> +		/* UBLK_IO_FLAG_CANCELED can be cleared now */
> +		spin_lock(&ubq->cancel_lock);
> +		for (j = 0; j < ubq->q_depth; j++)
> +			ubq->ios[j].flags &= ~UBLK_IO_FLAG_CANCELED;
> +		spin_unlock(&ubq->cancel_lock);
> +		ubq->canceling = false;
> +		ubq->fail_io = false;
> +	}
> +}
> +
>  /* device can only be started after all IOs are ready */
>  static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>  	__must_hold(&ub->mutex)
> @@ -1844,8 +1909,12 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>  		if (capable(CAP_SYS_ADMIN))
>  			ub->nr_privileged_daemon++;
>  	}
> -	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
> +
> +	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues) {
> +		/* now we are ready for handling ublk io request */
> +		ublk_reset_io_flags(ub);
>  		complete_all(&ub->completion);
> +	}
>  }
>  
>  static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
> @@ -2954,41 +3023,14 @@ static int ublk_ctrl_set_params(struct ublk_device *ub,
>  	return ret;
>  }
>  
> -static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
> -{
> -	int i;
> -
> -	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
> -
> -	/* All old ioucmds have to be completed */
> -	ubq->nr_io_ready = 0;
> -	/* old daemon is PF_EXITING, put it now */
> -	put_task_struct(ubq->ubq_daemon);
> -	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
> -	ubq->ubq_daemon = NULL;
> -	ubq->timeout = false;
> -
> -	for (i = 0; i < ubq->q_depth; i++) {
> -		struct ublk_io *io = &ubq->ios[i];
> -
> -		/* forget everything now and be ready for new FETCH_REQ */
> -		io->flags = 0;
> -		io->cmd = NULL;
> -		io->addr = 0;
> -	}
> -}
> -
>  static int ublk_ctrl_start_recovery(struct ublk_device *ub,
>  		const struct ublksrv_ctrl_cmd *header)
>  {
>  	int ret = -EINVAL;
> -	int i;
>  
>  	mutex_lock(&ub->mutex);
>  	if (ublk_nosrv_should_stop_dev(ub))
>  		goto out_unlock;
> -	if (!ub->nr_queues_ready)
> -		goto out_unlock;
>  	/*
>  	 * START_RECOVERY is only allowd after:
>  	 *
> @@ -3012,12 +3054,6 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
>  		goto out_unlock;
>  	}
>  	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
> -	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> -		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
> -	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
> -	ub->mm = NULL;
> -	ub->nr_queues_ready = 0;
> -	ub->nr_privileged_daemon = 0;
>  	init_completion(&ub->completion);
>  	ret = 0;
>   out_unlock:
> @@ -3030,7 +3066,6 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
>  {
>  	int ublksrv_pid = (int)header->data[0];
>  	int ret = -EINVAL;
> -	int i;
>  
>  	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
>  			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
> @@ -3050,22 +3085,10 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
>  		goto out_unlock;
>  	}
>  	ub->dev_info.ublksrv_pid = ublksrv_pid;
> +	ub->dev_info.state = UBLK_S_DEV_LIVE;
>  	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
>  			__func__, ublksrv_pid, header->dev_id);
> -
> -	blk_mq_quiesce_queue(ub->ub_disk->queue);
> -	ub->dev_info.state = UBLK_S_DEV_LIVE;
> -	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> -		struct ublk_queue *ubq = ublk_get_queue(ub, i);
> -
> -		ubq->canceling = false;
> -		ubq->fail_io = false;
> -	}
> -	blk_mq_unquiesce_queue(ub->ub_disk->queue);
> -	pr_devel("%s: queue unquiesced, dev id %d.\n",
> -			__func__, header->dev_id);
>  	blk_mq_kick_requeue_list(ub->ub_disk->queue);
> -
>  	ret = 0;
>   out_unlock:
>  	mutex_unlock(&ub->mutex);
> -- 
> 2.47.0
> 
