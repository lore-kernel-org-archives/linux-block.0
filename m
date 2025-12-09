Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CA22BE7AB
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765302565; cv=none; b=K/gYNolhWaUljl7ewSDdYiP0qyQ6T1sbl0EXV/yeSV2WvnT6X1qwBQJgCUEnYlg5qI/EPrn/aAUTu4lXlXXZnMepJD0ArqG1DwbJmhArMfYdX6XT7M/1Ip1RIPUtyIwOkT53ZF0TF/86te8uLPXwhJUXdTl39raDP//tVvbblO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765302565; c=relaxed/simple;
	bh=k9nc/oIuVNKvEzfosgQpz8WyXpPtovU/h1xUr0fGlnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tp4oACLvuABnafUEk0P8blhFPa5rMScqQhjMAkmlt8c7T8zab7EgbJOslOU/PkI5QgXqbcDdQhTagzh+KncST0y/DzKvG4s/ghVzJAfIKQnNGs628b+j+rbJvVgbGdTjoGyaCk/CgzRZoxw1F5ihAvKnXCX+YnkBYN8rOiF+m20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RTch1hCX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RTch1hCX"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so6379101b3a.1
        for <linux-block@vger.kernel.org>; Tue, 09 Dec 2025 09:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765302563; x=1765907363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rz2s4/XACP16CBGrl75sJvoaK4RRP2zE8Z8SxMQdAxE=;
        b=RTch1hCXlWwUACfKxWdgumW1Z5SHFJrrAcrxm1E17JulWPxVbO9xqynepfSC/udbAS
         JdiXjwPXzIT6CSv5FuN+8xgxbWeOD2Ex6C7oemftOAzKk1S1IUizIq3I5FhFQqG9rTQm
         L/5v6KkYNqw1Ki++SN4YNSfwdldAt5d86ycSJlU5h5PLycArczCF+4TjJwldurBc+fNP
         1SmYNOhDKIihtciIZ0sZTj5s/jey4rkYYgx9YmXz4IuqKzOQ9div42VFfBjqy4TwYAxn
         AJYqT8ajyCCO/AFGUjKwodWhgbguMIDmChFXONDH/DM7tPeAxGJF7SDGSKhYGyqSBWqh
         ojnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765302563; x=1765907363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rz2s4/XACP16CBGrl75sJvoaK4RRP2zE8Z8SxMQdAxE=;
        b=uKIF2sdLNBCHdXxeIjg2rNeOoHM3TIgMQ+5U329qry/BB7n9K9bR3k8hTtWvBz8JpK
         Y2zvs7EcI/v+ZZ3Vi0joXe4Y+7lv5OcXBwvFK4rmAcQMdnMHGs78dsdM3P0lwE354Cns
         /tRXLkDKGr0gc05/T3V1yds3S3IU7ZSCOUpyoV0l/NVbEgbrkwZFZ/ZpEHCtb40k5b10
         0Y75w+S4MhjIwcCOg868z3Kr3kbXR6luur7v4F5qHmoAAWYTNN6ME30Uuor7c3uGE7A+
         IK0RUzUX8RVMBOf7FVlKsuEB8m6HnZbeWxgSGeIdSrk5TapmPqPLpuslB8BI/YXl/MfW
         9Ayw==
X-Forwarded-Encrypted: i=1; AJvYcCWWw5ZJWUW+xSR01z/97X9w8DHadS97NUcms96/rIrHnwkEtInlAObK074XRjQ+OLaajwmkxiXhzAEZ4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsqnNuUY1VsNe/onuDdu6+Ai+f1y1LVE6kzNLktKDv8DcDmfTU
	sJcaMvSj4uZjoGQ1BbfOZN4WSzl4QKbHpmBS4hVWBsVi7fRy4ho7b9KyIxvu+1UapfA=
