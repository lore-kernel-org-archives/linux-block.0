Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E272614
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 07:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464925; cv=none; b=CIRVeVlSfx6fgV4ILHFkw4009jKDEj/FIUUdNE+W7tVluEBBmLqt1omDSRmd5pADD0+NCLCTVk2I+eXAMTw5hPsPO8AOkmlWYyoflSKqxMRgxb5dr/sP/flaMap5XuVR2n4aZHfVjYkPodHdIsDUMCTtXWdiaCY8aFPij8adPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464925; c=relaxed/simple;
	bh=dhG6we6M/mLtAnIpRjNUK0JnPRp6VvlLVyrt8kulklc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qv6iVvK7nBBgwoziz6eqvfRqvgqFEqgyK27zFRRID5UiTqc72rodd4oZzof9et3cPTwdbkfVepWfxX3gRP7b1Mxd1IdwpZISqN6uV/Cq36+QxceB6ARUdEbjz98Qn3iGTkrjAzylK6ZDL3rZbvPCCJk357DkjL/cREP4FAejdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XClBFO69; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XClBFO69"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754464921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5TWNjHyL02FdYMAY/O8HimM+YJa4gJVyBuV2mOJEco=;
	b=XClBFO69QifNbm7aZvigqBG358DMW9+02eSqwzZHY89WNZCgYM5lw6LEpubDyRaf8Iarjr
	ffC7LfU5je2GfDVcbd/yfb3O5ZHinmlOqH5dA5dhs9hk628CQyoohpQ5JmXA8Nhikp0s2z
	3ejT8f0g24W2iZ6hZUqNqsbxKfS+uZA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-IcECjP6ZP6uRjBapL3E4aw-1; Wed,
 06 Aug 2025 03:21:56 -0400
X-MC-Unique: IcECjP6ZP6uRjBapL3E4aw-1
X-Mimecast-MFC-AGG-ID: IcECjP6ZP6uRjBapL3E4aw_1754464915
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 638FA19560B4;
	Wed,  6 Aug 2025 07:21:54 +0000 (UTC)
Received: from fedora (unknown [10.72.116.154])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E20430001A1;
	Wed,  6 Aug 2025 07:21:48 +0000 (UTC)
Date: Wed, 6 Aug 2025 15:21:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, kch@nvidia.com,
	shinichiro.kawasaki@wdc.com, hch@lst.de, gjoyce@ibm.com
Subject: Re: [PATCH 0/2] block: blk-rq-qos: replace static key with atomic
 bitop
Message-ID: <aJMCiMC6luT_V-f7@fedora>
References: <20250804122125.3271397-1-nilay@linux.ibm.com>
 <aJC4tDUsk42Nb9Df@fedora>
 <682f0f43-733a-4c04-91ed-5665815128bc@linux.ibm.com>
 <aJH8qDEzV4tiG2wE@fedora>
 <897eaaa4-31c7-4661-b5d4-3e2bef1fca1e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <897eaaa4-31c7-4661-b5d4-3e2bef1fca1e@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Aug 05, 2025 at 10:35:38PM +0530, Nilay Shroff wrote:
