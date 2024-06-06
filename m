Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69520160865
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684228; cv=none; b=agfCojQFGeTeCBGhRBWSh6sMUTb8hLF1vXUEbl3hihaMmLHrOlr6oIi4mRx+Vf4q+6IwvtxfEWiYPkcZqM/+6FCLZgaEA8SL79LYgLZoeKzfw3Z5HaydaGGlmXKM/SOkCdYzcEfX1TuPjay47nomJqkUO+xg/1CeelcBoSnh0cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684228; c=relaxed/simple;
	bh=pZ1CKh3rD/Cz84c1OVJeXYmbaArg0035BD5hKW/0e0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx+3bdHsEW9AKz8FyGtLU6iXRHldelBb/dmJBexC5EvKs/fjjVD4d3bgLbMdxLGRs4mwwDbXRe6AW9F4ais/sf8MmbdGYTl8R/KT5hDMpBB7pJCRFoBjkS+Y9buc4lGIOiXNpTcgp06pI3dZy48NYhb6AHA0LhI+7oIpLBMywRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dw/iUL5g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dw/iUL5g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717684225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iqw3ulTgT3WOYmTar3ZvencBj9bvK1e+eNQvYeGna2o=;
	b=Dw/iUL5gzTTaFLaiq4HLZs0jEcGVf+lIpplZX6hLPl0p5QT2DFn6UyfKuslj132suca5S3
	xQUvYR9Ym97hy+iNXgQxbBCfIAPopb9gqa5335M2rwVomKmJfja6pETv2h4tmoxVCNFcqg
	hrd9xQvOvrFqiWViESKv282JZrY5xoM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-bNueIWOhOgeP9J9aaoLCfA-1; Thu,
 06 Jun 2024 10:30:22 -0400
X-MC-Unique: bNueIWOhOgeP9J9aaoLCfA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5062F196DFDF;
	Thu,  6 Jun 2024 14:30:20 +0000 (UTC)
Received: from fedora (unknown [10.72.113.78])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B9301959178;
	Thu,  6 Jun 2024 14:30:11 +0000 (UTC)
Date: Thu, 6 Jun 2024 22:30:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: yebin <yebin@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ye Bin <yebin10@huawei.com>, Zhang Yi <yizhan@redhat.com>,
	"Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
Message-ID: <ZmHH7mW0M80RaPlj@fedora>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
 <ZmFatW3BEzTPgR7S@infradead.org>
 <66619EB6.4040002@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66619EB6.4040002@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Jun 06, 2024 at 07:34:14PM +0800, yebin wrote:
> 
> 
> On 2024/6/6 14:44, Christoph Hellwig wrote:
> > What kernel is this on?  As of Linux 6.9 we are now always freezing
> v4.18
> > the queue while updating the logical_block_size in the nvme driver,
> > so there should be no inflight I/O while it is changing.
> > 
> The root cause of the problem is that there is no concurrency protection
> between
> issuing DIO checks in __ blkdev direct IO simple() and updating logical
> block sizes ,
> resulting in the block layer being able to see DIOs that are not aligned
> with logical
> blocks.

Yeah, that is one area queue freezing can't cover logical block size
change, but I'd suggest to put the logical bs check into submit_bio() or
slow path of __bio_queue_enter() at least.

BTW, Yi has one reproducer, and slab is corrupted just like this report
when running 'nvme format' & IO on partitions.

I am not sure if this kind of change can avoid the issue completely, anyway
Yi and I can test it and see if the kind of change works.

My concern is that nvme format is started without draining IO, and
IO can be submitted to hardware when nvme FW is handling formatting.
I am not sure if nvme FW can deal with this situation correctly.
Ewan suggested to run 'nvme format' with exclusive nvme disk open, which
needs nvme-cli change.



Thanks,
Ming

