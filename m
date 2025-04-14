Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F401D86F6
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744663003; cv=none; b=AbD+mvTFvABSZ+h8wrFGqdX/4PN7nqd+qTncecOYCZGuhfZVMNofyU0S2u2aLJDw2aUKN2z1yqCe1jDKWQu8GP760mCpXK56YwRB3S9S9Ga1pZ2jv+I0g90TBEd+ZlaHXoIcqU2deLsEmKFs43yF3zgFQ3tt197FNh8tHdRvioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744663003; c=relaxed/simple;
	bh=nXhLRqRq7QAi+qzVD20kTCG+R3ZJcraaKKMHhOofkik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJWVGoZIsj0Yk+4jO/gSmB+C6cA7oTpXiuN2PLb51LwJZ2637P07IUNoMZFUVfcOk0ISxZINHrtrDUqiyk7+TmveSIqaWDT5Fdb5xzR97O+pyYM+EwAeZN4usYcFTWSpQwTH19m7GaAFgCTQQdEWZJ4nIx19wSv8UHXT38vz6+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OwXVbZi3; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OwXVbZi3"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-ae727e87c26so3243372a12.0
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744663000; x=1745267800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYnO505IH8naQS2Oe7MGUH+Xwr4a4hfAalbxBErzKnE=;
        b=OwXVbZi3uJIRqUB7CrAUq98WoxPuvoYCa/BuJHpMqBz7qVbILC7HBY9OAuDZhQrkgR
         xD2k04Uo2lsBIz/cDfL1GRJ1HvFVc9nQ9uNR6pYIKDYG0RF/XL44a447POxxp4nYddzW
         jWkqtJtfO6crZd1Rm0te2hTrC4KtIe+jJ1nqsrT51O3TJp9BLhqJ1BjibMCUynDmFEyp
         p+LAEY6h2+KdHgy6Y73g/JdgH9P+t7UWvYiqaQZEGKp+fWhgmbERwoTN4mGk3mSlGkBt
         DCglQWeWWfPj0XL8kNGgW1Ui6IK8asVqP5J8eXyn2lxwT12hBvt8b0CiUiz2BIuIbPH/
         pA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744663000; x=1745267800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYnO505IH8naQS2Oe7MGUH+Xwr4a4hfAalbxBErzKnE=;
        b=BQY3o5hTW6fkXM9ACk2axwi792POO82yFRP5r2uoyjZskFS19fe0eTPLTq8Po3npt5
         0BbNcpDoIJZ+DhwsDm3tAfeL8o9z6+5NLeQG0MS8LBcs9N1qBrjIjB+SM8LHuyDPoh4j
         9mrgQbGzRqwiF+O5Ef+NNEuSyfXMUValgq+vvPiEURQCm56BlewJk0T+R32AJ7rbXQCh
         IUaTRRFsqk+UTROG3kcHxYlwDDjeXsoearPywFvOHC466WQ2NoyLDIUVAg4MX43EjR7G
         v96sz7NZ54Pl2chFI2tABA5P9i6ORPdw1ACmZ1DdvFHODdOo/EsqkS0uFGiJtYJe+ix7
         GlnA==
X-Forwarded-Encrypted: i=1; AJvYcCWrGnDKI8Cl5PTRtjb1xG99ec+AbgSy2UpL/m2g26yW2EorJqEPM5Gw0njbgVk82avyNWIzkYq6PhWelA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyM95QEKmTJEKbL2E883ZzKf57ch+412JBqVEDzO3ZWD8RsqD2g
	fkszHaUleefXPIcSouiuMdf+G+VhWuVN9ec2US/MPW8Ir2duOneqjEVmptwZ9grxSa5ESSQ6KnW
	9e/aEM4ldbqyvTtxZvQNahnofpzmYIM6l
X-Gm-Gg: ASbGncv7Z/l1AmXQFKRCEt2WgbIHZxvRhGZ0WKt8A3BfpvLiqAghIQlvi4k17la4j+3
	tIvmXn7R8Fq2vSqUvsk81JvEYP2aAIYokTmYtIfbTObLFaM6Jit2LbG5CcAsOZwhV5ktGQYMhcJ
	N7tGKA2ozQFEs98Zds/tKi543yIqEH8K2XT+/AWpqnKZseZuMTrOl1gLmL2OmJXms9wKlVZqmf3
	6O9O2F5ZHQCxNBmTcss2G2JBLxPnoGqc7I2qsf/aPqm0EQhqOnhz2uphZWs/LN89vmQNArbwGNH
	S6+jc8l0wT9sPpgm0cHSBGvNTc+k9k8uhh0VwXwODQ+PWA==
