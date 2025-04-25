Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF85149C4D
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745545433; cv=none; b=NEeGAdSR5ZgDzAVbPFjOr+7PD84UU3XN0dorjcNlKLTkmiz0tp/rfJUmfxNy7tJXZLhe7dlaWdwPiNVT3qD+p0K7IY7wB9ojJpKa1n40JwOFOQ2yTfbRGpC2b2OMEa1J0c1Wcu0EvnPx1A1FXqWAoqf171qUjArLdUUhGlCwqWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745545433; c=relaxed/simple;
	bh=23y4DG68A+VGJ+b0cbwI1NIkyfWd3w3xgzETv0Z8M6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjrUR9BFYWRXhYyVi8r3gLqzykzMrf0/TqMDpXRhL56fc93b9rPAFGVhG285ybUtULVbVUECXgj+kI6RKMN3BJsl6NndE3mtN3dOSAD8YauLmXADDcmUkKMlIpIA6E5pUfFHgCTy14hNBJdKiBNg0jZC1JrDuphf9HZm9MJ6obM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTM9qy4j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTM9qy4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745545430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0UW416ozYgSHj9Tf2QN+MOgFs6R7bB9WVplivzWdTMw=;
	b=XTM9qy4jV24Y3rQzn21kzyP2JxIXJK5TRHxWuS7cyPKVCyOowjmdeUUkZ0u5gbf+v92dSA
	uOVCnpwJNwpjcTtS7njG31EHi2XCVEnMfFxUk8iheIiymPxv3MkMO9DuAfH/xDiKqYglaS
	YoHxD6DWjFP1+tar9boLXEdA0DyMeGQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-hfyNhiTnMSehf0dW9zT_aw-1; Thu,
 24 Apr 2025 21:43:47 -0400
X-MC-Unique: hfyNhiTnMSehf0dW9zT_aw-1
X-Mimecast-MFC-AGG-ID: hfyNhiTnMSehf0dW9zT_aw_1745545425
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96A911956086;
	Fri, 25 Apr 2025 01:43:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F5841800374;
	Fri, 25 Apr 2025 01:43:39 +0000 (UTC)
Date: Fri, 25 Apr 2025 09:43:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jared Holzman <jholzman@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Guy Eisenberg <geisenberg@nvidia.com>, Yoav Cohen <yoav@nvidia.com>,
	Omri Levi <omril@nvidia.com>, Ofer Oshri <ofer@nvidia.com>
Subject: Re: [PATCH 0/2] ublk: fix race between io_uring_cmd_complete_in_task
 and ublk_cancel_cmd
Message-ID: <aArox0HMI386qGZd@fedora>
References: <20250423092405.919195-1-ming.lei@redhat.com>
 <f7d8a462-7685-47e0-a206-77d358ff4639@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7d8a462-7685-47e0-a206-77d358ff4639@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Apr 25, 2025 at 12:10:31AM +0300, Jared Holzman wrote:
> On 23/04/2025 12:24, Ming Lei wrote:
> > Hello Jens,
> > 
> > The 2 patches try to fix race between between io_uring_cmd_complete_in_task
> > and ublk_cancel_cmd, please don't apply until Jared verifies them.
> > 
> > Jared, please test and see if the two can fix your crash issue on v6.15-rc3.
> > 
> > If you can't reproduce it on v6.15-rc3, please backport them to v6.14, and I
> > can help the backport if you need.
> > 
> > Thanks,
> > Ming
> > 
> > Ming Lei (2):
> >   ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA
> >   ublk: fix race between io_uring_cmd_complete_in_task and
> >     ublk_cancel_cmd
> > 
> >  drivers/block/ublk_drv.c | 51 ++++++++++++++++++++++++++--------------
> >  1 file changed, 34 insertions(+), 17 deletions(-)
> > 
> 
> Hi Ming,
> 
> It's a solid fix. I ran it through our automation and it passed 300 iterations without an issue. Previously we were getting crash after less than 20.
> 

Jared, thanks for the test and feedback!


> I also back-ported the patches to 6.14 and it works there too.
> 
> Will these fixes make it into 6.15? Or only 6.16?

I think it is fine for v6.15 if Jens agrees.

> 
> Also is there a 6.14 maintenance branch that could also be fixed or is it end-of-life already?

Both the two are simple enough, which may be backported to any stable tree,
IMO.


thanks,
Ming

