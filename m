Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668827BB0A
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784172; cv=none; b=nOGpm1GAplZyVnR7mJ7EOw/jxGdaoZkJlROR2U7+du15msOxmcctgtrVaCIAS1XUih4l00gbB6B2dTwM/kdk/F2y9luDyuPtMAlOo+D8ddHrH4GwJb3DynI7Nx/qDWs0XD3+Z8U3N3kUopIP2v+3Iv960uibh6c6MkJwUetNgkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784172; c=relaxed/simple;
	bh=ZHo4ycUPlSKuHV7py6D8xBCYbfyeTvXQmU4+hxrp7RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZtmOYx1/sU4QigN1oD47/wADYXsIcFKM1h2O7/bWuIccemh0UTWOjJ0rW6BqFW1+O739uQ3IWI9b1K4wbi79zO2cIlVNrF/Shq772/4AlJeN4cmN8KcOj1PX7ovu4bKWBeFRPtOpmAfqDyzV5igQGl6W6vzvW3ea3GuxTmKJ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3dgHU74; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3dgHU74"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718784170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pL3qnYyOyuShAb4JTh2CkuhfFV0r8FiHzeF6zGTNP7k=;
	b=a3dgHU74KEp93kGsj/ant1VWhQ7ePDnxjaRnJVKLK+G3XHry1FVFOM95YVYVo9LJwg5sWd
	k6Zq5Ta5LAf4OMLcKtrA62pPBVWWWgz3EtPp7isTA3ItxFPKCMhwf4mi1nH6v8gDkSSUyy
	sMsIr2riMeluH+RIb+Eae/N+BcpQPPc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-0qtIuuzFP66-T6Zs9YRyDw-1; Wed,
 19 Jun 2024 04:02:48 -0400
X-MC-Unique: 0qtIuuzFP66-T6Zs9YRyDw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87AA1195609F;
	Wed, 19 Jun 2024 08:02:47 +0000 (UTC)
Received: from fedora (unknown [10.72.112.148])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 492EE1956087;
	Wed, 19 Jun 2024 08:02:41 +0000 (UTC)
Date: Wed, 19 Jun 2024 16:02:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] block: check bio alignment in blk_mq_submit_bio
Message-ID: <ZnKQnQDTa6PNDWkL@fedora>
References: <20240619033443.3017568-1-ming.lei@redhat.com>
 <69d3bca7-0bdb-43cc-9181-a733ec495810@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d3bca7-0bdb-43cc-9181-a733ec495810@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Jun 19, 2024 at 09:50:38AM +0200, Hannes Reinecke wrote:
> On 6/19/24 05:34, Ming Lei wrote:
> > IO logical block size is one fundamental queue limit, and every IO has
> > to be aligned with logical block size because our bio split can't deal
> > with unaligned bio.
> > 
> > The check has to be done with queue usage counter grabbed because device
> > reconfiguration may change logical block size, and we can prevent the
> > reconfiguration from happening by holding queue usage counter.
> > 
> > logical_block_size stays in the 1st cache line of queue_limits, and this
> > cache line is always fetched in fast path via bio_may_exceed_limits(),
> > so IO perf won't be affected by this check.
> > 
> > Cc: Yi Zhang <yi.zhang@redhat.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Ye Bin <yebin10@huawei.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-mq.c | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> > 
> Is this still an issue after the atomic queue limits patchset from
> Christoph?
> One of the changes there is that we now always freeze the queue before
> changing any limits.
> So really this check should never trigger.

submit_bio() just blocks on queue freezing, and once queue is unfrozen,
submit_bio() still moves on, then unaligned bio is issued to
driver/hardware, please see:

https://lore.kernel.org/linux-block/ZnDmXsFIPmPlT6Si@fedora/T/#m48c098e6d2df142da97ee3992b47d2b7e942a161


Thanks,
Ming

