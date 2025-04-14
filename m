Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFF7DA82
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 01:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744595203; cv=none; b=twfivA1jAJxgDakGK7CVCbwOGcavwMweYW664vLu8b3cQLqYNmjb2X43sgpH2vRXsOunAY15LVrf8chJtn0XWciBnFzXnl9aqZo4Xaq7Jx9Qp/aTyUtfyxA2Wi7ZWl+VclB3s97BuaC/FwEdmqfrMdQEOustyOrZkZ+Sk5Ypgz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744595203; c=relaxed/simple;
	bh=b68MR2Qrrd9LPhQLk8SLZfI4rzwxCPhk1FAIXpDzlts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQmT5YjOuScej96eCJA8RN1yJzaf+TvYqbPSTzL8YM0KQ1CXLPGg3W6Tie+ccom24lsDvxNuG/A6TENQCK43k4H9fePtJIPqdEnCNUIfUZGBoSL//VxVSzcAjHw2lFj7rVvGKR+9a3TP8CIaZFe8XAuqCvt9pZvO0tYDo+7ZLqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVbB/qDx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVbB/qDx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744595200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVYfPEQxPKLX2Ihm46qzi1FoAvf/WuQZIq56gieiVI4=;
	b=cVbB/qDxMW9UysyA4q3FbH5mXKwCPcpf1m1BbLDJUwudm9koEuzhXLR0jXx7hJjNpTrLNj
	KgStovN0IJdlr3fO3oe1a492Rqi2dAUC1tLL5u2WycQbr5264dRWAGfa/tMUzKyz/Coibf
	7+Nxmm8NSRkWYr/BLU1qUUnV7oYdDhI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-mU2-dh7DOmSr51ayL10EVA-1; Sun,
 13 Apr 2025 21:46:35 -0400
X-MC-Unique: mU2-dh7DOmSr51ayL10EVA-1
X-Mimecast-MFC-AGG-ID: mU2-dh7DOmSr51ayL10EVA_1744595193
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD54E19560BC;
	Mon, 14 Apr 2025 01:46:33 +0000 (UTC)
Received: from fedora (unknown [10.72.116.68])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAEDA1956094;
	Mon, 14 Apr 2025 01:46:29 +0000 (UTC)
Date: Mon, 14 Apr 2025 09:46:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 13/15] block: remove several ->elevator_lock
Message-ID: <Z_xo8GwBAs8v6sfJ@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-14-ming.lei@redhat.com>
 <567cb7ab-23d6-4cee-a915-c8cdac903ddd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <567cb7ab-23d6-4cee-a915-c8cdac903ddd@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Apr 11, 2025 at 12:37:49AM +0530, Nilay Shroff wrote:
> 
> 
> On 4/10/25 7:00 PM, Ming Lei wrote:
> > Both blk_mq_map_swqueue() and blk_mq_realloc_hw_ctxs() are only called
> > from queue initialization or updating nr_hw_queues code, in which
> > elevator switch can't happen any more.
> > 
> > So remove these ->elevator_lock uses.
> > 
> But what if blk_mq_map_swqueue runs in parallel, one context from
> blk_mq_init_allocated_queue and another from blk_mq_update_nr_hw_queues?
> It seems this is possible due to blk_mq_map_swqueue is invoked right
> after queue is added in tag-set from blk_mq_init_allocated_queue.

Good catch, one simple fix is to swap blk_mq_add_queue_tag_set() with
blk_mq_map_swqueue() in blk_mq_init_allocated_queue() since blk_mq_map_swqueue
doesn't rely on BLK_MQ_F_TAG_QUEUE_SHARED.


Thanks,
Ming