X-Gm-Gg: ASbGncuZijfu2zzHohISyim54I72qHUJoy5JPzMQ3r4FQsw/Tqv6jwTIYyJLsRKG+c/
	N/I86zFJCMc8PH1Idqd7jh3Uhi9nro2wyXujRVTa+dy2qqu91um1g7tDFSBsrBAahoMOdTIkQFl
	sxBX2nlsCsrKe8E0mbIYowFztkgePV6vlS9k+nqe8zUfRl2GnaJAwTkPmchm3xsUILpSPuFYIy7
	VlyrS1iE5TsMW6Ce7ZigqoxF1DGD2dWZOHfgdrprVw7hERPY5cXkEwUQG2M3AhlWYsxTH0aV7Fb
	zPSnCHosiiZQzqg8scYjdSo6U+G5iK9sUzHgi84vI5To5kQ9nQIH/KjI+om0q35kznDDHSty1Ii
	Ii30kSuzfdcXQu24dZrqO78X/ZJFTmdl4Pbk3uGMaBSfieJYBNxBACShnm2Xap44cPo5Ovio8A8
	1sB85Vf9AFrc0d0NLx1UfO+vHYvllJM0ZW/62ExPj5Lg==
X-Google-Smtp-Source: AGHT+IGis1f6KspkvOM2VBXvQEdi5glaA2doxCZeF0Ob2aKVUNq/AVWKalRTwQc42pJMi4xLulDIzA==
X-Received: by 2002:a05:7022:f8c:b0:11b:9386:825d with SMTP id a92af1059eb24-11e032c9b59mr10189100c88.42.1765302562406;
        Tue, 09 Dec 2025 09:49:22 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-11df7573508sm52718771c88.3.2025.12.09.09.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 09:49:22 -0800 (PST)
Date: Tue, 9 Dec 2025 09:49:20 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>, Waiman Long <llong@redhat.com>,
	Hillf Danton <hdanton@sina.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-ID: <20251209174920.GF337106-mkhalfella@purestorage.com>
References: <20251205211738.1872244-1-mkhalfella@purestorage.com>
 <20251205211738.1872244-2-mkhalfella@purestorage.com>
 <eb03af5f-6371-4e3b-acfc-9c3d75403d18@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb03af5f-6371-4e3b-acfc-9c3d75403d18@suse.de>

