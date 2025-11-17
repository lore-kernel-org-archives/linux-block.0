Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7022E199E94
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763345603; cv=none; b=i6AEEsSwvxzcDcqmPI027DDfCIAjFiQtb8FlvCONwxnrb0SELMGc7Calz2QpjPhLTo9TeZJ6eTaX3v0SaUglQHSX5Z9YcgaX84c9ngg4teldTZoYKD+bJQoCfFbghjx8HMBYQiUmo4qOyl4wM0sDLNqJas+XFrlIXS8Yo5F7AN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763345603; c=relaxed/simple;
	bh=xHqZB2MnqmsAbol0g6HqjK9cDJL+RZ3ClPWANYOe3v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA6ZLXoYQgHse1ZAYayZP9d1I8MoScV+pgHhy066ICNy4uUgEuYKBPE+ZQNpKbb2pXYyzqpx6g9yTfv97XRZLNZwEmJW3hVPYPIElrN10O2LFEMexW9g3jyGmRwPimwGxmN+aKHFoCaYxu8hL4hwaRkSziacvqXuAWV7fWVwakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iChZk2Xe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iChZk2Xe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763345600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VHRrC38mM0SceWwzHrODATwtwTQBprcwD8IIWTIxMq4=;
	b=iChZk2XeHVMm4HL8O4cngEBieOclM5+cdziQeukdFlIcfnyExWmZ85vK+Vk7i5XGLs2ves
	e1hDZX0K08t/gilcnL/a0ZkYbwRHIx3lcMsp9JDCHGZlA2a4fdjGxuvaFQKtFeqe0aLgR1
	UpxLIS02TQRxVpJvtPUfaVnK5yeWiNk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-QjYhJkZoMDmlt1lRuliI9w-1; Sun,
 16 Nov 2025 21:13:16 -0500
X-MC-Unique: QjYhJkZoMDmlt1lRuliI9w-1
X-Mimecast-MFC-AGG-ID: QjYhJkZoMDmlt1lRuliI9w_1763345594
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6552019560A1;
	Mon, 17 Nov 2025 02:13:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.55])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8573719560B0;
	Mon, 17 Nov 2025 02:13:05 +0000 (UTC)
Date: Mon, 17 Nov 2025 10:13:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Casey Chen <cachen@purestorage.com>,
	Vikas Manocha <vmanocha@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Convert tag_list mutex to rwsemaphore to avoid
 deadlock
Message-ID: <aRqErLcrPraY8b_L@fedora>
References: <20251113202320.2530531-1-mkhalfella@purestorage.com>
 <aRcVWtE4fHCe3jjM@fedora>
 <20251114173419.GA2197103-mkhalfella@purestorage.com>
 <aRnqmiFmWAI01zJq@fedora>
 <20251116164606.GA2376676-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116164606.GA2376676-mkhalfella@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sun, Nov 16, 2025 at 08:46:06AM -0800, Mohamed Khalfella wrote:
