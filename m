Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697D0156676
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670380; cv=none; b=JEEd9hfKPlXWOt1bjMNjVgP5YBcMOS8+dp9GsZxUaW88vayCpTaVnhcVvkjyQpY6o8p1H4KcdfL+0LswvRj+F0J8xtbgjE8IUe5vqjXUDspxwfLWVe/nEKwRYySxxLyRJEssxzmBdXYS3van2JVOPKKjK6WBvrQ9UOYIWacXYj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670380; c=relaxed/simple;
	bh=TSE9LXq7pNvzG9IEhwQsDAojIcUEMgKsdn9fOcX/EEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXOEyoXCztDyztqfmju6tZg5VKE9rWCNbD/YGDk9H5+Rf4rcQZSelOsI2/AMV2kz9IVg1JkjlfqLkvJ8F7M3wBgopDevGszi4q6NGYVNYJyjUR+JfmH3zPiUrtFyAl7/qDx5bxS05HLUC4AWuYsjlQiEkJR/4/TUgQfVDBW4CVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVj5J/IR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVj5J/IR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729670377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=flNiauSMuJzxNAApSLXDGIXGnE6RIBoNHkmC7BAQyj0=;
	b=DVj5J/IRlroRmvwMl+9fCKnfTS1322jNLnw7l7ibF3QdMJfl6V5jGrtdvl2Z3XKsAPrDFd
	EVEX22b3P5w5CycLWYEF7fLOop427RB5f8uU6zzQupjO/nfF569FsSL4fAJTGXRqOyQ1D3
	r7LQmW9/ZyA/c0WwcaXcbm0pxXKecnM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-VIz521dJOh-aZg0tljgTBQ-1; Wed,
 23 Oct 2024 03:59:33 -0400
X-MC-Unique: VIz521dJOh-aZg0tljgTBQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A0A619560BD;
	Wed, 23 Oct 2024 07:59:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.171])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FF151956088;
	Wed, 23 Oct 2024 07:59:27 +0000 (UTC)
Date: Wed, 23 Oct 2024 15:59:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: model freeze & enter queue as rwsem for
 supporting lockdep
Message-ID: <Zxis2vQgXENELBAr@fedora>
References: <20241018013542.3013963-1-ming.lei@redhat.com>
 <ed9a22b7-64b7-4b83-a6c9-1269129e89d1@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9a22b7-64b7-4b83-a6c9-1269129e89d1@acm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Oct 22, 2024 at 08:05:32AM -0700, Bart Van Assche wrote:
> On 10/17/24 6:35 PM, Ming Lei wrote:
> >                 -> #1 (q->q_usage_counter){++++}-{0:0}:
> 
> What code in the upstream kernel associates lockdep information
> with a *counter*? I haven't found it. Did I perhaps overlook something?

Please look fs/kernfs/dir.c, and there should be more in linux kernel.


Thanks,
Ming

