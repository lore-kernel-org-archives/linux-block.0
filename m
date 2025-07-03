Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A594F226D00
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507507; cv=none; b=sMc7axEjBo8iLxKwWPfZaen75qGaDGwzBiksGBHFyNH5BlUjiiEOfQYbleBuoxO8mGJjP0s5KTENY8/8Xy0PTBu42GKpdR+hf3IVTzGr5uWAsPepXYB+HmPYS/jm7oBGvdV/cN2z+OZ8rEq9yrurAykbmMdOPJsS2TEK2AwkJQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507507; c=relaxed/simple;
	bh=6M8PojE12rHC6uMfCz9xqOwXVFEBCE4QFTS2S78eQwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUqAKhGtpf26yfZETlWWqP7jgA6HRQrRRnxG6PGGNolvijh+WafMxNbxSkwUBzOycK/KnL6RDeyJrTZ5pW95X2drhCwLvOjWbF6tC8Az2wOEGDO6hJ4PZ6tDys0RK33R3yiEfXJpuTaJbS3ulkmmsnBOL0d3/WNANW8SIaU5o70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XaRu9hBQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaRu9hBQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751507504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5q8SqC4bQAEPwf6wTQNIcXmvq27HC9DtyTwDAiIEryw=;
	b=XaRu9hBQ3J3xrsc07YRBMQR7fXa9jr9NxDy7M0Niw5MMAKkN67Ts1657ixupGWDYhul2xC
	+Tg3B58ydzMxMp7YO/hmD5sE3oyRwntRCHTJcwfyi7aI9PAG7wTmZaHszyAG8lzpTmihUC
	whePQQbFz3rozMFw+/bzgLfiA1b4pF0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-zmqVO4fbP623QF4wvJm2JA-1; Wed,
 02 Jul 2025 21:51:41 -0400
X-MC-Unique: zmqVO4fbP623QF4wvJm2JA-1
X-Mimecast-MFC-AGG-ID: zmqVO4fbP623QF4wvJm2JA_1751507500
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2222C1955F3E;
	Thu,  3 Jul 2025 01:51:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.108])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 662BF30001B9;
	Thu,  3 Jul 2025 01:51:32 +0000 (UTC)
Date: Thu, 3 Jul 2025 09:51:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/8] block: Do not run frozen queues
Message-ID: <aGXiH1HqSlLk-QSI@fedora>
References: <20250702203845.3844510-1-bvanassche@acm.org>
 <20250702203845.3844510-3-bvanassche@acm.org>
 <699f9f38-009f-c5da-dfd3-60531e16c1ce@huaweicloud.com>
 <93500d50-ba11-425b-8d5f-1ce1930e4160@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93500d50-ba11-425b-8d5f-1ce1930e4160@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Jul 02, 2025 at 06:30:34PM -0700, Bart Van Assche wrote:
> On 7/2/25 6:15 PM, Yu Kuai wrote:
> > Just a question, blk_mq_quiesce_queue also calls synchronize_rcu() to
> > wait for inflight dispatch work to be done, is it safe in following
> > patches? I think it's not, dispatch work can be running while there is
> > no request pending, menas queue can be frozen with active dispatch work.
> 
> No work is dispatched if a queue is frozen because freezing a queue only
> finishes after q_usage_counter drops to zero. queue_rq() and queue_rqs()
> are only called if one or more requests are being executed.
> q_usage_counter is increased when a request is allocated and decreased
> when a request is freed. Hence, q_usage_counter cannot be zero while
> queue_rq() or queue_rqs() is in progress. Hence, neither queue_rq() nor
> queue_rqs() are called while q_usage_counter is zero.

It isn't related with queue_rq() or queue_rqs() only.

The dispatch work is still in-progress when all requests are
completed(.q_usage_counter becomes zero), because request can complete any
time, even before queue_rq()/queue_rqs() returns.

The dispatch critical area is much _longer_ than queue_rq()/queue_rqs(),
block layer data structure may still be accessed after .q_usage_counter drops
to zero.

Please run 'git grep', and we did fix such kind of issues several times, such as:

662156641bc4 ("block: don't drain in-progress dispatch in blk_cleanup_queue()")


Thanks,
Ming