> 
> 
> On 8/5/25 6:14 PM, Ming Lei wrote:
> > On Tue, Aug 05, 2025 at 10:28:14AM +0530, Nilay Shroff wrote:
> >>
> >>
> >> On 8/4/25 7:12 PM, Ming Lei wrote:
> >>> On Mon, Aug 04, 2025 at 05:51:09PM +0530, Nilay Shroff wrote:
> >>>> This patchset replaces the use of a static key in the I/O path (rq_qos_
> >>>> xxx()) with an atomic queue flag (QUEUE_FLAG_QOS_ENABLED). This change
> >>>> is made to eliminate a potential deadlock introduced by the use of static
> >>>> keys in the blk-rq-qos infrastructure, as reported by lockdep during 
> >>>> blktests block/005[1].
> >>>>
> >>>> The original static key approach was introduced to avoid unnecessary
> >>>> dereferencing of q->rq_qos when no blk-rq-qos module (e.g., blk-wbt or
> >>>> blk-iolatency) is configured. While efficient, enabling a static key at
> >>>> runtime requires taking cpu_hotplug_lock and jump_label_mutex, which 
> >>>> becomes problematic if the queue is already frozen — causing a reverse
> >>>> dependency on ->freeze_lock. This results in a lockdep splat indicating
> >>>> a potential deadlock.
> >>>>
> >>>> To resolve this, we now gate q->rq_qos access with a q->queue_flags
> >>>> bitop (QUEUE_FLAG_QOS_ENABLED), avoiding the static key and the associated
> >>>> locking altogether.
> >>>>
> >>>> I compared both static key and atomic bitop implementations using ftrace
> >>>> function graph tracer over ~50 invocations of rq_qos_issue() while ensuring
> >>>> blk-wbt/blk-iolatency were disabled (i.e., no QoS functionality). For
> >>>> easy comparision, I made rq_qos_issue() noinline. The comparision was
> >>>> made on PowerPC machine.
> >>>>
> >>>> Static Key (disabled : QoS is not configured):
> >>>> 5d0: 00 00 00 60     nop    # patched in by static key framework (not taken)
> >>>> 5d4: 20 00 80 4e     blr    # return (branch to link register)
> >>>>
> >>>> Only a nop and blr (branch to link register) are executed — very lightweight.
> >>>>
> >>>> atomic bitop (QoS is not configured):
> >>>> 5d0: 20 00 23 e9     ld      r9,32(r3)     # load q->queue_flags
> >>>> 5d4: 00 80 29 71     andi.   r9,r9,32768   # check QUEUE_FLAG_QOS_ENABLED (bit 15)
> >>>> 5d8: 20 00 82 4d     beqlr                 # return if bit not set
> >>>>
> >>>> This performs an ld and and andi. before returning. Slightly more work, 
> >>>> but q->queue_flags is typically hot in cache during I/O submission.
> >>>>
> >>>> With Static Key (disabled):
> >>>> Duration (us): min=0.668 max=0.816 avg≈0.750
> >>>>
> >>>> With atomic bitop QUEUE_FLAG_QOS_ENABLED (bit not set):
> >>>> Duration (us): min=0.684 max=0.834 avg≈0.759
> >>>>
> >>>> As expected, both versions are almost similar in cost. The added latency
> >>>> from an extra ld and andi. is in the range of ~9ns.
> >>>>
> >>>> There're two patches in the series. The first patch replaces static key
> >>>> with QUEUE_FLAG_QOS_ENABLED. The second patch ensures that we disable
> >>>> the QUEUE_FLAG_QOS_ENABLED when the queue no longer has any associated
> >>>> rq_qos policies.
> >>>>
> >>>> As usual, feedback and review comments are welcome!
> >>>>
> >>>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> >>>
> >>>
> >>> Another approach is to call memalloc_noio_save() in cpu hotplug code...
> >>>
> >> Yes that would help fix this. However per the general usage of GFP_NOIO scope in 
> >> kernel, it is used when we're performing memory allocations in a context where I/O
> >> must not be initiated, because doing so could cause deadlocks or recursion. 
> >>
> >> So we typically, use GFP_NOIO in a code path that is already doing I/O, such as:
> >> - In block layer context: during request submission 
> >> - Filesystem writeback, or swap-out.
> >> - Memory reclaim or writeback triggered by memory pressure.
> > 
> > If you grep blk_mq_freeze_queue, you will see the above list is far from
> > enough, :-)
> > 
> Yes you were correct:-) I didn't cover all cases but only a subset.
> 
> >>
> >> The cpu hotplug code may not be running in any of the above context. So
> >> IMO, adding memalloc_noio_save() in the cpu hotplug code would not be 
> >> a good idea, isn't it?
> > 
> > The reasoning(A -> B) looks correct, but the condition A is obviously not.
> > 
> Regarding the use of memalloc_noio_save() in CPU hotplug code:
> Notably this issue isn't limited to the CPU hotplug subsystem itself. 
> In reality, the cpu_hotplug_lock is widely used across various kernel 
> subsystems—not just in CPU hotplug-specific paths. There are several
> code paths outside of the hotplug core that acquire cpu_hotplug_lock
> and subsequently perform memory allocations using GFP_KERNEL.
> 
> You can observe this by grepping for usages of cpu_hotplug_lock throughout
> the kernel. This means that adding memalloc_noio_save() solely within the
> CPU hotplug code wouldn't address the broader problem.
> 
> I also experimented with placing memalloc_noio_save() in CPU hotplug path,
> and as expected, I still encountered a lockdep splat—indicating that the 
> root cause lies deeper in the general locking and allocation order around
> cpu_hotplug_lock and memory reclaim behavior. Please see below the new 
> lockdep splat observed (after adding memalloc_noio_save() in CPU hotplug
> code):
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.16.0+ #14 Not tainted
> ------------------------------------------------------
> check/4628 is trying to acquire lock:
> c0000000027b30c8 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_slow_inc+0x24/0x50
> 
> but task is already holding lock:
> c0000000cb825d28 (&q->q_usage_counter(io)#18){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x28/0x40
> 
> which lock already depends on the new lock.
> 

Technically it can be addressed by adding memalloc_noio_save() to
cpus_read_lock(), but it is one tree-wide change, so becomes harder
to move towards this way.

Now I don't object the approach in this patchset any more.


Thanks,
Ming

