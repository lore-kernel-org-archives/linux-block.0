Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9453BD64A
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773857215; cv=none; b=oh5ndB769/sUif3Yg/n60AEGER2kH5flg9MOqV6HFTz0+RGcpsUR3YNb20tuWbHg+Ssh8CIgVOg6nJi9vTrmxAvti/NxzIQmOUYxU2p0dM91VgF3IsVZ2xqy98xcB//iCXGddUjxwUzUQXFJL7vBceQZUsbMPQJnwgoW79hO6pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773857215; c=relaxed/simple;
	bh=tEYF0yvthI/+Lf8MlJS/wDa5hneK7VkFUrpLokYmFGo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FjGy4H7eRsOkEwbI7d3W0xHT6+bb6r/mQtDUBQr2EjQyvboBMlbgqrl7hAeGoIlNtpwAoYVwxVYTsy3n7MNekTBUcq/0C8ihDkSqHZHzW6UZAgcpqm4NcEAbPtCWsGmZE9ysanKw4ctHHtsKcKJ4E+LsyWgieT2k9AF/UMwLl9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jA5i2cil; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jA5i2cil"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773857210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LzVIxmpj+TIYO8Kbw1Gwzf+/rLM6UFMM2sXllLu1dO0=;
	b=jA5i2cilajtrKDi55WCczTLI9eS4WE1JVVdpceVLTLsDxtCWl6PQ9bG9fmAH2unwtkVx41
	POjZBXmxDEb8czbReLnmVUKbB8J5VCLHrwk26UxL9uXeTVxBOoXkFDm59lQfAjQP0spbEm
	9ZDT5zjQx3Sz91jq6ngUxVcTumRngyk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-BexQdf-UPH6zP41LlFrdYw-1; Wed,
 18 Mar 2026 14:06:49 -0400
X-MC-Unique: BexQdf-UPH6zP41LlFrdYw-1
X-Mimecast-MFC-AGG-ID: BexQdf-UPH6zP41LlFrdYw_1773857208
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E43251944F12;
	Wed, 18 Mar 2026 18:06:47 +0000 (UTC)
Received: from [10.44.32.29] (unknown [10.44.32.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73B981800351;
	Wed, 18 Mar 2026 18:06:46 +0000 (UTC)
Date: Wed, 18 Mar 2026 19:06:40 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Keith Busch <kbusch@kernel.org>
cc: Keith Busch <kbusch@meta.com>, dm-devel@lists.linux.dev, 
    linux-block@vger.kernel.org, snitzer@kernel.org
Subject: Re: [RESEND PATCHv3 1/2] dm-crypt: allow unaligned bio_vecs for
 direct io
In-Reply-To: <abrjgdttXBHCFh34@kbusch-mbp>
Message-ID: <fa0978af-398b-a212-73bc-80f0f2c375a4@redhat.com>
References: <20260316150229.1771884-1-kbusch@meta.com> <7cc4892a-5a2f-09b7-1f32-320acac4c797@redhat.com> <abrjgdttXBHCFh34@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On Wed, 18 Mar 2026, Keith Busch wrote:

> On Wed, Mar 18, 2026 at 05:19:39PM +0100, Mikulas Patocka wrote:
> > On Mon, 16 Mar 2026, Keith Busch wrote:
> > > +	if (!unaligned_allowed) {
> > > +		cc->io_alignment = cc->sector_size - 1;
> > > +	} else {
> > > +		set_bit(CRYPT_DISCONTIGUOUS_SEGS, &cc->cipher_flags);
> > > +		cc->io_alignment = 3;
> > > +	}
> > >  	return 0;
> > >  }
> > 
> > Why is "3" there? Should there be the dma_alignment of the underlying 
> > block device instead?
> 
> It doesn't matter what the underlying block device reports because
> dm-crypt bounces the incoming plain text buffers to something aligned to
> the backing device for the cypher text.

dm-crypt bounces writes, but doesn't bounce reads. When doing reads, it 
reads the data into the target buffer and decompresses them in place.

So, it must respect the alignment provided by the underlying device.

> Why 3? This can theoretically do 0, but you can't express that as a
> block limit; block layer will assume you didn't set anything and use a
> 511 default, which is exactly what I don't want. So why not 1 instead of
> 3? Three is the smallest non-zero cra_alignmask currently reported, and
> its inefficient to do byte aligned direct io anyway.
>  
> > > --- a/drivers/md/dm-table.c
> > > +++ b/drivers/md/dm-table.c
> > > @@ -1767,6 +1767,7 @@ int dm_calculate_queue_limits(struct dm_table *t,
> > >  	bool zoned = false;
> > >  
> > >  	dm_set_stacking_limits(limits);
> > > +	limits->dma_alignment = 0;
> > >  
> > >  	t->integrity_supported = true;
> > >  	for (unsigned int i = 0; i < t->num_targets; i++) {
> > 
> > dm-integrity doesn't set dma_alignment if it is using 512-byte sector size 
> > (assuming that there is default 511). This should be fixed in dm-integrity 
> > before making this change.
> > 
> > Other device mapper targets should also be reviewed to make sure that this 
> > change doens't break them.
> 
> The previous call to dm_set_stacking_limits() sets it to 511, which sets
> an unnecessary minimum. Setting it to 0 here means that the stacked
> device will inhereit whatever the mapper overrides it to, or go back to
> 511 if it decides not to override it.

If we have dm-integrity with 512-byte sector size on the top of a device 
that has dma_alignment less than 512, the code would set 
limits->dma_alignment to the value of the underlying block device and 
break dm-integrity (which assumes sector-aligned bios).

But that's a problem of dm-integrity - this "if (ic->sectors_per_block > 
1)" condition in dm_integrity_io_hints is weird, it should be dropped and 
the limits should be properly merged.

Mikulas

