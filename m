Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D21F03F1
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329189; cv=none; b=uc9RknZhmkhrMXcOPlySPfbir5Z6R8Y4jTi5u04YV97s4gTDxwvFVC/J4fgSLMYE2n1Yy+Owf90yumrxG/gzROT1k+R659ZkInrAVqAmv2DimvLNf0E5RpVgL1lTixW7mdfeg8202UBb3ZoOSU8cffwwChbyGgQKKKCKYPABJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329189; c=relaxed/simple;
	bh=WYhomn70P25FJi9MceIhGf2ntWQ8mL+UaI2z3gI9A6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suxorXADzLtEhc/bbUq7cpGDbKE0u9+FqkmfcP1/eY0MNQM1BsjmV1KxkVg0cXcAu6h4ld+oL6Ob9jGAHnTbESuJvBq7YPVDbLgt77hH5Jci5zwbY6qcJs3D68PFhYh1Th8nbpP9xK14Tm4aWubnTn7l3aBZy/Ynn7E6pZIim0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=damzhxch; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="damzhxch"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736329186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3vRzSAUwwa8R76b7J7XpJfZw7mhqd47kcxnNLCMmrA=;
	b=damzhxch2vNy1DXZiTWRzv6nW8l7NMq2ixIN0D9Ov4sNeYjCJ0KIfHb4Xik/SxnJoQVwVD
	mrrSsvUWrXyz1bS7usoCr+m64dJB07/2Fk2+S5BEMPTS7sVG00vkxH0Qju+amY7e1sPQsf
	80GowkEaf8srSn1S0IjSDUBoTPfdDQM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-Ra4IlvPmM_af-vbYQriptA-1; Wed,
 08 Jan 2025 04:39:43 -0500
X-MC-Unique: Ra4IlvPmM_af-vbYQriptA-1
X-Mimecast-MFC-AGG-ID: Ra4IlvPmM_af-vbYQriptA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F66F195609E;
	Wed,  8 Jan 2025 09:39:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8AC711956094;
	Wed,  8 Jan 2025 09:39:38 +0000 (UTC)
Date: Wed, 8 Jan 2025 17:39:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] New zoned loop block device driver
Message-ID: <Z35H1chBIvTt0luL@fedora>
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de>
 <Z33jJV6x1RnOLXvm@fedora>
 <ac42d762-60e5-4550-99f1-bd2072e474c2@kernel.org>
 <CAFj5m9+LUtAt2ST41KzMasx4BuVYBXjAuLg5MDr0Gh31yzZKzw@mail.gmail.com>
 <20250108090912.GA27786@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108090912.GA27786@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Jan 08, 2025 at 10:09:12AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 08, 2025 at 04:13:01PM +0800, Ming Lei wrote:
> > It is backed by virtual memory, which can be big enough because of swap, and
> 
> Good luck getting half way decent performance out of swapping for a 50TB
> data set.  Or even a partially filled one which really is the use case
> here so it might only be a TB or so.
> 
> > it is also easy to extend to file backed support since zloop doesn't store
> > zone meta data, which is similar to ram backed zoned actually.
> 
> No, zloop does store write point in the file sizse of each zone.  That's
> sorta the whole point becauce it enables things like mount and even
> power fail testing.
> 
> All of this is mentioned explicitly in the commit logs, documentation and
> code comments, so claiming something else here feels a bit uninformed.

OK, looks one smart idea.

It is easy to extend rublk/zoned in this way with io_uring io emulation, :-)



Thanks,
Ming

