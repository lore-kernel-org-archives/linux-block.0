Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FB214A4DB
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 23:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744846290; cv=none; b=lQwgQpae+weQiJu1eEOmslyFzcphIddZEnIzkxm3oD7Aygoo0njqJrnHjcO5qQL6CZRsWTqfb5PDgk9rM+466knsy0V0hyev/850Cne42ZdeCo6/ETZ3FVKwXHob2GtV0KmQ/RgyHCQbO89lEoH06mvlboL+/mbzdRq/CZMWoTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744846290; c=relaxed/simple;
	bh=vaL4WELFv0snY5FFLFYX09KXs1KHPczLumMOhzOC7S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD3p8VlUMnf58W0F7WriSqI/xEegcicv725NuMcTW7pJFGEQbEza/9QNVYfFmQ5x2PKvtptPSUjfymBvNgeeFWNol10Lv7hqGoFwZ45hUwCujJRe08VciP8fIUVkUoGh+HOk7jCs9XoEJAhtosmLySQawlyVBR50zvX8RcCoLeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EvXiju2f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvXiju2f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744846287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pb00SG8M9gcP8EMNwUSgafDGh6ZBHvhzc107xkTlnuk=;
	b=EvXiju2f+FmL0X4VUjrv+VXu94V4yh6CypLrtv6ParZjToENcJO7JfH+E/C4h9kvoyiD42
	6qOSvyx1U6pxNoQTcQjrQI0XzGAP4R5Q1BbM/8jJE5TW+7eCyWw7NG+IorlvenLev+lr7h
	H13ECsTTpZ/t/EsuiEkVkDP9OTKyAhI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534--fG8ywgYPrCLDmfO-Wd0hA-1; Wed,
 16 Apr 2025 19:31:23 -0400
X-MC-Unique: -fG8ywgYPrCLDmfO-Wd0hA-1
X-Mimecast-MFC-AGG-ID: -fG8ywgYPrCLDmfO-Wd0hA_1744846280
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50AC51800876;
	Wed, 16 Apr 2025 23:31:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.82])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B71C130001A1;
	Wed, 16 Apr 2025 23:31:16 +0000 (UTC)
Date: Thu, 17 Apr 2025 07:31:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH V2 4/8] ublk: move device reset into ublk_ch_release()
Message-ID: <aAA9v03LmUzUnf3P@fedora>
References: <20250416035444.99569-1-ming.lei@redhat.com>
 <20250416035444.99569-5-ming.lei@redhat.com>
 <Z//+0vPyo1/4spfx@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z//+0vPyo1/4spfx@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Apr 16, 2025 at 01:02:42PM -0600, Uday Shankar wrote:
> On Wed, Apr 16, 2025 at 11:54:38AM +0800, Ming Lei wrote:
> > ublk_ch_release() is called after ublk char device is closed, when all
> > uring_cmd are done, so it is perfect fine to move ublk device reset to
> > ublk_ch_release() from ublk_ctrl_start_recovery().
> > 
> > This way can avoid to grab the exiting daemon task_struct too long.
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
> > index a479969fd77e..1fe39cf85b2f 100644
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
> 
> Can we take the ub->mutex here? I can't see a concrete data race but I
> feel there is lots of potential for one since the device still may be
> concurrently accessed via ctrl commands.

Actually it isn't needed:

- only the two RECOVERY commands may touch this data, but START_USER_RECOVERY waits
until close is done.

- for other commands, this data won't be touched, and just the state update
need to be protected by ub->mutex, which is always true. ublk_cancel_dev() is one
exception, but ubq->cancel_lock provides the protection.




thanks,
Ming

