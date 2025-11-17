Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129D3195F4
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763380462; cv=none; b=t+Id0KYaTKE7CKeqhj7EBX9J8UDCGhP43Ee926Jf31kfg7buMJCgApDJs29YpbpvaxR8p4BnOHnRUxVufldJrJlBPZ7gbcMnOSg5vguZuvh+DRTkfmj62VnkQPk2Tndb4GmKtpIw9QebPGQzvGAvlC3eNYGz1S6K6rYJHncXpWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763380462; c=relaxed/simple;
	bh=pTdMzy9oZY6yCitB3KJ/X0uqGOWC6fc62Lcg5xroiN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIIv2QrkI0vcInZfeNa5z1k7nXF78918oxC/pAmAvK9hSbedPS3Dco5Ez9YSG2wVKXFHe2Ydby11OiQ9MJzjarnPwpg1efm/55Q3MIOCki3Y19CyD4YPFA4A78o6zZITHIStIfu3PN14WN0LFTxzKQPb+OvskTJTew2tHyH+WFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAaiimfH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAaiimfH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763380458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfGCL9NANSVsj9tvRmYEUidbQFjtoaFczfTnfZrLdAs=;
	b=gAaiimfHN+Bbde8G4YmDb1gfBPnetMsbWlagMOH59KmESUin0NGyFOorNyRPCQGhq5+x/n
	PotVet7DHm4Otfr3qMmcNN9sWLAetivwWrBdJTKPflaFmn8/yYNJNQTmiMSSTV6yr44QVY
	VICKBlxk++7Om+ZWkkDK757eZmIvCN0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-X88lYDoCOnSte2rGEll6hA-1; Mon,
 17 Nov 2025 06:54:17 -0500
X-MC-Unique: X88lYDoCOnSte2rGEll6hA-1
X-Mimecast-MFC-AGG-ID: X88lYDoCOnSte2rGEll6hA_1763380456
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CAB71800561;
	Mon, 17 Nov 2025 11:54:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35892195608E;
	Mon, 17 Nov 2025 11:54:11 +0000 (UTC)
Date: Mon, 17 Nov 2025 19:54:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	tj@kernel.org
Subject: Re: [PATCH RESEND 1/5] block/blk-rq-qos: add a new helper
 rq_qos_add_freezed()
Message-ID: <aRsM34hifFrUNe6w@fedora>
References: <20251116041024.120500-1-yukuai@fnnas.com>
 <20251116041024.120500-2-yukuai@fnnas.com>
 <aRsAdF3GxNJ3Q1Qv@fedora>
 <1bd4a77f-399f-4dbe-a6b6-79b07f5e2759@linux.ibm.com>
 <aRsHVyvL8sMrmDlt@fedora>
 <8cca91f6-cfe2-4ef7-a072-dd48c3ee243b@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cca91f6-cfe2-4ef7-a072-dd48c3ee243b@fnnas.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Nov 17, 2025 at 07:39:57PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/11/17 19:30, Ming Lei 写道:
