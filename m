Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC461F1500
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314175; cv=none; b=mAXTldiis6qfdmtotIqJjkhi1u6QKYzLOo4RSVJn9OyD6w0GFnEf1PjQORh5kCsk9jbfpBhLmfAPoFgoIiUCOub1kW1h5wrPy7cyKcWw0rC51j/99ZYMIt/SBAfGIzIl6CS1crEfpji4wHeYKQp7tDSVwNfaXdVf4H1vBjFrMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314175; c=relaxed/simple;
	bh=pKQIoEhRnLFOHy6kojlmcNTfTpbN47DqyFCRgdApEn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJXQO4gUb8nBCyjVfJ2FV0Z8QwdzsX2flhjycLAsdyJqNSicpSxZhwOm2FzEWrNpEDCq85RcndKVNAc4v56biWNfV7r6TbSOzBAtqPK4n9guUAqwmcwR42BTweNBSEObFhPvDEmRt502VoKAA3ESSwoH7uZRpsloN989h2oM5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3hxwWxe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3hxwWxe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745314172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5RsruNrH3UlUOtkSbkB1T/xnaz6GZuHSOHiVKBGw40=;
	b=H3hxwWxeZ1l535DU/IS/66tiidMwQJCxuBzO0P1K61xugukBRy1V8uyQmXcgMz0LMLRDpB
	jvGZS99CMBrn7Rk7kIsW5HnF50dKUrQwVV9xsP6211YbCsLsKubxAGZzwXTVx5ddtVNn6r
	OFbm8cmm5sUp7VFeiSGFBizE1nKbQHc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-j4x4HFFmMm61UqBP4vLsIQ-1; Tue,
 22 Apr 2025 05:29:28 -0400
X-MC-Unique: j4x4HFFmMm61UqBP4vLsIQ-1
X-Mimecast-MFC-AGG-ID: j4x4HFFmMm61UqBP4vLsIQ_1745314167
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC0CE18001E0;
	Tue, 22 Apr 2025 09:29:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.157])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A86C01956095;
	Tue, 22 Apr 2025 09:29:22 +0000 (UTC)
Date: Tue, 22 Apr 2025 17:29:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH V2 07/20] block: prevent adding/deleting disk during
 updating nr_hw_queues
Message-ID: <aAdhbUAzFSxtCWzR@fedora>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-8-ming.lei@redhat.com>
 <094c312a-38ec-4c5b-9db3-2269c37de36a@linux.ibm.com>
 <aAWv3NPtNIKKvJZc@fedora>
 <20250422070432.GB30990@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422070432.GB30990@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Apr 22, 2025 at 09:04:32AM +0200, Christoph Hellwig wrote:
> On Mon, Apr 21, 2025 at 10:39:24AM +0800, Ming Lei wrote:
> > > In my view, RCU is optimized for read-heavy workloads with:
> > > - Non-blocking readers
> > 
> > srcu allows blocking reader
> 
> It does.  But it's certainly not optimized for long blocking readers.
> 
> > Basically I agree with you that rwsem(instead of rwlock) should match with
> > this case in theory, but I feel that rwsem is stronger than srcu from lock
> > viewpoint, and we will add new dependency if rwsem is held inside
> > ->store(), such as the following splat.
> 
> How does manually implementing a reader/write lock using SRCU avoid
> that dependency vs just hiding it?
> 
> I'd rather sort this out as a rwsem is very natural her as Nilay pointed
> out, and also avoids the whole giv up and retry pattern.
 
Thinking of further, the warning triggered from rwsem is false positive,
because elevator switch can't happen until disk is added, and the splat
can be avoided by switching to down_read_nested() in elevator_change(),
which need to be nested too.

So looks fine to use rwsem.


Thanks,
Ming

