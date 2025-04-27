Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD2A22172E
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745739167; cv=none; b=kSQrmg3iKV9XuiOUFoVOQLjTRqJbk0kKaopeJ4eQcMKLAY1B6CMlYqlnWncPrXtUjVk2YnNKmSURKb0WZdNf6Pgaop7f8ODmipWCHCuHl/7K0SHuRopoUTs1LUZ1H48WwQtCgaLWBKnLkWZJ5ZhR+FePl5hXXF9QbpLWDsVDB4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745739167; c=relaxed/simple;
	bh=Zdwz87QxT759PZpE2s7uB0XNbkojnzBVnW6fTAj+jjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKpodwW5OTTAtveLkRQ8yaDNVOCCzbLpVrYxzYD8tlS02kwJNErh2lEwEhFxFEZVUJcL/jcGBQ9gOXZt5nwsaBK8bJg7D1VS0y70kOFNzCRb+3oBv7UZS26k2hBWckiND+LNk6gxyrusESPVkrjY7Qa6eYa09k+OXaV2jn3pqhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M4uCMMTt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4uCMMTt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745739162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7c0ULzx108dZoXxppyx3B84/87j4EvvxFBauQ1lv+QM=;
	b=M4uCMMTtfUvDZPjst3QEV2Mnf7IhcKAPxuEqMiHqrdf5sbOEwr0V7YKdkTS7BH2OpIa/Xm
	8D20/WKFbBGeyDZN6T4KIwX+ftJdmpBTIWJb7EwUmDWbjo//NM8HSQMn0LYzrRiRQDBXyW
	MwqKk3T+f3aQfaKrgiM/JaVOGwnqL0Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-GIT6A_q0PJOP1KRxqXuYqg-1; Sun,
 27 Apr 2025 03:32:37 -0400
X-MC-Unique: GIT6A_q0PJOP1KRxqXuYqg-1
X-Mimecast-MFC-AGG-ID: GIT6A_q0PJOP1KRxqXuYqg_1745739156
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E8AC195608E;
	Sun, 27 Apr 2025 07:32:36 +0000 (UTC)
Received: from fedora (unknown [10.72.116.119])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09BBD180045C;
	Sun, 27 Apr 2025 07:32:32 +0000 (UTC)
Date: Sun, 27 Apr 2025 15:32:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 3/4] ublk: add feature UBLK_F_AUTO_ZERO_COPY
Message-ID: <aA3dil8q-69jruIq@fedora>
References: <20250426094111.1292637-1-ming.lei@redhat.com>
 <20250426094111.1292637-4-ming.lei@redhat.com>
 <CADUfDZqQ_xvFMP=yjUYvvnn6u36iNBmcgoONBoBVhDjyiZQfjA@mail.gmail.com>
 <aA2XwIcOPysPTra9@kbusch-mbp.dhcp.thefacebook.com>
 <aA2gJqKs31-_diER@fedora>
 <aA2s3oVFfOF1X485@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA2s3oVFfOF1X485@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Apr 26, 2025 at 10:04:46PM -0600, Keith Busch wrote:
> On Sun, Apr 27, 2025 at 11:10:30AM +0800, Ming Lei wrote:
> > On Sat, Apr 26, 2025 at 08:34:40PM -0600, Keith Busch wrote:
> > > 
> > > This is very similiar to something I proposed off-list, and the feedback
> > 
> > Looks we both think of it, :-)
> 
> Yeah, for real. I was a bit dismayed when I learned of such use cases.
> So much simplicity and elegance went away...

That is reality, and probably these use cases may be addressed elegantly too
in future...

>  
> > > back then was this won't work because the back-end ring that wants to
> > > use the zero-copy buffer isn't the same as the ublk server ring
> > > recieving notification of a new command; the ublk driver has no idea
> > > which uring to register the bvec with. Also, this is using the request
> > > "tag" as the io_uring buf index, which wouldn't work when the ublk
> > > server ring handles multiple ublk devices due to the tag collisions.
> > > 
> > > If you're can make those trade-offs, then this is a great simplification
> > > to the whole thing.
> > 
> > The io_uring fd & buffer index can be provided from 'ublksrv_io_cmd'.
> > 
> > https://lore.kernel.org/linux-block/aA2RNG3-WzuQqEN6@fedora/
> > 
> > If we only support IORING_ENTER_REGISTERED_RING, 32bit is enough for
> > io_uring fd & buffer index, and there is still 64bits available if not
> > taking UBLK_F_ZONED into account.
> 
> We still need a registered sparse table for the backend ring. I think
> maybe a simple ida from the ublk driver to select an index may let the
> daemon register something reasonably small.

Yeah, I think it is reasonable to let userspace register the sparse table,
and we can document it in UAPI.


thanks,
Ming

