Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7C4211A06
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442955; cv=none; b=mCF2IxRukE0Roj7GR3moAcy4Jq2AUbkeaX9cm9ZdQb3nGHD3isNMJ5OGkjDNClR0nyNN97ASAYBJMiZNLvCC7mR15aub/frptfd6AGKSRngKYCWuBnV0k/zUvg3mfgZIj1CgN7gnx2SPoApYlg6rHjMsB3uPlM+dQso9cqDJf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442955; c=relaxed/simple;
	bh=m5NvTOxNKzqjkqUWcV1izDv7VmnPzIYv3sSK6OHyDnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KL0XwARAOC+UDnbyu5hgUaTcUgu1PcQMOGzZ8UK+Izxy1RHoxwYmwlNkMMko97yHOv85wj6m9hNjWCdMat3tERG0Zeo/Yxwkj1yKwBhwS9yIk53stkjjckOnUj/HKiYWopuwBiur/UuRQHSY49mSm4OpltKxLrXhkCafrI4qByk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0V3Wd1/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0V3Wd1/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739442951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ujQNwD51Oq+PW96gd4bojYksvcjep+n1GbRSbO/WDSc=;
	b=N0V3Wd1/d6nhbEMTH6CIY3Mb79qVN4l32JbhJ1sKXbr+AUpq8iK/wpx6fsqgHkOMSXhWuB
	Z2bOKaN3tE7+9jnKuCkmI7rP28Rfs/F3jsZh4M8yAkCrD2ioU5sUt6KizWpJDUKoKI5xMK
	hDC5JRKJlk2L2FxuqQCDgHSqJmQB25E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-BME_rlfeNAG2Dp_c-vG5zA-1; Thu,
 13 Feb 2025 05:35:48 -0500
X-MC-Unique: BME_rlfeNAG2Dp_c-vG5zA-1
X-Mimecast-MFC-AGG-ID: BME_rlfeNAG2Dp_c-vG5zA_1739442947
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D037619039C6;
	Thu, 13 Feb 2025 10:35:46 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B085180034D;
	Thu, 13 Feb 2025 10:35:40 +0000 (UTC)
Date: Thu, 13 Feb 2025 18:35:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z63K99wkFLWqIfxW@fedora>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <faf95365-5b55-40f6-82f8-195ccc3edb9e@oracle.com>
 <Z63CY9rE7X8m3nmv@fedora>
 <63bdc82a-fa01-44ae-9142-2cb649d34fb7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63bdc82a-fa01-44ae-9142-2cb649d34fb7@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Feb 13, 2025 at 10:23:02AM +0000, John Garry wrote:
> On 13/02/2025 09:58, Ming Lei wrote:
> > On Thu, Feb 13, 2025 at 08:45:18AM +0000, John Garry wrote:
> > > On 10/02/2025 09:03, Ming Lei wrote:
> > > > PAGE_SIZE is applied in some block device queue limits, this way is
> > > > very fragile and is wrong:
> > > > 
> > > > - queue limits are read from hardware, which is often one readonly
> > > > hardware property
> > > > 
> > > > - PAGE_SIZE is one config option which can be changed during build time.
> > > > 
> > > > In RH lab, it has been found that max segment size of some mmc card is
> > > > less than 64K, then this kind of card can't work in case of 64K PAGE_SIZE.
> > > > 
> > > > Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
> > > > with queue limits and checking if bio needn't split. Define BLK_MIN_SEGMENT_SIZE
> > > > as 4K(minimized PAGE_SIZE).
> > > Please note that blk_queue_max_quaranteed_bio() for atomic writes assumes
> > > that we can fit a PAGE_SIZE in a segment. I suppose that if the
> > > max_segment_size < PAGE_SIZE is supported, then the calculation there needs
> > > to change.
> > It isn't related with blk_queue_max_guaranteed_bio() which calculates the max
> > allowed ubuf bytes which can fit in a bio, so PAGE_SIZE has to be used here.
> > 
> > BLK_MIN_SEGMENT_SIZE is just one hint which can be used to check if one
> > bvec can fit in single segment quickly, otherwise the normal split code
> > path is run into.
> 
> So consider we have PAGE_SIZE > 4k and max_segment_size=4k, if an iovec has
> PAGE_SIZE then a bvec can also have PAGE_SIZE but then we need to split into
> multiple segments, right?

Yes, hardware limit needs to be respected.

Looks one write atomic application trouble in case of 64K page size,
and it can't work w/wo this patchset.


Thanks, 
Ming

