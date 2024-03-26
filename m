Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31861BF58
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711416169; cv=none; b=oQHfm5+7kP03DDKQgQGjiCpA9zPue1OS9E9zGBvZW7Jr5a6S3KNtDmivjOTDXC8852P981ghZbDJHtdMJBTd+LBIMoGmS78zRBq+WBDovQ7l5Z6Vjkdc7bNkkfER6cawEYIqxE4hNHSkzBBBlhAu+Vxn1bzONssA08HgRjyvVd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711416169; c=relaxed/simple;
	bh=vgQZ3yjUewCRYrY/j0eHbaeJw1mz7/45AxfhGRnhHdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEexGSHjR4dnOKijXoiClTk2DePHH47A1BB+bP4evG1US1wBdW1iM/BGPZovcn240MU6dQsWKOsjmZO7Ds/o4zz1KwJY5jBSgEw9phnT5OYp5fOZ/h0KfazubHoG1gKxNikjAB2zcpG6TedJO3Ivf1Ohy5N5sHBijDdwK2qayjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+KOdO+9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+KOdO+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711416166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UvfuAQTTOiQMx/vnRRNva/46dbVDIdYjctczJ5I6R88=;
	b=g+KOdO+9qtS2h8Zvx73fQHEVEc6+1PxdWJdSr28FRQpyPsPyy4JIgnHqlmE99VwNAiY1Fa
	lj9oH2sNMO7tPEqnR7r5srbOcY5fVpgbN6tT0H3jznpO6DyiYrBojGLmTS7qFF077IsFsp
	aTE5aV1x9y1wOR8xKqUF81pGhdzTDww=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-OzgONVgxM0uRrqNt6Xpgsg-1; Mon, 25 Mar 2024 21:20:00 -0400
X-MC-Unique: OzgONVgxM0uRrqNt6Xpgsg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4DA580190B;
	Tue, 26 Mar 2024 01:19:59 +0000 (UTC)
Received: from fedora (unknown [10.72.116.60])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D1F8C492BD3;
	Tue, 26 Mar 2024 01:19:55 +0000 (UTC)
Date: Tue, 26 Mar 2024 09:19:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH V2] block: fail unaligned bio from submit_bio_noacct()
Message-ID: <ZgIis4gzth7iCjJf@fedora>
References: <20240324133702.1328237-1-ming.lei@redhat.com>
 <ZgHIOUpZB78uVxAm@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHIOUpZB78uVxAm@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Mon, Mar 25, 2024 at 11:53:45AM -0700, Keith Busch wrote:
> On Sun, Mar 24, 2024 at 09:37:02PM +0800, Ming Lei wrote:
> > @@ -780,6 +793,9 @@ void submit_bio_noacct(struct bio *bio)
> >  		}
> >  	}
> >  
> > +	if (WARN_ON_ONCE(!bio_check_alignment(bio, q)))
> > +		goto end_io;
> > +
> 
> The "status" at this point is "BLK_STS_IOERR", so user space would see
> EIO, but the existing checks return EINVAL. I'm not sure if that's "ok",
> but assuming it is, I think the user visible different behavior should
> be mentioned in the changelog.
> 
> Alternatively, maybe we want an asynchronous way to return EINVAL for

It has to be async way to return it because submit_bio*() returns
void.

> these conditions. It's more informative to a user where the problem is
> than a generic EIO. There is no BLK_STS_ value that translates to
> EINVAL, though, so maybe we need a new block status code like
> BLK_STS_INVALID_REQUEST.

Yeah, I agree, but that is one existed issue. The 'status' should have
been initialized as 'BLK_STS_INVALID_REQUEST' or 'BLK_STS_INVALID' in
submit_bio_noacct(), and all check failure can be thought as -EINVAL.


Thanks, 
Ming

