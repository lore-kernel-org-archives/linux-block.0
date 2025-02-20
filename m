Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2781F460F
	for <linux-block@vger.kernel.org>; Thu, 20 Feb 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051556; cv=none; b=W3D3NYiYxJuuUbwD1uyaXeLNet8+Np/HB6RfNSC8P21Bz0ITJ+WDQj9cuXy7ZBx0j83YPqzB48nTaApleQ2vwYkh2fz8Ch2LhPNABGugQ4wzgaSN7BcDcgkjIQ5mwuuW+q64zoeEqT3MZOpz4E+uKaviST8J7ShHzsbKU9Vdj1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051556; c=relaxed/simple;
	bh=W5d16DAyYZ5/Rti2l4k2nBD96fEA3RgpkhwWBhdi3/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fT06q9Ce655rxFTHYaVh7+kDKYOkyaZAzKb07/uW/bAI9fC5hQBa2wJmuUCo9AZ8cOd/wMFpynz2psfeNWi6E6MX0kB1w+fCicgl49jyY9iZtTKQrq+pERnZ89uYbIr7I8H4NQFwPFEZj0HQsIqs0Nmjr5/CpeiLwlnpfuhDB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DR4+n5Pq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DR4+n5Pq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740051553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ALb4YOLPvLzKIpMKCVohw54cSkOI6A7qKFi4nwjNEI=;
	b=DR4+n5PqvmhCj+XGHnNLNxcuoU9nJ7LTNKGqJ0ojnjRERtWWmUgTQ2KoY408PiyvSWqp86
	qpN7RRcQgrp4xOoDCG5nuxXOZhvbjJCq96QAhwbe7cQpIpBoCdkk3IVr09iz0YIxx+Tg1T
	pEt2GiZ03nHd7UbGsatQQENFpi/KvXg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-Wf5HxF4bNs-dqFF7lThfKw-1; Thu,
 20 Feb 2025 06:39:10 -0500
X-MC-Unique: Wf5HxF4bNs-dqFF7lThfKw-1
X-Mimecast-MFC-AGG-ID: Wf5HxF4bNs-dqFF7lThfKw_1740051549
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75A031800877;
	Thu, 20 Feb 2025 11:39:08 +0000 (UTC)
Received: from fedora (unknown [10.72.120.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2FFF180035F;
	Thu, 20 Feb 2025 11:39:00 +0000 (UTC)
Date: Thu, 20 Feb 2025 19:38:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Daniel Gomez <da.gomez@kernel.org>,
	Paul Bunyan <pbunyan@redhat.com>, Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V4] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z7cUTjZlTnibC0AC@fedora>
References: <20250219024409.901186-1-ming.lei@redhat.com>
 <Z7bIBNc1SuTyy6ac@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7bIBNc1SuTyy6ac@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Feb 19, 2025 at 10:13:24PM -0800, Christoph Hellwig wrote:
> On Wed, Feb 19, 2025 at 10:44:09AM +0800, Ming Lei wrote:
> > PAGE_SIZE is applied in validating block device queue limits, this way is
> > very fragile and is wrong:
> 
> It's neither very fragily nor wrong.  If you want to change it to suit
> your needs that might or might not be ok but this language isn't.

max segment size is fixed value since it is read from hardware, now
kernel validates it by variable PAGE_SIZE, not fragile?

Well, it isn't my need only, there are lots of device which max segment
size is < 64K, they work just fine in 4K page size kernel, however,
they become unusable in 64K page size kernel.

> 
> > - queue limits are read from hardware, which is often one readonly hardware
> > property
> 
> queues limits aren't read from hardware per definition.  Very often they
> are software limits.

Fine, I will update the commit log to just mention max segment size limit.


Thanks,
Ming

