Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B586EA927
	for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 01:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729560098; cv=none; b=mdlpc1z2nMTtZ6ZCI8bykKzRCfBN/M6VOXHNAQDfi76w23Z39c0Ih7Fk9B/rLFqc6L7Jjoa5moqDzYYZVOA3YfJUZzYC384PAyo+CLlEZjjMiBpmY8Udfsj0oXfm6WYj/1a+AfF4DCtwn1MTO2j7UJZ52zqTTpY3C9/Ocfs0pWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729560098; c=relaxed/simple;
	bh=+UdpPjbg3ZFzZaKHgzfWU1kbJRQH1eMEqi+alnOrYys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIuCVGQuZgwWVF9an+dqiGGpvVwp3bVmeo2scigSukPefNhnoBvjd7T67cRpefioVKbdC649O0+P3K9y0u8ltTXNz/GaMqausou3B6TXzI7xBrOumzgfBOOicI+hb8oa4joP6eK91Hap5kPBUh1pmGwxks1vf0pIgFYqeAzxqmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZyvgZnaO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyvgZnaO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729560095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v272HUmYRgxPKLfG1gPjdLR7tn0IcWmJucyi9bJO23A=;
	b=ZyvgZnaOCL+7TM2hh2D8DUGt+3T5PsDXVdtgwM3aMIT3lqbO6+05HcU+6cFF4KRUjZSwPZ
	9cixNZw7FIL3EsHGRaRE7+b9UdBT8mnGzArKvSXbMbQVQSlNfFobLRpcbedt9G0JG/peIY
	hgBczcu0Mb/wnlS2lLXY0BIlXrpHzIA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-t_VrZu5POTChy5paYQ9Qqw-1; Mon,
 21 Oct 2024 21:21:34 -0400
X-MC-Unique: t_VrZu5POTChy5paYQ9Qqw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26E7219560AA;
	Tue, 22 Oct 2024 01:21:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16ED91956056;
	Tue, 22 Oct 2024 01:21:26 +0000 (UTC)
Date: Tue, 22 Oct 2024 09:21:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [Regression] b1a000d3b8ec ("block: relax direct io memory
 alignment")
Message-ID: <Zxb-EWevBxzjbYL3@fedora>
References: <Zw6a7SlNGMlsHJ19@fedora>
 <20241016080419.GA30713@lst.de>
 <Zw958YtMExrNhUxy@fedora>
 <20241016123153.GA18219@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016123153.GA18219@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Oct 16, 2024 at 02:31:53PM +0200, Christoph Hellwig wrote:
> On Wed, Oct 16, 2024 at 04:31:45PM +0800, Ming Lei wrote:
> > On Wed, Oct 16, 2024 at 10:04:19AM +0200, Christoph Hellwig wrote:
> > > On Wed, Oct 16, 2024 at 12:40:13AM +0800, Ming Lei wrote:
> > > > Hello Guys,
> > > > 
> > > > Turns out host controller's DMA alignment is often too relax, so two DMA
> > > > buffers may cross same cache line easily, and trigger the warning of
> > > > "cacheline tracking EEXIST, overlapping mappings aren't supported".
> > > > 
> > > > The attached test code can trigger the warning immediately with CONFIG_DMA_API_DEBUG
> > > > enabled when reading from one scsi disk which queue DMA alignment is 3.
> > > > 
> > > 
> > > We should not allow smaller than cache line alignment on architectures
> > > that are not cache coherent indeed.
> > 
> > Yes, something like the following change:
> 
> We only really need this if the architecture support cache incoherent
> DMA.  Maybe even as a runtime setting.

Can you take coherent DMA into account on kernel/dma/debug.c first?
Otherwise the warning still may be triggered on coherent DMA.


thanks, 
Ming

