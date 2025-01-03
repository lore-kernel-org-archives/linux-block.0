Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6450187876
	for <linux-block@vger.kernel.org>; Fri,  3 Jan 2025 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869748; cv=none; b=YqBmRR3GtOYfNRfWVBH5IWEwLgTHqoWhtjWPxURoZjIbXyS6+6M0AOVBE5CY/qsHacrWAO4H3W4BGOThyxa33Aku2rl0ubTUHRfQmTR6OzdJNIezCKEkpCu5xvrfI+JjIeS/gIj6m9nU6euSnChWgxCa5hN56GioPoSLmW3C/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869748; c=relaxed/simple;
	bh=AvQQVDSrd9xkqZBOsEiocP3W85bxnnolZeMdrhUPfIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5z9haACXV1pUM+9LdsNhkYxlf9BYpW4+BICwh2U7Ycwb3tahZMBmbRoCc6PpoLUbDCro44iA6FsYp3BWurK0egYNN5NWQc8OIYLRReF90kdH0tkI8q2YSogs6DbBiQPQu8MsghFda0B2E9gIEO0K5LMg8jwSf69d0eoGfAKfi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpKNnUPI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpKNnUPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735869745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wJjtyfJ1LBYN6rLvzwpWerDYB1UtCFcfHX9G1CeQQx0=;
	b=dpKNnUPIb+FjigDZVYJ1ntJOo7qrJZGd771qu9dSmDYaP+7MkUpsMH6WM1mG+XwXsP5QkO
	LCoyFkwZMTNsrt2dUw8OvR6K8WUBjolfUyls1bvVvxFbatj/L5cEcok0Po71KTWpNm/FML
	1+sTfv5Yu4k8i2EUFyvvrvMvbFSBTUM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-B3hk8V-sMVOaamjZRSJ2nQ-1; Thu,
 02 Jan 2025 21:02:20 -0500
X-MC-Unique: B3hk8V-sMVOaamjZRSJ2nQ-1
X-Mimecast-MFC-AGG-ID: B3hk8V-sMVOaamjZRSJ2nQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84D09184AB36;
	Fri,  3 Jan 2025 02:01:53 +0000 (UTC)
Received: from fedora (unknown [10.72.116.47])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29BA0196BBC3;
	Fri,  3 Jan 2025 02:01:46 +0000 (UTC)
Date: Fri, 3 Jan 2025 10:01:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: make queue limits workable in case of 64K
 PAGE_SIZE
Message-ID: <Z3dFBQIiik6FWLut@fedora>
References: <20250102015620.500754-1-ming.lei@redhat.com>
 <0b423229-f928-4210-9351-dca353071231@acm.org>
 <Z3X-xMeMuF8j0RDA@fedora>
 <0b34bfc9-2cd3-40a8-8153-3207a6d62f8c@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b34bfc9-2cd3-40a8-8153-3207a6d62f8c@acm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Jan 01, 2025 at 07:46:41PM -0800, Bart Van Assche wrote:
> On 1/1/25 6:49 PM, Ming Lei wrote:
> > On Wed, Jan 01, 2025 at 06:30:30PM -0800, Bart Van Assche wrote:
> > > Additionally, this patch looks wrong to me. There are good reasons why the
> > > block layer requires that the DMA segment size is at least as large
> > > as the page size.
> > 
> > Do you think 512byte sector can't be DMAed?
> 
> A clarification: I was referring to the maximum DMA segment size. The
> 512 byte number in your email refers to the actual DMA transfer size. My
> statement does not apply to the actual DMA transfer size.

But why does DMA segment size have to be >= PAGE_SIZE(4KB, 64KB)?

I don't think that the constraint is from hardware because DMA controller is
capable of doing DMA on buffer with smaller alignment & size.

IMO, the limit is actually from block layer, that is why I posted out
this patch.

> 
> > > You may want to take a look at this rejected patch series:
> > > Bart Van Assche, "PATCH v6 0/8] Support limits below the page size",
> > > June 2023 (https://lore.kernel.org/linux-block/20230612203314.17820-1-bvanassche@acm.org/).
> > 
> > '502 Bad Gateway' is returned for the above link.
> 
> That link works fine here on multiple devices (laptop, workstation,
> smartphone) so please check your setup.

It is reachable now.

From the link, you have storage controllers with DMA segment size which
is less than 4K, which may never get supported by linux kernel.

I am looking at hardware which works fine on kernel with 4K page size, but
it becomes not workable when kernel is built as 64K page size, which confuses
final kernel users.


Thanks,
Ming

