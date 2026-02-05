Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4692C21C1
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 03:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770261146; cv=none; b=jO60D9vnGKTsMk+18ifg5FGhqS3dE3s+UJEFGaxyYCsr7iU2bD5Ep4GaDddzXHKPKsaQVXitF1I+fa6n8ID3CNirKvfnlpE6B6Ajcyf7FMqk6+3iRBjP+DuXGFyJfT3YIhWkfpHyyyAayxP8A/F9pLqx5S+2Tjz7IJKFgMqcwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770261146; c=relaxed/simple;
	bh=G6vfD4Yxb3fnPBBrZTuCljmSL1phCxflePu2ZT8fNYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTCTju4NyHsDEc5gJ7XS47mDZUBnC3Rijp0cpclGUx16hHhjTqAk/D5KTVWapo+BhyyiLwrzrVyXO0arp2S65mNlva+Qo6P/bH4eQnfuVs2/x3/RdG2eOUOVf/Ot4idALpDU8uozBNjBmq+7JlGrJmpj79WvnJtjeSOPcMPtqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqE0JwnP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqE0JwnP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770261145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PU4GlXydM1MAqgXjMDFq3vjCStUesvrTn2wdEAI/iFs=;
	b=iqE0JwnPI7kuhoa9IJo4B9QD3UtMAcAIwYO2trxIpne+yDP2pvU/EkppZTr0g/pK9TXG9r
	4T0bWTZl8yQ3ljE484nXeTSqKmik2KoHiXj006tILV1v/DG+7WyU9Xoj+ltesBKh184N3o
	IBRKRIVn05gFmg82niY8KFYu7SiVlFk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-TVTha8Z0ON-75qSXyp4XFg-1; Wed,
 04 Feb 2026 22:12:22 -0500
X-MC-Unique: TVTha8Z0ON-75qSXyp4XFg-1
X-Mimecast-MFC-AGG-ID: TVTha8Z0ON-75qSXyp4XFg_1770261140
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74E0C18003F6;
	Thu,  5 Feb 2026 03:12:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B1171800465;
	Thu,  5 Feb 2026 03:12:11 +0000 (UTC)
Date: Thu, 5 Feb 2026 11:12:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Gohad, Tushar" <tushar.gohad@intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
Message-ID: <aYQKhcnTJLimnbEn@fedora>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Feb 03, 2026 at 02:29:55PM +0000, Pavel Begunkov wrote:
> Good day everyone,
> 
> dma-buf is a powerful abstraction for managing buffers and DMA mappings,
> and there is growing interest in extending it to the read/write path to
> enable device-to-device transfers without bouncing data through system
> memory. I was encouraged to submit it to LSF/MM/BPF as that might be
> useful to mull over details and what capabilities and features people
> may need.
> 
> The proposal consists of two parts. The first is a small in-kernel
> framework that allows a dma-buf to be registered against a given file
> and returns an object representing a DMA mapping. The actual mapping
> creation is delegated to the target subsystem (e.g. NVMe). This
> abstraction centralises request accounting, mapping management, dynamic
> recreation, etc. The resulting mapping object is passed through the I/O
> stack via a new iov_iter type.
> 
> As for the user API, a dma-buf is installed as an io_uring registered
> buffer for a specific file. Once registered, the buffer can be used by
> read / write io_uring requests as normal. io_uring will enforce that the
> buffer is only used with "compatible files", which is for now restricted
> to the target registration file, but will be expanded in the future.
> Notably, io_uring is a consumer of the framework rather than a
> dependency, and the infrastructure can be reused.

I am interested in this topic.

Given dma-buf is inherently designed for sharing, I hope the io-uring
interface can be generic for covering:

- read/write with same dma-buf can be submitted to multiple devices

- read/write with dma-buf can cross stackable devices(device mapper, raid,
  ...)


Thanks,
Ming

