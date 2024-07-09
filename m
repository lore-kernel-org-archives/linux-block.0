Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1518FC6D
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533064; cv=none; b=gtjv9CtgqJ5BDiXv0HtG9w0XgeiQcYE4mG+yUY/y8o2RtjG0jFsS1T6L5tE7PS8xqpn7jFBjhFR6++QYyJ+8uf9nE6NeyKKDz0PC1nXdWh2wHG7JTun+nv4UJ7q8Xv3/bSI8hUzhecow/Y+Z31C0lFM9N/C51v1w/zZYQFf0bfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533064; c=relaxed/simple;
	bh=tUcFeOBKpkuLiXynnmsEDe3i9yVmWp1iyO2q3KqZki0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+O/7Psjm9BF/YJH99IDFYY1Vz0CQorMnMGuYX9aXzg+p7XXv3WnC2B+RwCoeL5gzsjlgMQ4X1MMRoN+/nJcXwimQipex0uNiwhibTq2PG7PhJZyZMNJXdn+x+mIlMZwCGao5nhcGrUNuRBJs8k0yKGqKXnEB22t1DmcFCB1LnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BymPL6jz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BymPL6jz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720533061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/0w4P8k2T8eGRD+FePldLn8bbjCVQIThSKs89xQh5EQ=;
	b=BymPL6jz85ay4sx379v1/P9Pe2qvStzgpYvRnCc+Q8vccv5v64ltUJTMCjTSv4KEqzwa4I
	jqUdtAFq+l1pcuvgvjZNcNHHn8zX2KxhyGsCVGAdJxOyYCd+yu8kVfg0hUWe/5yrxNu3a0
	5o95cGh7XvqJWZ4KQaoxsZCTbiPViww=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-rjzG8VNQM6yOgUT0l-qJRw-1; Tue,
 09 Jul 2024 09:51:00 -0400
X-MC-Unique: rjzG8VNQM6yOgUT0l-qJRw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE7701955E74;
	Tue,  9 Jul 2024 13:50:58 +0000 (UTC)
Received: from fedora (unknown [10.72.112.85])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5649D1955F3B;
	Tue,  9 Jul 2024 13:50:54 +0000 (UTC)
Date: Tue, 9 Jul 2024 21:50:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also check bio alignment for bio based drivers
Message-ID: <Zo1AOKOK7dCpPll2@fedora>
References: <20240705125700.2174367-1-hch@lst.de>
 <20240705125700.2174367-2-hch@lst.de>
 <Zofzm6TRrOFb5iy9@fedora>
 <20240705133630.GA30748@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705133630.GA30748@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Jul 05, 2024 at 03:36:30PM +0200, Christoph Hellwig wrote:
> On Fri, Jul 05, 2024 at 09:22:35PM +0800, Ming Lei wrote:
> > On Fri, Jul 05, 2024 at 02:56:50PM +0200, Christoph Hellwig wrote:
> > > Extend the checks added in 0676c434a99b ("block: check bio alignment
> > > in blk_mq_submit_bio") for blk-mq drivers to bio based drivers as
> > > all the same reasons apply for them as well.
> > 
> > Do we have bio based driver which may re-configure logical block size?
> 
> nvme multipath can, and it looks drbd might be able to do so as well.

nvme multipath should be fine since the check is done for the underlying nvme
device.

drbd doesn't call freeze queue, so it shouldn't have done that.

> 
> > If yes, is it enough to do so? Cause queue usage counter is only held
> > during bio submission, and it won't cover the whole bio lifetime.
> 
> Yes.  But for me the prime intend here is not to prevent that, but
> to ensure we actually have the damn sanity check for all drivers
> instead of just a few and instead a gazillion more or less equivalent
> open coded versions.
> 
> That doesn't mean we shouldn't look into actually holding q_usage_count
> over the entire bio lifetime for bio based drivers, but that's a
> separate project.

What if logical block size is changed between bio submission and
completion?

For blk-mq device, we need to drain any IO when re-configuring device,
however it can't be supported generically for bio based driver.



Thanks,
Ming

