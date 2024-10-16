Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC5C1F80C1
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067522; cv=none; b=p1vTsbFlKeC3sOU1JrfzWckRGyUe+K99p03gEHgkABnbbuWnGYnOvbWc7qlLStuNEw3FzmqkAidW007EMFp6gJRXGEX9rdxJKwpYIySuozFKI2MYsKqpH6icnPMn+Cb7vG4EjIpjtEBBaVw4il25qk16ffDi8OpKd9Ld288g0aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067522; c=relaxed/simple;
	bh=HochnkcnH4RaBRWXhxwwGqe2jFgJOCCoo6LbV74OU6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQAA/08/RDCBEDtg5qn+/0CzBQauagcPaSG52Il6XkHoWFeV5WktghP3NJJ2+4j5x/2hDqfBskc5PGMhTpA/pkyFQ/9jB8sP2VhVAY2LA5Xge/gnGj+ds2AoAi8UabqyvwgRcn/RiWUZd9jcBadUaeHAG4amhsLVzX80Ovq1uTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aksUMMQN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aksUMMQN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729067520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6meqci1T/+gFr8r5uq6k+97j+u6uKiqkg4dUaqER0g=;
	b=aksUMMQN8tV/WtPhKbFIEM+tOrtvggxd+6MVtvEOagEsvSapnOeDTCm1/qfHH8QF2/YIxT
	7CLvkHmswhb8pSSexLDdsWmktyyn/l5NSQpb0u2GxCID+bk4np7W8zIWHVoT9InO1gz2Xm
	jEsNB3cJuxi0QAfvLAsM3qJBW91AUiA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-7BRDUEc-MzqHgT2XQqlMDg-1; Wed,
 16 Oct 2024 04:31:57 -0400
X-MC-Unique: 7BRDUEc-MzqHgT2XQqlMDg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6272619560AD;
	Wed, 16 Oct 2024 08:31:55 +0000 (UTC)
Received: from fedora (unknown [10.72.116.176])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC1211956086;
	Wed, 16 Oct 2024 08:31:50 +0000 (UTC)
Date: Wed, 16 Oct 2024 16:31:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, ming.lei@redhat.com
Subject: Re: [Regression] b1a000d3b8ec ("block: relax direct io memory
 alignment")
Message-ID: <Zw958YtMExrNhUxy@fedora>
References: <Zw6a7SlNGMlsHJ19@fedora>
 <20241016080419.GA30713@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016080419.GA30713@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Oct 16, 2024 at 10:04:19AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 16, 2024 at 12:40:13AM +0800, Ming Lei wrote:
> > Hello Guys,
> > 
> > Turns out host controller's DMA alignment is often too relax, so two DMA
> > buffers may cross same cache line easily, and trigger the warning of
> > "cacheline tracking EEXIST, overlapping mappings aren't supported".
> > 
> > The attached test code can trigger the warning immediately with CONFIG_DMA_API_DEBUG
> > enabled when reading from one scsi disk which queue DMA alignment is 3.
> > 
> 
> We should not allow smaller than cache line alignment on architectures
> that are not cache coherent indeed.

Yes, something like the following change:

diff --git a/block/blk-settings.c b/block/blk-settings.c
index a446654ddee5..26bd0e72c68e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -348,7 +348,9 @@ static int blk_validate_limits(struct queue_limits *lim)
 	 */
 	if (!lim->dma_alignment)
 		lim->dma_alignment = SECTOR_SIZE - 1;
-	if (WARN_ON_ONCE(lim->dma_alignment > PAGE_SIZE))
+	else if (lim->dma_alignment < L1_CACHE_BYTES - 1)
+		lim->dma_alignment = L1_CACHE_BYTES - 1;
+	else if (WARN_ON_ONCE(lim->dma_alignment > PAGE_SIZE))
 		return -EINVAL;
 
 	if (lim->alignment_offset) {
 


Thanks,
Ming

