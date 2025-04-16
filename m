Received: from mail-qv1-f104.google.com (mail-qv1-f104.google.com [209.85.219.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A6208970
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 01:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765457; cv=none; b=FIKuohjLXh8k1usUfH18QM2M5bM9Zj/fuBpq/desl/cZbV5ke7sncwMaboILM9sEystiXFEEG20mAJhM0wPQFPgPJ/MRujcRxJNy4TsEWjqBpZPCC8FpNahhXqnYYstnyCHSLTMstbEVj40PcP+1CrEukB2hhFZUt8sRKiin/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765457; c=relaxed/simple;
	bh=EQ+bJT+5lBemedPMeNnieVHsqdLCMPUAOOQ5F5QZ1qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVoLHUiPLAKvRGmKdwOvZDN5Xlt+P4rfjrpgXD1CHV4Q0rFQwIsDLKdJ9GaW/pbN5fe4jhjB1WaqmdWfOJcxvhDnniC4JFDMVKaW1RQE4WPOOQTw0MED/PkIxWjJtaSkvrzwKHUdcIYrmhsT8XhxIhXQ7dMamTG11y85JEJuDFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A1ZyqZTR; arc=none smtp.client-ip=209.85.219.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A1ZyqZTR"
Received: by mail-qv1-f104.google.com with SMTP id 6a1803df08f44-6e8fc176825so49838556d6.0
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 18:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744765454; x=1745370254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bH471zvhRrvQqbsotE4IPd53HbvSCGzUst0hbr6krpc=;
        b=A1ZyqZTRKJaBIya1vkomi/SX2lgudCWy/DjMcahudOQBA0ACaJDhtee+Cb6ogWVLGo
         0eG7FquH9oLtEpX+s6WZu3IqeCYa66qTUEslVwJa7vSU26XNn6a8FyCPOiuzJN+yJI+D
         zcts+fOB/ZW1oDgf9hWm1RExiJjj2WWNBMs8g8O3ZM+4oLMlnNZU7hCdS3ey4/kDtUXM
         RVN5tQYyDmGMOAeQ8VF3dtLH8VbXddTpxTjr2iB7ey5I0loLvKflmJBuBcEyo2sggFVC
         Z/m6/vRy27TuTsEoU/QQFqnjkYqxSzlix90+0NJUYNlz6vEqorbK35Q/Dj4FzcTHhgeb
         9TxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744765454; x=1745370254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bH471zvhRrvQqbsotE4IPd53HbvSCGzUst0hbr6krpc=;
        b=HheaARXZ5jHHeBOnY7dJTE3Eaxs866axrIcyxnTCqMFsLPCyPe6LARmazt/8Q0uQzy
         qfN0br8z00lZ9Ib7yKGlMnogwje42Pq85wfjSgAPEWDPK0o1JL4Jujkx40d9dbPhahAg
         BZy7toGlIsDTPL1gXVXum1skqZqHst72EoLBxnwAT/h8cJ4nYo6oDhxaPbToh2von5Eg
         2e+95nmKfz+vIOzjxg8t+3oo/0YSza29huOqLd1pCsq32zs9vIeIZD3hmh1IMRLq7yP6
         9kVkL5ylL9PH8u6H6dExm376b+L0637i5UJ6NsSqXiuQkbVf1p/aBgyMCdAEVLaNahLS
         e/xA==
X-Forwarded-Encrypted: i=1; AJvYcCWJSWFpEr5SdXszKutUP9DqU4RQolKJ2FpMzS1znmbCQ6J8C9SfaPHEz3TM6pHuZizzMGLltdCmMLi/OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YykzcqnWCvz1+DacYY4RNmShmqSR5x8PvM83Kf4fyW7NpQkw3NU
	SsbOBls80fo3epDXrdXb3/GFG9AA17Ty3G6Q5gHNegeUpkjml3lYmucmugNZW0hEnDlsb2eUo6z
	Jp5L0EV2xhUw6txA4h6C91M8O2NoogUrK
X-Gm-Gg: ASbGncuTEqOkEz9fWDtxtAOqvnkq4cBHzsxL0CThnqfc4VBXEeme9uVDYhqAS/W685K
	rv+3QpMdp2V0DptMTcCTYaWrRXL38V7D0BLpf/Gz/DCn0PH0uV0JfG9lczyrAEt3BJMIClDe14c
	U94lrewDtpnhxCzg8V7lgBedteHGYRZ5vcNw2eBcf/nVbwqKWfffHbN+sv96MgmjkYE78xZjAfF
	Y84zNWB/P1YSqRh1o9uTe/pAji+Ttz2O8Mrwml/uHLSF5WtOVDPvd3GMWgedjdiUBqKHJqoe4QU
	Jt+CGeQ4r7HcURJdUBFCc6+p5RuyM+Z0kMMPdNY9tIQN9Q==
X-Google-Smtp-Source: AGHT+IEsBsD0YGizQF9FJSSlcyfmj8lIfBIf7s9HgpfdBUrG6AGwEz58F0x/ZwZaOwS25CrZewkV5E6yY8lB
X-Received: by 2002:a05:6214:5285:b0:6e8:f4e2:26e1 with SMTP id 6a1803df08f44-6f2ad8e5797mr25974436d6.20.1744765454049;
        Tue, 15 Apr 2025 18:04:14 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6f0de96e4absm7586936d6.17.2025.04.15.18.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 18:04:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 523433400DE;
	Tue, 15 Apr 2025 19:04:13 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 47897E40318; Tue, 15 Apr 2025 19:04:13 -0600 (MDT)
Date: Tue, 15 Apr 2025 19:04:13 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 2/9] ublk: properly serialize all FETCH_REQs
Message-ID: <Z/8CDUwcKNDRzyOU@dev-ushankar.dev.purestorage.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-3-ming.lei@redhat.com>
 <Z/1o946/z43QETPr@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/1o946/z43QETPr@dev-ushankar.dev.purestorage.com>

On Mon, Apr 14, 2025 at 01:58:47PM -0600, Uday Shankar wrote:
> On Mon, Apr 14, 2025 at 07:25:43PM +0800, Ming Lei wrote:
> > From: Uday Shankar <ushankar@purestorage.com>
> > 
> > Most uring_cmds issued against ublk character devices are serialized
> > because each command affects only one queue, and there is an early check
> > which only allows a single task (the queue's ubq_daemon) to issue
> > uring_cmds against that queue. However, this mechanism does not work for
> > FETCH_REQs, since they are expected before ubq_daemon is set. Since
> > FETCH_REQs are only used at initialization and not in the fast path,
> > serialize them using the per-ublk-device mutex. This fixes a number of
> > data races that were previously possible if a badly behaved ublk server
> > decided to issue multiple FETCH_REQs against the same qid/tag
> > concurrently.
> > 
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > Reported-by: Caleb Sander Mateos <csander@purestorage.com>
> > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> 
> Thanks for picking this up. Can you use the following patch instead? It
> has two changes compared to [1]:
> 
> - Factor FETCH command into its own function
> - Return -EAGAIN for non-blocking dispatch because we are taking a
>   mutex.
> 
> [1] https://lore.kernel.org/linux-block/20250410-ublk_task_per_io-v3-1-b811e8f4554a@purestorage.com/
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2fd05c1bd30b..8efb7668ab2c 100644
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
> @@ -1906,6 +1905,52 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
>  	return io_buffer_unregister_bvec(cmd, index, issue_flags);
>  }
>  
> +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
> +		      struct ublk_queue *ubq, struct ublk_io *io,
> +		      const struct ublksrv_io_cmd *ub_cmd,
> +		      unsigned int issue_flags)
> +{
> +	int ret = 0;
> +
> +	if (issue_flags & IO_URING_F_NONBLOCK)
> +		return -EAGAIN;
> +
> +	mutex_lock(&ub->mutex);
> +	/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
> +	if (ublk_queue_ready(ubq)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	/* allow each command to be FETCHed at most once */
> +	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
> +
> +	if (ublk_need_map_io(ubq)) {
> +		/*
> +		 * FETCH_RQ has to provide IO buffer if NEED GET
> +		 * DATA is not enabled
> +		 */
> +		if (!ub_cmd->addr && !ublk_need_get_data(ubq))
> +			goto out;
> +	} else if (ub_cmd->addr) {
> +		/* User copy requires addr to be unset */
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> +	ublk_mark_io_ready(ub, ubq);
> +
> +out:
> +	mutex_unlock(&ub->mutex);
> +	return ret;
> +}
> +
>  static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  			       unsigned int issue_flags,
>  			       const struct ublksrv_io_cmd *ub_cmd)
> @@ -1962,34 +2007,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  	case UBLK_IO_UNREGISTER_IO_BUF:
>  		return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_flags);
>  	case UBLK_IO_FETCH_REQ:
> -		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
> -		if (ublk_queue_ready(ubq)) {
> -			ret = -EBUSY;
> -			goto out;
> -		}
> -		/*
> -		 * The io is being handled by server, so COMMIT_RQ is expected
> -		 * instead of FETCH_REQ
> -		 */
> -		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
> -			goto out;
> -
> -		if (ublk_need_map_io(ubq)) {
> -			/*
> -			 * FETCH_RQ has to provide IO buffer if NEED GET
> -			 * DATA is not enabled
> -			 */
> -			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
> -				goto out;
> -		} else if (ub_cmd->addr) {
> -			/* User copy requires addr to be unset */
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -
> -		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> -		ublk_mark_io_ready(ub, ubq);
> -		break;
> +		return ublk_fetch(cmd, ub, ubq, io, ub_cmd, issue_flags);

One more bug here, this skips the

ublk_prep_cancel(cmd, issue_flags, ubq, tag);
return -EIOCBQUEUED;

that is after the switch statement.

>  	case UBLK_IO_COMMIT_AND_FETCH_REQ:
>  		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
>  
> 
