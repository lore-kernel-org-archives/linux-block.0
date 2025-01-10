Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB920D51D
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512463; cv=none; b=aKpcWl9DABDUlvTIMUPcmbtpqHxF5Q7Fu9NBEqMFiQ84mam9NlbzrsdOhHodmkuTkny5Bsg07p6T7dbvNQ2/Y2WA8YhTNLyw7Y9lCJGJWQqj7g/svMKw21Z7VewWKdj133Wd6OzTZdZIH1ichlVH5EBJPMkvo/0/BNGtiLjfRPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512463; c=relaxed/simple;
	bh=KayzpIfZvRbt2uT+xAwQ+kxTrN+38InCw4uDvAltYmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKQul6oowDpsXUvdFzV8WJS2OMw28VFrz+L/rasDlHzUwqrabazizEsh9axmpVAwFrfn9maYNH1ZRZ9YTl2We3iC5jYdBcH46ujir8U0lxJPNpa7N/VLBYXcFUlVO9AWpNrTr0lr0NrEQfvPbUnC/zjVvixXucz0cwR+w+ZDitg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fi/uRSvu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fi/uRSvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736512458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6d84nx4pEKrv8YHDnLiYGFJfk+5CxLaA534UhOpK1AM=;
	b=Fi/uRSvuW/+rbO096wt5pVhbXYVtJdrnTcWH+T7e0JrdhGtuxzlFGC6REtQBpOsGKdq9ak
	iF4X+08FdOWY/9BiHDRgTuk5F3t8OPsqYo2JCi3WgIlGH7T7ehbjkYCYOT7L9q06L4jpY4
	65uNc2rG20VNaynzUTo2qprzrc+tkLs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-rSjRuSpXOm6Ywuk7WJRTNw-1; Fri,
 10 Jan 2025 07:34:15 -0500
X-MC-Unique: rSjRuSpXOm6Ywuk7WJRTNw-1
X-Mimecast-MFC-AGG-ID: rSjRuSpXOm6Ywuk7WJRTNw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E47C61979066;
	Fri, 10 Jan 2025 12:34:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.19])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B6CD19560AB;
	Fri, 10 Jan 2025 12:34:09 +0000 (UTC)
Date: Fri, 10 Jan 2025 20:34:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <Z4ETvfwVfzNWtgAo@fedora>
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de>
 <Z33jJV6x1RnOLXvm@fedora>
 <ac42d762-60e5-4550-99f1-bd2072e474c2@kernel.org>
 <CAFj5m9+LUtAt2ST41KzMasx4BuVYBXjAuLg5MDr0Gh31yzZKzw@mail.gmail.com>
 <20250108090912.GA27786@lst.de>
 <Z35H1chBIvTt0luL@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z35H1chBIvTt0luL@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Jan 08, 2025 at 05:39:33PM +0800, Ming Lei wrote:
> On Wed, Jan 08, 2025 at 10:09:12AM +0100, Christoph Hellwig wrote:
> > On Wed, Jan 08, 2025 at 04:13:01PM +0800, Ming Lei wrote:
> > > It is backed by virtual memory, which can be big enough because of swap, and
> > 
> > Good luck getting half way decent performance out of swapping for a 50TB
> > data set.  Or even a partially filled one which really is the use case
> > here so it might only be a TB or so.
> > 
> > > it is also easy to extend to file backed support since zloop doesn't store
> > > zone meta data, which is similar to ram backed zoned actually.
> > 
> > No, zloop does store write point in the file sizse of each zone.  That's
> > sorta the whole point becauce it enables things like mount and even
> > power fail testing.
> > 
> > All of this is mentioned explicitly in the commit logs, documentation and
> > code comments, so claiming something else here feels a bit uninformed.
> 
> OK, looks one smart idea.
> 
> It is easy to extend rublk/zoned in this way with io_uring io emulation, :-)

Here it is:

https://github.com/ublk-org/rublk/commits/file-backed-zoned/

Top two commits implement the feature by command line `--path $zdir`:

	[rublk]# git diff --stat=80 HEAD^^...
	 src/zoned.rs   | 397 +++++++++++++++++++++++++++++++++++++++++++++++----------
	 tests/basic.rs |  49 ++++---
	 2 files changed, 363 insertions(+), 83 deletions(-)

It takes 280 new LoC:

    - support both ram-back and file-back
    - completely async io_uring IO emulation for zoned read/write IO
    - include selftest code for running mkfs.btrfs/mount/read & write IO/umount


Thanks,
Ming

