Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FDA17579
	for <linux-block@vger.kernel.org>; Mon, 21 Oct 2024 01:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729474768; cv=none; b=BmMQeQXGD4myiYrZdI9CoJv1q9EZFyn9uzfHuA6MVrxAj2gVP5AOUs1qf52zZdGgUrpvLzu9t/dTOOsSV0DrLENLMq7ajObn1G/f+eYrccH1fg4SLP3dM++zFp/ywFHu2SD32M8deDzbdKPQHUTqaQgYNmhTLz+KTZVF1nvLAqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729474768; c=relaxed/simple;
	bh=/uzzaNJezF7oaSzA3AeyX2IArPjPGreLCAxbgk9jhz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMqAW9E/d0YMvqb/CJVGW3lMCmN7Crfv4v3YZeYDN0qgX7gBxSbmqT+0MEJ36gKGoreLtLCp3g1hmv1elJo9rzumOOfXLAA2J70FJZVLdGm5DsTyXTyOHjJ0hfBwtKhP+UCGdEqz80QMUZoFDnmTRrhvwlIvxvPvNfrsKaJFDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZeQqg/X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZeQqg/X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729474765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQA277wjiIsEsX13SC3EOBQ9MmBhGxtmhKvxedw4Rlk=;
	b=AZeQqg/Xmcc6nimbyHORQTzSExfIcaUc8WfNYlg2yd7VTKcbmsBsCcWinVam44JESJid8n
	jjCAn+nhE2tjm7GxYooOj2jvz322XrQXAgHFYGRnY8yKOuEcSKcZGf/Y/UPaiFbov/4zmC
	NM/rQG/wfa4Yk2X7hvWsSV3P2XxFNmk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-wQlEZ6TvMaiCF-M6LJjQ4Q-1; Sun,
 20 Oct 2024 21:39:24 -0400
X-MC-Unique: wQlEZ6TvMaiCF-M6LJjQ4Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63B2719560A2;
	Mon, 21 Oct 2024 01:39:21 +0000 (UTC)
Received: from fedora (unknown [10.72.116.25])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87D5519560A2;
	Mon, 21 Oct 2024 01:39:14 +0000 (UTC)
Date: Mon, 21 Oct 2024 09:39:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: zhuxiaohui <zhuxiaohui400@gmail.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
Message-ID: <ZxWwvF0Er-Aj-rtX@fedora>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sun, Oct 20, 2024 at 10:40:41PM +0800, zhuxiaohui wrote:
> From: Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
> 
> It is observed that nvme connect to a nvme over fabric target will
> always fail when 'nohz_full' is set.
> 
> In commit a46c27026da1 ("blk-mq: don't schedule block kworker on
> isolated CPUs"), it clears hctx->cpumask for all isolate CPUs,
> and when nvme connect to a remote target, it may fails on this stack:
> 
>         blk_mq_alloc_request_hctx+1
>         __nvme_submit_sync_cmd+106
>         nvmf_connect_io_queue+181
>         nvme_tcp_start_queue+293
>         nvme_tcp_setup_ctrl+948
>         nvme_tcp_create_ctrl+735
>         nvmf_dev_write+532
>         vfs_write+237
>         ksys_write+107
>         do_syscall_64+128
>         entry_SYSCALL_64_after_hwframe+118
> 
> due to that the given blk_mq_hw_ctx->cpumask is cleared with no available
> blk_mq_ctx on the hw queue.
> 
> This patch introduce a new blk_mq_req_flags_t flag 'BLK_MQ_REQ_ARB_MQ'
> as well as a nvme_submit_flags_t 'NVME_SUBMIT_ARB_MQ' which are used to
> indicate that block layer can fallback to a  blk_mq_ctx whose cpu
> is not isolated.

blk_mq_alloc_request_hctx()
	...
	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
	...

It can happen in case of non-cpu-isolation too, such as when this hctx hasn't
online CPUs, both are same actually from this viewpoint.

It is one long-time problem for nvme fc.


Thanks,
Ming

