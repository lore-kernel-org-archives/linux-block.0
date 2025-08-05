Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4511D5CEA
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397891; cv=none; b=BQrJGrrL/HHIzXQZ2tIlNJS2pghv4/sLWr45FEzyhGPiIQ3VIWpEWYjohO+BY2qyyo1YSXVgC4TGbOjF/c/z12xj8uBZ1WRRMJp9/JyiI+wx6WQK3HgNNj2CwvQZgW8qVoFtTlwuOK27j78AHqPllOAyk+6gkbrg9rH+K45Vli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397891; c=relaxed/simple;
	bh=Si6MReIrTk1/rh8ENRbKAplQGUzXxcK5ZPZD845rZrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpJMuTvU3KWhoUMOEpI5wiXDsjbn4TZKj852qz17NGPeXHF+vNCDKfVmFJpGuBGRk73M0Py0QJIoW67B9eFMnU9wdgdBDHQtUH9KNaiXASyG/W51lrj+VL7+TiIbrDIjQ5JVCIStnIxEILN5LZomXz1lPv0VPhnMG/9AnrjNOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B1PJmNfC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1PJmNfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754397888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BF1RUyoME7iGL8y4OTbb+xtfAVb+8hSzDJ3hc266uHI=;
	b=B1PJmNfCK0vDF3OkBrejja+GpQe+n+s6+jJRzjO349/ewFG+Oig+gRDuKrx+8s1yO2tehh
	sP73Lhs5q/S0/PlM1WLBkgu+CgqpsEGG7SBRRX1YFQ0JvTs08vG/1U87PtkW9tLu93DP4f
	+/gAmPM9OOeRe5A9CUdMyS66q4k5Tus=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-Fz0r2K1QNyyX1ACUJqYXKw-1; Tue,
 05 Aug 2025 08:44:45 -0400
X-MC-Unique: Fz0r2K1QNyyX1ACUJqYXKw-1
X-Mimecast-MFC-AGG-ID: Fz0r2K1QNyyX1ACUJqYXKw_1754397884
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 808BC195D020;
	Tue,  5 Aug 2025 12:44:43 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 880E81954B0C;
	Tue,  5 Aug 2025 12:44:34 +0000 (UTC)
Date: Tue, 5 Aug 2025 20:44:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, kch@nvidia.com,
	shinichiro.kawasaki@wdc.com, hch@lst.de, gjoyce@ibm.com
Subject: Re: [PATCH 0/2] block: blk-rq-qos: replace static key with atomic
 bitop
Message-ID: <aJH8qDEzV4tiG2wE@fedora>
References: <20250804122125.3271397-1-nilay@linux.ibm.com>
 <aJC4tDUsk42Nb9Df@fedora>
 <682f0f43-733a-4c04-91ed-5665815128bc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <682f0f43-733a-4c04-91ed-5665815128bc@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Aug 05, 2025 at 10:28:14AM +0530, Nilay Shroff wrote:
> 
> 
> On 8/4/25 7:12 PM, Ming Lei wrote:
> > On Mon, Aug 04, 2025 at 05:51:09PM +0530, Nilay Shroff wrote:
> >> This patchset replaces the use of a static key in the I/O path (rq_qos_
> >> xxx()) with an atomic queue flag (QUEUE_FLAG_QOS_ENABLED). This change
> >> is made to eliminate a potential deadlock introduced by the use of static
> >> keys in the blk-rq-qos infrastructure, as reported by lockdep during 
> >> blktests block/005[1].
> >>
> >> The original static key approach was introduced to avoid unnecessary
> >> dereferencing of q->rq_qos when no blk-rq-qos module (e.g., blk-wbt or
> >> blk-iolatency) is configured. While efficient, enabling a static key at
> >> runtime requires taking cpu_hotplug_lock and jump_label_mutex, which 
> >> becomes problematic if the queue is already frozen — causing a reverse
> >> dependency on ->freeze_lock. This results in a lockdep splat indicating
> >> a potential deadlock.
> >>
> >> To resolve this, we now gate q->rq_qos access with a q->queue_flags
> >> bitop (QUEUE_FLAG_QOS_ENABLED), avoiding the static key and the associated
> >> locking altogether.
> >>
> >> I compared both static key and atomic bitop implementations using ftrace
> >> function graph tracer over ~50 invocations of rq_qos_issue() while ensuring
> >> blk-wbt/blk-iolatency were disabled (i.e., no QoS functionality). For
> >> easy comparision, I made rq_qos_issue() noinline. The comparision was
> >> made on PowerPC machine.
> >>
> >> Static Key (disabled : QoS is not configured):
> >> 5d0: 00 00 00 60     nop    # patched in by static key framework (not taken)
> >> 5d4: 20 00 80 4e     blr    # return (branch to link register)
> >>
> >> Only a nop and blr (branch to link register) are executed — very lightweight.
> >>
> >> atomic bitop (QoS is not configured):
> >> 5d0: 20 00 23 e9     ld      r9,32(r3)     # load q->queue_flags
> >> 5d4: 00 80 29 71     andi.   r9,r9,32768   # check QUEUE_FLAG_QOS_ENABLED (bit 15)
> >> 5d8: 20 00 82 4d     beqlr                 # return if bit not set
> >>
> >> This performs an ld and and andi. before returning. Slightly more work, 
> >> but q->queue_flags is typically hot in cache during I/O submission.
> >>
> >> With Static Key (disabled):
> >> Duration (us): min=0.668 max=0.816 avg≈0.750
> >>
> >> With atomic bitop QUEUE_FLAG_QOS_ENABLED (bit not set):
> >> Duration (us): min=0.684 max=0.834 avg≈0.759
> >>
> >> As expected, both versions are almost similar in cost. The added latency
> >> from an extra ld and andi. is in the range of ~9ns.
> >>
> >> There're two patches in the series. The first patch replaces static key
> >> with QUEUE_FLAG_QOS_ENABLED. The second patch ensures that we disable
> >> the QUEUE_FLAG_QOS_ENABLED when the queue no longer has any associated
> >> rq_qos policies.
> >>
> >> As usual, feedback and review comments are welcome!
> >>
> >> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> > 
> > 
> > Another approach is to call memalloc_noio_save() in cpu hotplug code...
> > 
> Yes that would help fix this. However per the general usage of GFP_NOIO scope in 
> kernel, it is used when we're performing memory allocations in a context where I/O
> must not be initiated, because doing so could cause deadlocks or recursion. 
> 
> So we typically, use GFP_NOIO in a code path that is already doing I/O, such as:
> - In block layer context: during request submission 
> - Filesystem writeback, or swap-out.
> - Memory reclaim or writeback triggered by memory pressure.

If you grep blk_mq_freeze_queue, you will see the above list is far from
enough, :-)

> 
> The cpu hotplug code may not be running in any of the above context. So
> IMO, adding memalloc_noio_save() in the cpu hotplug code would not be 
> a good idea, isn't it?

The reasoning(A -> B) looks correct, but the condition A is obviously not.


Thanks,
Ming

