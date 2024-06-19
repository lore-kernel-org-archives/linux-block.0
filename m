Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2377F2C
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785793; cv=none; b=muPVvBc+MFVKt6EeY9VMqOJciQLcgv1Erb9DV+wZ5xQs6OO+uXYzj/tiqHGnyICzZRksXAtSwoTOpmryaKrAQ/QDUYrNt42FbafVu6GQCF9mtMLzoOzsQ3xKb2N1XbDFq2YmBuOJZHXZj1WtLlsHRcxse7x4PdWncuIYWb20ZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785793; c=relaxed/simple;
	bh=K+54NseXwlxDcQdjOUmr6y3eTKaD8j5PiTHBOJ2rY4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IleRYVEP1xps9RmMBzTXGvkNVO9TZQwcj5tmdUtZCWKqAz45MtCbcIluGdtPPcFEYINRYMs7ZWQCof8TwSFfZQ7n+HvGdng4JpDeLmGH3Oc8vahJ0YYM0DHohifNTI/EydVeJ7spbPHzmQFXs84/J4gWFqJtHQB5QxShU9STwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZpEWBnX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZpEWBnX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718785790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bbvctdq8ZY2T1RAlfsJBaI1D35PBT748PULy8RAhnNs=;
	b=VZpEWBnXc9mvykYNiC7WWtEci1N8ah/RX6OAdTKyUiS3mQ8OOkHPvuTIeQpq4vnAHCZs5M
	A9k71g8E1cnrslzKK2Tx5qPuovPsHykx+P4BvVDjW7GS7E3ThftHOEu2bEiUYf3QuNgRjR
	otHKU20FjbcLI4c64M+81lHJRP8BWgw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-mva05VP8MO2ZiH3yRJAeBA-1; Wed,
 19 Jun 2024 04:29:49 -0400
X-MC-Unique: mva05VP8MO2ZiH3yRJAeBA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8B171956051;
	Wed, 19 Jun 2024 08:29:47 +0000 (UTC)
Received: from fedora (unknown [10.72.112.148])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBE8819560AE;
	Wed, 19 Jun 2024 08:29:42 +0000 (UTC)
Date: Wed, 19 Jun 2024 16:29:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] block: check bio alignment in blk_mq_submit_bio
Message-ID: <ZnKW8MAekDIMJyBS@fedora>
References: <20240619033443.3017568-1-ming.lei@redhat.com>
 <7ed12f7e-f59a-4f6f-975b-ce7bb21652de@kernel.org>
 <355cc36f-e771-4f00-bfb0-0095674d5d49@kernel.org>
 <ZnKJ3d-18rzl32j2@infradead.org>
 <ZnKPrYI72g2iT/rV@fedora>
 <ZnKRiG0PKxPzQrcb@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKRiG0PKxPzQrcb@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Jun 19, 2024 at 01:06:32AM -0700, Christoph Hellwig wrote:
> On Wed, Jun 19, 2024 at 03:58:37PM +0800, Ming Lei wrote:
> > > > 	unsigned int bs_mask = queue_logical_block_size(q) - 1;
> > > 
> > > Please avoid use of the queue helpers.  This should be:
> > > 
> > > 	unsigned int bs_mask = bdev_logical_block_size(bio->bi_bdev);
> >  
> > It is one blk-mq internal helper, I think queue helper is more
> > efficient since it is definitely in fast path.
> 
> Does it actually generate different code for you with all the inlining
> modern compilers do?
 
It is hard to answer, cause there are so many compilers(versions).

I definitely agree bdev_logical_block_size() should be used in external
users, but it is fine to use queue helper in block internal functions.


thanks,
Ming

