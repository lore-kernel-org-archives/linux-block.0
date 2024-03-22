Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445917FD
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 02:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711074374; cv=none; b=AOEPgCQGNAD3TepKr0PMT0rjNKH1xp5lM212bCGouNxRzzDZnZME6CoimLnWoZOPnr7aKoH6g7fD8zlWVwrP7Xua2a6/HysygL82pOEJeqqTozqI8Pn8nU2wnk9nM/EjDvg5un1H6dO1Ig7fbo8Si5Voww6UeEs70Lpp/C8WuZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711074374; c=relaxed/simple;
	bh=AOzOD8RBDmM8Y1KPrUT9j6lSvGC1LXyXz2s4GV0oIjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDkeNWS4eOxioWQnzP0NAd0hI/r6YNrfqFuNGYPe4aYVVbD1aNLV7IWrpeGUNQ2+q9dRte2/sYbhdMXjvrtom5bBFpEopE5e5fOQIn5XsYkWUEtew/JYJyu74284FKRE/dCtyDyxKh/c3Zud2iichgH9IS86UH9IjbQgQ9/o4Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V1wyOiEQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1wyOiEQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711074371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N7746ZU4FoSSPfS7xv/0h+o6rQB3qDPk+tHdE5cymGc=;
	b=V1wyOiEQ69YHUhQGuq4eP6bgd8klAw26fUxIwub9kd6Nyo3Bmy414giZEiP8Cigq2DoKSg
	Y2cEGheEaz+43+b9tv/2fs4QCVwCMtq07pCgrBI966yQAAheSd1o5+omJm9v9ikA4vd5sZ
	vcvBZx3DeDIEoAQ0pZtvBX4LZyMadpo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-ncHV1_6CPv6jR1cbCmUpgA-1; Thu, 21 Mar 2024 22:26:06 -0400
X-MC-Unique: ncHV1_6CPv6jR1cbCmUpgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBA2C800265;
	Fri, 22 Mar 2024 02:26:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A747EC041F0;
	Fri, 22 Mar 2024 02:26:00 +0000 (UTC)
Date: Fri, 22 Mar 2024 10:25:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Yu Kuai <yukuai3@huawei.com>, ming.lei@redhat.com
Subject: Re: [PATCH] block: Improve IOPS by removing the fairness code
Message-ID: <ZfzsMIGnaGhWCw80@fedora>
References: <20240321224605.107783-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321224605.107783-1-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Thu, Mar 21, 2024 at 03:46:05PM -0700, Bart Van Assche wrote:
> There is an algorithm in the block layer for maintaining fairness
> across queues that share a tag set. The sbitmap implementation has
> improved so much that we don't need the block layer fairness algorithm
> anymore and that we can rely on the sbitmap implementation to guarantee
> fairness.
> 
> This patch removes the following code and structure members:
> - The function hctx_may_queue().
> - blk_mq_hw_ctx.nr_active and request_queue.nr_active_requests_shared_tags
>   and also all the code that modifies these two member variables.
> 
> On my test setup (x86 VM with 72 CPU cores) this patch results in 2.9% more
> IOPS. IOPS have been measured as follows:
> 
> $ modprobe null_blk nr_devices=1 completion_nsec=0
> $ fio --bs=4096 --disable_clat=1 --disable_slat=1 --group_reporting=1 \
>       --gtod_reduce=1 --invalidate=1 --ioengine=psync --ioscheduler=none \
>       --norandommap --runtime=60 --rw=randread --thread --time_based=1 \
>       --buffered=0 --numjobs=64 --name=/dev/nullb0 --filename=/dev/nullb0

The above test just covers single LUN test.

But the code you removed is actually for providing fairness over multi-LUN,
do you have multi-LUN test result for supporting the change?

Thanks,
Ming

