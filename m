Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450C1CAA6D
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744662596; cv=none; b=GzVLNA9zTnH+YLVOTXQYmpQAjoP79npCY0nMd/Eh1hGxrOE7LPjq3kzBqaQVs/TY39JF6VXJ7ivVAvLW8Tx7p8l9FMGAS+qagMGSaQRwsyRN+3sFaB1H04tHhPMk2txokgog/qK45PUEdYJagwJIEderxmejTzqNHXrsHGlJhyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744662596; c=relaxed/simple;
	bh=M8lYlmAeoBCfIbLDuonxe0Z0sT9ZAIpC8LGN6qy8r4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2PYY3kjB+SeMBe0+DX7fsjDN3U0cY22qgX0rnG67AwaHSAbdPKmGjHhp5NNDvnPk+CECDlhZ8HFNuzvVZUnM+lb0mvz9zP8tgA9HsmnHR6WV/8dhfkywTSFbR6qx5f2R1BzA9Rq3HA++YxwISqGSSZ3xrNGi83LELWhGEMcTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=e6T/Pd4W; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="e6T/Pd4W"
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-6e8f6970326so46780406d6.0
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744662590; x=1745267390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TcKUepAOspzesy4uSp3Ci8+LxHSawsgaP+KW6hcAGDQ=;
        b=e6T/Pd4WKYRv8jtVifS3nG8fjZvvz0NMgYcT8hZlVVnMFZ7wMUWJ7wjQT6IUIWKtkF
         g3pQjH3iWLaYjFiRuqNUWZFgviLEnt53y05rKr++mrI9x5E3N4NGrn6NPuGcKQiTEQk+
         LkK8DIcZS1yfGqTLkxVVTueMbYsKUAKWsKYFNsKGlwPsqgQIS/MN1/8MFHlUt+tWJnPL
         rUei2PJfDHCt4SapqSDsVbyudRkhpDuBiVqwY//bgCtwbtWl2gMdVco7U8byifklHbI7
         nax7nep6Y3u4PLFtJR/cXE7MWmEmzU4aZZhVvTpEu8NP3gjP1/a6lwlrc3SFsLfM5hms
         a7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744662590; x=1745267390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcKUepAOspzesy4uSp3Ci8+LxHSawsgaP+KW6hcAGDQ=;
        b=mJcXEO05xtffMbgDNY5ZBQZxKn/DRWpfC7OxVmmNnoLIt9vnfEita1c+/zZtkF45Gv
         wGWCnE8E/kMpWoiwtIVlq/Zv3NLUqGGz/FY7wN+BNp4FHHkjHjfipSmjJgtor1aSFZlO
         4EOd9GB47EABJW+aidZJvCWMv4tkbdLRwUb9c5aEpoCZZy7YKzNLjw8aGau9gPPDFWcU
         aW1SORzs+WafZ0yivrY4E/k+fsChkvoA7pc6txGIeInc+Takr+4nJaPt8Ydu/1Lr0cHV
         0Tpq1LSSpfzTb7HtlW0otyukWafqH08XEU1vdAUDiXldqC8gL17z9nQZDP6c3T/qD25J
         zVcg==
X-Forwarded-Encrypted: i=1; AJvYcCVOo9lMwRduk+uvrHvy8Qln52rA6jKKru18Dx05Q45l1M0Mn2zFUq9fTo0wxc6K3zMmjXDwiGiBIQ3gsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk6pP01yPChYb54pFmNkhLXiuLYTjZhsj37QSvtNFx/PHNqLUH
	HTSlyjTnR57kWuu0v1UY5TF4r+6IFuDNVPIzLnMXLSm/cwHhIHGMAgWuIkZmsnmu5Bc68KtTiHh
	HpYvMssZ8esi3d3AhTXI+Fbc6rR9wYiNk8EtGXp7mCbOYoTQR
X-Gm-Gg: ASbGncux+ENu9GqkxiMfAZAU7kVQsAuT+cdDipLmuaBP2Ng2twQeyNNh4bXa3vef7Ld
	igeQwqPF9EiuUllzla7xP2CetTmpxotk0Ucgw95npO4Yf8xLGKqn6bhN7sQKaCQMILOKUcaRxXV
	Ppit2e/M+g5JfqHo6SFbwO84aRW+ez3un61gP1eA0zExQ2lbwoJkcojiz90gXWb4VGpEUoTOTrp
	Gf8WrM/fvvAWuDyugqXdqz31L9fxh5sagOvUkEuMTCqsrlA8VNEA7zLdZuD5mfqHYI8EQSpR1Cs
	iTTfOjuobW8uxK/lSvKx9mgmsKo8tD4=
X-Google-Smtp-Source: AGHT+IHGnpEqodASnsKvgYiMBnln4Dz7F89pWOfwp9UzB82ok4xiWNNOgeA8/7B5LJUsFXbOxWnMMIXx+tvB
X-Received: by 2002:ad4:5d69:0:b0:6e8:f4c6:681a with SMTP id 6a1803df08f44-6f230d22749mr191824366d6.12.1744662590038;
        Mon, 14 Apr 2025 13:29:50 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6f0dea12d70sm7053546d6.61.2025.04.14.13.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:29:50 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E93C23401C3;
	Mon, 14 Apr 2025 14:29:48 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id DBAB8E402BD; Mon, 14 Apr 2025 14:29:48 -0600 (MDT)
Date: Mon, 14 Apr 2025 14:29:48 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 5/9] ublk: move device reset into ublk_ch_release()
Message-ID: <Z/1wPCiGOlFgcrpq@dev-ushankar.dev.purestorage.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-6-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414112554.3025113-6-ming.lei@redhat.com>

On Mon, Apr 14, 2025 at 07:25:46PM +0800, Ming Lei wrote:
> ublk_ch_release() is called after ublk char device is closed, when all
> uring_cmd are done, so it is perfect fine to move ublk device reset to
> ublk_ch_release() from ublk_ctrl_start_recovery().
> 
> This way can avoid to grab the exiting daemon task_struct too long.

Nice, I had noticed this leak too, where we keep the task struct ref
until the new daemon comes around. Thanks for the fix!

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
> index e0213222e3cf..b68bd4172fa8 100644
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

Do we need this? I think at this point there shouldn't be any concurrent
activity we need to protect against.

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
> @@ -2943,41 +3012,14 @@ static int ublk_ctrl_set_params(struct ublk_device *ub,
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
> @@ -3001,12 +3043,6 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
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
> @@ -3019,7 +3055,6 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
>  {
>  	int ublksrv_pid = (int)header->data[0];
>  	int ret = -EINVAL;
> -	int i;
>  
>  	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
>  			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
> @@ -3039,22 +3074,10 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
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
