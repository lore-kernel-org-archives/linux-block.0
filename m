Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428E24B29
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935856; cv=none; b=FcpA1J/k+yOH36AMKfGn8mpVcZw0po5hxh91bouqLD5nmIhUdA1zJN5YOWOMiUp4a0C/3X0E52x2fuVBsLIvhJPAhBMj7d2/XboBRARabv4A7rALom7tD8wH8gDMmWvglpRljDNkpo5HxaQLJEVXTbgGBOwmTHbcE6J/piHZL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935856; c=relaxed/simple;
	bh=9U5PFf08icoHorE35ueV6bRkg5Tl+Vtka1Y0O+c32NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUym2NGk8Tjh2LqXqVTurjPaq2s+roHEnoqhPtCribbmneKuk/JfSzin5W2+m8xx6Hu6bkWbaNS3INojD8+LrB7RcXGDaY+gaWHKS1EajeYmWJxdBHsrYqW1i5NYd62hBNYP+Z1UNdc8whWE8aWTYaHc5pAS08W2p8e6//62Kk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OjUB+NTl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjUB+NTl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751935853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AAUUWJ4ILNY8LjRs5owspqNT79ub9Plxf3V6xvT5JVk=;
	b=OjUB+NTlJPjICfgN9aAe23oX4fnDmskFuEIweFLKOyZrZ6na50Fi7nICbwvB3xrNrkz8oa
	e9S1aBGBkvWHoyY1SWuzrzVcYiYzlp47q64lDN/gDh0XHHP6lG4pCqhH3RgZVjW6DJ4aOp
	nkVBR6m/sW+5aUkCwTqSBubYhISGC7M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-Hut3IFhCN5ehbs-pjuC7Dw-1; Mon,
 07 Jul 2025 20:50:49 -0400
X-MC-Unique: Hut3IFhCN5ehbs-pjuC7Dw-1
X-Mimecast-MFC-AGG-ID: Hut3IFhCN5ehbs-pjuC7Dw_1751935847
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C26D1955F38;
	Tue,  8 Jul 2025 00:50:47 +0000 (UTC)
Received: from fedora (unknown [10.72.116.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F7BB1956087;
	Tue,  8 Jul 2025 00:50:41 +0000 (UTC)
Date: Tue, 8 Jul 2025 08:50:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/8] block: Do not run frozen queues
Message-ID: <aGxrW5xK6pFwpTbF@fedora>
References: <20250702203845.3844510-1-bvanassche@acm.org>
 <20250702203845.3844510-3-bvanassche@acm.org>
 <699f9f38-009f-c5da-dfd3-60531e16c1ce@huaweicloud.com>
 <93500d50-ba11-425b-8d5f-1ce1930e4160@acm.org>
 <aGXiH1HqSlLk-QSI@fedora>
 <bbf1ec71-6a6c-440d-9ddd-efb5c5e10d44@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbf1ec71-6a6c-440d-9ddd-efb5c5e10d44@acm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Jul 07, 2025 at 11:22:07AM -0700, Bart Van Assche wrote:
> On 7/2/25 6:51 PM, Ming Lei wrote:
> > The dispatch critical area is much _longer_ than queue_rq()/queue_rqs(),
> > block layer data structure may still be accessed after .q_usage_counter drops
> > to zero.
> 
> I think the above is only correct for block drivers that set the
> BLK_MQ_F_BLOCKING flag. If BLK_MQ_F_BLOCKING is not set,

No, please see my comment:

https://lore.kernel.org/linux-block/aGXiH1HqSlLk-QSI@fedora/

thanks,
Ming

