Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE8182D0
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751340007; cv=none; b=OpPfDSY2NEE20vNZJOGrQTiwX73YcTlzz49FYvAMMMCpsW0UTp0tmMjBVOvuvzKxK5adCIJmtSRpmmqhFaRYzC+fegA0X9rtzX6MicSXQwGO2hhuFcDKLt4nrO2unPG+6K6VpeTV4o4pvMCQoX6Ucw63ECVd3rjItDkDic92qd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751340007; c=relaxed/simple;
	bh=iUBszRQ8fsWE6QLTfB8yVj5VabY+bNBCECMHZwO+HhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l66W5b7GUz2WsduK454ibokGuR8H+EzLvbXw9Pf+f/x3XxLXdoYMI7aBwOSsFPi8+VFQiiiNuBwYK01psutVFrnWeyZ1TYDqmr/6pdVjxJEv9EON8mgsm00EvS1vuaP4MLG+VUd9Fz1z+CNXyjSkVpLSo5mJv4l0iiBx3fInQ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgmV8lYd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgmV8lYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751340004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7qdqyczZhaUxcCF3Q+pkKyz1W+hxIYch/jkutiH1JLQ=;
	b=cgmV8lYdpI4Q9Zcyo/mBeEoRmDKap+x9QvagbnQEa5gdF3/ekpWO7aZVcXOqjDPgaYM6/S
	uICbRlqb6zSY4RaJ7pey9RfmHyxHPizm3z9+G7KNpzYcGDZBSI0i0F7Po6jtaxS0Ntk9ZN
	msqjdsQ7Ehn+vUvl1L0376wRrBYTv00=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-BYmS2TVDNt6cms3UDUCBcw-1; Mon,
 30 Jun 2025 23:20:01 -0400
X-MC-Unique: BYmS2TVDNt6cms3UDUCBcw-1
X-Mimecast-MFC-AGG-ID: BYmS2TVDNt6cms3UDUCBcw_1751339999
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED44A18011FE;
	Tue,  1 Jul 2025 03:19:58 +0000 (UTC)
Received: from fedora (unknown [10.72.116.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F35A6195E74A;
	Tue,  1 Jul 2025 03:19:53 +0000 (UTC)
Date: Tue, 1 Jul 2025 11:19:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	sth@linux.ibm.com, lkp@intel.com, gjoyce@ibm.com
Subject: Re: [PATCHv6 2/3] block: fix lockdep warning caused by lock
 dependency in elv_iosched_store
Message-ID: <aGNT1L_MWN2cMDUg@fedora>
References: <20250630054756.54532-1-nilay@linux.ibm.com>
 <20250630054756.54532-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630054756.54532-3-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jun 30, 2025 at 10:51:55AM +0530, Nilay Shroff wrote:
> Recent lockdep reports [1] have revealed a potential deadlock caused by a
> lock dependency between the percpu allocator lock and the elevator lock.
> This issue can be avoided by ensuring that the allocation and release of
> scheduler tags (sched_tags) are performed outside the elevator lock.
> Furthermore, the queue does not need to be remain frozen during these
> operations.
> 
> To address this, move all sched_tags allocations and deallocations outside
> of both the ->elevator_lock and the ->freeze_lock. Since the lifetime of
> the elevator queue and its associated sched_tags is closely tied, the
> allocated sched_tags are now stored in the elevator queue structure. Then,
> during the actual elevator switch (which runs under ->freeze_lock and
> ->elevator_lock), the pre-allocated sched_tags are assigned to the
> appropriate q->hctx. Once the elevator switch is complete and the locks
> are released, the old elevator queue and its associated sched_tags are
> freed.
> 
> This commit specifically addresses the allocation/deallocation of sched_
> tags during elevator switching. Note that sched_tags may also be allocated
> in other contexts, such as during nr_hw_queues updates. Supporting that
> use case will require batch allocation/deallocation, which will be handled
> in a follow-up patch.
> 
> This restructuring ensures that sched_tags memory management occurs
> entirely outside of the ->elevator_lock and ->freeze_lock context,
> eliminating the lock dependency problem seen during scheduler updates.
> 
> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> 
> Reported-by: Stefan Haberland <sth@linux.ibm.com>
> Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

