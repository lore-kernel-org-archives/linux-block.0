Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4D11DF754
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747966250; cv=none; b=YXAN/66NbK1vhdt4Xcfr2PPI/QdPDmQbwmVf4NS1tC5RP/0ZvWi571bWOkmUNIrYd6tfHbwgQ6Rg9mznNGbExRTnIHuysaIiJqiRAH7AbhckG9wVM9XEECwnh2QqP7Lfo4BL8wg67pUfdKdmpDI3H14Hb8xoZcGu6W8IuNrBU/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747966250; c=relaxed/simple;
	bh=WScc3Jb3venQUdG3A3pwXOXbFu+pfD8ipZw5q1RUaEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNO3prHfp34iQQSZVP/D3acR0y4mt4eSlyI+nCg/JlK/KFnki15Mu0b2V1mC3S6hmFG1cgaYMWlBlOzMuXMiQboS++pq4VhDPDOZ2W1s17dp0cYdxaXeyoajXsZ5HOtFBVGYryDXVPMSJI7vy15zyHpBvNb8Sq0Ca6vJtlfvoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmrllPoh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmrllPoh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747966245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZD21kWlXVkCXTQ6qIIyjvZ+QVrc2Nl+Bw+5u37lzorw=;
	b=NmrllPohRIAl/GbKjUFrYpdXGaaWBBXfgyemBTVqNBcB1p+lXqC5rYni6eEZLpODr0jtzR
	NkU4QpRjLRQG5wxpX8GVCeDZMqt25QjK6LS84jAd0AIRmUejOSePRMYfKi0+utisGVxprw
	yJhz0ItRiXuEXltFf3qE3bW0gyJXx0w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-UNJrGfp4OYGpALiuVO3ung-1; Thu,
 22 May 2025 22:10:41 -0400
X-MC-Unique: UNJrGfp4OYGpALiuVO3ung-1
X-Mimecast-MFC-AGG-ID: UNJrGfp4OYGpALiuVO3ung_1747966239
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14EB9195608A;
	Fri, 23 May 2025 02:10:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.55])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F185D19560AD;
	Fri, 23 May 2025 02:10:33 +0000 (UTC)
Date: Fri, 23 May 2025 10:10:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>, stable@vger.kernel.org
Subject: Re: [PATCH] block: Fix a deadlock related freezing zoned storage
 devices
Message-ID: <aC_ZFIICdxzSOxCt@fedora>
References: <20250522171405.3239141-1-bvanassche@acm.org>
 <b1ea4120-e16a-47c8-b10c-ff6c9d5feb69@kernel.dk>
 <78244478-3ce3-4671-b28f-c67c5b21dba9@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78244478-3ce3-4671-b28f-c67c5b21dba9@acm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, May 22, 2025 at 11:32:58AM -0700, Bart Van Assche wrote:
> On 5/22/25 10:38 AM, Jens Axboe wrote:
> > On 5/22/25 11:14 AM, Bart Van Assche wrote:
> > >   static void __submit_bio(struct bio *bio)
> > >   {
> > >   	/* If plug is not used, add new plug here to cache nsecs time. */
> > > @@ -633,8 +640,12 @@ static void __submit_bio(struct bio *bio)
> > >   	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
> > >   		blk_mq_submit_bio(bio);
> > > -	} else if (likely(bio_queue_enter(bio) == 0)) {
> > > +	} else {
> > >   		struct gendisk *disk = bio->bi_bdev->bd_disk;
> > > +		bool zwp = bio_zone_write_plugging(bio);
> > > +
> > > +		if (unlikely(!zwp && bio_queue_enter(bio) != 0))
> > > +			goto finish_plug;
> > >   	
> > >   		if ((bio->bi_opf & REQ_POLLED) &&
> > >   		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
> > > @@ -643,9 +654,12 @@ static void __submit_bio(struct bio *bio)
> > >   		} else {
> > >   			disk->fops->submit_bio(bio);
> > >   		}
> > > -		blk_queue_exit(disk->queue);
> > > +
> > > +		if (!zwp)
> > > +			blk_queue_exit(disk->queue);
> > >   	}
> > 
> > This is pretty ugly, and I honestly absolutely hate how there's quite a
> > bit of zoned_whatever sprinkling throughout the core code. What's the
> > reason for not unplugging here, unaligned writes? Because you should
> > presumable have the exact same issues on non-zoned devices if they have
> > IO stuck in a plug (and doesn't get unplugged) while someone is waiting
> > on a freeze.
> > 
> > A somewhat similar case was solved for IOPOLL and queue entering. That
> > would be another thing to look at. Maybe a live enter could work if the
> > plug itself pins it?
> 
> Hi Jens,
> 
> q->q_usage_counter is not increased for bios on current->plug_list.
> q->q_usage_counter is increased before a bio is added to the zoned pluglist.
> So these two cases are different.
> 
> I think it is important to hold a q->q_usage_counter reference for bios
> on the zoned plug list because bios are added to that list after bio
> splitting happened. Hence, request queue limits must not change while
> any bio is on the zoned plug list.

Hi Bart,

Can you share why request queue limit can't be changed after bio is added
to zoned plug list?

If it is really true, we may have to drain zoned plug list when freezing
queue.


Thanks, 
Ming

