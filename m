Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C7E3043B5
	for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768530590; cv=none; b=gW2Fmc+qeKx6XYQL792uo0Oj6HjPbd0YcRK7DWev7xlS4Kct63wffua6UpmQSJ/LgTIZKWhlh2R26WhGRPnIsHGZIZ2xvrqWXtuUXsb2cb4rBMS7yaW5+YN1iQWzoT9F3Dhtq111pvL1xYWP4UdknJO5disf2UZTLsLzOg0GEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768530590; c=relaxed/simple;
	bh=K8B8M7eyzBTpuEy2wcfy6rGDyriJ3NZzDf9tPl5rXw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAtAFoK8gSqJaHg3YfgMQRrzjT1XwIaBt66cYeFUlCc7sW0mwgC++fmG9uHF/OIakec7DyK0+ozNlLXOzkQDRXEBzUS8defKJ4oMju+U6fBlYOyhG5FtJmI7lRWAhrWJf965BmnbTV914f4ZAq3jagJEaGYk9+qnFAoGSx5wkvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aj25M64C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aj25M64C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768530587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WS2SICUrwaPPpzRXOUocpqBLbS1kjBn3jEB2NsfxtKA=;
	b=Aj25M64CRrL/HKx8WvGtMg3dwx/pu+BGIJAFlEdPJD7rYOEAtQ3vfQaJ0K76dJ2Vs6oaIR
	MbLTA9iiOJeRO42XN8C+ZzHM7/khvGcZj075pm49INOdySbqTfuj5BU+KS54Azfg2523BU
	PT8s+Iafaz74t0LV/+AQw/s3W3AVnqQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-knSiroeYO4e49MsBlmhXOg-1; Thu,
 15 Jan 2026 21:29:44 -0500
X-MC-Unique: knSiroeYO4e49MsBlmhXOg-1
X-Mimecast-MFC-AGG-ID: knSiroeYO4e49MsBlmhXOg_1768530583
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA9031956048;
	Fri, 16 Jan 2026 02:29:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.198])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 345DC1800240;
	Fri, 16 Jan 2026 02:29:37 +0000 (UTC)
Date: Fri, 16 Jan 2026 10:29:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: optimize passthrough IOPOLL completion for local
 ring context
Message-ID: <aWmijezYIIWLKeM2@fedora>
References: <20260115085952.494077-1-ming.lei@redhat.com>
 <aWkwNVgAyBbx732l@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWkwNVgAyBbx732l@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Jan 15, 2026 at 11:21:41AM -0700, Keith Busch wrote:
> On Thu, Jan 15, 2026 at 04:59:52PM +0800, Ming Lei wrote:
> > +	if (blk_rq_is_poll(req) && req->poll_ctx == io_uring_cmd_ctx_handle(ioucmd)) {
> 
> ...
> 
> > @@ -677,8 +691,14 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
> >  	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> >  	struct request *req = pdu->req;
> >  
> > -	if (req && blk_rq_is_poll(req))
> > +	if (req && blk_rq_is_poll(req)) {
> > +		/*
> > +		 * Store the polling context in the request so end_io can
> > +		 * detect if it's completing in the local ring's context.
> > +		 */
> > +		req->poll_ctx = iob ? iob->poll_ctx : NULL;
> 
> I don't think this works. The io_uring polling always polls from a
> single ctx's iopoll_list, so it's redundant to store the ctx in the iob
> since it will always match the ctx of the ioucmd passed in.

Yeah, the patch looks totally wrong, what it should record is the
io_ring_ctx for completing the request, instead of the context which owns
the uring_cmd, which can be obtained always from the uring_cmd.

> 
> Which then leads to the check at the top: if req->poll_ctx was ever set,
> then it should always match its ioucmd ctx too, right? If it was set
> once before, but the polling didn't find the completion, then another
> ctx polling does find it, we won't complete it in the iouring task as
> needed.
> 
> I think you want to save off ctx that called
> 'nvme_ns_chr_uring_cmd_iopoll()', but there doesn't seem to be an
> immediate way to refer back to that from 'nvme_uring_cmd_end_io'. Maybe
> stash it in current->io_uring->last instead, then check if
> io_uring_cmd_ctx_handle(ioucmd)) equals that.

One easy way is to add `iob` to rq_end_io_fn, then pass it via
blk_mq_end_request_batch().


Thanks,
Ming

