Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16313FEE
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300044; cv=none; b=Z/V62OKB2itishxxla/pT9Jw7gC2+SLCFB7gwFNG/HZ4Yw+yVodvmVV4/N0ae141bb0g7GPfYTcsqLDD0GEyDKun5tpMRS86QCy+M1tr3ZrQaWCWe/tzWVUooT5+qzzf7GiQco2D4Oa3bLyLhJ4LmKXYudcOuxRAOzZew1KyqeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300044; c=relaxed/simple;
	bh=+pUg+AznvGm1Q0wqGXFoR3KvDeIqhrHY0uFX4Xw6MkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jORqdP2wqXY/rFELpRYW8z4aQPTHP9oloptufaD2RolLk/KNK38yV64AfNaIbqdxKWTI41FGjkV5iM7opH4WChmhOmI/9bXbIBezzNankD8LySl325eW85uTLhOAhlGXhvxFH2ARpg1MAKrH0LMsrTfYJRAYPzfOCRbDql7uQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vv25jRhf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vv25jRhf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730300041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhEdWlWR1rF2plOsckgqtFn8WJGeMrDInbMoUSGfeuA=;
	b=Vv25jRhfEL4+jKHo2bUfwTDTg0hkKo9DVjZIal01l0H5hiX+YoUOQStFdusAJjKgHFgkLf
	ljvZI3CyU/EisHVV34vj5pcNDaSLxsdguMYRUnaxK26EP7JFeALQgc1l1wvXVpG9whjN3i
	fXsThNwXj4dsWjT/TS7L4icAb/GorRE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-ennkxHqcOkKczA8EESZ5wg-1; Wed,
 30 Oct 2024 10:53:58 -0400
X-MC-Unique: ennkxHqcOkKczA8EESZ5wg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD0A21955EAD;
	Wed, 30 Oct 2024 14:53:54 +0000 (UTC)
Received: from fedora (unknown [10.72.116.34])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4E0330001B5;
	Wed, 30 Oct 2024 14:53:51 +0000 (UTC)
Date: Wed, 30 Oct 2024 22:53:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/5] block: always verify unfreeze lock on the owner task
Message-ID: <ZyJIcPFQb13mJ8K3@fedora>
References: <20241030124240.230610-1-ming.lei@redhat.com>
 <20241030124240.230610-5-ming.lei@redhat.com>
 <20241030144614.GC32043@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030144614.GC32043@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Oct 30, 2024 at 03:46:14PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 30, 2024 at 08:42:36PM +0800, Ming Lei wrote:
> > commit f1be1788a32e ("block: model freeze & enter queue as lock for
> > supporting lockdep") tries to apply lockdep for verifying freeze &
> > unfreeze. However, the verification is only done the outmost freeze and
> > unfreeze. This way is actually not correct because q->mq_freeze_depth
> > still may drop to zero on other task instead of the freeze owner task.
> 
> Well, that's how non-owner functions work in general.
> 
> > Fix this issue by always verifying the last unfreeze lock on the owner
> > task context, and freeze lock is still verified on the outmost one.
> > 
> > Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")
> 
> What does this actually fix vs just improving coverage?  Because the
> hacks in here look pretty horrible and I'd be much happier if we didn't
> have them.
 
task A								task B

blk_mq_freeze_queue()
									blk_mq_freeze_queue()

blk_mq_unfreeze_queue()
									blk_mq_unfreeze_queue()


freeze_queue is verified on task A, but unfreeze_queue is verified on
task B, this way is definitely wrong.

This patch moves unfreeze_queue verification on task A.


Thanks, 
Ming

