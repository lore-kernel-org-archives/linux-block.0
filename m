Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE598E552
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682071; cv=none; b=CTxkBycASSP2yszen5XXP6uXRpwyLYlCtlC8Ip+3f3vsJkENrvKk3fk0guobc1EHy8dh19W4h4thd65jQiCVO+fG3ubzz5jzxp7n7r/FtP6bsgR+vSS0phvXDaNuZr44+Q+Ce2MsHZ6PA1pA/3NC9dJZY2PGGfqrpSEfcnRmp3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682071; c=relaxed/simple;
	bh=IjZx5rx5a+jvZxtLHl9iAXxduGPMEAjEV4LG6yoDzJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kI702zujmOQCjA1LHQ3EKNWBe2Nn7l7Khq7M1wVxHMAdDr3RAhC3ZEV74jzy5jNUthbyBDm3wYugPRah0Rhg92aWSGy8xHPg7nKvcbU1llVEOW7WktcKOh2NQN88Er9PS3GswGzVkn2XG+L8JpKFMPjvRZg1ZlT0TEoQhuSX8J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VsavNC8D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsavNC8D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744682068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bv+71sG9aL+YdaYhhzlDbu0qTChlc3DZdztdQ7t3rZ4=;
	b=VsavNC8DkKBs2Iceh8ycOKWLIJfMk/qa3ihrDYjlQhDMpHNsqoiktysRj1R8pFjEvtAbo/
	f+e8qLlfcgzZ65HIqzGty5aSTgj7618atDU6gSXSVam6jhS80/Q1vS/sxQAm2vOfk6s5Tl
	CHqY/Ms0mb7/OGT+L8MNEXOnNp/gkq8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-rtkGZFwWP7e4tyEqcsAKdA-1; Mon,
 14 Apr 2025 21:54:23 -0400
X-MC-Unique: rtkGZFwWP7e4tyEqcsAKdA-1
X-Mimecast-MFC-AGG-ID: rtkGZFwWP7e4tyEqcsAKdA_1744682062
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64FD31800266;
	Tue, 15 Apr 2025 01:54:21 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13FD5180B488;
	Tue, 15 Apr 2025 01:54:17 +0000 (UTC)
Date: Tue, 15 Apr 2025 09:54:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 6/9] ublk: improve detection and handling of ublk server
 exit
Message-ID: <Z_28RbNHq1Knm6Ef@fedora>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-7-ming.lei@redhat.com>
 <Z/1x19wmebu/RnPK@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/1x19wmebu/RnPK@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Apr 14, 2025 at 02:36:39PM -0600, Uday Shankar wrote:
