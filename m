Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F32BD5AC
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745920292; cv=none; b=M82L+ZfhAhOO2cJCVQLFqHhYCXOkihgsjn69eFFTo//VZuHEc8UDsdw7c7P9HL9jF6sbxa4WX+ZDLNVzmldxc/G0FBacau1yZalDLLgbEiUlsjQQQaxD8EOCCTJr0BlaO3RAZzsleB397EvSI+nI8jm2buY+rsvaZNCKzBNwkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745920292; c=relaxed/simple;
	bh=NDfiosWpghNdkbExVK/xSe+msZz74Bsfo3WnprS/6oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RB00LVHlRvsfPohOaKMfGV3jLOQFeWSzGk3VP0R082AHf08UEUBL+y6ZLPvRC9tFUvQxZnl9dXHGf76oWlXIbg6uPGaMHO0hHT7WmARnZkdW6p5hF4e4bKXwUtFiYFDo/jxvt9aoZs3FVSxjo5xDSSFSfDQqPhh4Um9QCqecVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSf1Acp5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSf1Acp5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745920289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciFT+QTt1ushX0kP7JbFFppzWL8qGNgMttnhv9VPz2U=;
	b=aSf1Acp5rTN9Myn7kBz4ZeWaX9W+IdLwz+KCR7CLLhl64jnXR9Y7+IB70kiLugbK4v+BL6
	K+mD4eG2CWGTTi5igH5tqGk8Siz68nsALJph1/dWzmRIyVmwE5dk0wFNmVpPzJszlWkO/d
	dFc+JqDmCFLikzuiem4UADiT8e85LNc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-f6VES7XAOseeDuCV7brjmg-1; Tue,
 29 Apr 2025 05:51:26 -0400
X-MC-Unique: f6VES7XAOseeDuCV7brjmg-1
X-Mimecast-MFC-AGG-ID: f6VES7XAOseeDuCV7brjmg_1745920285
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C308180036F;
	Tue, 29 Apr 2025 09:51:24 +0000 (UTC)
Received: from fedora (unknown [10.72.116.109])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7685519560A3;
	Tue, 29 Apr 2025 09:51:19 +0000 (UTC)
Date: Tue, 29 Apr 2025 17:51:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH V3 09/20] block: simplify elevator reattachment for
 updating nr_hw_queues
Message-ID: <aBChExvRF61O7E0F@fedora>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-10-ming.lei@redhat.com>
 <20250425181227.GA25925@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425181227.GA25925@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Apr 25, 2025 at 08:12:27PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 24, 2025 at 11:21:32PM +0800, Ming Lei wrote:
> > +static int __elevator_change(struct request_queue *q,
> > +			     const char *elevator_name)
> 
> There's still not good reason for this helper.

With the helper, we can avoid the 'force' reattachment flag.

> 
> I'd suggest you add the two first attached patches before this one
> (it'll need a bi of reabsing as all of them are after your entire
> sweries right now) and then fold the third one into this, which will
> give us less code and a cleaner interface.

I'd suggest to add your patches after this one, which changes
elevator_switch() into local symbol.


Thanks, 
Ming

