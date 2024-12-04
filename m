Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD281B85FD
	for <linux-block@vger.kernel.org>; Wed,  4 Dec 2024 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314506; cv=none; b=ZV6noM6NVf1IdwnYGUXIKFmIBT5b7NgeDAg1F0NnH36uwxZ+CczUzZCMyl6tTgGE4/fWrFN3Ar+dsJ08a1+6zGTAL63CrZ7RP8hbKpnFcDSveaKv/R3FLFJxD+JwWy1AECSU0MAFUVGcqGHdxUCIiigF6hOIrg0IFHAWeY83QF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314506; c=relaxed/simple;
	bh=VM/IjnUOoYmaXM9BjcHi0kTxMdNJTkJ8qRoPit9JiX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCWugzzBku+t8APTeND7Ns01B6eyiM3SJOUiUy+Strtzvd/OfWMGjIG/yShe5cHrRTbzzraJflD5LgrCZ+4dYbBiaHe+i8SgAEd2VtAOZqHxHrq2jzm2PdCjCVhb8cCkDaLKCS24FD2rnU8VULGQNSSSjcmQkQGkZGBL7lOyLPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRJEgfaD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRJEgfaD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733314504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lx+GC+/nemnWHzZ45M7hMXvsnmVcB+AgrZQMoaW8xeQ=;
	b=KRJEgfaDWLDZGe7xGLj98HCgEN8B310MGpDXSvdQUOI4IzWbGZozvj9T3UYSt9aRhlmIMx
	RQlrApQ/LlV0tfIaez8NIndvCbAmhsQu9lEBGWL/pUEBGHdjb71bEacxDSlH5qlPsx9E8s
	XFv7/vsDL6sh0aRTkpDdORdBoW2mHuc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-mlVSwX70PT69VKblSRyVwg-1; Wed,
 04 Dec 2024 07:15:00 -0500
X-MC-Unique: mlVSwX70PT69VKblSRyVwg-1
X-Mimecast-MFC-AGG-ID: mlVSwX70PT69VKblSRyVwg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFDBA1955F4A;
	Wed,  4 Dec 2024 12:14:58 +0000 (UTC)
Received: from fedora (unknown [10.72.112.144])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C41B41956048;
	Wed,  4 Dec 2024 12:14:52 +0000 (UTC)
Date: Wed, 4 Dec 2024 20:14:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Johan Hovold <johan@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Alan Stern <stern@rowland.harvard.edu>, linux-block@vger.kernel.org,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Lockdep splat on UMS disconnect (6.13-rc1)
Message-ID: <Z1BHt0lqYDIm3nXH@fedora>
References: <Z1A8fai9_fQFhs1s@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1A8fai9_fQFhs1s@hovoldconsulting.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Dec 04, 2024 at 12:26:53PM +0100, Johan Hovold wrote:
> Hi,
> 
> I'm seeing a new lockdep splat with 6.13-rc1 on resume after having
> disconnected a USB mass storage device while suspended. This does not
> seem to show up with 6.12.
> 
> On one attempt to reproduce this with a ThinkPad T14s, the NVMe was
> hosed after resume as well so I fear that this is not just about missing
> annotation.
> 
> I don't have time to look into this myself right now so I'm reporting in
> the hope that someone familiar with these paths would be able to
> pinpoint any potential regression without too much effort.
> 

The dependency between lock(&q->q_usage_counter(queue)#3) and lock(&q->limits_lock)
is real trouble.

The real deadlock was reported before:

https://lore.kernel.org/linux-scsi/ZxG38G9BuFdBpBHZ@fedora/

And the warning can be triggered by the following command too:

	echo 'none' > /sys/block/sda/queue/write_cache


Thanks,
Ming

