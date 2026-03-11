Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48033DEC9
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 02:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195242; cv=none; b=UVKgnBN0uxKzRnsX1635Ah6nQyN4j1eRKqgZfx/7EVEfmaIsQ9C0W/wdDwrKoe2Jg6Y1sHUt8E3YB0jDdey5T1U9hSbF5REIgcZsaBHwvrie5tY9JXjEcYU6QQbSbLtOhe5nWn+AEbRmKbhMAx2F7iplxCy/YljP7bg821CDeRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195242; c=relaxed/simple;
	bh=qIzMtdyNn8o+CeKW9NdLqgioc+ZCEb39I5K34smZUxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DspVOM5nPHf+wXwSGiIKyLOGIlsTymZRsdoeQrUscewG4BkF6nz5qEBc9jMO7azUdoGpodRl2qYjiIU0fiQpqJWypfTbZ8nau6o0UUkZ4X+fnSym8mBYP05YM1NY7Ipu7xrlVX5OL01WL9FiOCIZUgEBAOGEMOKDXmGZ7JuN3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gz+17o2V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gz+17o2V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773195240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=etgRjOtHtvWhzRFrL2pFSwa4bNDc2aarRBSYFJVPxmk=;
	b=Gz+17o2VOBCj0F3Vhv0VZ7Snbw9bPAMGeLE1MG+VU/Os5FV1QDd++Ilfmlc1zXQBTwux9i
	REn/dFFlv2L4q5CEi3iTMd6bgKaX3PdEj3FhxRTL6kfxuSJQbIhPVYVTTbINeBayZnSEBj
	HTL0v+w6vIgeOjCA1RXCeCnEeuPfbuM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-3Vpo0I-mNRyd0blmAYtkLw-1; Tue,
 10 Mar 2026 22:13:58 -0400
X-MC-Unique: 3Vpo0I-mNRyd0blmAYtkLw-1
X-Mimecast-MFC-AGG-ID: 3Vpo0I-mNRyd0blmAYtkLw_1773195237
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F52519560A6;
	Wed, 11 Mar 2026 02:13:57 +0000 (UTC)
Received: from fedora (unknown [10.72.116.147])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F25219560B7;
	Wed, 11 Mar 2026 02:13:51 +0000 (UTC)
Date: Wed, 11 Mar 2026 10:13:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] blk-cgroup: wait for blkcg cleanup before initializing
 new disk
Message-ID: <abDP2r1SwmHI0hfh@fedora>
References: <20260309100906.1740351-1-ming.lei@redhat.com>
 <abAamVMoIHncU29q@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abAamVMoIHncU29q@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Mar 10, 2026 at 06:20:25AM -0700, Christoph Hellwig wrote:
> On Mon, Mar 09, 2026 at 06:09:06PM +0800, Ming Lei wrote:
> > +	if (READ_ONCE(q->root_blkg)) {
> > +		/* 20s is a random timeout, disk_release() should be done well before */
> > +		unsigned long end = jiffies + msecs_to_jiffies(20000);
> > +
> > +		while (READ_ONCE(q->root_blkg) &&
> > +				time_before(jiffies, end))
> > +			msleep(1);
> > +		if (READ_ONCE(q->root_blkg))
> > +			return -EEXIST;
> 
> Random sleeps are almost never a good idea.  If you don't want to waste
> a waitqueue on this use wake_up_var/wait_on_var, but make it properly
> wait for an event.

The two wait variable helpers looks pretty handy, will take it in V2.

Thanks,
Ming

