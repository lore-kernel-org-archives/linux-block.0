Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36C4C70
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730249128; cv=none; b=Ra3ZeuhDQ8nTEh8/QDPKVJsDdQn2yBZNVOOtr4agX0QwqnA5DgYDkEm4lYA5MoM0JaP69fvVDgrmlLIrTnjQTuXrjRusx5gpW9gZedWnOhWofeuzSbAmdRbnR6USGxH5ScDjM97OIKh4cbIUE/7kcbnwxgSZttJqo4YxKAuTkvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730249128; c=relaxed/simple;
	bh=q0XgTlrNtBGGrXXeNoFe11wWPBxeRiPJvn/YRW2CroA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/QlMqlLl+t0YWcKBihycMmVAczocNwD8XMyoTwt+bR9UdrSxnELrQAE5ubHVmJbtVXWo4MWJR0K+VdcPOwEJHFwyPVDmETiKpvv1v2VmT/vtLQKt5f/Kb602jRplEGFE3G9tMG2v1jK+QL58MsWKllH1zI5nvbR4qxv8RiHKIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWse4DKM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWse4DKM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730249124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FUQbGHE89Tjuuzon/UFuhihO7l7z+hPsgybfAFogew8=;
	b=LWse4DKM+out1JuYvy5ohrALkuEZ8S2g03cTRdKssV+L4ARVYiZaNtGcYkNr80W+JQlz49
	h/xeI7Y1bEBoNpHi4ifdkiWgfQuphis88Ob+m48h7CCrOTkZGkVrxmhbls3XE/BZIVKfs3
	Oqh+Z65r324btysVhE8v2ZMOKHVwDSI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-01mQZ12jNkqoKHpDuTsjSQ-1; Tue,
 29 Oct 2024 20:45:20 -0400
X-MC-Unique: 01mQZ12jNkqoKHpDuTsjSQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E07A195608A;
	Wed, 30 Oct 2024 00:45:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.45])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EFFB1956088;
	Wed, 30 Oct 2024 00:45:14 +0000 (UTC)
Date: Wed, 30 Oct 2024 08:45:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>
Subject: Re: [PATCH V8 5/7] io_uring: support leased group buffer with
 REQ_F_GROUP_KBUF
Message-ID: <ZyGBlWUt02xJRQii@fedora>
References: <20241025122247.3709133-1-ming.lei@redhat.com>
 <20241025122247.3709133-6-ming.lei@redhat.com>
 <4576f723-5694-40b5-a656-abd1c8d05d62@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4576f723-5694-40b5-a656-abd1c8d05d62@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Oct 29, 2024 at 04:47:59PM +0000, Pavel Begunkov wrote:
> On 10/25/24 13:22, Ming Lei wrote:
> ...
> > diff --git a/io_uring/rw.c b/io_uring/rw.c
> > index 4bc0d762627d..5a2025d48804 100644
> > --- a/io_uring/rw.c
> > +++ b/io_uring/rw.c
> > @@ -245,7 +245,8 @@ static int io_prep_rw_setup(struct io_kiocb *req, int ddir, bool do_import)
> >   	if (io_rw_alloc_async(req))
> >   		return -ENOMEM;
> > -	if (!do_import || io_do_buffer_select(req))
> > +	if (!do_import || io_do_buffer_select(req) ||
> > +	    io_use_leased_grp_kbuf(req))
> >   		return 0;
> >   	rw = req->async_data;
> > @@ -489,6 +490,11 @@ static bool __io_complete_rw_common(struct io_kiocb *req, long res)
> >   		}
> >   		req_set_fail(req);
> >   		req->cqe.res = res;
> > +		if (io_use_leased_grp_kbuf(req)) {
> 
> That's what I'm talking about, we're pushing more and
> into the generic paths (or patching every single hot opcode
> there is). You said it's fine for ublk the way it was, i.e.
> without tracking, so let's then pretend it's a ublk specific
> feature, kill that addition and settle at that if that's the
> way to go.

As I mentioned before, it isn't ublk specific, zeroing is required
because the buffer is kernel buffer, that is all. Any other approach
needs this kind of handling too. The coming fuse zc need it.

And it can't be done in driver side, because driver has no idea how
to consume the kernel buffer.

Also it is only required in case of short read/recv, and it isn't
hot path, not mention it is just one check on request flag.


Thanks,
Ming

