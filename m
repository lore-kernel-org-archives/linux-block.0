Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FE4634
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744593915; cv=none; b=K84mMRp6rfTmomzDJevWcli7IXn+Q7iG2xXQqivKVOgQ4MD6axM3BCJLMcBDshzzAFiDVGjE0n8TCz2u3BrFClhNosfn9vC2cJxFHtL9dPLHwui885O3F/rFYAjVKmtaF/SnHN8ThsDCVgLSjg1TGKThrgMuHzBDRSKoTIuUwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744593915; c=relaxed/simple;
	bh=Tp8uaIc7wklztM+EB+F9luR9qGd4AHklfsnHlTcGmhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbQ/4MMf2H09qkM/8CDbA3McaFd4P4S4kD7/O3XKsaS9H34VANXCI6pIrztSDR1tfFlghtw12vSEJV1n5/1i5NO91r4szkPEMo9lkG5pUJ2G3z6MkZE2w7qmP4bOQCJTPwa0O+JU+8s/ddrA9tcJsF4h3gmfPcX0Pfl6dnF1JZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRGqwXX+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRGqwXX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744593912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MCbIN+BH2SmiU58PoKA9sLaSQKe7H98W1zGLbdpj9Qg=;
	b=eRGqwXX+TE9jvx5iaT1UEheR8oY9sMCe3kYvKT/L3z/niKs3bEh5VZo3omvzADjLy3d1hn
	S/hUfotMd9eWN0QIcUdErgr+UGr27j7s4HTNseEAXfMb46JNB6Ge3dnpyV17teS1UlP67h
	eru6Q238j39d/zYCUzGjiH7TLqW7swA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-UPwgjJFkNka5kq7Ov_xPtw-1; Sun,
 13 Apr 2025 21:25:08 -0400
X-MC-Unique: UPwgjJFkNka5kq7Ov_xPtw-1
X-Mimecast-MFC-AGG-ID: UPwgjJFkNka5kq7Ov_xPtw_1744593907
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7CDB1955BC6;
	Mon, 14 Apr 2025 01:25:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.68])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0563A19560AD;
	Mon, 14 Apr 2025 01:25:01 +0000 (UTC)
Date: Mon, 14 Apr 2025 09:24:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/15] block: move elv_register[unregister]_queue out of
 elevator_lock
Message-ID: <Z_xj6OAZ9o142Dvl@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-12-ming.lei@redhat.com>
 <43e99891-94f2-4b31-a073-f7e717afbdd7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e99891-94f2-4b31-a073-f7e717afbdd7@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Sat, Apr 12, 2025 at 12:50:10AM +0530, Nilay Shroff wrote:
> 
> 
> On 4/10/25 7:00 PM, Ming Lei wrote:
> > +int elevator_change_done(struct request_queue *q, struct elev_change_ctx *ctx)
> > +{
> > +	int ret = 0;
> > +
> > +	if (ctx->old) {
> > +		elv_unregister_queue(q, ctx->old);
> > +		kobject_put(&ctx->old->kobj);
> > +	}
> > +	if (ctx->new) {
> > +		ret = elv_register_queue(q, ctx->new, ctx->uevent);
> > +		if (ret) {
> > +			unsigned memflags = blk_mq_freeze_queue(q);
> > +
> > +			mutex_lock(&q->elevator_lock);
> > +			elevator_exit(q);
> > +			mutex_unlock(&q->elevator_lock);
> > +			blk_mq_unfreeze_queue(q, memflags);
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> We could have sysf elevator attributes simultaneously accessed while this function 
> adds/removes sysfs elevator attributes without any protection. In fact, the show/store
> methods of elevator attributes runs with e->sysfs_lock held. So it seems moving 
> the above function out of lock protection might cause crash or other side effects?

sysfs/kobject provides such protection, and kobject_del() will drain any
in-flight attribute access.


Thanks,
Ming

