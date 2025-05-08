Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198017D2
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 03:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746676647; cv=none; b=tMX3/uNVdIpMRpPR+AYQPFghVld6CPguWpeTfQ7TmKhAcl5wateOLucFTMCXyEYAvvFUt60cFydcKnY1saSEdHQzSWcsfzcHlcerNfQ4aLdXVbkZzdhVtIusYzRZPG14mrATbEjfedy/YgPUlrqH6tdBclkBicfKHxYmoKhdz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746676647; c=relaxed/simple;
	bh=RGpYhYMAph4S08D0PWsKTe5vru2XJ3aDj9YxOXMURF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMfgfcONcahiatctVmWymfagBjXXZqDlbWUJd9smYjDsU74Vs6nA7NVaTPtDCxeSJ0SdjY7RLfzzzF2Z2RCG0yBnsN4ywSPQzCEj0iOV3f/r2BB37/eB1BjHfYsNOtKkDJqGGvW4JKNbFZvfQCYjz23T1odm4FmD0S75S4v5B6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gecll0tw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gecll0tw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746676644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uyx+Lz7NKUurMoypnLdUnVH0shmnLTgBqB4K/fIox9s=;
	b=Gecll0tw8lFiGwYHtzFxkZ2UV2821vYEI+grlYV0id9r3l+CGTWrgQ22kFLPBCN23zg2kW
	/ablOhRCf5FP6qqLKZZIZZgdKXGV/LEPGH0D4bgA0PGqPZMsSlhjyE+cQH2ucMu6jvElKJ
	FjRuXjIaL3FPbkka/F7TIJyDUmSepgk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-IRdOMNSGMquxXoCTWPiybw-1; Wed,
 07 May 2025 23:57:20 -0400
X-MC-Unique: IRdOMNSGMquxXoCTWPiybw-1
X-Mimecast-MFC-AGG-ID: IRdOMNSGMquxXoCTWPiybw_1746676639
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D3B81956096;
	Thu,  8 May 2025 03:57:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 645121956055;
	Thu,  8 May 2025 03:57:14 +0000 (UTC)
Date: Thu, 8 May 2025 11:57:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 2/2] block: avoid unnecessary queue freeze in
 elevator_set_none()
Message-ID: <aBwrlQuvlBVPGb5Y@fedora>
References: <20250507120406.3028670-1-ming.lei@redhat.com>
 <20250507120406.3028670-3-ming.lei@redhat.com>
 <20250507135450.GB1019@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507135450.GB1019@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, May 07, 2025 at 03:54:50PM +0200, Christoph Hellwig wrote:
> On Wed, May 07, 2025 at 08:04:03PM +0800, Ming Lei wrote:
> > elevator_set_none() is called when deleting disk, in which queue has been
> > un-registered, and elevator switch can't happen any more.
> > 
> > So if q->elevator is NULL, it is not necessary to freeze queue and drain
> > IO any more.
> 
> Yes.  Also if the disk owns the queue there can't be any more I/O per
> definition, so maybe check for that as well?

Not sure if I get your point, do you want to avoid freeze queue for the case
of disk owning the queue? I think it can't be done, because someone may
still open the bdev and submit IO to it even though del_gendisk() is
in-progress.


Thanks,
Ming

