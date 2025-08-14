Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358A5192D97
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158071; cv=none; b=erFgyENW98I2KdDPQ7/J6SE9V0qMVNZrtFckfMGwO4vAMHFVYhkZRk1H1rKvewEPbz0uoJ9Ck82S5GFQJvyWYGyFGJt0GBwmQkLCwRDMHHICJ7e8NWMA88yIWJEKyv/SEOZ19MrDLNamaEi1KGZxDrVN4wix5wVkUTGqhNBXzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158071; c=relaxed/simple;
	bh=gFxsN1xHXuH4aYODzZvCn6y9twW0wvYlwEoeBLVoaNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8A7/N+pTI23PN354TIp7P4EaOHp0+Lre85gEtbtsQBZAiKK8eLBSM9ZBvdinBhYaElWL02cYtrqX9KqBeM7z8qhlHE5rJSflxmglbQnjZcMzh/D3AOOcAgRs873ocr1TPkZYyJdGNjFNxQIasx2n99KQGC3JJIrog4qIA5bJXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHZnmlxk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHZnmlxk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755158068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gvCHjnpcSAUaN7gXzwggkNMvZ98WWP2pt/inhjEHLms=;
	b=SHZnmlxkLF07TrXjmvKcFrWrwiaUufSgExrzsNftLz1/Tpo6LLqGsYbbnNrwK3WfIkkXw0
	rLioeEie951IUm4gI01/HIpWX3C2SEuIna1zjvJLRyL4nksmAihMqmnmpklxToQb/m4THM
	pVIf7zuMAL7mtefNBxQNhZdxAaYyi8s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-bu6aYrPAMeysp_9OCXCHZA-1; Thu,
 14 Aug 2025 03:54:24 -0400
X-MC-Unique: bu6aYrPAMeysp_9OCXCHZA-1
X-Mimecast-MFC-AGG-ID: bu6aYrPAMeysp_9OCXCHZA_1755158062
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BA711800298;
	Thu, 14 Aug 2025 07:54:21 +0000 (UTC)
Received: from fedora (unknown [10.72.116.148])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 805F019327C0;
	Thu, 14 Aug 2025 07:54:11 +0000 (UTC)
Date: Thu, 14 Aug 2025 15:54:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, yukuai3@huawei.com, bvanassche@acm.org,
	nilay@linux.ibm.com, hare@suse.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 00/16] blk-mq: introduce new queue attribute asyc_dpeth
Message-ID: <aJ2WH_RAMPQ9sd6r@fedora>
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814033522.770575-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Aug 14, 2025 at 11:35:06AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Backgroud and motivation:
> 
> At first, we test a performance regression from 5.10 to 6.6 in
> downstream kernel(described in patch 13), the regression is related to
> async_depth in mq-dealine.
> 
> While trying to fix this regression, Bart suggests add a new attribute
> to request_queue, and I think this is a good idea because all elevators
> have similar logical, however only mq-deadline allow user to configure
> async_depth. And this is patch 9-16, where the performance problem is
> fixed in patch 13;
> 
> Because async_depth is related to nr_requests, while reviewing related
> code, patch 2-7 are cleanups and fixes to nr_reqeusts.
> 
> I was planning to send this set for the next merge window, however,
> during test I found the last block pr(6.17-rc1) introduce a regression
> if nr_reqeusts grows, exit elevator will panic, and I fix this by
> patch 1,8.

Please split the patchset into two:

- one is for fixing recent regression on updating 'nr_requests', so this
  can be merged to v6.17, and be backport easily for stable & downstream

- another one is for improving IO performance related with async_depth.


Thanks,
Ming

