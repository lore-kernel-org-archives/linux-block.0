Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C147199FC1
	for <linux-block@vger.kernel.org>; Fri,  4 Apr 2025 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768383; cv=none; b=W0gwEOQFS6e3lqvOSVn234WeTbP5ssU7s+JKqUN53ZgUFJL/hrB1bXpT/P0Dm9DsZt2KE3dW/q1rE9DYB8v7i31pbBWUMStutRk6cjr/pObjqb2E6tLaAG8nnMAn3YgBwKuX11yc1xCS9hUndUElpEX/WMlH+XUf3hUnwlnjbOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768383; c=relaxed/simple;
	bh=XonAPuP61TGyLqVoYfgEX3V3ARlRTT6k2kF+XdRAq2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgAWgnnK6Nb1Hr992DHoqWGL9uOCOeZAkJ6+rvEN3cQs3cKtdHs13Kz/9ECmhPvAkPSLmhqPFnVZHJ/3mxD8YO5aS8wq7yYIpCmYih/T2Z6eHygq10qi54iqeoR0dWKYVUSQdYGp8/EVFMb6jc434zH8oUXSYOTP25qnPNszQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TyxRDlot; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyxRDlot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743768380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5uKHwQgg+TUjxVR2+PRCqd9oyglVoTcAtQciikxDUcE=;
	b=TyxRDlotgBmcI7J14/qB+Ey3gKXiWZxhEVrODZACKn9Vc4gwIY+N6bQcPyNVKmDMPOsejp
	+zaVJ1xRuAQ0928FTqpnNZRl68n95oqHCXVoNrk7+vE+A0I/nhWQh0lPGu2hsgnLXBl7qa
	QiAZqP6HA3ti16aGkT1rAsW0J3dz9dU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-a1f0dLhnORGZU0WKt16aRA-1; Fri,
 04 Apr 2025 08:06:19 -0400
X-MC-Unique: a1f0dLhnORGZU0WKt16aRA-1
X-Mimecast-MFC-AGG-ID: a1f0dLhnORGZU0WKt16aRA_1743768376
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3432518001E6;
	Fri,  4 Apr 2025 12:06:16 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ECC31828AA7;
	Fri,  4 Apr 2025 12:06:10 +0000 (UTC)
Date: Fri, 4 Apr 2025 20:06:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com
Subject: Re: [PATCH] loop: replace freezing queue with quiesce when changing
 loop specific setting
Message-ID: <Z-_LLTtusK8g0rlM@fedora>
References: <20250403105414.1334254-1-ming.lei@redhat.com>
 <20250404091149.GC12163@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404091149.GC12163@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Apr 04, 2025 at 11:11:49AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 03, 2025 at 06:54:14PM +0800, Ming Lei wrote:
> > freeze queue should be used for changing block layer generic setting, such
> > as logical block size, PI, ..., and it is enough to quiesce queue for
> > changing loop specific setting.
> 
> Why?  A queue should generally be frozen for any setting affecting the
> I/O path.  Nothing about generic or internal.

For any driver specific setting, quiesce is enough, because these settings
are only visible in driver IO code path, quiesce does provide the
required protection exactly.

> 
> This also misses an explanation of what setting this protects and why
> you think this is safe and the sound fix.

1) it is typical queue quiesce use case

2) loop specific setting is only visible in loop queue_rq() & workfn, and
quiesce does provide the sync for queue_rq()

3) for driver, quiesce is always preferred over freeze, and freeze is
easily mis-used by driver, you know we have bad driver uses for freeze.

However, for loop, quiesce only isn't enough, we need to flush the
workqueue for avoiding workfn to use the changed setting too, will do
it in V2.

Thanks,
Ming

