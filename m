Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C061096F
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974947; cv=none; b=cbOouNGou8kRWX+s9uE2e8KSCoXBkmebvRp98QDufQC0m/4SWCXctQ36RBDX3Q43jwuzajAdMNodMJbC46uQ76nRFxcIjbgryHuWnfnuxFBYyvMfXdKe4cv/VRghHlKJz0+G0ORyq+yX9CMjP77PPcGCrG2EJAIr6dcQ9e29C8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974947; c=relaxed/simple;
	bh=+joBFnap1Zy88Qx9KLeTDuNpFUQvP/eFFduyXDiR2eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2//AIgzBrhsA6E2Kf4ZctTwRAZbrZcVL8BGxh7X4ycSqzznkqjq4NtsaSGakHIskhaEb/CccqonKr0DRTXVLRUR1OqKc+qO0ID2aUSg6EHNbJv6KqK2rGz5dHGMsgOKeqYOl/m3ny5RLU1jaRirrK1Z6aus07WKFUZn84SxRXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBbO52su; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBbO52su"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763974945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AtOasMHvCP7ivXo4B4weeUpeNfCZFIX/ucoYYb5qtyI=;
	b=QBbO52suArN2/bFE6dJuU8SE38ExyNj4KaLxsWJbL4MkB66I3VmkLl9BaZp0SCt2mVnsBq
	HN0rnhpxXCBsJUoUVFgtWC38DAH4hB0p8ZHuRz+GVUj3FRxL3Sh3Rg3HjhXmvMDBQ+PSFK
	awfiw7mNoo46Te1/w/zoUlDnimM1xRE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-IfGb1u6uNI-ykC5sqbsIKQ-1; Mon,
 24 Nov 2025 04:02:18 -0500
X-MC-Unique: IfGb1u6uNI-ykC5sqbsIKQ-1
X-Mimecast-MFC-AGG-ID: IfGb1u6uNI-ykC5sqbsIKQ_1763974936
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D02BE1955DE0;
	Mon, 24 Nov 2025 09:02:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.210])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 104811956045;
	Mon, 24 Nov 2025 09:02:07 +0000 (UTC)
Date: Mon, 24 Nov 2025 17:02:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: calling into file systems directly from ->queue_rq, was Re:
 [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
Message-ID: <aSQfC2rzoCZcMfTH@fedora>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
 <aSP3SG_KaROJTBHx@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSP3SG_KaROJTBHx@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sun, Nov 23, 2025 at 10:12:24PM -0800, Christoph Hellwig wrote:
> FYI, with this series I'm seeing somewhat frequent stack overflows when
> using loop on top of XFS on top of stacked block devices.

Can you share your setting?

BTW, there are one followup fix:

https://lore.kernel.org/linux-block/20251120160722.3623884-1-ming.lei@redhat.com/

I just run 'xfstests -q quick' on loop on top of XFS on top of dm-stripe,
not see stack overflow with the above fix against -next.

> 
> This seems to be because this can now issue I/O directly from ->queue_rq
> instead of breaking the stack chain, i.e. we can build much deeper call
> stacks now.
> 
> Also this now means a file systems using current->journal_info can call
> into another file system trying to use, making things blow up even worse.
> 
> In other words:  I don't think issuing file system I/O from the
> submission thread in loop can work, and we should drop this again.

I don't object to drop it one more time.

However, can we confirm if it is really a stack overflow because of
calling into FS from ->queue_rq()?

If yes, it could be dead end to improve loop in this way, then I can give up.


Thanks, 
Ming

