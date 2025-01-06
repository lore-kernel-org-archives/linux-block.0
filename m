Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102ED647
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736126422; cv=none; b=PyoMymztLKvqCk+s5fUYI3HVLO9nPrJXVFBTdq4D1gRmcDC45HhKqCh2GxBXh6xsqqk6EVBYiWxvwEJleRmLzs4SRajWvJRaN4i0BynW02fHy65UB8+lbdTy8G/04DYBQUAl9/6ykjWoS5eaNJJkk9OfupSciHx+rPubFwc4En0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736126422; c=relaxed/simple;
	bh=M8PWfyhz9/OeAIXMbAOPsSo1hI14f4E8rTYJ2mo8nZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHT10Y155izxqxTJfZQR6QNXjqkKm8CAOuHLxSHMR9MXxCz3UCBJqTvXthWiUQurzbTBEZAAsJK429HwErbdXy9uTMOXuX8b2cdfRCsDF4n1E2jrM8TEp5uqtwY2faWI4qQIQCZ2hObsjLeqJqXW7wVDymLEExdy2yKBDvqiZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5mwVw1E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5mwVw1E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736126418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0Q39y7uzzFLplb4GTUzH2Z3xvQiX86KCjgrqheqPuc=;
	b=U5mwVw1EcIT57ZBTSaz7asJOL+G+UmZuuKFoNnBXUslYPzV70ZZEXXQZVEtlgNJHtMxSxw
	INjRlCxstQw/WPQSKet8JJDzzpAtZdHYugxgw08xU5L4exVsBP5cyv2uKYCSWndEwO3n5G
	nQQJcK+w4kj102gEuKFlzUVyz88f2aw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-Pkuulfe3PLaOIjT18uM7hw-1; Sun,
 05 Jan 2025 20:20:15 -0500
X-MC-Unique: Pkuulfe3PLaOIjT18uM7hw-1
X-Mimecast-MFC-AGG-ID: Pkuulfe3PLaOIjT18uM7hw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5537D1956086;
	Mon,  6 Jan 2025 01:20:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.65])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 984141956088;
	Mon,  6 Jan 2025 01:20:07 +0000 (UTC)
Date: Mon, 6 Jan 2025 09:20:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: make queue limits workable in case of 64K
 PAGE_SIZE
Message-ID: <Z3svwejnonFmsY8q@fedora>
References: <20250102015620.500754-1-ming.lei@redhat.com>
 <0b423229-f928-4210-9351-dca353071231@acm.org>
 <Z3X-xMeMuF8j0RDA@fedora>
 <0b34bfc9-2cd3-40a8-8153-3207a6d62f8c@acm.org>
 <Z3dFBQIiik6FWLut@fedora>
 <1b1bf316-359a-4bec-8195-0152cd706001@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b1bf316-359a-4bec-8195-0152cd706001@acm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Jan 03, 2025 at 02:12:36PM -0800, Bart Van Assche wrote:
> On 1/2/25 6:01 PM, Ming Lei wrote:
> > But why does DMA segment size have to be >= PAGE_SIZE(4KB, 64KB)?
> 
> From the description of patch 5/8 of my patch series: "If the segment
> size is smaller than the page size there may be multiple segments per
> bvec even if a bvec only contains a single page." The current block
> layer implementation is based on the assumption that a single page
> fits in a single DMA segment. Please take a look at patch 5/8 of my
> patch series.

OK, I guess you agree it is one block layer constraint now, which
need to be relaxed for both big logical block size and >4k PAGE_SIZE.

Yes, your patch 5/8 is still needed.

> 
> > From the link, you have storage controllers with DMA segment size which
> > is less than 4K, which may never get supported by linux kernel.
> 
> As mentioned in the cover letter of that patch series, I came up with
> that patch series to support a DMA controller with max_segment_size of
> 4 KiB on a system with a PAGE_SIZE of 16 KiB.

Probably the conception of subpage need to avoid, because PAGE_SIZE is
config option, and not see strong reason to couple with fixed &
readable hardware properties with configurable kernel page size.


Thanks,
Ming

