Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B027DA8C
	for <linux-block@vger.kernel.org>; Mon, 17 Feb 2025 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739761916; cv=none; b=pIZd8URwMWzLXcRc12qYjRZhsq2f0Kg53e/P7TYyVxv1j4IoawDgh/Fgq5q2Kg/QIi6YA+e05Pm4YA/XL4jWz7wUueSOLvltf77dYzRNpCacJ1OI83VPyZy/fwDOlOP0qmWC1FNu4kTrjnotFQyRHSrat1vza9ZldrWTxdIpDKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739761916; c=relaxed/simple;
	bh=zdj8PBNcO24x4BLVgI+gKE9PUJt6AECQqoVz2EUT5gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etFEisWjXr9lhGGJlpPe9/B2BYxK2SLnKYRZed5ABnK8YvV9ih2aRimlnA1Gy0YSAvRaN7WzNwotuSJLWFu40IBunoKbMZou8RQhgAkxnVEsnm8rkfjwFz8nC9cW8cb8PNYw/Mrk2Gq152G8uHB1xViIxeq0IhLDWzWM/sJnYL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VtcJ6qtU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtcJ6qtU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739761913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rCyd4J4VY6/LQHKvoEAmmldsLHnA8M4H8IkwV3mSjjk=;
	b=VtcJ6qtUeIG0lxTv3XT+67q1Y38XwTQXmESBAQ3tzjcQBJIHIGPhHd0WWY3HNrSdZ43sHA
	uQqh1ODRFs9RX2DfOUQskWUmAMywKdrZj+v5puMZ+AzeiKS0YBma4n073nGLfti25iOR1Y
	YDyvhYQrYO86d5w9ABtu4Ajo0Gruf9c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-TpyMVAL_MZeJYIxFHPz95A-1; Sun,
 16 Feb 2025 22:11:49 -0500
X-MC-Unique: TpyMVAL_MZeJYIxFHPz95A-1
X-Mimecast-MFC-AGG-ID: TpyMVAL_MZeJYIxFHPz95A_1739761908
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2492180034A;
	Mon, 17 Feb 2025 03:11:47 +0000 (UTC)
Received: from fedora (unknown [10.72.120.19])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0AD31800352;
	Mon, 17 Feb 2025 03:11:43 +0000 (UTC)
Date: Mon, 17 Feb 2025 11:11:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Cheyenne Wills <cheyenne.wills@gmail.com>
Subject: Re: [PATCH] block: fix NULL pointer dereferenced within
 __blk_rq_map_sg
Message-ID: <Z7Ko6gCTKoHitPgT@fedora>
References: <20250214084638.58437-1-ming.lei@redhat.com>
 <20250214141010.GA24011@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214141010.GA24011@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Feb 14, 2025 at 03:10:10PM +0100, Christoph Hellwig wrote:
> On Fri, Feb 14, 2025 at 04:46:38PM +0800, Ming Lei wrote:
> > Discard request may use special payload only and doesn't have bio
> > attached, so the request iterator has to be initialized from valid
> > req->bio, otherwise NULL pointer dereferenced is triggered.
> 
> So while the code changes here look good to me, the commit message is
> wrong.  discard requests always have at least one bio attached, so we're
> not going to hit this condition.  Discard requests also aren't even
> handled by the function in Cheyenne's report.  I'm pretty sure this is
> a flush request, as these are the only non-passthrough requests without
> a bio.
> 
> > +	/* discard request may not have bio attached */
> > +	if (iter.bio)
> > +		iter.iter = iter.bio->bi_iter;
> 
> Same for the comment.
 
You are right, it should be the flush internal request, even though
mapping discard request may not need bio, I will fix the commit log and
comment.


Thanks,
Ming