> On Mon, Apr 14, 2025 at 07:25:47PM +0800, Ming Lei wrote:
> > From: Uday Shankar <ushankar@purestorage.com>
> > 
> > There are currently two ways in which ublk server exit is detected by
> > ublk_drv:
> > 
> > 1. uring_cmd cancellation. If there are any outstanding uring_cmds which
> >    have not been completed to the ublk server when it exits, io_uring
> >    calls the uring_cmd callback with a special cancellation flag as the
> >    issuing task is exiting.
> > 2. I/O timeout. This is needed in addition to the above to handle the
> >    "saturated queue" case, when all I/Os for a given queue are in the
> >    ublk server, and therefore there are no outstanding uring_cmds to
> >    cancel when the ublk server exits.
> > 
> > There are a couple of issues with this approach:
> > 
> > - It is complex and inelegant to have two methods to detect the same
> >   condition
> > - The second method detects ublk server exit only after a long delay
> >   (~30s, the default timeout assigned by the block layer). This delays
> >   the nosrv behavior from kicking in and potential subsequent recovery
> >   of the device.
> > 
> > The second issue is brought to light with the new test_generic_06 which
> > will be added in following patch. It fails before this fix:
> > 
> > selftests: ublk: test_generic_06.sh
> > dev id is 0
> > dd: error writing '/dev/ublkb0': Input/output error
> > 1+0 records in
> > 0+0 records out
> > 0 bytes copied, 30.0611 s, 0.0 kB/s
> > DEAD
> > dd took 31 seconds to exit (>= 5s tolerance)!
> > generic_06 : [FAIL]
> > 
> > Fix this by instead detecting and handling ublk server exit in the
> > character file release callback. This has several advantages:
> > 
> > - This one place can handle both saturated and unsaturated queues. Thus,
> >   it replaces both preexisting methods of detecting ublk server exit.
> > - It runs quickly on ublk server exit - there is no 30s delay.
> > - It starts the process of removing task references in ublk_drv. This is
> >   needed if we want to relax restrictions in the driver like letting
> >   only one thread serve each queue
> > 
> > There is also the disadvantage that the character file release callback
> > can also be triggered by intentional close of the file, which is a
> > significant behavior change. Preexisting ublk servers (libublksrv) are
> > dependent on the ability to open/close the file multiple times. To
> > address this, only transition to a nosrv state if the file is released
> > while the ublk device is live. This allows for programs to open/close
> > the file multiple times during setup. It is still a behavior change if a
> > ublk server decides to close/reopen the file while the device is LIVE
> > (i.e. while it is responsible for serving I/O), but that would be highly
> > unusual. This behavior is in line with what is done by FUSE, which is
> > very similar to ublk in that a userspace daemon is providing services
> > traditionally provided by the kernel.
> > 
> > With this change in, the new test (and all other selftests, and all
> > ublksrv tests) pass:
> > 
> > selftests: ublk: test_generic_06.sh
> > dev id is 0
> > dd: error writing '/dev/ublkb0': Input/output error
> > 1+0 records in
> > 0+0 records out
> > 0 bytes copied, 0.0376731 s, 0.0 kB/s
> > DEAD
> > generic_04 : [PASS]
> > 
> > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 231 ++++++++++++++++++++++-----------------
> >  1 file changed, 131 insertions(+), 100 deletions(-)
> > 
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index b68bd4172fa8..e02f205f6da4 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -199,8 +199,6 @@ struct ublk_device {
> >  	struct completion	completion;
> >  	unsigned int		nr_queues_ready;
> >  	unsigned int		nr_privileged_daemon;
> > -
> > -	struct work_struct	nosrv_work;
> >  };
> >  
> >  /* header of ublk_params */
> > @@ -209,8 +207,9 @@ struct ublk_params_header {
> >  	__u32	types;
> >  };
> >  
> > -static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
> > -
> > +static void ublk_stop_dev_unlocked(struct ublk_device *ub);
> > +static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
> > +static void __ublk_quiesce_dev(struct ublk_device *ub);
> >  static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
> >  		struct ublk_queue *ubq, int tag, size_t offset);
> >  static inline unsigned int ublk_req_build_flags(struct request *req);
> > @@ -1336,8 +1335,6 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
> >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> >  {
> >  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> > -	unsigned int nr_inflight = 0;
> > -	int i;
> >  
> >  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> >  		if (!ubq->timeout) {
> > @@ -1348,26 +1345,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> >  		return BLK_EH_DONE;
> >  	}
> >  
> > -	if (!ubq_daemon_is_dying(ubq))
> > -		return BLK_EH_RESET_TIMER;
> > -
> > -	for (i = 0; i < ubq->q_depth; i++) {
> > -		struct ublk_io *io = &ubq->ios[i];
> > -
> > -		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
> > -			nr_inflight++;
> > -	}
> > -
> > -	/* cancelable uring_cmd can't help us if all commands are in-flight */
> > -	if (nr_inflight == ubq->q_depth) {
> > -		struct ublk_device *ub = ubq->dev;
> > -
> > -		if (ublk_abort_requests(ub, ubq)) {
> > -			schedule_work(&ub->nosrv_work);
> > -		}
> > -		return BLK_EH_DONE;
> > -	}
> > -
> >  	return BLK_EH_RESET_TIMER;
> >  }
> >  
> > @@ -1525,13 +1502,112 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
> >  	ub->nr_privileged_daemon = 0;
> >  }
> >  
> > +static struct gendisk *ublk_get_disk(struct ublk_device *ub)
> > +{
> > +	struct gendisk *disk;
> > +
> > +	spin_lock(&ub->lock);
> > +	disk = ub->ub_disk;
> > +	if (disk)
> > +		get_device(disk_to_dev(disk));
> > +	spin_unlock(&ub->lock);
> > +
> > +	return disk;
> > +}
> > +
> > +static void ublk_put_disk(struct gendisk *disk)
> > +{
> > +	if (disk)
> > +		put_device(disk_to_dev(disk));
> > +}
> > +
> >  static int ublk_ch_release(struct inode *inode, struct file *filp)
> >  {
> >  	struct ublk_device *ub = filp->private_data;
> > +	struct gendisk *disk;
> > +	int i;
> > +
> > +	/*
> > +	 * disk isn't attached yet, either device isn't live, or it has
> > +	 * been removed already, so we needn't to do anything
> > +	 */
> > +	disk = ublk_get_disk(ub);
> > +	if (!disk)
> > +		goto out;
> > +
> > +	/*
> > +	 * All uring_cmd are done now, so abort any request outstanding to
> > +	 * the ublk server
> > +	 *
> > +	 * This can be done in lockless way because ublk server has been
> > +	 * gone
> > +	 *
> > +	 * More importantly, we have to provide forward progress guarantee
> > +	 * without holding ub->mutex, otherwise control task grabbing
> > +	 * ub->mutex triggers deadlock
> > +	 *
> > +	 * All requests may be inflight, so ->canceling may not be set, set
> > +	 * it now.
> > +	 */
> > +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> > +		struct ublk_queue *ubq = ublk_get_queue(ub, i);
> > +
> > +		ubq->canceling = true;
> > +		ublk_abort_queue(ub, ubq);
> > +	}
> > +	blk_mq_kick_requeue_list(disk->queue);
> > +
> > +	/*
> > +	 * All infligh requests have been completed or requeued and any new
> > +	 * request will be failed or requeued via `->canceling` now, so it is
> > +	 * fine to grab ub->mutex now.
> > +	 */
> > +	mutex_lock(&ub->mutex);
> > +
> > +	/* double check after grabbing lock */
> > +	if (!ub->ub_disk)
> > +		goto unlock;
> > +
> > +	/*
> > +	 * Transition the device to the nosrv state. What exactly this
> > +	 * means depends on the recovery flags
> > +	 */
> > +	blk_mq_quiesce_queue(disk->queue);
> > +	if (ublk_nosrv_should_stop_dev(ub)) {
> > +		/*
> > +		 * Allow any pending/future I/O to pass through quickly
> > +		 * with an error. This is needed because del_gendisk
> > +		 * waits for all pending I/O to complete
> > +		 */
> > +		for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> > +			ublk_get_queue(ub, i)->force_abort = true;
> > +		blk_mq_unquiesce_queue(disk->queue);
> > +
> > +		ublk_stop_dev_unlocked(ub);
> > +	} else {
> > +		if (ublk_nosrv_dev_should_queue_io(ub)) {
> > +			/*
> > +			 * keep request queue as quiesced for queuing new IO
> > +			 * during QUIESCED state
> > +			 *
> > +			 * request queue will be unquiesced in ending
> > +			 * recovery, see ublk_ctrl_end_recovery
> > +			 */
> 
> Does this comment need an update after
> 
> [PATCH 4/9] ublk: rely on ->canceling for dealing with ublk_nosrv_dev_should_queue_io
> 
> If I read that one right, actually the request queue is not quiesced
> anymore during the UBLK_S_DEV_QUIESCED state

The comment is removed actually in the following patch, but it shouldn't have
been added here, will do it in V2.


Thanks, 
Ming

