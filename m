Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33E208CA
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 00:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744592135; cv=none; b=AUYYa0CLZLzftFitfTGb/o3Rp+ofg+buccNrkqCu7+9Gi5dyv6jIEyi+IIZtcDI2s5JMOOLJv//2iCIMVPsTn1KG9M0EimluC79cmQrKtLmxtsEU0t4GpFxuUJ2z+oOKWu1+/q0TXfSNOD/ZdrIB0vpo5Zd/eWCGjwxzTk3aTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744592135; c=relaxed/simple;
	bh=+teflM9yIK20a1XvjKacPLlsA21Ud1Gt5/waAqiHqEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bus65cVCVudzmL3hO75Tp60S54JiA/+O+4hH9DXUyTJn/vGSa4MXi9D0umpBytt96z0JsMB2XG5zLWL2YuSQ1my1oZWx6ssYlfmnvoE1f26pp7eVcmiaMFr02O1ywtcBD8exafIgcTBlLCh5P8n9t3LRyRms5bvlHXc6pnt0Z+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DY6WTgd7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DY6WTgd7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744592132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HZLjRmlbciFswUQshINmucgQXfNIrjs1CXpBzzmy29c=;
	b=DY6WTgd7oRYFx2FRy50QE0l7x7qU1M3S+Yfg8iPZH6l4rimSKd7s3uE35LGtBFvvbJJddw
	9KUbrUSvg7zcHXLXhj7q45mHAQ48xFTAYdLIzCGF0tGmDLq+OoiXN8Hb06E+4iOvgwt4/e
	5vPeuD4+8Q9fsrs2UnQ8anE4RCuToOU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-wxUPaQ3DN22X1dO2zW_c_Q-1; Sun,
 13 Apr 2025 20:55:26 -0400
X-MC-Unique: wxUPaQ3DN22X1dO2zW_c_Q-1
X-Mimecast-MFC-AGG-ID: wxUPaQ3DN22X1dO2zW_c_Q_1744592123
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B709195609F;
	Mon, 14 Apr 2025 00:55:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.68])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F174E1808867;
	Mon, 14 Apr 2025 00:55:18 +0000 (UTC)
Date: Mon, 14 Apr 2025 08:55:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/15] block: prevent elevator switch during updating
 nr_hw_queues
Message-ID: <Z_xc8hbIKb23bjtX@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-5-ming.lei@redhat.com>
 <3c4350f4-4ab3-493f-b948-22f093e97d16@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c4350f4-4ab3-493f-b948-22f093e97d16@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sat, Apr 12, 2025 at 12:43:10AM +0530, Nilay Shroff wrote:
> 
> 
> On 4/10/25 7:00 PM, Ming Lei wrote:
> > @@ -5081,7 +5087,18 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> >  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
> >  {
> >  	mutex_lock(&set->tag_list_lock);
> > +	/*
> > +	 * Mark us in updating nr_hw_queues for preventing switching
> > +	 * elevator
> > +	 *
> > +	 * Elevator switch code can _not_ acquire ->tag_list_lock
> > +	 */
> > +	set->flags |= BLK_MQ_F_UPDATE_HW_QUEUES;
> > +	synchronize_srcu(&set->update_nr_hwq_srcu);
> > +
> >  	__blk_mq_update_nr_hw_queues(set, nr_hw_queues);
> > +
> > +	set->flags &= BLK_MQ_F_UPDATE_HW_QUEUES;
> 
> I think here we want to clear BLK_MQ_F_UPDATE_HW_QUEUES, so we need to
> have set->flags updated as below:
> 
> set->flags &= ~BLK_MQ_F_UPDATE_HW_QUEUES;

Good catch!


Thanks,
Ming

