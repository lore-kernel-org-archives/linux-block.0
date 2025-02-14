Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5C71EA91
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537532; cv=none; b=e1ByAEbhA74HhWeZcgtXRd61Nzky/NWISohQOsy1HhXxLYxocAK9sl1c97dYtNzyf+P8ooYw7AfUdB/HJaceWDzHZrMWDbqxnk8swF9WRkT5Fw5SMNvF6+nVUSeNWaOy/1ktCRG51e1uzxRlbjL23qWOQM2Tem7zulOuDp+78GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537532; c=relaxed/simple;
	bh=Bg0Fy/u2XUYgt7JPhAjYM3tJ+fjEiCRChCCPXQGELQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBfF7ELJTHQ+myC/GwGGqi+2l7P+uwRnjZZQLyOznLYTdlIj6KXSf72jNjqYoLYUYPe/xF/nvl4ET0TzyoHgW8I8yc6TU65FWaoGi/Ik97ebfzJctQi8HoEhlC0/WPlueDBsqzTtQ+JIN8PaoxI4JbfgW5ffEkTguD/06GoJyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ozqr1vMa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ozqr1vMa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739537529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tCIzqNCHZcHlzybzbxQTnd1kZRCpiqm/6VDF4k51+VA=;
	b=Ozqr1vMaYIBlWhHlSEKV2QGeU5B0Cl+vZXY84y47W0e7HC5B6fIgrlxmG59B5tnVjE/PDV
	mlGg9j8G6adZPEGae1nCis7Vvu+R/0Umm5sXkOOtPoaTmYUwFt2txQkMQHypUmWNZWu2jo
	wG0RisGOJeOqdlhxfPw21qvSiGTQSoI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-C1zD18VWNluky0Qs085cOw-1; Fri,
 14 Feb 2025 07:52:06 -0500
X-MC-Unique: C1zD18VWNluky0Qs085cOw-1
X-Mimecast-MFC-AGG-ID: C1zD18VWNluky0Qs085cOw_1739537525
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50E8219560BC;
	Fri, 14 Feb 2025 12:52:05 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1F0B19373D9;
	Fri, 14 Feb 2025 12:51:58 +0000 (UTC)
Date: Fri, 14 Feb 2025 20:51:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z688aFX58AbEqyW5@fedora>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <ifgg2za26r6frfco4cky6wxywgdj3l7r6hx6sbqarizqltshfx@kccnmlr3x7nq>
 <Z68m0X9o3Mw_oPsU@fedora>
 <xjuuc5qqgy6ujywimm2poxibbhsh5zbsefqeiqjru7q2llmjoj@spht3a4bx555>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xjuuc5qqgy6ujywimm2poxibbhsh5zbsefqeiqjru7q2llmjoj@spht3a4bx555>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Feb 14, 2025 at 01:28:41PM +0100, Daniel Gomez wrote:
> On Fri, Feb 14, 2025 at 07:19:45PM +0100, Ming Lei wrote:
> > On Fri, Feb 14, 2025 at 10:38:36AM +0100, Daniel Gomez wrote:
> > > On Mon, Feb 10, 2025 at 05:03:19PM +0100, Ming Lei wrote:
> > > >  /**
> > > > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > > > index 248416ecd01c..32188af4051e 100644
> > > > --- a/include/linux/blkdev.h
> > > > +++ b/include/linux/blkdev.h
> > > > @@ -1163,6 +1163,7 @@ static inline bool bdev_is_partition(struct block_device *bdev)
> > > >  enum blk_default_limits {
> > > >  	BLK_MAX_SEGMENTS	= 128,
> > > >  	BLK_SAFE_MAX_SECTORS	= 255,
> > > > +	BLK_MIN_SEGMENT_SIZE	= 4096, /* min(PAGE_SIZE) */
> > > 
> > > I think it would be useful to expose this value to the queue_limits and
> > 
> > Can you share it is useful for what?
> 
> I meant for your use case.

No, it isn't single case, there are many such devices with < 64K
max_segment_size, please see previous Bart's post:

https://lore.kernel.org/linux-block/20230612203314.17820-1-bvanassche@acm.org/

> 
> > 
> > > sysfs (and remove it from here). We can default it to PAGE_SIZE (as it has
> > > always been) and allow to overwrite it when the block driver initializes the
> > 
> > Which device driver needs to initialize it?
> 
> I mean, it would be yours. Keeping the default minimum segment size to PAGE_SIZE
> rather than changing it to 4k, would keep the current behaviour. Then, adding
> the minimum segment limit would allow your driver to overwrite it for your use
> case.

But these devices doesn't export min_segment_size, why do you want to fake this
limit?

It is fragile to take variable PAGE_SIZE as soft min_segment_size, and
it is actually wrong to bind it with fixed hardware max_segment_size.

To be honest, not see any benefit with your approach, just make things
complicated.

Thanks,
Ming

