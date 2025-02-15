Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA298F4ED
	for <linux-block@vger.kernel.org>; Sat, 15 Feb 2025 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739583303; cv=none; b=BUWtATuUVbQx80x7HoDT5sO/IULlvHxuEkSnPhv0TfNaaQGy1fw57lZgZyq8h6c725gqnlks0lxWuHcsMUZe2pVEmByQ1DJP9muq0AONN6FNw9akdJwfu4iOSALMOhcnzJDIHi8KwwvcGpXE5Ir5pxqsMjUo6ta6mUT6AtFBiec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739583303; c=relaxed/simple;
	bh=my3LwZD0EdW82/hsUwpe2Jptq76eDR43I2jVupXjtfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKwMB8S+aaXwG+as83rQXeSO/JXoNWj/qCWcoGbB1O2RBCH2wnQnsVi34xdhNP2ssvz/C9s1NUJFfJm6KbxGwie7T6ClrC3Ncq4DQG8NRBYZ1NcbhfaNKqiD8Fsygep677WMpgpAQ88w6UtYciYEhG3O4qFztQrBqOBy+v8RZ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOO2DUKJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOO2DUKJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739583300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TXDNucX4B3knIUiUTJcvNK21oP7y55DgLdW5UJGYdOY=;
	b=VOO2DUKJyhdPw1if0229UUttZN8Id1I7VWo1WnDIdgT5z0L/5uY0NOlROiL4L/enUbR27Q
	dnlnm2yLyjEX/9wwo+NGrozpeRTTa2R5PSpISFe/K77qz2PSNEvQuh2n3ZugbPsQ2LCcRY
	dKgaUIoQx4vmMu7aShqXbWtK6+Jel50=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-N1jFdHTuPqGcRSG9MWkjyQ-1; Fri,
 14 Feb 2025 20:34:55 -0500
X-MC-Unique: N1jFdHTuPqGcRSG9MWkjyQ-1
X-Mimecast-MFC-AGG-ID: N1jFdHTuPqGcRSG9MWkjyQ_1739583294
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CBB11800373;
	Sat, 15 Feb 2025 01:34:54 +0000 (UTC)
Received: from fedora (unknown [10.72.120.11])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C99419373D9;
	Sat, 15 Feb 2025 01:34:48 +0000 (UTC)
Date: Sat, 15 Feb 2025 09:34:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, asml.silence@gmail.com, axboe@kernel.dk,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	bernd@bsbernd.com
Subject: Re: [PATCHv2 3/6] io_uring: add support for kernel registered bvecs
Message-ID: <Z6_vMvwv3ncTvi7e@fedora>
References: <20250211005646.222452-1-kbusch@meta.com>
 <20250211005646.222452-4-kbusch@meta.com>
 <Z664w0GrgA8LjYko@fedora>
 <Z69gmZs4BcBFqWbP@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z69gmZs4BcBFqWbP@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Feb 14, 2025 at 08:26:17AM -0700, Keith Busch wrote:
> On Fri, Feb 14, 2025 at 11:30:11AM +0800, Ming Lei wrote:
> > On Mon, Feb 10, 2025 at 04:56:43PM -0800, Keith Busch wrote:
> > > +
> > > +	node->release = release;
> > > +	node->priv = rq;
> > > +
> > > +	nr_bvecs = blk_rq_nr_phys_segments(rq);
> > > +	imu = kvmalloc(struct_size(imu, bvec, nr_bvecs), GFP_KERNEL);
> > > +	if (!imu) {
> > > +		kfree(node);
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	imu->ubuf = 0;
> > > +	imu->len = blk_rq_bytes(rq);
> > > +	imu->acct_pages = 0;
> > > +	imu->nr_bvecs = nr_bvecs;
> > > +	refcount_set(&imu->refs, 1);
> > > +	node->buf = imu;
> > 
> > request buffer direction needs to be stored in `imu`, for READ,
> > the buffer is write-only, and for WRITE, the buffer is read-only,
> > which isn't different with user mapped buffer.
> > 
> > Meantime in read_fixed/write_fixed side or buffer lookup abstraction
> > helper, the buffer direction needs to be validated.
> 
> I suppose we could add that check, but the primary use case doesn't even
> use those operations. They're using uring_cmd with the FIXED flag, and
> io_uring can't readily validate the data direction from that interface.

The check can be added to io_import_fixed().

It is a security trouble. Without the validation:

- kernel data can be redirected to user file via write_fixed,

- kernel page data is over-written unexpectedly via read_fixed, cause fs corruption or
even kernel panic.


Thanks,
Ming

