Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7805B213E81
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629298; cv=none; b=kODMjGA6NVgIOIqIELaKjO+Pk2gSnIorSCwTh4EqehYWImU3BTy74Vu4hQGm3n8XW9+p+DJgN5kp0Yas10B7wJpn9mgCETFrE2Vkf0kDnm/rs9qE8laugtgQmXn4DPwxjoGSb2tN55AEdSUK2LTkq6bIPSqYFgfNwmfmOTNeKGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629298; c=relaxed/simple;
	bh=Xl1Y5gMRG5Ak1wLVNOmog/eXIgwQ1blcGKY8NMiuqUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/nDyEOk/YzXLNAKDld5N+naAElx0XpIypUAZ0KQhGtr6IuU98lYJiNNR1Bpkxkb7hJVSBTGZ+vBlelV4f4sp+plBj33pFZ1sDtgl1OkMs3D4i+79D/OAzQ501FCQPqFsUfmIpU4EUZNMWmHfFarvX1k/WFSTrBPPdhKWMOIa1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vu4zlNal; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vu4zlNal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746629294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=elpmTR45OEW4xw8i/pNg1hXUgkUv8Vh0cF+i23OeiXY=;
	b=Vu4zlNalyHnE5xuDb9la/Qj3eJ9DrDkzTA0HrbG+IflyZQgSd19EsE8ji870mTIXpbpPDx
	i2QmC1KtNBIakG22oT0JT9Yn+l+qTd5v102+owNFMosrwTgES2WZtZB6jLXwAUF56reALd
	obk4fWbTVt1hP8B9zrzoBFI5zHuqJBc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-SAXkAJa8P56pPWuEGUAoOg-1; Wed,
 07 May 2025 10:48:11 -0400
X-MC-Unique: SAXkAJa8P56pPWuEGUAoOg-1
X-Mimecast-MFC-AGG-ID: SAXkAJa8P56pPWuEGUAoOg_1746629290
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCD5E1800EC9;
	Wed,  7 May 2025 14:48:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A936E19560AD;
	Wed,  7 May 2025 14:48:06 +0000 (UTC)
Date: Wed, 7 May 2025 22:48:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/2] block: move queue quiesce into elevator_change()
Message-ID: <aBtyobQ2NxLjFkET@fedora>
References: <20250507120406.3028670-1-ming.lei@redhat.com>
 <20250507120406.3028670-2-ming.lei@redhat.com>
 <20250507135349.GA1019@lst.de>
 <aBtuCDKTQK1PReDg@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBtuCDKTQK1PReDg@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, May 07, 2025 at 10:28:24PM +0800, Ming Lei wrote:
> On Wed, May 07, 2025 at 03:53:49PM +0200, Christoph Hellwig wrote:
> > On Wed, May 07, 2025 at 08:04:02PM +0800, Ming Lei wrote:
> > > blk_mq_freeze_queue() can't be called on quiesced queue, otherwise it may
> > > never return if there is any queued requests.
> > > 
> > > Fix it by moving queue quiesce int elevator_change() by adding one flag to
> > > 'struct elv_change_ctx' for controlling this behavior.
> > 
> > Why do we even need to quiesce the queue here, and not anywhere else?
> 
> Quiesce is for draining the in-progress critical area, which can't be
> covered by queue freeze. Typically, all requests are freed, the run queue
> activity isn't finished yet, so schedule data can be touched by the un-finished
> code path.
> 
> We did fix this kind of bugs by queue quiesce several times.

For example:

24f5a90f0d13 blk-mq: quiesce queue during switching io sched and updating nr_requests

c2856ae2f315 blk-mq: quiesce queue before freeing queue

Ming

