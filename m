Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81CF211292
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440759; cv=none; b=CfrjfOW4ndw7IgZ4qKzAAtCTWx32N9uPjhd3XiGqKVTAD5C+vA2XkgqzZigVKfyzEL/JZP62CIJPHcpvocO9Klb9GyMzVl/jFYtcovW88FKZ5TzZakxm5AAh16uZfOGv4OYUgmsrJKos28yOrKN9Y+m0le7WOpGT/qB3UZRrGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440759; c=relaxed/simple;
	bh=3S+VaLUIycztkQ7kee8T4vPPub8pX5kczbBez29PCZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D87pXVUjl/Q5hDIJh0wopl3Z06Y2heIKlP2Iu1sFSjwbVgzgn/R2F6ohA5XGapYfQr4pIPo7YCrUQQ6lnv5BK5PKLWYfc746rZbV2hKhngTTydmq0mJ2Qt4l9HZYTpsct5YMImcSWr/Rq6riQkEKsrnUSlqbDktbKPOi9RhvceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WY9RFK6s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WY9RFK6s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739440755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=erE8onpccJmyx8G4Kp6YKUHaPmvGfEo6rtoZHiLg2Q8=;
	b=WY9RFK6s8YF9qLARjyTr8RXqiiJhZ87NrTtHy5cIz+AF20HafLmCX5tGl5MMcrOFi7+LAO
	G6mhYE9KaQoPHAe0NZztA5QlGqh3Nj5ECsjG787KlcSZGjyGKDH3Jl1q07CtHHJF4CxT3j
	gIk8VRmrDEgxFadapsP8NKyomHDLWds=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-0ta8TGazNcmqbHePOdG5TQ-1; Thu,
 13 Feb 2025 04:59:12 -0500
X-MC-Unique: 0ta8TGazNcmqbHePOdG5TQ-1
X-Mimecast-MFC-AGG-ID: 0ta8TGazNcmqbHePOdG5TQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BC0319373D8;
	Thu, 13 Feb 2025 09:59:11 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 552381955F0F;
	Thu, 13 Feb 2025 09:59:04 +0000 (UTC)
Date: Thu, 13 Feb 2025 17:58:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z63CY9rE7X8m3nmv@fedora>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <faf95365-5b55-40f6-82f8-195ccc3edb9e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faf95365-5b55-40f6-82f8-195ccc3edb9e@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Feb 13, 2025 at 08:45:18AM +0000, John Garry wrote:
> On 10/02/2025 09:03, Ming Lei wrote:
> > PAGE_SIZE is applied in some block device queue limits, this way is
> > very fragile and is wrong:
> > 
> > - queue limits are read from hardware, which is often one readonly
> > hardware property
> > 
> > - PAGE_SIZE is one config option which can be changed during build time.
> > 
> > In RH lab, it has been found that max segment size of some mmc card is
> > less than 64K, then this kind of card can't work in case of 64K PAGE_SIZE.
> > 
> > Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
> > with queue limits and checking if bio needn't split. Define BLK_MIN_SEGMENT_SIZE
> > as 4K(minimized PAGE_SIZE).
> 
> Please note that blk_queue_max_quaranteed_bio() for atomic writes assumes
> that we can fit a PAGE_SIZE in a segment. I suppose that if the
> max_segment_size < PAGE_SIZE is supported, then the calculation there needs
> to change.

It isn't related with blk_queue_max_guaranteed_bio() which calculates the max
allowed ubuf bytes which can fit in a bio, so PAGE_SIZE has to be used here.

BLK_MIN_SEGMENT_SIZE is just one hint which can be used to check if one
bvec can fit in single segment quickly, otherwise the normal split code
path is run into.


Thanks,
Ming

