Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBBA2E634
	for <linux-block@vger.kernel.org>; Tue,  7 Jan 2025 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736210732; cv=none; b=DFIHS2NnENWRVLeg8NYIozZAKSdajxRVpLOKclJjqLbvHblMC2jPog+gBwD/W6ASSf9n3MpXusCeF3NtGOy6/AeM+wVtAAboffqvnrkYndqJxEP+9AIiI8YJkwShYNaEJFTtqv+RqC5kRq1O/QZixoiAifHoQNKEFuE8pGLQh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736210732; c=relaxed/simple;
	bh=+Wn/MP0S6m5z3l005GkIlGnJGFLeTI5IC0myX7X9ssw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xp1jtvMI8Plak1l/IY9dDZ8GCB3BwWuKXnAW5IQaIt3iW7bN3yt5XX1Xu7Ql1d8ftmeX7O9aXXL5FPGCoRCaVkLZTqA7i7AlpLoebcPMdOgDLeP5hhevY5mB2WeM5/h3fyIk8seUnmALy0udWjpSZuAxyBjEJdO8Lv500kDsgSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAxPdJ1L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAxPdJ1L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736210729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2ow3WPU9nS00Hk+pQzwgzy+yTO/847uxs0UlW6oZME=;
	b=FAxPdJ1LOV1uGkteecqxt8PkYnCrxxYb1q1oyRKhzqFP1BXvRPYqgUq59U1QxLzWFZPTbX
	yeXdWnH/HK2O3Pc0E+r9Blk5rFVJRvlqEQialAbmPmdQKlJP0iqVq8IVAbd/9PPqTFnNKF
	p8RGyOIgRDmRcKuZ/s+ihQGK4xi2Clw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-57ER_xUgNEOOYM1u31EC0g-1; Mon,
 06 Jan 2025 19:45:26 -0500
X-MC-Unique: 57ER_xUgNEOOYM1u31EC0g-1
X-Mimecast-MFC-AGG-ID: 57ER_xUgNEOOYM1u31EC0g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEC8919560B2;
	Tue,  7 Jan 2025 00:45:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.43])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC74519560A2;
	Tue,  7 Jan 2025 00:45:17 +0000 (UTC)
Date: Tue, 7 Jan 2025 08:45:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <Z3x5F3_GIkD4sxl7@fedora>
References: <20250104132522.247376-1-dlemoal@kernel.org>
 <20250104132522.247376-2-dlemoal@kernel.org>
 <Z3tOn4C5i096owJc@fedora>
 <20250106082902.GC18408@lst.de>
 <Z3u7Twc4UPWvlfJJ@fedora>
 <20250106152931.GC27431@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106152931.GC27431@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jan 06, 2025 at 04:29:31PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 07:15:27PM +0800, Ming Lei wrote:
> > On Mon, Jan 06, 2025 at 09:29:02AM +0100, Christoph Hellwig wrote:
> > > On Mon, Jan 06, 2025 at 11:31:43AM +0800, Ming Lei wrote:
> > > > As I mentioned in another thread, freezing queue may not be needed in
> > > > ->store(), so let's discuss and confirm if it is needed here first.
> > > > 
> > > > https://lore.kernel.org/linux-block/Z3tHozKiUqWr7gjO@fedora/
> > > 
> > > We do need the freezing.  What you're proposing is playing fast and loose
> > > which is going to get us in trouble.
> > 
> > It is just soft update from sysfs interface, and both the old and new limits
> > are correct from device viewpoint.
> > 
> > What is the trouble? We have run the .store() code without freezing for
> > more than 10 years, no one report issue in the area.
> 
> No, we had various bug reports due to it, including racing with other
> updates.  Let's stop trying to take shortcuts that will byte us again
> later and sort this out properly.

Can you share the bug reports? I am curious how it happen.


Thanks, 
Ming

