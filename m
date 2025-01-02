Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFEF28FF
	for <linux-block@vger.kernel.org>; Thu,  2 Jan 2025 02:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735786199; cv=none; b=qdyDiO4LUTC6qSnyngpbOMUCXfU3tuXPzMtigh2xSoteZ/ov3tG+YqPfeX6V86vAIZ3Chvd48RDt3yyw/v3+aGvTDq+8kgzaf1wWtQLvsOeAZwrg7aLaaGOkOc1mxRbgZrzPVrtinzcmmfU7Vqonbi5ptBv+HLR/fKeeJiMBBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735786199; c=relaxed/simple;
	bh=8slTVwSGXSNNEk3d3soKtTAENlD2wh93w0FFdg97WiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPcOt5syl5ZfpqXsx0pDT7y/fYqqNdUFJmkJz6Y32fv/XVb0ZDQoZq/Q/98RG3ZrJsGQKFlLM3ETxfdyjji3gYDHRGDR9UrAnphm0pncdmVEiKqpKwZoI2UMuOPzLHeBkrL7Hp6Kh09QtZL0qPDLm0eGR1CwCq5hvhU9EMOkHLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VL8FRYmj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VL8FRYmj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735786196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ptrxv4eXon2QGOmftsswMXn+nuoIqjmKegCR9c6et4=;
	b=VL8FRYmjqT3JbR5vwWqUdF2HERPn9goxOHD826ibbuHcDteo5eFXIfehKM2zifLB4FTJ3Y
	qYcHg9PWmpJCr7+Xe4x102CZ5jO7G63reELnrhDcAKDVzZ6bNxK/i4IZad1hAaNn1gVTwp
	e+o6UAXFeeMdyTHVxlSbJ126Rq3VT1g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-moOa4TUYNYaLWZDJmQ9_Rw-1; Wed,
 01 Jan 2025 21:49:53 -0500
X-MC-Unique: moOa4TUYNYaLWZDJmQ9_Rw-1
X-Mimecast-MFC-AGG-ID: moOa4TUYNYaLWZDJmQ9_Rw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A48D19560AB;
	Thu,  2 Jan 2025 02:49:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B967F1956052;
	Thu,  2 Jan 2025 02:49:45 +0000 (UTC)
Date: Thu, 2 Jan 2025 10:49:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: make queue limits workable in case of 64K
 PAGE_SIZE
Message-ID: <Z3X-xMeMuF8j0RDA@fedora>
References: <20250102015620.500754-1-ming.lei@redhat.com>
 <0b423229-f928-4210-9351-dca353071231@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b423229-f928-4210-9351-dca353071231@acm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Jan 01, 2025 at 06:30:30PM -0800, Bart Van Assche wrote:
> On 1/1/25 5:56 PM, Ming Lei wrote:
> > In RH lab, it has been found that max segment size of some mmc card is
> > less than 64K, then this kind of card can't work in case of 64K PAGE_SIZE.
> 
> That means that that MMC card is incompatible with the 64K page size.

Is there any such linux kernel compatibility standard? If yes, please share
it here.

> 
> Additionally, this patch looks wrong to me. There are good reasons why the
> block layer requires that the DMA segment size is at least as large
> as the page size.

Do you think 512byte sector can't be DMAed?

> 
> You may want to take a look at this rejected patch series:
> Bart Van Assche, "PATCH v6 0/8] Support limits below the page size",
> June 2023 (https://lore.kernel.org/linux-block/20230612203314.17820-1-bvanassche@acm.org/).

'502 Bad Gateway' is returned for the above link.

Thanks,
Ming

