Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B724F23A6
	for <linux-block@vger.kernel.org>; Mon,  4 Nov 2024 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730679404; cv=none; b=VWVaHa0IlQxLwE/Jtn7Zsy2f+KVNHOSRyV/CkdMaCwsAyyqTO5ZAqViDf5JnHYlAi8fmSQDmES+buieeQ5+SxsirdK974eJd1OBIxUiC9MGaxQ/2Miz67b7JfNCGnOILnkEn2zS3pgjG8IKrFSFgukwfpQsgR9UacbL1TKXcRo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730679404; c=relaxed/simple;
	bh=M70eisBWpg3I71yZDIId/qycGuZkcss5v2Wba028nfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5+bUa6CyeMuHPFWigzZbsnojrxikYHqUlT6MOYruaQi9Pjt93WlC+CoLUp341FM0LPW8xJIBi9RmQicy2qNQCre+cbOZkwd743vnjMISJ6opKgxBEFRv6PYYDt6olmMviHCndIGGUfdHKMd5CEeffVvOQcNXbluxLluLKrrGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnW2Smh+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnW2Smh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730679401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CU3FDgB5ZlNOXOjll3ZLNJ02L4FVQ4xwcWvIa7+dE9Y=;
	b=AnW2Smh+uCFHcTj6HqJo6GSKY8EVa759A1GWmqRv8rk9aBW8zVXGGOWuypW/ggyDaEWTTH
	lggiaD1y+nSQINTpWdzl2Z1tg1Yk2CTVmX79z4UaouAl6Vc8N3lT2nqE80qxPjGIt2ahXg
	P4Ra7Yjy4VppmRmzvIdpaAWcasrgW+U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-jWLoHY0XNtORtVKXbFzj3Q-1; Sun,
 03 Nov 2024 19:16:38 -0500
X-MC-Unique: jWLoHY0XNtORtVKXbFzj3Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74B9219560AA;
	Mon,  4 Nov 2024 00:16:36 +0000 (UTC)
Received: from fedora (unknown [10.72.116.38])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E83F319560AD;
	Mon,  4 Nov 2024 00:16:30 +0000 (UTC)
Date: Mon, 4 Nov 2024 08:16:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>
Subject: Re: [PATCH V8 5/7] io_uring: support leased group buffer with
 REQ_F_GROUP_KBUF
Message-ID: <ZygSWB08t1PPyPyv@fedora>
References: <20241025122247.3709133-1-ming.lei@redhat.com>
 <20241025122247.3709133-6-ming.lei@redhat.com>
 <4576f723-5694-40b5-a656-abd1c8d05d62@gmail.com>
 <ZyGBlWUt02xJRQii@fedora>
 <bbf2612e-e029-460f-91cf-e1b00de3e656@gmail.com>
 <ZyGURQ-LgIY9DOmh@fedora>
 <40107636-651f-47ea-8086-58953351c462@gmail.com>
 <ZyQpH8ttWAhS9C5G@fedora>
 <4802ef4c-84ca-4588-aa34-6f1ffa31ac49@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4802ef4c-84ca-4588-aa34-6f1ffa31ac49@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Sun, Nov 03, 2024 at 10:31:25PM +0000, Pavel Begunkov wrote:
> On 11/1/24 01:04, Ming Lei wrote:
> > On Thu, Oct 31, 2024 at 01:16:07PM +0000, Pavel Begunkov wrote:
> > > On 10/30/24 02:04, Ming Lei wrote:
> > > > On Wed, Oct 30, 2024 at 01:25:33AM +0000, Pavel Begunkov wrote:
> > > > > On 10/30/24 00:45, Ming Lei wrote:
> > > > > > On Tue, Oct 29, 2024 at 04:47:59PM +0000, Pavel Begunkov wrote:
> > > > > > > On 10/25/24 13:22, Ming Lei wrote:
> > > > > > > ...
> > > > > > > > diff --git a/io_uring/rw.c b/io_uring/rw.c
> > > > > > > > index 4bc0d762627d..5a2025d48804 100644
> > > > > > > > --- a/io_uring/rw.c
> > > > > > > > +++ b/io_uring/rw.c
> > > > > > > > @@ -245,7 +245,8 @@ static int io_prep_rw_setup(struct io_kiocb *req, int ddir, bool do_import)
> > > > > > > >      	if (io_rw_alloc_async(req))
> > > > > > > >      		return -ENOMEM;
> > > > > > > > -	if (!do_import || io_do_buffer_select(req))
> > > > > > > > +	if (!do_import || io_do_buffer_select(req) ||
> > > > > > > > +	    io_use_leased_grp_kbuf(req))
> > > > > > > >      		return 0;
> > > > > > > >      	rw = req->async_data;
> > > > > > > > @@ -489,6 +490,11 @@ static bool __io_complete_rw_common(struct io_kiocb *req, long res)
> > > > > > > >      		}
> > > > > > > >      		req_set_fail(req);
> > > > > > > >      		req->cqe.res = res;
> > > > > > > > +		if (io_use_leased_grp_kbuf(req)) {
> > > > > > > 
> > > > > > > That's what I'm talking about, we're pushing more and
> > > > > > > into the generic paths (or patching every single hot opcode
> > > > > > > there is). You said it's fine for ublk the way it was, i.e.
> > > > > > > without tracking, so let's then pretend it's a ublk specific
> > > > > > > feature, kill that addition and settle at that if that's the
> > > > > > > way to go.
> > > > > > 
> > > > > > As I mentioned before, it isn't ublk specific, zeroing is required
> > > > > > because the buffer is kernel buffer, that is all. Any other approach
> > > > > > needs this kind of handling too. The coming fuse zc need it.
> > > > > > 
> > > > > > And it can't be done in driver side, because driver has no idea how
> > > > > > to consume the kernel buffer.
> > > > > > 
> > > > > > Also it is only required in case of short read/recv, and it isn't
> > > > > > hot path, not mention it is just one check on request flag.
> > > > > 
> > > > > I agree, it's not hot, it's a failure path, and the recv side
> > > > > is of medium hotness, but the main concern is that the feature
> > > > > is too actively leaking into other requests.
> > > > The point is that if you'd like to support kernel buffer. If yes, this
> > > > kind of change can't be avoided.
> > > 
> > > There is no guarantee with the patchset that there will be any IO done
> > > with that buffer, e.g. place a nop into the group, and even then you
> > 
> > Yes, here it depends on user. In case of ublk, the application has to be
> > trusted, and the situation is same with other user-emulated storage, such
> > as qemu.
> > 
> > > have offsets and length, so it's not clear what the zeroying is supposed
> > > to achieve.
> > 
> > The buffer may bee one page cache page, if it isn't initialized
> > completely, kernel data may be leaked to userspace via mmap.
> > 
> > > Either the buffer comes fully "initialised", i.e. free of
> > > kernel private data, or we need to track what parts of the buffer were
> > > used.
> > 
> > That is why the only workable way is to zero the remainder in
> > consumer of OP, imo.
> 
> If it can leak kernel data in some way, I'm afraid zeroing of the
> remainder alone won't be enough to prevent it, e.g. the recv/read
> len doesn't have to match the buffer size.

The leased kernel buffer size is fixed, and the recv/read len is known
in case of short read/recv, the remainder part is known too, so can you
explain why zeroing remainder alone isn't enough?



Thanks,
Ming