X-Google-Smtp-Source: AGHT+IHQSEAkOJnlZ5NZ5DKfOCxaTTq0WPhHwh8aEpJ90YN7LxC5d1/kTsm1VhfmEUt4bYx9Y9WAj0GlKioo
X-Received: by 2002:a05:6a21:9007:b0:1f5:82ae:69d1 with SMTP id adf61e73a8af0-201797b7405mr20370233637.20.1744663000479;
        Mon, 14 Apr 2025 13:36:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b02a350d814sm773771a12.31.2025.04.14.13.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:36:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id AFC553401C3;
	Mon, 14 Apr 2025 14:36:39 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A1CE3E402BD; Mon, 14 Apr 2025 14:36:39 -0600 (MDT)
Date: Mon, 14 Apr 2025 14:36:39 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 6/9] ublk: improve detection and handling of ublk server
 exit
Message-ID: <Z/1x19wmebu/RnPK@dev-ushankar.dev.purestorage.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-7-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414112554.3025113-7-ming.lei@redhat.com>

On Mon, Apr 14, 2025 at 07:25:47PM +0800, Ming Lei wrote:
> From: Uday Shankar <ushankar@purestorage.com>
> 
> There are currently two ways in which ublk server exit is detected by
> ublk_drv:
> 
> 1. uring_cmd cancellation. If there are any outstanding uring_cmds which
>    have not been completed to the ublk server when it exits, io_uring
>    calls the uring_cmd callback with a special cancellation flag as the
>    issuing task is exiting.
> 2. I/O timeout. This is needed in addition to the above to handle the
>    "saturated queue" case, when all I/Os for a given queue are in the
>    ublk server, and therefore there are no outstanding uring_cmds to
>    cancel when the ublk server exits.
> 
> There are a couple of issues with this approach:
> 
> - It is complex and inelegant to have two methods to detect the same
>   condition
> - The second method detects ublk server exit only after a long delay
>   (~30s, the default timeout assigned by the block layer). This delays
>   the nosrv behavior from kicking in and potential subsequent recovery
>   of the device.
> 
> The second issue is brought to light with the new test_generic_06 which
> will be added in following patch. It fails before this fix:
> 
> selftests: ublk: test_generic_06.sh
> dev id is 0
> dd: error writing '/dev/ublkb0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 30.0611 s, 0.0 kB/s
> DEAD
> dd took 31 seconds to exit (>= 5s tolerance)!
> generic_06 : [FAIL]
> 
> Fix this by instead detecting and handling ublk server exit in the
> character file release callback. This has several advantages:
> 
> - This one place can handle both saturated and unsaturated queues. Thus,
>   it replaces both preexisting methods of detecting ublk server exit.
> - It runs quickly on ublk server exit - there is no 30s delay.
> - It starts the process of removing task references in ublk_drv. This is
>   needed if we want to relax restrictions in the driver like letting
>   only one thread serve each queue
> 
> There is also the disadvantage that the character file release callback
> can also be triggered by intentional close of the file, which is a
> significant behavior change. Preexisting ublk servers (libublksrv) are
> dependent on the ability to open/close the file multiple times. To
> address this, only transition to a nosrv state if the file is released
> while the ublk device is live. This allows for programs to open/close
> the file multiple times during setup. It is still a behavior change if a
> ublk server decides to close/reopen the file while the device is LIVE
> (i.e. while it is responsible for serving I/O), but that would be highly
> unusual. This behavior is in line with what is done by FUSE, which is
> very similar to ublk in that a userspace daemon is providing services
> traditionally provided by the kernel.
> 
> With this change in, the new test (and all other selftests, and all
> ublksrv tests) pass:
> 
> selftests: ublk: test_generic_06.sh
> dev id is 0
> dd: error writing '/dev/ublkb0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 0.0376731 s, 0.0 kB/s
> DEAD
> generic_04 : [PASS]
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 231 ++++++++++++++++++++++-----------------
>  1 file changed, 131 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index b68bd4172fa8..e02f205f6da4 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -199,8 +199,6 @@ struct ublk_device {
>  	struct completion	completion;
>  	unsigned int		nr_queues_ready;
>  	unsigned int		nr_privileged_daemon;
> -
> -	struct work_struct	nosrv_work;
>  };
>  
>  /* header of ublk_params */
> @@ -209,8 +207,9 @@ struct ublk_params_header {
>  	__u32	types;
>  };
>  
> -static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
> -
> +static void ublk_stop_dev_unlocked(struct ublk_device *ub);
> +static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
> +static void __ublk_quiesce_dev(struct ublk_device *ub);
>  static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
>  		struct ublk_queue *ubq, int tag, size_t offset);
>  static inline unsigned int ublk_req_build_flags(struct request *req);
> @@ -1336,8 +1335,6 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
>  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  {
>  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> -	unsigned int nr_inflight = 0;
> -	int i;
>  
>  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
>  		if (!ubq->timeout) {
> @@ -1348,26 +1345,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  		return BLK_EH_DONE;
>  	}
>  
> -	if (!ubq_daemon_is_dying(ubq))
> -		return BLK_EH_RESET_TIMER;
> -
> -	for (i = 0; i < ubq->q_depth; i++) {
> -		struct ublk_io *io = &ubq->ios[i];
> -
> -		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
> -			nr_inflight++;
> -	}
> -
> -	/* cancelable uring_cmd can't help us if all commands are in-flight */
> -	if (nr_inflight == ubq->q_depth) {
> -		struct ublk_device *ub = ubq->dev;
> -
> -		if (ublk_abort_requests(ub, ubq)) {
> -			schedule_work(&ub->nosrv_work);
> -		}
> -		return BLK_EH_DONE;
> -	}
> -
>  	return BLK_EH_RESET_TIMER;
>  }
>  
> @@ -1525,13 +1502,112 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
>  	ub->nr_privileged_daemon = 0;
>  }
>  
> +static struct gendisk *ublk_get_disk(struct ublk_device *ub)
> +{
> +	struct gendisk *disk;
> +
> +	spin_lock(&ub->lock);
> +	disk = ub->ub_disk;
> +	if (disk)
> +		get_device(disk_to_dev(disk));
> +	spin_unlock(&ub->lock);
> +
> +	return disk;
> +}
> +
> +static void ublk_put_disk(struct gendisk *disk)
> +{
> +	if (disk)
> +		put_device(disk_to_dev(disk));
> +}
> +
>  static int ublk_ch_release(struct inode *inode, struct file *filp)
>  {
>  	struct ublk_device *ub = filp->private_data;
> +	struct gendisk *disk;
> +	int i;
> +
> +	/*
> +	 * disk isn't attached yet, either device isn't live, or it has
> +	 * been removed already, so we needn't to do anything
> +	 */
> +	disk = ublk_get_disk(ub);
> +	if (!disk)
> +		goto out;
> +
> +	/*
> +	 * All uring_cmd are done now, so abort any request outstanding to
> +	 * the ublk server
> +	 *
> +	 * This can be done in lockless way because ublk server has been
> +	 * gone
> +	 *
> +	 * More importantly, we have to provide forward progress guarantee
> +	 * without holding ub->mutex, otherwise control task grabbing
> +	 * ub->mutex triggers deadlock
> +	 *
> +	 * All requests may be inflight, so ->canceling may not be set, set
> +	 * it now.
> +	 */
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> +		struct ublk_queue *ubq = ublk_get_queue(ub, i);
> +
> +		ubq->canceling = true;
> +		ublk_abort_queue(ub, ubq);
> +	}
> +	blk_mq_kick_requeue_list(disk->queue);
> +
> +	/*
> +	 * All infligh requests have been completed or requeued and any new
> +	 * request will be failed or requeued via `->canceling` now, so it is
> +	 * fine to grab ub->mutex now.
> +	 */
> +	mutex_lock(&ub->mutex);
> +
> +	/* double check after grabbing lock */
> +	if (!ub->ub_disk)
> +		goto unlock;
> +
> +	/*
> +	 * Transition the device to the nosrv state. What exactly this
> +	 * means depends on the recovery flags
> +	 */
> +	blk_mq_quiesce_queue(disk->queue);
> +	if (ublk_nosrv_should_stop_dev(ub)) {
> +		/*
> +		 * Allow any pending/future I/O to pass through quickly
> +		 * with an error. This is needed because del_gendisk
> +		 * waits for all pending I/O to complete
> +		 */
> +		for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +			ublk_get_queue(ub, i)->force_abort = true;
> +		blk_mq_unquiesce_queue(disk->queue);
> +
> +		ublk_stop_dev_unlocked(ub);
> +	} else {
> +		if (ublk_nosrv_dev_should_queue_io(ub)) {
> +			/*
> +			 * keep request queue as quiesced for queuing new IO
> +			 * during QUIESCED state
> +			 *
> +			 * request queue will be unquiesced in ending
> +			 * recovery, see ublk_ctrl_end_recovery
> +			 */

Does this comment need an update after

[PATCH 4/9] ublk: rely on ->canceling for dealing with ublk_nosrv_dev_should_queue_io

If I read that one right, actually the request queue is not quiesced
anymore during the UBLK_S_DEV_QUIESCED state

> +			__ublk_quiesce_dev(ub);
> +		} else {
> +			ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
> +			for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +				ublk_get_queue(ub, i)->fail_io = true;
> +		}
> +		blk_mq_unquiesce_queue(disk->queue);
> +	}
> +unlock:
> +	mutex_unlock(&ub->mutex);
> +	ublk_put_disk(disk);
>  
>  	/* all uring_cmd has been done now, reset device & ubq */
>  	ublk_reset_ch_dev(ub);
> -
> +out:
>  	clear_bit(UB_STATE_OPEN, &ub->state);
>  	return 0;
>  }
> @@ -1627,37 +1703,22 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
>  }
>  
>  /* Must be called when queue is frozen */
> -static bool ublk_mark_queue_canceling(struct ublk_queue *ubq)
> +static void ublk_mark_queue_canceling(struct ublk_queue *ubq)
>  {
> -	bool canceled;
> -
>  	spin_lock(&ubq->cancel_lock);
> -	canceled = ubq->canceling;
> -	if (!canceled)
> +	if (!ubq->canceling)
>  		ubq->canceling = true;
>  	spin_unlock(&ubq->cancel_lock);
> -
> -	return canceled;
>  }
>  
> -static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
> +static void ublk_start_cancel(struct ublk_queue *ubq)
>  {
> -	bool was_canceled = ubq->canceling;
> -	struct gendisk *disk;
> -
> -	if (was_canceled)
> -		return false;
> -
> -	spin_lock(&ub->lock);
> -	disk = ub->ub_disk;
> -	if (disk)
> -		get_device(disk_to_dev(disk));
> -	spin_unlock(&ub->lock);
> +	struct ublk_device *ub = ubq->dev;
> +	struct gendisk *disk = ublk_get_disk(ub);
>  
>  	/* Our disk has been dead */
>  	if (!disk)
> -		return false;
> -
> +		return;
>  	/*
>  	 * Now we are serialized with ublk_queue_rq()
>  	 *
> @@ -1666,15 +1727,9 @@ static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
>  	 * touch completed uring_cmd
>  	 */
>  	blk_mq_quiesce_queue(disk->queue);
> -	was_canceled = ublk_mark_queue_canceling(ubq);
> -	if (!was_canceled) {
> -		/* abort queue is for making forward progress */
> -		ublk_abort_queue(ub, ubq);
> -	}
> +	ublk_mark_queue_canceling(ubq);
>  	blk_mq_unquiesce_queue(disk->queue);
> -	put_device(disk_to_dev(disk));
> -
> -	return !was_canceled;
> +	ublk_put_disk(disk);
>  }
>  
>  static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
> @@ -1698,6 +1753,17 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
>  /*
>   * The ublk char device won't be closed when calling cancel fn, so both
>   * ublk device and queue are guaranteed to be live
> + *
> + * Two-stage cancel:
> + *
> + * - make every active uring_cmd done in ->cancel_fn()
> + *
> + * - aborting inflight ublk IO requests in ublk char device release handler,
> + *   which depends on 1st stage because device can only be closed iff all
> + *   uring_cmd are done
> + *
> + * Do _not_ try to acquire ub->mutex before all inflight requests are
> + * aborted, otherwise deadlock may be caused.
>   */
>  static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
>  		unsigned int issue_flags)
> @@ -1705,8 +1771,6 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
>  	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
>  	struct ublk_queue *ubq = pdu->ubq;
>  	struct task_struct *task;
> -	struct ublk_device *ub;
> -	bool need_schedule;
>  	struct ublk_io *io;
>  
>  	if (WARN_ON_ONCE(!ubq))
> @@ -1719,16 +1783,12 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
>  	if (WARN_ON_ONCE(task && task != ubq->ubq_daemon))
>  		return;
>  
> -	ub = ubq->dev;
> -	need_schedule = ublk_abort_requests(ub, ubq);
> +	if (!ubq->canceling)
> +		ublk_start_cancel(ubq);
>  
>  	io = &ubq->ios[pdu->tag];
>  	WARN_ON_ONCE(io->cmd != cmd);
>  	ublk_cancel_cmd(ubq, io, issue_flags);
> -
> -	if (need_schedule) {
> -		schedule_work(&ub->nosrv_work);
> -	}
>  }
>  
>  static inline bool ublk_queue_ready(struct ublk_queue *ubq)
> @@ -1779,6 +1839,7 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
>  	}
>  }
>  
> +/* Now all inflight requests have been aborted */
>  static void __ublk_quiesce_dev(struct ublk_device *ub)
>  {
>  	int i;
> @@ -1787,13 +1848,11 @@ static void __ublk_quiesce_dev(struct ublk_device *ub)
>  			__func__, ub->dev_info.dev_id,
>  			ub->dev_info.state == UBLK_S_DEV_LIVE ?
>  			"LIVE" : "QUIESCED");
> -	blk_mq_quiesce_queue(ub->ub_disk->queue);
>  	/* mark every queue as canceling */
>  	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
>  		ublk_get_queue(ub, i)->canceling = true;
>  	ublk_wait_tagset_rqs_idle(ub);
>  	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
> -	blk_mq_unquiesce_queue(ub->ub_disk->queue);
>  }
>  
>  static void ublk_force_abort_dev(struct ublk_device *ub)
> @@ -1830,50 +1889,25 @@ static struct gendisk *ublk_detach_disk(struct ublk_device *ub)
>  	return disk;
>  }
>  
> -static void ublk_stop_dev(struct ublk_device *ub)
> +static void ublk_stop_dev_unlocked(struct ublk_device *ub)
> +	__must_hold(&ub->mutex)
>  {
>  	struct gendisk *disk;
>  
> -	mutex_lock(&ub->mutex);
>  	if (!ub->ub_disk)
> -		goto unlock;
> +		return;
> +
>  	if (ublk_nosrv_dev_should_queue_io(ub))
>  		ublk_force_abort_dev(ub);
>  	del_gendisk(ub->ub_disk);
>  	disk = ublk_detach_disk(ub);
>  	put_disk(disk);
> - unlock:
> -	mutex_unlock(&ub->mutex);
> -	ublk_cancel_dev(ub);
>  }
>  
> -static void ublk_nosrv_work(struct work_struct *work)
> +static void ublk_stop_dev(struct ublk_device *ub)
>  {
> -	struct ublk_device *ub =
> -		container_of(work, struct ublk_device, nosrv_work);
> -	int i;
> -
> -	if (ublk_nosrv_should_stop_dev(ub)) {
> -		ublk_stop_dev(ub);
> -		return;
> -	}
> -
>  	mutex_lock(&ub->mutex);
> -	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
> -		goto unlock;
> -
> -	if (ublk_nosrv_dev_should_queue_io(ub)) {
> -		__ublk_quiesce_dev(ub);
> -	} else {
> -		blk_mq_quiesce_queue(ub->ub_disk->queue);
> -		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
> -		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> -			ublk_get_queue(ub, i)->fail_io = true;
> -		}
> -		blk_mq_unquiesce_queue(ub->ub_disk->queue);
> -	}
> -
> - unlock:
> +	ublk_stop_dev_unlocked(ub);
>  	mutex_unlock(&ub->mutex);
>  	ublk_cancel_dev(ub);
>  }
> @@ -2491,7 +2525,6 @@ static void ublk_remove(struct ublk_device *ub)
>  	bool unprivileged;
>  
>  	ublk_stop_dev(ub);
> -	cancel_work_sync(&ub->nosrv_work);
>  	cdev_device_del(&ub->cdev, &ub->cdev_dev);
>  	unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
>  	ublk_put_device(ub);
> @@ -2776,7 +2809,6 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
>  		goto out_unlock;
>  	mutex_init(&ub->mutex);
>  	spin_lock_init(&ub->lock);
> -	INIT_WORK(&ub->nosrv_work, ublk_nosrv_work);
>  
>  	ret = ublk_alloc_dev_number(ub, header->dev_id);
>  	if (ret < 0)
> @@ -2908,7 +2940,6 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
>  static int ublk_ctrl_stop_dev(struct ublk_device *ub)
>  {
>  	ublk_stop_dev(ub);
> -	cancel_work_sync(&ub->nosrv_work);
>  	return 0;
>  }
>  
> -- 
> 2.47.0
> 
