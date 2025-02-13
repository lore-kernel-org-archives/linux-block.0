Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E51227E88
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446402; cv=none; b=D3rvG8kySIefX36FovWto6OhJHREswpZuoH3jAuJ2ZmbY1MRq4l6y7dYrP6F/D2Kr1XWhPjrc/GtlzFyg120GHSQOPSvB4cn1QBOYdWAIUxzc/2k+Lx8OsZI7uZCtUnVuegh50AZBF4r07/geVNdUvMLumH/+WdyVbpDdBOMee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446402; c=relaxed/simple;
	bh=yY2ak2RRSOCqruJMGedSSSKgTQkMSO7HPzXLWTjV2/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy9VFdbYY7c3hh+4erL+Vu3a0J3+M7yQxVCp0J9RebRxW4ISgi1s8SSckjYPzMpxfZ3r1MCleE41wHNr1itiFJOh7z/FeNB4yh8oZmyTaqra1IKoTQRascbIjfzhc+Q67kw8sPvaB4MWrfO6zt8+rsbMYBzeYPsLgNzO2UelEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqh1U9v4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqh1U9v4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739446399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YYR/EZuX7OQ9G+tRxldUfliNmD5WOCr+3NEZU9sxYu8=;
	b=bqh1U9v4yHke/9p17mQn7lFfguXT0zAfDqdCqLXZfg1mbB6jAfMrYZCHKJZ81WCcMvGAv2
	7jAlAR7+seYnBhfhYeAiJhoVb4sOCop/xBOGQM9CTBE9I57KWFLSthhK0ObIyI8Mp3ouBi
	8hOITTBekubyga9aLXWWPlIVn6zoPPM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-_xJ9x_IhMqiMdH0QtMeTLw-1; Thu,
 13 Feb 2025 06:33:16 -0500
X-MC-Unique: _xJ9x_IhMqiMdH0QtMeTLw-1
X-Mimecast-MFC-AGG-ID: _xJ9x_IhMqiMdH0QtMeTLw_1739446394
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA17918EB2C6;
	Thu, 13 Feb 2025 11:33:14 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F9C01800352;
	Thu, 13 Feb 2025 11:33:08 +0000 (UTC)
Date: Thu, 13 Feb 2025 19:33:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z63Yb9_wvjqLbg47@fedora>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <faf95365-5b55-40f6-82f8-195ccc3edb9e@oracle.com>
 <Z63CY9rE7X8m3nmv@fedora>
 <63bdc82a-fa01-44ae-9142-2cb649d34fb7@oracle.com>
 <Z63K99wkFLWqIfxW@fedora>
 <80fb598a-ed65-4e6f-9781-7742086a1d19@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80fb598a-ed65-4e6f-9781-7742086a1d19@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Feb 13, 2025 at 11:12:07AM +0000, John Garry wrote:
> On 13/02/2025 10:35, Ming Lei wrote:
> > > > BLK_MIN_SEGMENT_SIZE is just one hint which can be used to check if one
> > > > bvec can fit in single segment quickly, otherwise the normal split code
> > > > path is run into.
> > > So consider we have PAGE_SIZE > 4k and max_segment_size=4k, if an iovec has
> > > PAGE_SIZE then a bvec can also have PAGE_SIZE but then we need to split into
> > > multiple segments, right?
> > Yes, hardware limit needs to be respected.
> > 
> > Looks one write atomic application trouble in case of 64K page size,
> > and it can't work w/wo this patchset.
> 
> I think that we need to take max_segment_size into account in
> blk_queue_max_guaranteed_bio(), like:
> 
> static unsigned int blk_queue_max_guaranteed_bio(struct queue_limits *lim)
> {
> 	unsigned int max_segments = min(BIO_MAX_VECS, lim->max_segments);
> 	unsigned int length;
> 
> 	length = min(max_segments, 2) * lim->logical_block_size;
> 	if (max_segments > 2)
> 		length += (max_segments - 2) * min(PAGE_SIZE, lim->max_segment_size);
> 
> 	return length;
> }
> 
> Note that blk_queue_max_guaranteed_bio() is only really relevant to dio, so
> assumes that the iov_iter follows the bdev dio rules

It can't work because ITER_UBUF from pwritev2(iovcnt=1) is virtually-contiguous,
and the middle segment size has to be PAGE_SIZE.


Thanks,
Ming

