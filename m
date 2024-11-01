Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F983BBE5
	for <linux-block@vger.kernel.org>; Fri,  1 Nov 2024 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730423096; cv=none; b=plASAlaX8hZLfubIhGXx/OI7V4Xv+XvVBZ83EjwLUhDFCVUKcQEV6YJsobm+5tWmkTUq3o0Rbs7QOZks+BIU/P0RIC1WjTzIvHnfXaBu2pHXlem3WgQDh06+SJx+0qFm/cG4zkIEu4Xdkp1nEf/LRk+uOO90Td8NNb7pLn1g/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730423096; c=relaxed/simple;
	bh=KIwfnWgY5nC44Ns8o8IaUAacedRAE3vniwTAJcLOInw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6AeUmqZhKjBr42b/G78Gd4QgqEI+7Z9SXMb4DEUF0fRtL3UHGpYhjRMDzlBHW01HDamb6OMX6V3ErE3+/W+jGOy1wPMMKCPTT+888CUqG6rCvC4ZwWmv/m+X7QACY8mxxaITnYqLe59+9ceouQZv4YoKXQBvdBR1B8XM5vMacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ma09g2yP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ma09g2yP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730423089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dA/8Zid0UhQ0KPn5cvvbzv/Vh/itSj5gGvrGBM9gzKM=;
	b=Ma09g2yP0zguw5x6+Jj88EB3XARYCdAt+llay/4hf/X3MiVrtBAPL220Y9UIir6m9c60Q2
	+zf3+Y4bzzyW+pxSHTd+QzCBtAbWRYCYySY7AV4j9rwszt2f4qA1NvR1yRWUe9cm2AJKAX
	BvqsJxVorn0xFbI7xlu7pTbzXPzqO1M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-8TIlRJlaO1usRbpPte6V5w-1; Thu,
 31 Oct 2024 21:04:43 -0400
X-MC-Unique: 8TIlRJlaO1usRbpPte6V5w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD1E519560BD;
	Fri,  1 Nov 2024 01:04:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.63])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4B4B1956088;
	Fri,  1 Nov 2024 01:04:36 +0000 (UTC)
Date: Fri, 1 Nov 2024 09:04:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>
Subject: Re: [PATCH V8 5/7] io_uring: support leased group buffer with
 REQ_F_GROUP_KBUF
Message-ID: <ZyQpH8ttWAhS9C5G@fedora>
References: <20241025122247.3709133-1-ming.lei@redhat.com>
 <20241025122247.3709133-6-ming.lei@redhat.com>
 <4576f723-5694-40b5-a656-abd1c8d05d62@gmail.com>
 <ZyGBlWUt02xJRQii@fedora>
 <bbf2612e-e029-460f-91cf-e1b00de3e656@gmail.com>
 <ZyGURQ-LgIY9DOmh@fedora>
 <40107636-651f-47ea-8086-58953351c462@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40107636-651f-47ea-8086-58953351c462@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Oct 31, 2024 at 01:16:07PM +0000, Pavel Begunkov wrote:
> On 10/30/24 02:04, Ming Lei wrote:
> > On Wed, Oct 30, 2024 at 01:25:33AM +0000, Pavel Begunkov wrote:
> > > On 10/30/24 00:45, Ming Lei wrote:
> > > > On Tue, Oct 29, 2024 at 04:47:59PM +0000, Pavel Begunkov wrote:
> > > > > On 10/25/24 13:22, Ming Lei wrote:
> > > > > ...
> > > > > > diff --git a/io_uring/rw.c b/io_uring/rw.c
> > > > > > index 4bc0d762627d..5a2025d48804 100644
> > > > > > --- a/io_uring/rw.c
> > > > > > +++ b/io_uring/rw.c
> > > > > > @@ -245,7 +245,8 @@ static int io_prep_rw_setup(struct io_kiocb *req, int ddir, bool do_import)
> > > > > >     	if (io_rw_alloc_async(req))
> > > > > >     		return -ENOMEM;
> > > > > > -	if (!do_import || io_do_buffer_select(req))
> > > > > > +	if (!do_import || io_do_buffer_select(req) ||
> > > > > > +	    io_use_leased_grp_kbuf(req))
> > > > > >     		return 0;
> > > > > >     	rw = req->async_data;
> > > > > > @@ -489,6 +490,11 @@ static bool __io_complete_rw_common(struct io_kiocb *req, long res)
> > > > > >     		}
> > > > > >     		req_set_fail(req);
> > > > > >     		req->cqe.res = res;
> > > > > > +		if (io_use_leased_grp_kbuf(req)) {
> > > > > 
> > > > > That's what I'm talking about, we're pushing more and
> > > > > into the generic paths (or patching every single hot opcode
> > > > > there is). You said it's fine for ublk the way it was, i.e.
> > > > > without tracking, so let's then pretend it's a ublk specific
> > > > > feature, kill that addition and settle at that if that's the
> > > > > way to go.
> > > > 
> > > > As I mentioned before, it isn't ublk specific, zeroing is required
> > > > because the buffer is kernel buffer, that is all. Any other approach
> > > > needs this kind of handling too. The coming fuse zc need it.
> > > > 
> > > > And it can't be done in driver side, because driver has no idea how
> > > > to consume the kernel buffer.
> > > > 
> > > > Also it is only required in case of short read/recv, and it isn't
> > > > hot path, not mention it is just one check on request flag.
> > > 
> > > I agree, it's not hot, it's a failure path, and the recv side
> > > is of medium hotness, but the main concern is that the feature
> > > is too actively leaking into other requests.
> > The point is that if you'd like to support kernel buffer. If yes, this
> > kind of change can't be avoided.
> 
> There is no guarantee with the patchset that there will be any IO done
> with that buffer, e.g. place a nop into the group, and even then you

Yes, here it depends on user. In case of ublk, the application has to be
trusted, and the situation is same with other user-emulated storage, such
as qemu.

> have offsets and length, so it's not clear what the zeroying is supposed
> to achieve.

The buffer may bee one page cache page, if it isn't initialized
completely, kernel data may be leaked to userspace via mmap.

> Either the buffer comes fully "initialised", i.e. free of
> kernel private data, or we need to track what parts of the buffer were
> used.

That is why the only workable way is to zero the remainder in
consumer of OP, imo.


Thanks,
Ming