> > On Mon, Nov 17, 2025 at 04:43:11PM +0530, Nilay Shroff wrote:
> >>
> >> On 11/17/25 4:31 PM, Ming Lei wrote:
> >>> On Sun, Nov 16, 2025 at 12:10:20PM +0800, Yu Kuai wrote:
> >>>> queue should not be freezed under rq_qos_mutex, see example index
> >>>> commit 9730763f4756 ("block: correct locking order for protecting blk-wbt
> >>>> parameters"), which means current implementation of rq_qos_add() is
> >>>> problematic. Add a new helper and prepare to fix this problem in
> >>>> following patches.
> >>>>
> >>>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> >>>> ---
> >>>>   block/blk-rq-qos.c | 27 +++++++++++++++++++++++++++
> >>>>   block/blk-rq-qos.h |  2 ++
> >>>>   2 files changed, 29 insertions(+)
> >>>>
> >>>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> >>>> index 654478dfbc20..353397d7e126 100644
> >>>> --- a/block/blk-rq-qos.c
> >>>> +++ b/block/blk-rq-qos.c
> >>>> @@ -322,6 +322,33 @@ void rq_qos_exit(struct request_queue *q)
> >>>>   	mutex_unlock(&q->rq_qos_mutex);
> >>>>   }
> >>>>   
> >>>> +int rq_qos_add_freezed(struct rq_qos *rqos, struct gendisk *disk,
> >>>> +		       enum rq_qos_id id, const struct rq_qos_ops *ops)
> >>>> +{
> >>>> +	struct request_queue *q = disk->queue;
> >>>> +
> >>>> +	WARN_ON_ONCE(q->mq_freeze_depth == 0);
> >>>> +	lockdep_assert_held(&q->rq_qos_mutex);
> >>>> +
> >>>> +	if (rq_qos_id(q, id))
> >>>> +		return -EBUSY;
> >>>> +
> >>>> +	rqos->disk = disk;
> >>>> +	rqos->id = id;
> >>>> +	rqos->ops = ops;
> >>>> +	rqos->next = q->rq_qos;
> >>>> +	q->rq_qos = rqos;
> >>>> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
> >>>> +
> >>>> +	if (rqos->ops->debugfs_attrs) {
> >>>> +		mutex_lock(&q->debugfs_mutex);
> >>>> +		blk_mq_debugfs_register_rqos(rqos);
> >>>> +		mutex_unlock(&q->debugfs_mutex);
> >>>> +	}
> >>> It will cause more lockdep splat to let q->debugfs_mutex depend on queue freeze,
> >>>
> >> I think we already have that ->debugfs_mutex dependency on ->freeze_lock.
> >> for instance,
> >>    ioc_qos_write  => freeze-queue
> >>     blk_iocost_init
> >>       rq_qos_add
> > Why is queue freeze needed in above code path?
> >
> > Also blk_iolatency_init()/rq_qos_add() doesn't freeze queue.
> 
> I don't quite understand, rq_qos_add() always require queue freeze, prevent
> deference q->rq_qos from IO path concurrently.
> 
> >
> >> and also,
> >>    queue_wb_lat_store  => freeze-queue
> >>      wbt_init
> >>        rq_qos_add
> > Not all wbt_enable_default()/wbt_init() is called with queue frozen, but Kuai's
> > patchset changes all to freeze queue before registering debugfs entry, people will
> > complain new warning.
> 
> Yes, but the same as above, rq_qos_add() from wbt_init() will always freeze queue
> before this set, so I don't understand why is there new warning?

The in-tree rq_qos_add() registers debugfs after queue is unfreeze, but
your patchset basically moves queue freeze/unfreeze to callsite of rq_qos_add(),
then debugfs register is always done with queue frozen.

Dependency between queue freeze and q->debugfs_mutex is introduced in some
code paths, such as, elevator switch, blk_iolatency_init, ..., this way
will trigger warning because it isn't strange to run into memory
allocation in debugfs_create_*().

> 
> >
> >>> Also blk_mq_debugfs_register_rqos() does _not_ require queue to be frozen,
> >>> and it should be fine to move blk_mq_debugfs_register_rqos() out of queue
> >>> freeze.
> >>>
> >> Yes correct, but I thought this pacthset is meant only to address incorrect
> >> locking order between ->rq_qos_mutex and ->freeze_lock. So do you suggest
> >> also refactoring code to avoid ->debugfs_mutex dependency on ->freeze_lock?
> >> If yes then shouldn't that be handled in a separate patchset?
> > It is fine to fix in that way, but at least regression shouldn't be caused.
> >
> > More importantly we shouldn't add new unnecessary dependency on queue freeze.
> 
> This is correct, I'll work on the v2 set to move debugfs_mutex outside of freeze
> queue, however, as you suggested before we should we should fix this incorrect
> lock order first. How about I make them in a single set?

That is fine, but patches for moving debugfs_mutex should be put before
this patchset, which is always friendly for 'git bisect'.


Thanks,
Ming

