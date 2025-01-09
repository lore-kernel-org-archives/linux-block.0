Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5F51FC11F
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736410595; cv=none; b=VqH1XnYuMaFI3JCNiiLXQNwWevIeYS/F7KbEI9JY6xsx5Rg6B/fuuSmQD33mAHfBM4TzyU7G9pPp3W3mz4/Lw27/H7DBnZ1D6XsQQNtuyfAj8LkjaD4mVeKgjYhNOgYLWN9XNCV/wgpB0R7G5mMnmLrJUDU1KWSZuzV2u2QYNhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736410595; c=relaxed/simple;
	bh=r8WzzhbMd9uRlumR+jiKxG8aABvgiegFwU6aaqrcXj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsazrOHZgciuhTYoHAxaH1jiOmCB5rHjwrcucFKBfjHVwSPWDcXdW+lDt7lyEAZ8dhFF1awk1JH0z0CUDI1KVIRg0NjkU8YHNyd3XDrmjfQ2OXMgnJ9TiueidRzKacSryeZ+COvcXYgfiyzkS07yV80DSrkpvyMf2WU9oS99OBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxXT3hCm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxXT3hCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736410592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eD4PQ2lqozBCLy6ODlL7uzyXEhGgP3XjJCgY56pBPH0=;
	b=LxXT3hCm7W6StSLVHHPub7yW06kIk880dlBBGnvQOBSVgyZkfaC/Ntf1ThNNP126LQSWPz
	YgzXbck9hP4O1usRczJKduaLI5rLOo854IyB7N23eYhWabj13fK/2EWJEMMHD4BcIBusUr
	b3IfNCgscT46aKNEsEEY56xzeylZDkI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-NkzkPsgmN0iiF3ToB2oXgQ-1; Thu,
 09 Jan 2025 03:16:29 -0500
X-MC-Unique: NkzkPsgmN0iiF3ToB2oXgQ-1
X-Mimecast-MFC-AGG-ID: NkzkPsgmN0iiF3ToB2oXgQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA31A1955D71;
	Thu,  9 Jan 2025 08:16:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.139])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B49C1955BE3;
	Thu,  9 Jan 2025 08:16:19 +0000 (UTC)
Date: Thu, 9 Jan 2025 16:16:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 04/11] block: don't update BLK_FEAT_POLL in
 __blk_mq_update_nr_hw_queues
Message-ID: <Z3-Fzrj-En-l82Uc@fedora>
References: <20250109055810.1402918-1-hch@lst.de>
 <20250109055810.1402918-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109055810.1402918-5-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jan 09, 2025 at 06:57:25AM +0100, Christoph Hellwig wrote:
> When __blk_mq_update_nr_hw_queues changes the number of tag sets, it
> might have to disable poll queues.  Currently it does so by adjusting
> the BLK_FEAT_POLL, which is a bit against the intent of features that
> describe hardware / driver capabilities, but more importantly causes
> nasty lock order problems with the broadly held freeze when updating the
> number of hardware queues and the limits lock.  Fix this by leaving
> BLK_FEAT_POLL alone, and instead check for the number of poll queues in
> the bio submission and poll handlers.  While this adds extra work to the
> fast path, the variables are in cache lines used by these operations
> anyway, so it should be cheap enough.
> 
> Fixes: 8023e144f9d6 ("block: move the poll flag to queue_limits")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

