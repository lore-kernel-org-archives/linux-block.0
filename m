Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44814B953
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765525645; cv=none; b=Nwhm/yJkqYTRGcUAXprx09iUOlHGlVhfMopibVBIpjjsQhuRsHn2yDj3LljyxaFm9NT0gCdzAy72LWhr0LvZeg/IxEqh7SO5ymL8Uifj6EzWOnXhwsfxuGUl/XPzYmMxmWrRyKmX6KALLzZDfIVUYviqyeSVKklPyWcuUBxmb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765525645; c=relaxed/simple;
	bh=YfNrZr7V9XO1cq+fNCubqmX3H6+Fwf9B3uAc2MLD090=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gcq7nyjxJSiXyDFiv0eyvq4p8R7bB9TIMGovOVSvAi6uOgx+XWez8GSCX3Z76WsBYhfBdnqmfctp3G3RbkJ595aYSyglqduy9BMrLOliCA28/ML/si0Bd+Nyj42vhHjO05SCpb2I6jEXYVLEiv80v9R7M5gRDB2QaHAgBp7IKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmWq54Im; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmWq54Im"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765525642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WeYiDBM/6JuC0zLK/reVdL8cvSC4h0ix0JW7mRr2k0w=;
	b=XmWq54ImN/dfD0fUY8If/7thnsh6yAAGv2QJIdyHnhJQ4G7Y0UAiXzqK20fadjx2Je93oO
	bz7TxP9Mm6xvYdv4Lgn7oKrQPyZR31fQF1yQm/tNgQxzpYSO49tZz8tsJw8Gyirc4S3DDV
	48LYaBAQXxGnW9AK0bi1HmyGa5Z60tc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-QR0ITZm5O-y0G9XwQRow-g-1; Fri,
 12 Dec 2025 02:47:16 -0500
X-MC-Unique: QR0ITZm5O-y0G9XwQRow-g-1
X-Mimecast-MFC-AGG-ID: QR0ITZm5O-y0G9XwQRow-g_1765525635
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CDB718011DF;
	Fri, 12 Dec 2025 07:47:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BA721800451;
	Fri, 12 Dec 2025 07:47:07 +0000 (UTC)
Date: Fri, 12 Dec 2025 15:47:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai3@huawei.com>,
	Guangwu Zhang <guazhang@redhat.com>
Subject: Re: [PATCH] block: fix race between wbt_enable_default and IO
 submission
Message-ID: <aTvIdnk3Pl-L-4s_@fedora>
References: <20251210091001.236296-1-ming.lei@redhat.com>
 <52b5f2a4-e5e1-4917-8620-490fde89cfe7@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52b5f2a4-e5e1-4917-8620-490fde89cfe7@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Dec 12, 2025 at 01:56:20PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/12/10 17:10, Ming Lei 写道:
> > When wbt_enable_default() is moved out of queue freezing in elevator_change(),
> > it can cause the wbt inflight counter to become negative (-1), leading to hung
> > tasks in the writeback path. Tasks get stuck in wbt_wait() because the counter
> > is in an inconsistent state.
> >
> > The issue occurs because wbt_enable_default() could race with IO submission,
> > allowing the counter to be decremented before proper initialization. This manifests
> > as:
> >
> >    rq_wait[0]:
> >      inflight:             -1
> >      has_waiters:        True
> >
> > And results in hung task warnings like:
> >    task:kworker/u24:39 state:D stack:0 pid:14767
> >    Call Trace:
> >      rq_qos_wait+0xb4/0x150
> >      wbt_wait+0xa9/0x100
> >      __rq_qos_throttle+0x24/0x40
> >      blk_mq_submit_bio+0x672/0x7b0
> >      ...
> >
> > Fix this by:
> >
> > 1. Splitting wbt_enable_default() into:
> >     - __wbt_enable_default(): Returns true if wbt_init() should be called
> >     - wbt_enable_default(): Wrapper for existing callers (no init)
> >     - wbt_init_enable_default(): New function that checks and inits WBT
> >
> > 2. Using wbt_init_enable_default() in blk_register_queue() to ensure
> >     proper initialization during queue registration
> >
> > 3. Move wbt_init() out of wbt_enable_default() which is only for enabling
> >     disabled wbt from bfq and iocost, and wbt_init() isn't needed. Then the
> >     original lock warning can be avoided.
> >
> > 4. Removing the ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT flag and its handling
> >     code since it's no longer needed
> >
> > This ensures WBT is properly initialized before any IO can be submitted,
> > preventing the counter from going negative.
> >
> > Cc: Nilay Shroff <nilay@linux.ibm.com>
> > Cc: Yu Kuai <yukuai3@huawei.com>
> > Cc: Guangwu Zhang <guazhang@redhat.com>
> > Fixes: 78c271344b6f ("block: move wbt_enable_default() out of queue freezing from sched ->exit()")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/bfq-iosched.c |  2 +-
> >   block/blk-sysfs.c   |  2 +-
> >   block/blk-wbt.c     | 20 ++++++++++++++++----
> >   block/blk-wbt.h     |  5 +++++
> >   block/elevator.c    |  4 ----
> >   block/elevator.h    |  1 -
> >   6 files changed, 23 insertions(+), 11 deletions(-)
> >
> > diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> > index 4a8d3d96bfe4..6e54b1d3d8bc 100644
> > --- a/block/bfq-iosched.c
> > +++ b/block/bfq-iosched.c
> > @@ -7181,7 +7181,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
> >   
> >   	blk_stat_disable_accounting(bfqd->queue);
> >   	blk_queue_flag_clear(QUEUE_FLAG_DISABLE_WBT_DEF, bfqd->queue);
> > -	set_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT, &e->flags);
> > +	wbt_enable_default(bfqd->queue->disk);
> >   
> >   	kfree(bfqd);
> >   }
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index 8684c57498cc..e0a70d26972b 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -932,7 +932,7 @@ int blk_register_queue(struct gendisk *disk)
> >   		elevator_set_default(q);
> >   
> >   	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
> > -	wbt_enable_default(disk);
> > +	wbt_init_enable_default(disk);
> >   
> >   	/* Now everything is ready and send out KOBJ_ADD uevent */
> >   	kobject_uevent(&disk->queue_kobj, KOBJ_ADD);
> > diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> > index eb8037bae0bd..0974875f77bd 100644
> > --- a/block/blk-wbt.c
> > +++ b/block/blk-wbt.c
> > @@ -699,7 +699,7 @@ static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
> >   /*
> >    * Enable wbt if defaults are configured that way
> >    */
> > -void wbt_enable_default(struct gendisk *disk)
> > +static bool __wbt_enable_default(struct gendisk *disk)
> >   {
> >   	struct request_queue *q = disk->queue;
> >   	struct rq_qos *rqos;
> > @@ -716,19 +716,31 @@ void wbt_enable_default(struct gendisk *disk)
> >   		if (enable && RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT)
> >   			RQWB(rqos)->enable_state = WBT_STATE_ON_DEFAULT;
> 
> Is this problem due to above state? Changing the state is not under queue frozen.
> The commit message is not quite clear to me. If so, the changes looks good to me,
> by setting the state with queue frozen.

Yes, rwb_enabled() checks the state, which can be update exactly between wbt_wait()
(rq_qos_throttle()) and wbt_track()(rq_qos_track), then the inflight counter will
become negative.


Thanks,
Ming

