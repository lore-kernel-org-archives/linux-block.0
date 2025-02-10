Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4602253AB
	for <linux-block@vger.kernel.org>; Mon, 10 Feb 2025 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193988; cv=none; b=bTc5FyUJmFOLxE2hXMPhyQmjHIRJHiaeGot6siFD3qp7mV0iA2fKXNuU3faPpK3rFztLfrZFiisIyhHTHTjQ1yvXjM0jpUKVZDMIeienS9uyEagTb7i2xm/AHAwjZbCv3Hf8X+cazN9yUkZRJzl9DyaQ4MbD9nD9vnpE18p1k3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193988; c=relaxed/simple;
	bh=RzFhUtwwplkdHMPOpVemh3JherPHaHQRq5G+qYyc/r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoXbcBRRQFzED8DJor3pAiJCD7bA83ubm1IvRupaq/TKxHregHNAK/j/atj6rk+WZCxhu0fraIZcg1z8XeexfFWDs9HeTmZ+7jt7nOEQ24M0jSc2QhWQj9NN2idYW2LCM9I9QBAojBNv81diqmgs5XVe/znzeb5NOZoXiPlWrfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsowDuOT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsowDuOT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739193985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E6q/kSsJyA7vK/azlwyGtDb19kZc/IlecclccTu0GH4=;
	b=SsowDuOTPs8nzZr7Y1yzHBH26+pitn7tEtwLHElQ3bMARWEQfxFuL+SaHNpzgqSmsGaGbV
	L6SfSnPLQB3Lh3wkCg3DSLydteZBQQQ2sv7g2P3T6ydOmWbU8oKvh9nd5J85ga/U6YlOvm
	oKlW3qzKHHjqg+ZSYaRBM7ePQeIaCHA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-0slBmrV2Pn-o-8EnrUfs_g-1; Mon,
 10 Feb 2025 08:26:23 -0500
X-MC-Unique: 0slBmrV2Pn-o-8EnrUfs_g-1
X-Mimecast-MFC-AGG-ID: 0slBmrV2Pn-o-8EnrUfs_g
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F4DE18011E1;
	Mon, 10 Feb 2025 13:26:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.149])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0640B18004A7;
	Mon, 10 Feb 2025 13:26:14 +0000 (UTC)
Date: Mon, 10 Feb 2025 21:26:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z6n-cbpvEerzNlAr@fedora>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <51da6bf9-4226-467d-87c1-e6ec785b1c06@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51da6bf9-4226-467d-87c1-e6ec785b1c06@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Feb 10, 2025 at 01:14:00PM +0100, Hannes Reinecke wrote:
> On 2/10/25 10:03, Ming Lei wrote:
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
> So why isn't this reflected in the blk_min_segment settings?
> Or, rather, why isn't setting blk_min_segment not enough?

There isn't min_segment_size setting, at block layer takes PAGE_SIZE
as the actual min_segment_size.

> 
> > Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
> > with queue limits and checking if bio needn't split. Define BLK_MIN_SEGMENT_SIZE
> > as 4K(minimized PAGE_SIZE).
> > 
> But why 4k then? That is a value like anything else, and what is the
> rationale to use that instead of the more natural sector size?

The comment explains it already: 4K = min(PAGE_SIZE).


Thanks,
Ming