On Tue 2025-12-09 08:30:23 +0100, Hannes Reinecke wrote:
> On 12/5/25 22:17, Mohamed Khalfella wrote:
> > blk_mq_{add,del}_queue_tag_set() functions add and remove queues from
> > tagset, the functions make sure that tagset and queues are marked as
> > shared when two or more queues are attached to the same tagset.
> > Initially a tagset starts as unshared and when the number of added
> > queues reaches two, blk_mq_add_queue_tag_set() marks it as shared along
> > with all the queues attached to it. When the number of attached queues
> > drops to 1 blk_mq_del_queue_tag_set() need to mark both the tagset and
> > the remaining queues as unshared.
> > 
> > Both functions need to freeze current queues in tagset before setting on
> > unsetting BLK_MQ_F_TAG_QUEUE_SHARED flag. While doing so, both functions
> > hold set->tag_list_lock mutex, which makes sense as we do not want
> > queues to be added or deleted in the process. This used to work fine
> > until commit 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > made the nvme driver quiesce tagset instead of quiscing individual
> > queues. blk_mq_quiesce_tagset() does the job and quiesce the queues in
> > set->tag_list while holding set->tag_list_lock also.
> > 
> > This results in deadlock between two threads with these stacktraces:
> > 
> >    __schedule+0x47c/0xbb0
> >    ? timerqueue_add+0x66/0xb0
> >    schedule+0x1c/0xa0
> >    schedule_preempt_disabled+0xa/0x10
> >    __mutex_lock.constprop.0+0x271/0x600
> >    blk_mq_quiesce_tagset+0x25/0xc0
> >    nvme_dev_disable+0x9c/0x250
> >    nvme_timeout+0x1fc/0x520
> >    blk_mq_handle_expired+0x5c/0x90
> >    bt_iter+0x7e/0x90
> >    blk_mq_queue_tag_busy_iter+0x27e/0x550
> >    ? __blk_mq_complete_request_remote+0x10/0x10
> >    ? __blk_mq_complete_request_remote+0x10/0x10
> >    ? __call_rcu_common.constprop.0+0x1c0/0x210
> >    blk_mq_timeout_work+0x12d/0x170
> >    process_one_work+0x12e/0x2d0
> >    worker_thread+0x288/0x3a0
> >    ? rescuer_thread+0x480/0x480
> >    kthread+0xb8/0xe0
> >    ? kthread_park+0x80/0x80
> >    ret_from_fork+0x2d/0x50
> >    ? kthread_park+0x80/0x80
> >    ret_from_fork_asm+0x11/0x20
> > 
> >    __schedule+0x47c/0xbb0
> >    ? xas_find+0x161/0x1a0
> >    schedule+0x1c/0xa0
> >    blk_mq_freeze_queue_wait+0x3d/0x70
> >    ? destroy_sched_domains_rcu+0x30/0x30
> >    blk_mq_update_tag_set_shared+0x44/0x80
> >    blk_mq_exit_queue+0x141/0x150
> >    del_gendisk+0x25a/0x2d0
> >    nvme_ns_remove+0xc9/0x170
> >    nvme_remove_namespaces+0xc7/0x100
> >    nvme_remove+0x62/0x150
> >    pci_device_remove+0x23/0x60
> >    device_release_driver_internal+0x159/0x200
> >    unbind_store+0x99/0xa0
> >    kernfs_fop_write_iter+0x112/0x1e0
> >    vfs_write+0x2b1/0x3d0
> >    ksys_write+0x4e/0xb0
> >    do_syscall_64+0x5b/0x160
> >    entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > 
> > The top stacktrace is showing nvme_timeout() called to handle nvme
> > command timeout. timeout handler is trying to disable the controller and
> > as a first step, it needs to blk_mq_quiesce_tagset() to tell blk-mq not
> > to call queue callback handlers. The thread is stuck waiting for
> > set->tag_list_lock as it tries to walk the queues in set->tag_list.
> > 
> > The lock is held by the second thread in the bottom stack which is
> > waiting for one of queues to be frozen. The queue usage counter will
> > drop to zero after nvme_timeout() finishes, and this will not happen
> > because the thread will wait for this mutex forever.
> > 
> > Given that [un]quiescing queue is an operation that does not need to
> > sleep, update blk_mq_[un]quiesce_tagset() to use RCU instead of taking
> > set->tag_list_lock, update blk_mq_{add,del}_queue_tag_set() to use RCU
> > safe list operations. Also, delete INIT_LIST_HEAD(&q->tag_set_list)
> > in blk_mq_del_queue_tag_set() because we can not re-initialize it while
> > the list is being traversed under RCU. The deleted queue will not be
> > added/deleted to/from a tagset and it will be freed in blk_free_queue()
> > after the end of RCU grace period.
> > 
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> > ---
> >   block/blk-mq.c | 17 ++++++++---------
> >   1 file changed, 8 insertions(+), 9 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index d626d32f6e57..05db3d20783f 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -335,12 +335,12 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
> >   {
> >   	struct request_queue *q;
> >   
> > -	mutex_lock(&set->tag_list_lock);
> > -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
> >   		if (!blk_queue_skip_tagset_quiesce(q))
> >   			blk_mq_quiesce_queue_nowait(q);
> >   	}
> > -	mutex_unlock(&set->tag_list_lock);
> > +	rcu_read_unlock();
> >   
> >   	blk_mq_wait_quiesce_done(set);
> >   }
> > @@ -350,12 +350,12 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
> >   {
> >   	struct request_queue *q;
> >   
> > -	mutex_lock(&set->tag_list_lock);
> > -	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
> >   		if (!blk_queue_skip_tagset_quiesce(q))
> >   			blk_mq_unquiesce_queue(q);
> >   	}
> > -	mutex_unlock(&set->tag_list_lock);
> > +	rcu_read_unlock();
> >   }
> >   EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
> >   
> > @@ -4294,7 +4294,7 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
> >   	struct blk_mq_tag_set *set = q->tag_set;
> >   
> >   	mutex_lock(&set->tag_list_lock);
> > -	list_del(&q->tag_set_list);
> > +	list_del_rcu(&q->tag_set_list);
> >   	if (list_is_singular(&set->tag_list)) {
> >   		/* just transitioned to unshared */
> >   		set->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
> > @@ -4302,7 +4302,6 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
> >   		blk_mq_update_tag_set_shared(set, false);
> >   	}
> >   	mutex_unlock(&set->tag_list_lock);
> > -	INIT_LIST_HEAD(&q->tag_set_list);
> >   }
> >   
> I'm ever so sceptical whether we can remove the INIT_LIST_HEAD() here.
> If we can it was pointless to begin with, but I somehow doubt that.
> Do you have a rationale for that (except from the fact that you
> are moving to RCU, and hence the 'q' pointer might not be valid then).
> 
I think it was pointless to begin with. 'q' is on its way to be freed.
q->tag_set_list is not going to be used again.
