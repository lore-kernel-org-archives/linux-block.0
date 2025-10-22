Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA102D5A07
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 04:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107989; cv=none; b=eztp9Z/QTAenbGM9RK3IecRWT7BWqYbvwkYB4Wj/MhgkwKIIHW1A9ivTnpFDq5AsSxrht5nyJPSZqxpEBW+aZRiIQq2q01/rE3KeWXUI7ab54U2wTk3pfx6RxZrGGSO8LomFeM1YuPdyRuKnzAUBTMN8FRbqbIoDVmyKWQ25mbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107989; c=relaxed/simple;
	bh=bG6thHpq2WyRRM6jnS9D62tm6CEECRES+O6oXVeOqfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qymFqw7DWFCOLVTr91Fwvge1QR4FlDdgtCeU7A2hviQ3+VOMGfLQzIHb2vaiXLOHORKg3ZHKKP5NXBpkXkH4reMxSYZiHl+2UZ3anACPm+Hf3C5uf1MIdkNJ1Esy//N+Scx25kS5dpBH26fXrLAtPiyJWBrAL4xC0VxbN2BUipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCvE+xGY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCvE+xGY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761107986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeXzwMoyfofdSQMYwUEKBfUcheBoIBLSjF+1lfTbWos=;
	b=GCvE+xGY28w5QMkfeDH95nI+pbE98jgx2Vq658QV0flzCkmI+HIQSToXRxpy1bX5jrNZA5
	IAHStr/gL9w4R1nFNcBA1biWUxzRmzTo2iriNFuakORRtu3R0ot18z7WvPqJmbkkfa6R1N
	jxRoCKcUvhJP64/EavwKN/SLyGsRLVg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-TA6IzPjuONeAMQtzovjsdA-1; Wed,
 22 Oct 2025 00:39:42 -0400
X-MC-Unique: TA6IzPjuONeAMQtzovjsdA-1
X-Mimecast-MFC-AGG-ID: TA6IzPjuONeAMQtzovjsdA_1761107981
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2324D1956089;
	Wed, 22 Oct 2025 04:39:41 +0000 (UTC)
Received: from fedora (unknown [10.72.120.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E711180057C;
	Wed, 22 Oct 2025 04:39:34 +0000 (UTC)
Date: Wed, 22 Oct 2025 12:39:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, yukuai1@huaweicloud.com,
	axboe@kernel.dk, yi.zhang@redhat.com, czhong@redhat.com,
	gjoyce@ibm.com
Subject: Re: [PATCH 2/3] block: introduce alloc_sched_data and
 free_sched_data elevator methods
Message-ID: <aPhgAMxgG2q0DKcv@fedora>
References: <20251016053057.3457663-1-nilay@linux.ibm.com>
 <20251016053057.3457663-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016053057.3457663-3-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Oct 16, 2025 at 11:00:48AM +0530, Nilay Shroff wrote:
> The recent lockdep splat [1] highlights a potential deadlock risk
> involving ->elevator_lock and ->freeze_lock dependencies on -pcpu_alloc_
> mutex. The trace shows that the issue occurs when the Kyber scheduler
> allocates dynamic memory for its elevator data during initialization.
> 
> To address this, introduce two new elevator operation callbacks:
> ->alloc_sched_data and ->free_sched_data.

This way looks good.

> 
> When an elevator implements these methods, they are invoked during
> scheduler switch before acquiring ->freeze_lock and ->elevator_lock.
> This allows safe allocation and deallocation of per-elevator data

This per-elevator data should be very similar with `struct elevator_tags`
from block layer viewpoint: both have same lifetime, and follow same
allocation constraint(per-cpu lock).

Can we abstract elevator data structure to cover both? Then I guess the
code should be more readable & maintainable, what do you think of this way?

One easiest way could be to add 'void *data' into `struct elevator_tags`,
just the naming of `elevator_tags` is not generic enough, but might not
a big deal.


Thanks,
Ming

