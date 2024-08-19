Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C962BAEB
	for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 02:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724034478; cv=none; b=oc4bBMKbUPoxqotIi0VhlGIiuBsbRN7wC/v1p4fMNoG8BIcqetsDDXtP+fTcv+yNi6j9UcjsXCDdzj3eBEx0K4aKfq+9KIYif0RqdYK1v2uMjgDDYY4HF8a6UXu1r75iXIO/sWIVttVg2b35TFktbQuWG6zcVThCw3a3a6UlSgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724034478; c=relaxed/simple;
	bh=Iiqeic79pi9nenPlkGS4sY/hzeN0ATunWCrzxPbuJN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdBrSqj+sMUOrtTwz9ScZ+cLA+Pj+XYWycwmOjNJ9sIrczNlcBL/7UvM8sCF4Tlrtf1uHvt/RSDVphY9saG1z0+c/QGmbMPaNb3eP6eYpP7jxxWxqkYvVpiTFqnUdjr779uMqiSZNBAfYbrz6kXNP2UoUO1pvm9L0x1d8U+fkgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EFLCLrpb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFLCLrpb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724034473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxhuN2exCNnEqkY3HnUfUNgfKlAPCdqQvvzMpZrakNs=;
	b=EFLCLrpbiQUUaNUhqCtBeqEQkAsae0YN2znjKmFVlNuA1G2VXcfokMdzq32sN8QUx0JC0d
	2g+N3BKoc/6d6E2K5Eql/9SFGFlSfqsQPELzZfkMc4fdWqIP5LK3w9YWGahe7iJ2FJteHV
	DlSuDPrx3kYdW1XgzGknd+xXkcJUKxU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-38_HDQfTM_my5ANY1HW8OQ-1; Sun,
 18 Aug 2024 22:27:50 -0400
X-MC-Unique: 38_HDQfTM_my5ANY1HW8OQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C887A1955F3D;
	Mon, 19 Aug 2024 02:27:44 +0000 (UTC)
Received: from fedora (unknown [10.72.116.101])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BE3419773DF;
	Mon, 19 Aug 2024 02:27:39 +0000 (UTC)
Date: Mon, 19 Aug 2024 10:27:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 2/4] block: fix ordering between checking
 BLK_MQ_S_STOPPED and adding requests to hctx->dispatch
Message-ID: <ZsKtllxojkTe3mpY@fedora>
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-3-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811101921.4031-3-songmuchun@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Muchun,

On Sun, Aug 11, 2024 at 06:19:19PM +0800, Muchun Song wrote:
> Supposing the following scenario with a virtio_blk driver.
> 
> CPU0                                                                CPU1
> 
> blk_mq_try_issue_directly()
>     __blk_mq_issue_directly()
>         q->mq_ops->queue_rq()
>             virtio_queue_rq()
>                 blk_mq_stop_hw_queue()
>                                                                     virtblk_done()
>     blk_mq_request_bypass_insert()                                      blk_mq_start_stopped_hw_queues()
>         /* Add IO request to dispatch list */   1) store                    blk_mq_start_stopped_hw_queue()
>                                                                                 clear_bit(BLK_MQ_S_STOPPED)                 3) store
>     blk_mq_run_hw_queue()                                                       blk_mq_run_hw_queue()
>         if (!blk_mq_hctx_has_pending())                                             if (!blk_mq_hctx_has_pending())         4) load
>             return                                                                      return
>         blk_mq_sched_dispatch_requests()                                            blk_mq_sched_dispatch_requests()
>             if (blk_mq_hctx_stopped())          2) load                                 if (blk_mq_hctx_stopped())
>                 return                                                                      return
>             __blk_mq_sched_dispatch_requests()                                          __blk_mq_sched_dispatch_requests()
> 
> The full memory barrier should be inserted between 1) and 2), as well as between
> 3) and 4) to make sure that either CPU0 sees BLK_MQ_S_STOPPED is cleared or CPU1
> sees dispatch list or setting of bitmap of software queue. Otherwise, either CPU
> will not re-run the hardware queue causing starvation.

Yeah, it is one kind of race which is triggered when adding request into
->dispatch list after returning STS_RESOURCE. We were troubled by lots of
such kind of race.

stopping queue is used in very less drivers, and its only purpose should
be for throttling hw queue in case that low level queue is busy. There seems
more uses of blk_mq_stop_hw_queues(), but most of them should be replaced
with blk_mq_quiesce_queue().

IMO, fixing this kind of issue via memory barrier is too tricky to
maintain cause WRITE/READ dependency is very hard to follow. I'd suggest to
make memory barrier solution as the last resort, and we can try to figure
out other easier & more reliable way first.

One idea I thought of is to call blk_mq_request_bypass_insert()(or rename
& export it) before calling blk_mq_stop_hw_queue() in driver, then
return new status code STS_STOP_DISPATCH for notifying blk-mq to stop
dispatch simply.


thanks,
Ming