> On Sun 2025-11-16 23:15:38 +0800, Ming Lei wrote:
> > On Fri, Nov 14, 2025 at 09:34:19AM -0800, Mohamed Khalfella wrote:
> > > On Fri 2025-11-14 19:41:14 +0800, Ming Lei wrote:
> > > > On Thu, Nov 13, 2025 at 12:23:20PM -0800, Mohamed Khalfella wrote:
> > > > > blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> > > > > tagset, the functions make sure that tagset and queues are marked as
> > > > > shared when two or more queues are attached to the same tagset.
> > > > > Initially a tagset starts as unshared and when the number of added
> > > > > queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
> > > > > with all the queues attached to it. When the number of attached queues
> > > > > drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
> > > > > the remaining queues as unshared.
> > > > > 
> > > > > Both functions need to freeze current queues in tagset before setting on
> > > > > unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
> > > > > hold set->tag_list_lock mutex, which makes sense as we do not want
> > > > > queues to be added or deleted in the process. This used to work fine
> > > > > until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > > > > made the nvme driver quiesce tagset instead of quiscing individual
> > > > > queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
> > > > > set->tag_list while holding set->tag_list_lock also.
> > > > > 
> > > > > This results in deadlock between two threads with these stacktraces:
> > > > > 
> > > > >   __schedule+0x48e/0xed0
> > > > >   schedule+0x5a/0xc0
> > > > >   schedule_preempt_disabled+0x11/0x20
> > > > >   __mutex_lock.constprop.0+0x3cc/0x760
> > > > >   blk_mq_quiesce_tagset+0x26/0xd0
> > > > >   nvme_dev_disable_locked+0x77/0x280 [nvme]
> > > > >   nvme_timeout+0x268/0x320 [nvme]
> > > > >   blk_mq_handle_expired+0x5d/0x90
> > > > >   bt_iter+0x7e/0x90
> > > > >   blk_mq_queue_tag_busy_iter+0x2b2/0x590
> > > > >   ? __blk_mq_complete_request_remote+0x10/0x10
> > > > >   ? __blk_mq_complete_request_remote+0x10/0x10
> > > > >   blk_mq_timeout_work+0x15b/0x1a0
> > > > >   process_one_work+0x133/0x2f0
> > > > >   ? mod_delayed_work_on+0x90/0x90
> > > > >   worker_thread+0x2ec/0x400
> > > > >   ? mod_delayed_work_on+0x90/0x90
> > > > >   kthread+0xe2/0x110
> > > > >   ? kthread_complete_and_exit+0x20/0x20
> > > > >   ret_from_fork+0x2d/0x50
> > > > >   ? kthread_complete_and_exit+0x20/0x20
> > > > >   ret_from_fork_asm+0x11/0x20
> > > > > 
> > > > >   __schedule+0x48e/0xed0
> > > > >   schedule+0x5a/0xc0
> > > > >   blk_mq_freeze_queue_wait+0x62/0x90
> > > > >   ? destroy_sched_domains_rcu+0x30/0x30
> > > > >   blk_mq_exit_queue+0x151/0x180
> > > > >   disk_release+0xe3/0xf0
> > > > >   device_release+0x31/0x90
> > > > >   kobject_put+0x6d/0x180
> > > > >   nvme_scan_ns+0x858/0xc90 [nvme_core]
> > > > >   ? nvme_scan_work+0x281/0x560 [nvme_core]
> > > > >   nvme_scan_work+0x281/0x560 [nvme_core]
> > > > >   process_one_work+0x133/0x2f0
> > > > >   ? mod_delayed_work_on+0x90/0x90
> > > > >   worker_thread+0x2ec/0x400
> > > > >   ? mod_delayed_work_on+0x90/0x90
> > > > >   kthread+0xe2/0x110
> > > > >   ? kthread_complete_and_exit+0x20/0x20
> > > > >   ret_from_fork+0x2d/0x50
> > > > >   ? kthread_complete_and_exit+0x20/0x20
> > > > >   ret_from_fork_asm+0x11/0x20
> > > > 
> > > > It is one AB-BA deadlock, lockdep should have complained it, but nvme doesn't
> > > > support owned freeze queue.
> > > > 
> > > > Maybe the following change can avoid it?
> > > > 
> > > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > > index c916176bd9f0..9967c4a7e72d 100644
> > > > --- a/drivers/nvme/host/pci.c
> > > > +++ b/drivers/nvme/host/pci.c
> > > > @@ -3004,6 +3004,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> > > >         bool dead;
> > > > 
> > > >         mutex_lock(&dev->shutdown_lock);
> > > > +       nvme_quiesce_io_queues(&dev->ctrl);
> > > >         dead = nvme_pci_ctrl_is_dead(dev);
> > > >         if (state == NVME_CTRL_LIVE || state == NVME_CTRL_RESETTING) {
> > > >                 if (pci_is_enabled(pdev))
> > > > @@ -3016,8 +3017,6 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> > > >                         nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> > > >         }
> > > > 
> > > > -       nvme_quiesce_io_queues(&dev->ctrl);
> > > > -
> > > >         if (!dead && dev->ctrl.queue_count > 0) {
> > > >                 nvme_delete_io_queues(dev);
> > > >                 nvme_disable_ctrl(&dev->ctrl, shutdown);
> > > > 
> > > > 
> > > 
> > > Interesting. Can you elaborate more on why this diff can help us avoid
> > > the problem?
> > 
> > In nvme_dev_disable(), NS queues are frozen first, then call
> > nvme_quiesce_io_queues().
> > 
> > queue freeze can be thought as one lock, so q->freeze_lock -> tag_set->tag_list_lock
> > in timeout code path.
> > 
> > However, in blk_mq_exit_queue(), the lock order becomes
> > tag_set->tag_list_lock -> q->freeze_lock.
> > 
> > That is why I call it AB-BA lock.
> > 
> > However, that looks not the reason in your deadlock, so my patch shouldn't
> > work here, in which nvme_dev_disable() doesn't provide forward-progress
> > because of ->tag_list_lock.
> > 
> > > 
> > > If the thread doing nvme_scan_work() is waiting for queue to be frozen
> > > while holding set->tag_list_lock, then nvme_quiesce_io_queues() moved up
> > > will cause the deadlock, no?
> > 
> >  __schedule+0x48e/0xed0
> >   schedule+0x5a/0xc0
> >   blk_mq_freeze_queue_wait+0x62/0x90
> >   ? destroy_sched_domains_rcu+0x30/0x30
> >   blk_mq_exit_queue+0x151/0x180
> >   disk_release+0xe3/0xf0
> >   device_release+0x31/0x90
> >   kobject_put+0x6d/0x180
> > 
> > Here blk_mq_exit_queue() is called from disk release, and the disk is not
> > added actually, so question is why blk_mq_freeze_queue_wait() doesn't
> > return? Who holds queue usage counter here?  Can you investigate a bit
> > and figure out the reason?
> 
> The nvme controller has two namespaces. n1 was created with q1 added to
> the tagset. n2 was also created with q2 added to the tagset. Now the
> tagset is shared because it has two queues on it. Before the disk is
> added n2 was found to be duplicate to n1. That means the disk should be
> released, as noted above, and q2 should be removed from the tagset.
> Because n1 block device is ready to receive IO it is possible for q1
> usage counter to be greater than zero.
> 
> Back to q2 removal from the tagset. This requires q1 to be frozen before
> it can be marked as unshared. blk_mq_freeze_queue_wait() was called for
> q1 and it does not return because there is a request issued on the queue.
> nvme_timeout() was called for that request in q1.

Yeah, it is actually the other request queues frozen from
blk_mq_exit_queue(). Then your approach looks good, will run a close view.


Thanks,
Ming

