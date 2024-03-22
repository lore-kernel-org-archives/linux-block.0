Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0265C
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711070490; cv=none; b=AkNBpET1FmXANjeFffZebbVNDgnFbU9ntHHJGEnwvjvDr+CZhnT9C5l5iwGLcNdyfeJClmW/RDxcQFz9upGNHh6MJvovsC/y4UshLUeg5TUrBOQt6PhU03ritGtw+No5qFinzY8i/sLMQEbWXxMs2b9ii7024OC2PV26huHih+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711070490; c=relaxed/simple;
	bh=YGNVdORwpQi/+93UXBQc1hMFfSzhzPM5oL3USVs0+qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XetP1YhybP7IDlK2IIlUYZXWfmSO2gcvaAH2h08/SUdW8EvhG6GRoGAOA114jF1jre00eOY1kdFUMKeH3oO/RebcxA3KAz3aN417tLW2Vz4QZ74lgJBcy/PfnEHNMGKOUTvYKyEmGQ6nNKJ7WMyrFpb8MagiAaRJY3C+ujpQ9ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QUv+2Vx5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUv+2Vx5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711070486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2B4cvkmMJZA4lnV7u+9f9U+OxA8vbIJymOguPmjFCro=;
	b=QUv+2Vx5i/guyK7JfFrEgD27LHXtXPb27OL91ehzOCogKp8A5gHNyPcd1St0LCx287qbjF
	gKBaNoXxSY5uukwg+7XkM4isgw0wOjBBvvJ6M+t3posyqA6mx3++JWeFEAl67aeyHI4CVY
	SZytOJRVG0png4ry9fThcQYkMbpwbnM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-V8T8JoryOyyNou1Au5oQOw-1; Thu,
 21 Mar 2024 21:21:21 -0400
X-MC-Unique: V8T8JoryOyyNou1Au5oQOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39A843C025C9;
	Fri, 22 Mar 2024 01:21:21 +0000 (UTC)
Received: from fedora (unknown [10.72.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D3985C1576F;
	Fri, 22 Mar 2024 01:21:17 +0000 (UTC)
Date: Fri, 22 Mar 2024 09:21:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH] block: fail unaligned bio from submit_bio_noacct()
Message-ID: <ZfzdA9HpwvpCWQny@fedora>
References: <20240321131634.1009972-1-ming.lei@redhat.com>
 <979af2db-7482-4123-8a8b-e0354eb0bd45@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <979af2db-7482-4123-8a8b-e0354eb0bd45@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Thu, Mar 21, 2024 at 11:09:25AM -0600, Jens Axboe wrote:
> On 3/21/24 7:16 AM, Ming Lei wrote:
> > For any bio with data, its start sector and size have to be aligned with
> > the queue's logical block size.
> > 
> > This rule is obvious, but there is still user which may send unaligned
> > bio to block layer, and it is observed that dm-integrity can do that,
> > and cause double free of driver's dma meta buffer.
> > 
> > So failfast unaligned bio from submit_bio_noacct() for avoiding more
> > troubles.
> > 
> > Cc: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: Mike Snitzer <snitzer@kernel.org>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-core.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index a16b5abdbbf5..b1a10187ef74 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -729,6 +729,20 @@ void submit_bio_noacct_nocheck(struct bio *bio)
> >  		__submit_bio_noacct(bio);
> >  }
> >  
> > +static bool bio_check_alignment(struct bio *bio, struct request_queue *q)
> > +{
> > +	unsigned int bs = q->limits.logical_block_size;
> > +	unsigned int size = bio->bi_iter.bi_size;
> > +
> > +	if (size & (bs - 1))
> > +		return false;
> > +
> > +	if (size && ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & (bs - 1)))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  /**
> >   * submit_bio_noacct - re-submit a bio to the block device layer for I/O
> >   * @bio:  The bio describing the location in memory and on the device.
> > @@ -780,6 +794,9 @@ void submit_bio_noacct(struct bio *bio)
> >  		}
> >  	}
> >  
> > +	if (WARN_ON_ONCE(!bio_check_alignment(bio, q)))
> > +		goto end_io;
> > +
> >  	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> >  		bio_clear_polled(bio);
> 
> Where is this IO coming from? The normal block level dio has checks. And
> in fact they are expensive... If we add this one, then we should be able
> to kill the block/fops.c checks, no?

I think Most of fs code should send good bio since I didn't trigger it in
xfstests.

But we still have md, dm, bcache and target code which build bio in
their way. The reported issue is from device mapper integrity code.

Yes, all (offset & size) alignment in fops.c shouldn't be needed any more.


Thanks,
Ming

