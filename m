Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7ED171C9
	for <linux-block@vger.kernel.org>; Sat, 16 Aug 2025 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755309597; cv=none; b=PAE/r3igdsZfyJK9TOFJAOnxbxt3nCch3YVqLS7IBKvql2RBdpOtQJE2WUImOVrno/QBOzsI6fDNyQ5iD3/x0rTgVoutQTZP1COufOoXph0H4TU6SCoqGI0hzHhZhc1F+R06evcyr54rfdEKzzj4hOpOSv5OYG2OOJl4801SFXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755309597; c=relaxed/simple;
	bh=dWGVEW0rI4jZsOH+fJ+GfjpIjS2ER2w/z9imFecE0Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MohFd1E+lDyt+ADLYq6tudYXaK9GBxuYZi9xleBl0ZBFi+Yt2OiaMYhAN/mTeD/V28a5QHeg4O6NXO0OM8X0kNztxVqBhNBuKPSRQnqKpTyQzZOHZI5ZKWh+taBjXDY20KgrVYYfSB/El3a8AfKuZ9s5oWGjReH0NViKc/9YYnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0PLwCkP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0PLwCkP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755309593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AHny59QuKH1WGEjYsTIpzzo9XWmx+jTQix7hBrx4Os0=;
	b=i0PLwCkPYJemQ6mSt4ro49vAOV4UMziDYZJsfZwdQXxHyXmCyRSF8JD/aoR0jJ2TNbrl5F
	EGCdaLeiqUXQ1eBH8AqPJJ69iuuHNAv5Oeb3OB2SLKPUwcvMtlcLBYN9rBxvtPluLwgmjC
	AM7u5kWr1h5Ew0ZqZe/eENKhvcoySpo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-PRJwOZ5-M_GCgvcgUd1Cjw-1; Fri,
 15 Aug 2025 21:59:50 -0400
X-MC-Unique: PRJwOZ5-M_GCgvcgUd1Cjw-1
X-Mimecast-MFC-AGG-ID: PRJwOZ5-M_GCgvcgUd1Cjw_1755309588
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E509F1956086;
	Sat, 16 Aug 2025 01:59:47 +0000 (UTC)
Received: from fedora (unknown [10.72.116.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0BAC19327C0;
	Sat, 16 Aug 2025 01:59:41 +0000 (UTC)
Date: Sat, 16 Aug 2025 09:59:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, yukuai1@huaweicloud.com,
	hch@lst.de, shinichiro.kawasaki@wdc.com, kch@nvidia.com,
	gjoyce@ibm.com
Subject: Re: [PATCHv3 3/3] block: avoid cpu_hotplug_lock depedency on
 freeze_lock
Message-ID: <aJ_mCDObfCV999UX@fedora>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
 <20250814082612.500845-4-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814082612.500845-4-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Aug 14, 2025 at 01:54:59PM +0530, Nilay Shroff wrote:
> A recent lockdep[1] splat observed while running blktest block/005
> reveals a potential deadlock caused by the cpu_hotplug_lock dependency
> on ->freeze_lock. This dependency was introduced by commit 033b667a823e
> ("block: blk-rq-qos: guard rq-qos helpers by static key").
> 
> That change added a static key to avoid fetching q->rq_qos when
> neither blk-wbt nor blk-iolatency is configured. The static key
> dynamically patches kernel text to a NOP when disabled, eliminating
> overhead of fetching q->rq_qos in the I/O hot path. However, enabling
> a static key at runtime requires acquiring both cpu_hotplug_lock and
> jump_label_mutex. When this happens after the queue has already been
> frozen (i.e., while holding ->freeze_lock), it creates a locking
> dependency from cpu_hotplug_lock to ->freeze_lock, which leads to a
> potential deadlock reported by lockdep [1].
> 
> To resolve this, replace the static key mechanism with q->queue_flags:
> QUEUE_FLAG_QOS_ENABLED. This flag is evaluated in the fast path before
> accessing q->rq_qos. If the flag is set, we proceed to fetch q->rq_qos;
> otherwise, the access is skipped.
> 
> Since q->queue_flags is commonly accessed in IO hotpath and resides in
> the first cacheline of struct request_queue, checking it imposes minimal
> overhead while eliminating the deadlock risk.
> 
> This change avoids the lockdep splat without introducing performance
> regressions.
> 
> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

It is hard to use static branch correctly in current case from lock viewpoint, and
most distributions should enable at least one rqos, so static branch won't optimize
for typical cases:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

