Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD081CAA70
	for <linux-block@vger.kernel.org>; Sun,  9 Feb 2025 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739101319; cv=none; b=D4ecBEuIkUMVOvBR82w4c9YD5i9ZOtk/WscxZZbYZgDCIXFeaFDrcyKOlo6NlUCL51coSMO03M3Vw7PAiw5VoCYv+lGn71xyEInM/XhZJbx0d/4VPDFPumHtc1zq+dMQ4O7FD5j16Broz35VHAwKsfeFjjhh57pU/xXqRxJ1ndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739101319; c=relaxed/simple;
	bh=ZYR9YedN8sRw0Mbd6J+Jf+/qm9HKkEZVcgKhMgJzlNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMzOMC1f+z4bnnglBXN0upNOcCyIkdeTZ/KWLM/UyjrAMixSuDRRU22VaWxrgfPd72JAlKXDvAwYxMFyjZKhm1nhm1hqLLquZzBqaduoIyWCPy/eDhyBTF2Sew3x9N586CEp+l00r9dra3lWYoc87z21uHecSR4z5VG94o9XJuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TP0pbhGR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TP0pbhGR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739101315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gX+CNaPjusJczI7lX/sMg92er4n98HAFJljl4GhRhFU=;
	b=TP0pbhGRY/5qm0G5G1/IzhC9zpnddjUF62bpbZ4HyhLML4gUOcYkQhsaCWoGBIEronGHyV
	T9rgXCbpPlfHBOM95SHdRUnh8loNGTzPIpD5BOtdzHEpLBEBcWSqm2xISrFfJONuHeO778
	0v83ZrI9b0dcNO+Xl/Npgd9/iLauGHs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-khdPwrcvO7qeCBa8aTNopQ-1; Sun,
 09 Feb 2025 06:41:51 -0500
X-MC-Unique: khdPwrcvO7qeCBa8aTNopQ-1
X-Mimecast-MFC-AGG-ID: khdPwrcvO7qeCBa8aTNopQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4D4D19560AA;
	Sun,  9 Feb 2025 11:41:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.41])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86038195608D;
	Sun,  9 Feb 2025 11:41:44 +0000 (UTC)
Date: Sun, 9 Feb 2025 19:41:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCH 2/2] block: avoid acquiring q->sysfs_lock while accessing
 sysfs attributes
Message-ID: <Z6iUcqtqwAiJpU7-@fedora>
References: <20250205144506.663819-1-nilay@linux.ibm.com>
 <20250205144506.663819-3-nilay@linux.ibm.com>
 <20250205155330.GA14133@lst.de>
 <f933e87a-6014-434a-8258-d871c77ca14c@linux.ibm.com>
 <Z6c0xvOFGYrGqxCd@fedora>
 <4d7bb88c-9e1d-48dd-8d67-4b8c4948c4a8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d7bb88c-9e1d-48dd-8d67-4b8c4948c4a8@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sat, Feb 08, 2025 at 06:26:38PM +0530, Nilay Shroff wrote:
