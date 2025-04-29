Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250C231A2D
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941528; cv=none; b=uHzO9dtBjK/omGqW4wFlYYVBoOv7KPLwwWMgw/0Y/J+1oro9/Wu6T3SiXB+0XhbKFlZp5aD4c844fANEDrNxRloZiLik3mkpGU5Wo59vp4v+C+VSdp/MmLrmSg+aB0l9S6n1pocpq79XNPio2pfVnKOy69dZyz5v5udibeEsmcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941528; c=relaxed/simple;
	bh=3MJTkSMRRpXFCWhSot8Iqy2tdbklUpjt22NZ3bR+UTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9tzG6DQCmRGdviMHGdtY0gtDDbL+nB9segqCtRyblCpR79dV87+hw3GmNcY418qlfIizqiVL+9HtoHvr/KdyimitjVu9pcbnrdfl2kup1h5k8Ze1vjLvpVbib8YNUUkIgf/KXns+bdNkAGJWBmub0qwibTaLkXfD7MXH9esjNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcR7bcsr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcR7bcsr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745941525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWcK/7Jr2iRRF1J0P5sy55MMnsxOmivfmu57fbgbRi8=;
	b=YcR7bcsrfPk/+V0XienFpcul6s696y5TiUhjhlD9l9sDoigynirs8q5bgMNWdq9bhZ4aII
	eV1nZvVY1RqzQ5i1hQl13Ri/VHheo/R/H2qOICJL04dpSsNsxMBAhzpfIsYGn9+Ln/SApM
	b342+ahp+goV/2Eb5SG7n5D4B9PFHJ8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-5dZ-ro-hMGyAGYAX_EDziQ-1; Tue,
 29 Apr 2025 11:45:21 -0400
X-MC-Unique: 5dZ-ro-hMGyAGYAX_EDziQ-1
X-Mimecast-MFC-AGG-ID: 5dZ-ro-hMGyAGYAX_EDziQ_1745941520
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3C8019560A3;
	Tue, 29 Apr 2025 15:45:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.13])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 831C91800378;
	Tue, 29 Apr 2025 15:45:15 +0000 (UTC)
Date: Tue, 29 Apr 2025 23:45:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH V3 12/20] block: add `struct elv_change_ctx` for unifying
 elevator change
Message-ID: <aBD0Bp3WUhCJd3Yz@fedora>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-13-ming.lei@redhat.com>
 <20250425182341.GA26154@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425182341.GA26154@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Apr 25, 2025 at 08:23:41PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 24, 2025 at 11:21:35PM +0800, Ming Lei wrote:
> > +struct elv_change_ctx {
> > +	const char *name;
> > +	bool uevent;
> 
> There's only one caller that wants to supress the uevents.  So maybe
> invert the polarity so that it only has to be set in one place,
> which also documents how setting the initial scheduler is special a
> bit better.

OK.

> 
> > -	ret = elv_register_queue(q, true);
> > +	ret = elv_register_queue(q, ctx->uevent);
> 
> .. and pass the ctx on to elv_register_queue instead of converting
> paramter types.  Although that might be woeth doing later when
> another argument derived from ctx gets passed as well.

ctx isn't very useful for elv_register_queue(), which can't figure out
the exact elevator queue to use from `ctx` since there are two(old, new).


Thanks,
Ming

