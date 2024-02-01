Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770A3A8C5
	for <linux-block@vger.kernel.org>; Thu,  1 Feb 2024 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706757868; cv=none; b=a3OwSZkVKqdkwfiIJFwjqUw8eTT56t2iOlV+oBhw5046vYe2H4GagWTPeOmSWpoSSY6+/rkqeq4G80RsAquwEKlS+5RuHKP4j9nm3CBA2xBYN9+Dq6QlS/G33ysnJx5XLgixD1y24WKn7n2bYdpKhH01/nDl9tus9WGKGufdpO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706757868; c=relaxed/simple;
	bh=eXSMJMy46jUt3d1vais7cKlWCKwnstKYl7qJV37b4iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCI1W3ttGkUtYnnO8BEF1AeEAg7B/Ak04KjPMhWqNohrgwAdoXNa9CajCQxMOugi3dbUPQ7ezmQtAF/KWU+xtLCM5x18C4M7z53JMEOdsKemTZS30w1++aRW6X70nv8scpKHcG1MkoGhD0clmSuWaTef+04KH46MxBXho3ckH/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JEWAAuOs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEWAAuOs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706757865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3h5b05tR228P/1DdbjST3N+v0o21dfIjKISktnR6r58=;
	b=JEWAAuOsQ1TE5JEOEURCwCJCGe9HscB0+iNpVy4QnBY6sY4+rt4nO3Jqne0jq2ZzUjP3lo
	cuTAV5BzcHvLXbNdpVgDvBNv15ptER7IIs5qu4EiRCeBsEeLmlFLQCpl+tNuOQ4sE+/I8E
	QUhppP4DyxtUCVSBwO6GmZME5ZZimRY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-hNOuQwU4MwO5XVe8YFip3g-1; Wed, 31 Jan 2024 22:24:20 -0500
X-MC-Unique: hNOuQwU4MwO5XVe8YFip3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52615845E61;
	Thu,  1 Feb 2024 03:24:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.107])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AAA53C2E;
	Thu,  1 Feb 2024 03:24:10 +0000 (UTC)
Date: Thu, 1 Feb 2024 11:24:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: atomic queue limits updates v3
Message-ID: <ZbsO1wOD03NVD/9S@fedora>
References: <20240131130400.625836-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131130400.625836-1-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Wed, Jan 31, 2024 at 02:03:46PM +0100, Christoph Hellwig wrote:
> Hi Jens,
> 
> currently queue limits updates are a mess in that they are updated one
> limit at a time, which makes both cross-checking them against other
> limits hard, and also makes it hard to provide atomicy.
> 
> This series tries to change this by updating the whole set of queue
> limits atomically.   This in done in two ways:
> 
>  - for the initial setup the queue_limits structure is simply passed to
>    the queue/disk allocation helpers and applies there after validation.
>  - for the (relatively few) cases that update limits at runtime a pair
>    of helpers to take a snapshot of the current limits and to commit it
>    after picking up the callers changes are provided.
> 
> As the series is big enough it only converts two drivers - virtio_blk as
> a heavily used driver in virtualized setups, and loop as one that actually
> does runtime updates while being fairly simple.  I plan to update most
> drivers for this merge window, although SCSI will probably have to wait
> for the next one given that it will need extensive API changes in the
> LLDD and ULD interfaces.
> 
> Chances since v2:
>  - fix the physical block size default
>  - use PAGE_SECTORS_SHIFT more 
> 
> Chances since v1:
>  - remove a spurious NULL return in blk_alloc_queue
>  - keep the existing max_discard_sectors == 0 behavior
>  - drop the patch nvme discard limit update hack - it will go into
>    the series updating nvme instead
>  - drop a chunk_sector check
>  - use PAGE_SECTORS in a few places
>  - document the checks and defaults in blk_validate_limits
>  - various spelling fixes

For the whole series:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

