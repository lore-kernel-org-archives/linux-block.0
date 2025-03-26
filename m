Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D8CCA6F
	for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742956212; cv=none; b=Mk5M7xpytVA1mtQQw0qsPx9n/Qub9tuOEZfedGntW1McgH6H2hw2T8Isxc+gac65bv6gMdIlUeEXjTBA+QCHChnkRR9chWrPsLTKAUNBvfaM2PwtKr91i1KO96r6YTjjQKJYXbTjgdhY3lAgEAAAq9Ggot4oHDrAUnRZ0Eisiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742956212; c=relaxed/simple;
	bh=BB6InFm+Wb5J+xuQEUVhRz39dzYbkrwiWbOQQKmhUDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSi2nDNx8AGpeAvNqajPW+eUhGkjqBwZ+vu3p9R2BHhUfEkxfF6IQuPM0l1kI1KL4uGF91WYJXqOXLz11wW7a8ZX9iynnxB8jXlw9NI8iTEEoqwZ2za6FsH/ijooGCsOIkrYYAclJDUrdFANzAm9m9O3EUF05zJqJkAgyob+0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oebyna6c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oebyna6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742956209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XUNfhjGEnAXBDXFqJZEdYI8Bv9K/iV26/NoSgJWeIc4=;
	b=Oebyna6c9sVkS1MIN0QZc1QoX7bfWKHS9WCgafebufvu02ILgsrytxqXtrHqIf8jbgXMKU
	RkHvyp+yLgeokVnKYBbxzDad3yxs9JIZGjCLq6oo0DskzEs1bONW9ibT19+7/Fuj+iR9jc
	Td0eX0p4TVRklw6VTJCfg06P8JdSdqc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-BfqBvzdRNJKVXcBwbTWZOA-1; Tue,
 25 Mar 2025 22:30:05 -0400
X-MC-Unique: BfqBvzdRNJKVXcBwbTWZOA-1
X-Mimecast-MFC-AGG-ID: BfqBvzdRNJKVXcBwbTWZOA_1742956204
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4472B180035C;
	Wed, 26 Mar 2025 02:30:04 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BC8530001A1;
	Wed, 26 Mar 2025 02:29:59 +0000 (UTC)
Date: Wed, 26 Mar 2025 10:29:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 5/8] ublk: document zero copy feature
Message-ID: <Z-NmobqY9C4o8ESL@fedora>
References: <20250324134905.766777-1-ming.lei@redhat.com>
 <20250324134905.766777-6-ming.lei@redhat.com>
 <CADUfDZquEOA7ckJVkBbcso2Paw9viSa9-5eQptgRgQRoxgvVqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZquEOA7ckJVkBbcso2Paw9viSa9-5eQptgRgQRoxgvVqA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Mar 25, 2025 at 08:26:18AM -0700, Caleb Sander Mateos wrote:
> On Mon, Mar 24, 2025 at 6:49 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add words to explain how zero copy feature works, and why it has to be
> > trusted for handling IO read command.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  Documentation/block/ublk.rst | 28 ++++++++++++++++++++--------
> >  1 file changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> > index 1e0e7358e14a..33efff25b54d 100644
> > --- a/Documentation/block/ublk.rst
> > +++ b/Documentation/block/ublk.rst
> > @@ -309,18 +309,30 @@ with specified IO tag in the command data:
> >    ``UBLK_IO_COMMIT_AND_FETCH_REQ`` to the server, ublkdrv needs to copy
> >    the server buffer (pages) read to the IO request pages.
> >
> > -Future development
> > -==================
> > -
> >  Zero copy
> >  ---------
> >
> > -Zero copy is a generic requirement for nbd, fuse or similar drivers. A
> > -problem [#xiaoguang]_ Xiaoguang mentioned is that pages mapped to userspace
> > -can't be remapped any more in kernel with existing mm interfaces. This can
> > -occurs when destining direct IO to ``/dev/ublkb*``. Also, he reported that
> > -big requests (IO size >= 256 KB) may benefit a lot from zero copy.
> > +ublk zero copy relies on io_uring's fixed kernel buffer, which provides
> > +two APIs: `io_buffer_register_bvec()` and `io_buffer_unregister_bvec`.
> 
> nit: missing parentheses after io_buffer_unregister_bvec

OK

> 
> > +
> > +ublk adds IO command of `UBLK_IO_REGISTER_IO_BUF` to call
> > +`io_buffer_register_bvec()` for ublk server to register client request
> > +buffer into io_uring buffer table, then ublk server can submit io_uring
> > +IOs with the registered buffer index. IO command of `UBLK_IO_UNREGISTER_IO_BUF`
> > +calls `io_buffer_unregister_bvec` to unregister the buffer.
> 
> Parentheses missing here too.
> It might be worth adding a note that the registered buffer and any I/O
> that uses it will hold a reference on the ublk request. For a ublk
> server implementer, I think it's useful to know that the buffer needs
> to be unregistered in order to complete the ublk request, and that the
> zero-copy I/O won't corrupt any data even if it completes after the
> buffer is unregistered.

Good point, how about the following words?

```
The ublk client IO request buffer is guaranteed to be live between calling
`io_buffer_register_bvec()` and `io_buffer_unregister_bvec()`.

And any io_uring operation which supports this kind of kernel buffer will
grab one reference of the buffer until the operation is completed.
```

> 
> > +
> > +ublk server implementing zero copy has to be CAP_SYS_ADMIN and be trusted,
> > +because it is ublk server's responsibility to make sure IO buffer filled
> > +with data, and ublk server has to handle short read correctly by returning
> > +correct bytes filled to io buffer. Otherwise, uninitialized kernel buffer
> > +will be exposed to client application.
> 
> This isn't specific to zero-copy, right? ublk devices configured with
> UBLK_F_USER_COPY also need to initialize the full request buffer. I

Right, but it is important for zero copy.

> would also drop the "handle short read" part; ublk servers don't
> necessarily issue read operations in the backend, so "short read" may
> not be applicable.

Here 'read' in 'short read' means ublk front READ command, not actual read
done in ublk server. Maybe we can make it more accurate:

```
..., and ublk server has to return correct result to ublk driver when handling
READ command, and the result has to match with how many bytes filled to the IO
buffer. Otherwise, uninitialized kernel IO buffer will be exposed to client
application.
```

Thanks,
Ming

