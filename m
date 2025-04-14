Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3974C74
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744592327; cv=none; b=bpPIm1OahHMxyoOucRrLnEY2wUtwoD5J1DChN0TduuGNNd6gFtMYh2cjyf7Leo4xnPhDHX3HiuXMNMQrFhKox+57M7yWFZMqdUVRhFsFJ5U73GKpb0BbMIMPVHnbZYCc57yUJTS63TFwnpTZzdLEPABNgQSsdxZ9FX9+L9kjc5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744592327; c=relaxed/simple;
	bh=BHttNAQagST3r+Wide3RswlPGtBHMuEMCnnKMMZBkXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxdlGWrZsB48iefU9KM6ZXa4NWr/BmHnD3NwMaznEmZkxTjYQdlvNzSBa7L2Itkp2XukPuqRSawYMhRX45JxHvgcEaO89otjl4YU8g/ohLcMQUEbCcCYw/5bROgXD7dTwNXu6y4qKRMavXCGkN/scglc8ANHgqvL2oAUjZVKNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xc91dN9l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xc91dN9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744592323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EaXq5xRhNbiz4XL7USNPWFoTiL4W4wUXCuVe4kQn6yk=;
	b=Xc91dN9lOzLoukWta4DdwVlxMeSKgiiOQGWmqqrmWT3TtS2Jin656o35uKeNNvxJDpA+sw
	NVhT40iOw1+u4m3hHdbR/RM0KehEyt7VdkUzSWTSsIbTEPM3cL2Mh2NaeiJr9lywwdgfu2
	QWl51QEdS+ShZXKcJ/NoFST7uvX7Qbg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-Ls6k-oHqOASyLtPCvsQPwA-1; Sun,
 13 Apr 2025 20:58:40 -0400
X-MC-Unique: Ls6k-oHqOASyLtPCvsQPwA-1
X-Mimecast-MFC-AGG-ID: Ls6k-oHqOASyLtPCvsQPwA_1744592319
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4884180034D;
	Mon, 14 Apr 2025 00:58:38 +0000 (UTC)
Received: from fedora (unknown [10.72.116.68])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36355180B488;
	Mon, 14 Apr 2025 00:58:33 +0000 (UTC)
Date: Mon, 14 Apr 2025 08:58:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 05/15] block: simplify elevator reset for updating
 nr_hw_queues
Message-ID: <Z_xdtNiZb38ubXVe@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-6-ming.lei@redhat.com>
 <20250410153417.GA12430@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410153417.GA12430@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Apr 10, 2025 at 05:34:18PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 10, 2025 at 09:30:17PM +0800, Ming Lei wrote:
> > @@ -5071,9 +4984,15 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> >  		blk_mq_debugfs_register_hctxs(q);
> >  	}
> >  
> > -switch_back:
> > -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> > -		blk_mq_elv_switch_back(&head, q);
> > +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> > +		const char *name = "none";
> > +
> > +		mutex_lock(&q->elevator_lock);
> > +		if (q->elevator && !blk_queue_dying(q))
> > +			name = q->elevator->type->elevator_name;
> > +		__elevator_change(q, name, true);
> > +		mutex_unlock(&q->elevator_lock);
> > +	}
> 
> Coming back to this after looking through the next patches.
> 
> Why do we even need the __elevator_change call here?  We've not
> actually disabled the elevator, and we prevent other callers
> from changing it.
> 
> As you pass in the force argument this now always calls
> elevator_switch and thus blk_mq_init_sched.  But why?

sched tags is built over hctx and depends on ->nr_hw_queues,
when nr_hw_queues is changed, sched tags has to be rebuilt.


Thanks, 
Ming