> 
> 
> On 2/8/25 4:11 PM, Ming Lei wrote:
> > On Thu, Feb 06, 2025 at 07:24:02PM +0530, Nilay Shroff wrote:
> >>
> >>
> >> On 2/5/25 9:23 PM, Christoph Hellwig wrote:
> >>> On Wed, Feb 05, 2025 at 08:14:48PM +0530, Nilay Shroff wrote:
> >>>> The sysfs attributes are already protected with sysfs/kernfs internal
> >>>> locking. So acquiring q->sysfs_lock is not needed while accessing sysfs
> >>>> attribute files. So this change helps avoid holding q->sysfs_lock while
> >>>> accessing sysfs attribute files.
> >>>
> >>> the sysfs/kernfs locking only protects against other accesses using
> >>> sysfs.  But that's not really the most interesting part here.  We
> >>> also want to make sure nothing changes underneath in a way that
> >>> could cause crashes (and maybe even torn information).
> >>>
> >>> We'll really need to audit what is accessed in each method and figure
> >>> out what protects it.  Chances are that sysfs_lock provides that
> >>> protection in some case right now, and chances are also very high
> >>> that a lot of this is pretty broken.
> >>>
> >> Yes that's possible and so I audited all sysfs attributes which are 
> >> currently protected using q->sysfs_lock and I found some interesting
> >> facts. Please find below:
> >>
> >> 1. io_poll:
> >>    Write to this attribute is ignored. So, we don't need q->sysfs_lock.
> >>
> >> 2. io_poll_delay:
> >>    Write to this attribute is NOP, so we don't need q->sysfs_lock.
> >>
> >> 3. io_timeout:
> >>    Write to this attribute updates q->rq_timeout and read of this attribute
> >>    returns the value stored in q->rq_timeout Moreover, the q->rq_timeout is
> >>    set only once when we init the queue (under blk_mq_init_allocated_queue())
> >>    even before disk is added. So that means that we may not need to protect
> >>    it with q->sysfs_lock.
> >>
> >> 4. nomerges:
> >>    Write to this attribute file updates two q->flags : QUEUE_FLAG_NOMERGES 
> >>    and QUEUE_FLAG_NOXMERGES. These flags are accessed during bio-merge which
> >>    anyways doesn't run with q->sysfs_lock held. Moreover, the q->flags are 
> >>    updated/accessed with bitops which are atomic. So, I believe, protecting
> >>    it with q->sysfs_lock is not necessary.
> >>
> >> 5. nr_requests:
> >>    Write to this attribute updates the tag sets and this could potentially
> >>    race with __blk_mq_update_nr_hw_queues(). So I think we should really 
> >>    protect it with q->tag_set->tag_list_lock instead of q->sysfs_lock.
> >>
> >> 6. read_ahead_kb:
> >>    Write to this attribute file updates disk->bdi->ra_pages. The disk->bdi->
> >>    ra_pages is also updated under queue_limits_commit_update() which runs 
> >>    holding q->limits_lock; so I think this attribute file should be protected
> >>    with q->limits_lock and protecting it with q->sysfs_lock is not necessary. 
> >>    Maybe we should move it under the same sets of attribute files which today
> >>    runs with q->limits_lock held.
> >>
> >> 7. rq_affinity:
> >>    Write to this attribute file makes atomic updates to q->flags: QUEUE_FLAG_SAME_COMP
> >>    and QUEUE_FLAG_SAME_FORCE. These flags are also accessed from blk_mq_complete_need_ipi()
> >>    using test_bit macro. As read/write to q->flags uses bitops which are atomic, 
> >>    protecting it with q->stsys_lock is not necessary.
> >>
> >> 8. scheduler:
> >>    Write to this attribute actually updates q->elevator and the elevator change/switch 
> >>    code expects that the q->sysfs_lock is held while we update the iosched to protect 
> >>    against the simultaneous __blk_mq_update_nr_hw_queues update. So yes, this field needs 
> >>    q->sysfs_lock protection.
> >>
> >>    However if we're thinking of protecting sched change/update using q->tag_sets->
> >>    tag_list_lock (as discussed in another thread), then we may use q->tag_set->
> >>    tag_list_lock instead of q->sysfs_lock here while reading/writing to this attribute
> >>    file.
> > 
> > This is one misuse of tag_list_lock, which is supposed to cover host
> > wide change, and shouldn't be used for request queue level protection,
> > which is exactly provided by q->sysfs_lock.
> > 
> Yes I think Christoph was also pointed about the same but then assuming 
> schedule/elevator update would be a rare operation it may not cause
> a lot of contention. Having said that, I'm also fine creating another 
> lock just to protect elevator changes and removing ->sysfs_lock from 
> elevator code.

Then please use new lock.

> 
> > Not mention it will cause ABBA deadlock over freeze lock, please see
> > blk_mq_update_nr_hw_queues(). And it can't be used for protecting
> > 'nr_requests' too.
> I don't know how this might cause ABBA deadlock. The proposal here's to 
> use ->tag_list_lock (instead of ->sysfs_lock) while updating scheduler 
> attribute from sysfs as well as while we update the elevator through 
> __blk_mq_update_nr_hw_queues().
> 
> In each code path (either from sysfs attribute update or from nr_hw_queues 
> update), we first acquire ->tag_list_lock and then freeze-lock.
> 
> Do you see any code path where the above order might not be followed?  	

You patch 14ef49657ff3 ("block: fix nr_hw_queue update racing with disk addition/removal")
has added one such warning:  blk_mq_sysfs_unregister() is called after
queue freeze lock is grabbed from del_gendisk()

Also there are many such use cases in nvme: blk_mq_quiesce_tagset()/blk_mq_unquiesce_tagset()
called after tagset is frozen.

More serious, driver may grab ->tag_list_lock in error recovery code for
providing forward progress, you have to be careful wrt. using ->tag_list_lock,
for example:

	mutex_lock(->tag_list_lock)
	blk_mq_freeze_queue()		// If IO timeout happens, the driver timeout
								// handler stuck on mutex_lock(->tag_list_lock)


Thanks,
Ming

