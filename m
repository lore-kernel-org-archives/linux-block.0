Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BFB182DB
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783935; cv=none; b=n0+WWoMiyQlpCLXSTcmUvNVyLqDK5fC4zRM0Pjm85G0VkskUzHA7IAXJIgURF023MGZd7Wm30RtSBzi1F9glzNeFkw49waYrIV9ENFF3b3NjnkYhEhR2oLkblz38DEcCp6oh1UV4KAFqi8q1le1Rrsc5HGvFOzdt31qZgGTiDfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783935; c=relaxed/simple;
	bh=awyz/ghOG9QVOc1kjRO3r3k3bmEnc41GNGxv6+yv4uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSQTVI3J6xwEyISYpIugyTzUJwHhpyFHAv3kK5phv3lV7B/iZ/EMubsjIj5X7veNQYiD/RXgfpKXc5taGYJVcfBgOPPXue7Dzv0Y0lA6m7ZGvPC45pm+mFrjklerDZMh1ew32mcGNHGXaxbw+PfT4UXuj/huYdoR6j2TTGg2clw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dnqpqr1Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnqpqr1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718783933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIlSFa+EkV/ru7FYtgWxxQHyYf7o1kM6ybUaVbk+vQA=;
	b=dnqpqr1ZOErHdQLxozKCewPNZHVWPWPeg+iztAxYn7d/91EHKzPsLKjxHK21VeVNKl9bdU
	GpELm4K0unAyp4VtpJj0KZVgCqWNJxGZlQjFCPPUOrydURntg2bgNgaJzHCfKn2EK3S/VA
	SLkGwPghqUcjGtUpadmidqUNbgsmI9M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-CX7zaa_7MEGAMQHqPMTSzA-1; Wed,
 19 Jun 2024 03:58:50 -0400
X-MC-Unique: CX7zaa_7MEGAMQHqPMTSzA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2584195608B;
	Wed, 19 Jun 2024 07:58:48 +0000 (UTC)
Received: from fedora (unknown [10.72.112.148])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B8F319560AF;
	Wed, 19 Jun 2024 07:58:42 +0000 (UTC)
Date: Wed, 19 Jun 2024 15:58:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
	Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] block: check bio alignment in blk_mq_submit_bio
Message-ID: <ZnKPrYI72g2iT/rV@fedora>
References: <20240619033443.3017568-1-ming.lei@redhat.com>
 <7ed12f7e-f59a-4f6f-975b-ce7bb21652de@kernel.org>
 <355cc36f-e771-4f00-bfb0-0095674d5d49@kernel.org>
 <ZnKJ3d-18rzl32j2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKJ3d-18rzl32j2@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Jun 19, 2024 at 12:33:49AM -0700, Christoph Hellwig wrote:
> On Wed, Jun 19, 2024 at 01:22:27PM +0900, Damien Le Moal wrote:
> > static bool bio_unaligned(const struct bio *bio,
> > 		          const struct request_queue *q)
> > {
> > 	unsigned int bs_mask = queue_logical_block_size(q) - 1;
> 
> Please avoid use of the queue helpers.  This should be:
> 
> 	unsigned int bs_mask = bdev_logical_block_size(bio->bi_bdev);
 
It is one blk-mq internal helper, I think queue helper is more
efficient since it is definitely in fast path.


Thanks,
Ming

