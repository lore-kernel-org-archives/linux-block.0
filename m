Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C028EA
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853416; cv=none; b=KcqFKY5nu2ZflM30m5Bj4v4LJpW4LA65EMb7C0GdSL5yX9/rOJcrBRC0DCWzMQeoHvR/1gwpgK6XlMBsEufvCjq4l98hWgvFrk9YPXiP1afK4gx51RRH1kmX/QHpiBEY+Zg+LYOgse7mMiVwoKvp0NE9abVH30zjIqxhFdNstMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853416; c=relaxed/simple;
	bh=7l3eBb2l55GxYWw3MHEY33W+Xz0xSvLoQf9ssIoOkxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNSD5CEGMMQ7+BPqRJrLapWWkR0XbLFpmMHwal28GHkb0ET18o8jOoFNhxO3Eb0cFYWm+hNhM1oCnwj4vf96AnDjIOtD2dYPaIoHmEgCch04TqJlJ5a+EfqD9CXN3b2RD/mimfW0f32oTzYT6VYTcPeg5VCWyCbl8UdWxPxlYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JirB0GLX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JirB0GLX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744853413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JDcHYZNjIr+P/3nxy+/1jmbCilqHne4/lKIG/mV8f7o=;
	b=JirB0GLXznZK4wVgGzX5Sjr3ykYc7AXeYbASTJLaw4HdDONTqwoZx/pNNtryaLJaSmh7us
	rhnbbsol1bDjY3m9nA6/nlzHP1qfZUxNtTyIt5nsDFE7suAv+7Nu+TBxoZAa5/lt1b0fPb
	HGL9/YJen+/5yL0kE0fRg9Z7UU3TJOg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-6M_0QxPbNVq_X6Zv0Jz4lQ-1; Wed,
 16 Apr 2025 21:30:10 -0400
X-MC-Unique: 6M_0QxPbNVq_X6Zv0Jz4lQ-1
X-Mimecast-MFC-AGG-ID: 6M_0QxPbNVq_X6Zv0Jz4lQ_1744853409
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E65F11956094;
	Thu, 17 Apr 2025 01:30:08 +0000 (UTC)
Received: from fedora (unknown [10.72.116.90])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C77C2195608D;
	Thu, 17 Apr 2025 01:30:04 +0000 (UTC)
Date: Thu, 17 Apr 2025 09:29:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH v3 2/2] ublk: require unique task per io instead of
 unique task per hctx
Message-ID: <aABZl4Yxdf3yew4q@fedora>
References: <20250410-ublk_task_per_io-v3-0-b811e8f4554a@purestorage.com>
 <20250410-ublk_task_per_io-v3-2-b811e8f4554a@purestorage.com>
 <Z_jYfwFN_AYkUNJK@fedora>
 <Z/712T8dBZgTRLA4@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/712T8dBZgTRLA4@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Apr 15, 2025 at 06:12:09PM -0600, Uday Shankar wrote:
