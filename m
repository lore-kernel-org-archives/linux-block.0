Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EE8E552
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744681873; cv=none; b=LOi/rbJGUKp9r7gNEs2xN5PH3fp/Uio9jVVVK05H4WNRsRjE+ok/rxfDcwYjQOzrH2ktoMWoKuVU2Ly+4RrBUsH+g6MdveHbxlCVmBVbLxowO9tXUBKNDI2FMj8/wX8gQpSfWy5jGdepWnaNq/dsvMRF8Ybn7QEKm4Egn6NogrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744681873; c=relaxed/simple;
	bh=W6QzXK2WCGIPGAZ742GpSOAuMmHPGfAmVmxrrgcpB6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VY+RAUkBlZA7b/TuGmupW6Cw1osirKii4CLkhtalul1ECFjDFq8o3broH9A2fATuW00AExa8KXtMVHNzN0egJGQbi57vrWDw/3rlEk3rPY/GHeLmZLmvoYe3QMfSyeYIcCwykFVDwBIYUb1rKADur/gr4GWaZSgS0qJQ01Y1OEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8yZIt73; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8yZIt73"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744681870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MUr983zezsQZYqVR4aigpZ+AoXn5g8+atDQkkyvy8xg=;
	b=b8yZIt73ZwimJSglzUq1/KcRXNqXUxeQrxsbaaTZ4qoR7HtgKV6hn/VhuW/86sFb8YVrUG
	CdxDT5RPiY2dI3LNWjcuelD+ATm/mR4xtta8Bnsu9hLSojDQWkJguNNqRSJs7Ycb9vUh3/
	ozf/TE3GkCBHCeOMQ1OIvuwiZ/5kX+E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-U5QUlB77Ny2xacntjn-T2g-1; Mon,
 14 Apr 2025 21:51:07 -0400
X-MC-Unique: U5QUlB77Ny2xacntjn-T2g-1
X-Mimecast-MFC-AGG-ID: U5QUlB77Ny2xacntjn-T2g_1744681866
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19B2B180AF4D;
	Tue, 15 Apr 2025 01:51:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAF4A19560AD;
	Tue, 15 Apr 2025 01:51:02 +0000 (UTC)
Date: Tue, 15 Apr 2025 09:50:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 5/9] ublk: move device reset into ublk_ch_release()
Message-ID: <Z_27gfyGMY9peuYb@fedora>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-6-ming.lei@redhat.com>
 <Z/1wPCiGOlFgcrpq@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/1wPCiGOlFgcrpq@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Apr 14, 2025 at 02:29:48PM -0600, Uday Shankar wrote:
> On Mon, Apr 14, 2025 at 07:25:46PM +0800, Ming Lei wrote:
> > ublk_ch_release() is called after ublk char device is closed, when all
> > uring_cmd are done, so it is perfect fine to move ublk device reset to
> > ublk_ch_release() from ublk_ctrl_start_recovery().
> > 
> > This way can avoid to grab the exiting daemon task_struct too long.
> 
> Nice, I had noticed this leak too, where we keep the task struct ref
> until the new daemon comes around. Thanks for the fix!
> 
> > 
> > However, reset of the following ublk IO flags has to be moved until ublk
> > io_uring queues are ready:
> > 
> > - ubq->canceling
> > 
> > For requeuing IO in case of ublk_nosrv_dev_should_queue_io() before device
> > is recovered
> > 
> > - ubq->fail_io
> > 
> > For failing IO in case of UBLK_F_USER_RECOVERY_FAIL_IO before device is
> > recovered
> > 
> > - ublk_io->flags
> > 
> > For preventing using io->cmd
> > 
> > With this way, recovery is simplified a lot.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 121 +++++++++++++++++++++++----------------
> >  1 file changed, 72 insertions(+), 49 deletions(-)
> > 
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index e0213222e3cf..b68bd4172fa8 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1074,7 +1074,7 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
> >  
> >  static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
> >  {
> > -	return ubq->ubq_daemon->flags & PF_EXITING;
> > +	return !ubq->ubq_daemon || ubq->ubq_daemon->flags & PF_EXITING;
> >  }
> >  
> >  /* todo: handle partial completion */
> > @@ -1470,6 +1470,37 @@ static const struct blk_mq_ops ublk_mq_ops = {
> >  	.timeout	= ublk_timeout,
> >  };
> >  
> > +static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
> > +{
> > +	int i;
> > +
> > +	/* All old ioucmds have to be completed */
> > +	ubq->nr_io_ready = 0;
> > +
> > +	/*
> > +	 * old daemon is PF_EXITING, put it now
> > +	 *
> > +	 * It could be NULL in case of closing one quisced device.
> > +	 */
> > +	if (ubq->ubq_daemon)
> > +		put_task_struct(ubq->ubq_daemon);
> > +	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
> > +	ubq->ubq_daemon = NULL;
> > +	ubq->timeout = false;
> > +
> > +	for (i = 0; i < ubq->q_depth; i++) {
> > +		struct ublk_io *io = &ubq->ios[i];
> > +
> > +		/*
> > +		 * UBLK_IO_FLAG_CANCELED is kept for avoiding to touch
> > +		 * io->cmd
> > +		 */
> > +		io->flags &= UBLK_IO_FLAG_CANCELED;
> > +		io->cmd = NULL;
> > +		io->addr = 0;
> > +	}
> > +}
> > +
> >  static int ublk_ch_open(struct inode *inode, struct file *filp)
> >  {
> >  	struct ublk_device *ub = container_of(inode->i_cdev,
> > @@ -1481,10 +1512,26 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
> >  	return 0;
> >  }
> >  
> > +static void ublk_reset_ch_dev(struct ublk_device *ub)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> > +		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
> > +
> > +	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
> > +	ub->mm = NULL;
> > +	ub->nr_queues_ready = 0;
> > +	ub->nr_privileged_daemon = 0;
> > +}
> > +
> >  static int ublk_ch_release(struct inode *inode, struct file *filp)
> >  {
> >  	struct ublk_device *ub = filp->private_data;
> >  
> > +	/* all uring_cmd has been done now, reset device & ubq */
> > +	ublk_reset_ch_dev(ub);
> > +
> >  	clear_bit(UB_STATE_OPEN, &ub->state);
> >  	return 0;
> >  }
> > @@ -1831,6 +1878,24 @@ static void ublk_nosrv_work(struct work_struct *work)
> >  	ublk_cancel_dev(ub);
> >  }
> >  
> > +/* reset ublk io_uring queue & io flags */
> > +static void ublk_reset_io_flags(struct ublk_device *ub)
> > +{
> > +	int i, j;
> > +
> > +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> > +		struct ublk_queue *ubq = ublk_get_queue(ub, i);
> > +
> > +		/* UBLK_IO_FLAG_CANCELED can be cleared now */
> > +		spin_lock(&ubq->cancel_lock);
> 
> Do we need this? I think at this point there shouldn't be any concurrent
> activity we need to protect against.

Yeah, the lock isn't necessary, but doing it here actually has document benefit.


Thanks,
Ming

