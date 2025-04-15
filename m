Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6094833DF
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682738; cv=none; b=qxKSkBaxYaqFUvrD3pT78ks3Xn6wtr4xVwUeAoo3j3Aj5ZoA4P6sMt6En/kl/P/ICIYTgVVQUuPr/lTAAc4VvSAqH8LlavLM3OlplZAE0vM8iiUwq0IUNzoSmM37y8sfLozgPeArzjcfOdL9OjvRiUEB82mr6djbaywjUSF3WI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682738; c=relaxed/simple;
	bh=kMjAo71Sn0fyCc9X4XMEeo3L9tp+WLVeQenG/kvkplU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZRrR5KHxOOUKN/e1Pz77/AM0XOMGz5BIWD9DEgCWRADTAfGH36gZsfwaSzsdVUK8KnrynNsItcwolMHbipi7TxrWGflLD+LJrR0oqWmZBfD/sFfDpiVkwa4UMMYF+S20PFngnx7MoohRGd30oI2rlV0IGHOdaHhlLO0/vSPsLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JiVVAdsC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiVVAdsC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744682735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAbl51vBbU9TsoQAQrWTusQOKiOqUp740Q7mupXqAao=;
	b=JiVVAdsCUcqEW/Fj7Z0PsDe/+yN6oth2rzaQgeacHtAr+Xx+1ptPTZfJpGj2D0qagJC5vA
	fA812+hM6YWm2qpTiIob3PIvhmUv1tAZsaj3Vrjs12Dg3A6iIL8CFHXjZ3+l9/HnhOCDKX
	D1e/PCDsa7RatzJ50W3hVrCuA5yP6p4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-YGziZXAPM46RjAXEsB4QMw-1; Mon,
 14 Apr 2025 22:05:31 -0400
X-MC-Unique: YGziZXAPM46RjAXEsB4QMw-1
X-Mimecast-MFC-AGG-ID: YGziZXAPM46RjAXEsB4QMw_1744682729
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E36E180035E;
	Tue, 15 Apr 2025 02:05:29 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AA27180B488;
	Tue, 15 Apr 2025 02:05:24 +0000 (UTC)
Date: Tue, 15 Apr 2025 10:05:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 05/15] block: simplify elevator reset for updating
 nr_hw_queues
Message-ID: <Z_2-3AhBRcYtkWWN@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-6-ming.lei@redhat.com>
 <20250410153417.GA12430@lst.de>
 <Z_xdtNiZb38ubXVe@fedora>
 <20250414060959.GB6451@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414060959.GB6451@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Apr 14, 2025 at 08:09:59AM +0200, Christoph Hellwig wrote:
> On Mon, Apr 14, 2025 at 08:58:28AM +0800, Ming Lei wrote:
> > > Coming back to this after looking through the next patches.
> > > 
> > > Why do we even need the __elevator_change call here?  We've not
> > > actually disabled the elevator, and we prevent other callers
> > > from changing it.
> > > 
> > > As you pass in the force argument this now always calls
> > > elevator_switch and thus blk_mq_init_sched.  But why?
> > 
> > sched tags is built over hctx and depends on ->nr_hw_queues,
> > when nr_hw_queues is changed, sched tags has to be rebuilt.
> 
> Can you add a comment explaining this?

Sure.

Thanks,
Ming