> On Fri, Apr 11, 2025 at 04:53:19PM +0800, Ming Lei wrote:
> > On Thu, Apr 10, 2025 at 06:17:51PM -0600, Uday Shankar wrote:
> > > Currently, ublk_drv associates to each hardware queue (hctx) a unique
> > > task (called the queue's ubq_daemon) which is allowed to issue
> > > COMMIT_AND_FETCH commands against the hctx. If any other task attempts
> > > to do so, the command fails immediately with EINVAL. When considered
> > > together with the block layer architecture, the result is that for each
> > > CPU C on the system, there is a unique ublk server thread which is
> > > allowed to handle I/O submitted on CPU C. This can lead to suboptimal
> > > performance under imbalanced load generation. For an extreme example,
> > > suppose all the load is generated on CPUs mapping to a single ublk
> > > server thread. Then that thread may be fully utilized and become the
> > > bottleneck in the system, while other ublk server threads are totally
> > > idle.
> > > 
> > > This issue can also be addressed directly in the ublk server without
> > > kernel support by having threads dequeue I/Os and pass them around to
> > > ensure even load. But this solution requires inter-thread communication
> > > at least twice for each I/O (submission and completion), which is
> > > generally a bad pattern for performance. The problem gets even worse
> > > with zero copy, as more inter-thread communication would be required to
> > > have the buffer register/unregister calls to come from the correct
> > > thread.
> > 
> > Agree.
> > 
> > The limit is actually originated from current implementation, both
> > REGISTER_IO_BUF and UNREGISTER_IO_BUF should be fine to run from other
> > pthread because the request buffer 'meta' is actually read-only.
> > 
> > > 
> > > Therefore, address this issue in ublk_drv by requiring a unique task per
> > > I/O instead of per queue/hctx. Imbalanced load can then be balanced
> > > across all ublk server threads by having threads issue FETCH_REQs in a
> > > round-robin manner. As a small toy example, consider a system with a
> > > single ublk device having 2 queues, each of queue depth 4. A ublk server
> > > having 4 threads could issue its FETCH_REQs against this device as
> > > follows (where each entry is the qid,tag pair that the FETCH_REQ
> > > targets):
> > > 
> > > poller thread:	T0	T1	T2	T3
> > > 		0,0	0,1	0,2	0,3
> > > 		1,3	1,0	1,1	1,2
> > > 
> > > Since tags appear to be allocated in sequential chunks, this setup
> > > provides a rough approximation to distributing I/Os round-robin across
> > > all ublk server threads, while letting I/Os stay fully thread-local.
> > 
> > BLK_MQ_F_TAG_RR can be set for this way, so is it possible to make this
> > as one feature? And set BLK_MQ_F_TAG_RR for this feature.
> 
> Yes, it would be easy enough to add. However we have been testing with

That is why I suggest to add it as one feature, such as, PER_IO_TASK,
then you can run any optimization on this feature only in future.

There are other differences for this feature, such as, how to set each io
task's affinity, how to partition tag space in optimized way, ...

BTW, recently I found it is helpful to get good perf by only selecting one
cpu as the queue thread's sched affinity.

One feature flag also has document benefit.

Also `Documentation/block/ublk.rst` need to be updated with this
change/feature.

Fortunately the cancel code patch has been generic enough to cover
PER_IO_TASK already.

> the v1 patch [1] for a while now, and have seen pretty even load
> balancing even without BLK_MQ_F_TAG_RR. So I am not sure if it is worth
> it/if we will use the flag, especially considering that it is documented
> as reducing performance.

per-io task actually depends on IO balance over each partitioned tag space,
which highly relies on tag allocation algorithm.

> 
> [1] https://lore.kernel.org/all/20241002224437.3088981-1-ushankar@purestorage.com/
> 
> > Also can you share what the preferred implementation is for ublk server?
> > 
> > I think per-io pthread may not be good, maybe partition tags space into
> > fixed range/pthread?
> 
> By "unique task per io" I mean that each io can have its own task
> (including two ios in the same queue can have different tasks), but two
> ios can have the same task.
> 
> That's roughly what we're doing, we have a handful of threads (around
> 8-16) and we split up the I/Os between them. With this patch we lift the
> restriction that each thread corresponds 1:1 with a ublk_queue/hctx.

OK, care to add one command line(such as queue_tasks) to enable it in
ublk kernel selftest? Then it can serve:

- the added code can be covered in selftest

- avoid to break this feature by future change

- example for showing how to use this feature

- run performance evaluation with different target setting

The main change should be in ublk_io_handler_fn() & ublk_queue_init() by
allocating one io_uring array for each queue. For target code, we already
have ublk_queue_alloc_sqes(), in which the ring selection can be done
centrally & transparently.

> 
> > `ublk_queue' reference is basically read-only in IO code path, I think
> > it need to be declared explicitly as 'const' pointer in IO code/uring code
> > path first. Otherwise, it is easy to trigger data race with per-io task
> > since it is lockless.
> 
> That is a good suggestion.

Great to see you have started it.

Maybe it can be the prepare patches, which can be merged first.



Thanks,
Ming

