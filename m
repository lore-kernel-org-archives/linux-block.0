Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278AD482F6
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717717610; cv=none; b=JLEp00KoyMfbU0RXZWF+gE7vlT+zc0ONl6VxX994bRi1TRsiBcDBmfMVPJpYyFm+/LoZm1nD/qqV62XZtBY5rjIs5GLVAfycn8c/5NrWTaWi9XXKkFsncoC2/3Ih0aEWboKJKhZ+9LZsua5Mx1YvdKa3lx8xHNWcCceNz08iH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717717610; c=relaxed/simple;
	bh=Q5ZcmHTBdEtDXi0V6CYL5t/Co7Vi1if2BDN7rDzndCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+EbGmHIShNl39qYZP1Z+HZ644I0h6sc7zRu/c6W+mmUdDbz//8erAE8KGJYx1E3LejXTyRsK0VVI9hC9X9zthqILFBrbbkAPza5DWpSvkGOELhMvLhXJVWKPdR9mjK3bBeFF1vy69NxCo7gE2KJOf3/L1Zqp6LY+jyrxsL+R/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6x58FZX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6x58FZX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717717608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6KkShH+LBPBDtFL/J7+56MEKPg8eU6ralQnJ1U5rNo=;
	b=g6x58FZXDliAaXzQTVqKHyagu6FjuuxCP7ASjzM8ZaG1WlXfbTvxNkgnFUct5RsZXi/QLU
	38rDrd81vJZq2He4NU68DPzmNWEuKsXsepBKGoa9jka0qSsiBdW9GRsnaE55BucaPNSKeD
	krYbBz33e6lOFR3DZjnKYeKaZRVTYIg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-HAhIOT2zNmKofTm7DiPH8g-1; Thu,
 06 Jun 2024 19:46:43 -0400
X-MC-Unique: HAhIOT2zNmKofTm7DiPH8g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E5371944D3B;
	Thu,  6 Jun 2024 23:46:40 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CE101955F14;
	Thu,  6 Jun 2024 23:46:32 +0000 (UTC)
Date: Fri, 7 Jun 2024 07:46:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: yebin <yebin@huaweicloud.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ye Bin <yebin10@huawei.com>, Zhang Yi <yizhan@redhat.com>,
	"Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
Message-ID: <ZmJKU9mMDg1+mO3i@fedora>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
 <ZmFatW3BEzTPgR7S@infradead.org>
 <66619EB6.4040002@huaweicloud.com>
 <ZmHH7mW0M80RaPlj@fedora>
 <ZmHNQ56C6Ee01Kcv@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmHNQ56C6Ee01Kcv@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jun 06, 2024 at 07:52:51AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 06, 2024 at 10:30:06PM +0800, Ming Lei wrote:
> > Yeah, that is one area queue freezing can't cover logical block size
> > change, but I'd suggest to put the logical bs check into submit_bio() or
> > slow path of __bio_queue_enter() at least.
> 
> We really need an alignment check in submit_bio anyway, so doing it
> under the freeze protection would also help with this.
> 
> > My concern is that nvme format is started without draining IO, and
> > IO can be submitted to hardware when nvme FW is handling formatting.
> > I am not sure if nvme FW can deal with this situation correctly.
> > Ewan suggested to run 'nvme format' with exclusive nvme disk open, which
> > needs nvme-cli change.
> 
> .. and doesn't protect against someone using a different tool anyway.
> 
> That beeing said, nvme_passthru_start actually freezes all queues
> based on the commands supported an affects log, and
> nvme_init_known_nvm_effects should force this even for controllers
> not supporting the log or reporting bogus information.  So in general
> the queue should be frozen during the actual format.

That is something I missed, thanks for sharing the story.


Thanks,
Ming

