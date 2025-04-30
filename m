Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2710A1E
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745975257; cv=none; b=ku4h1KBDAPovXWfQcCPjYAiBwPKckSnYS1f1Da4Rp6Le47bp4vYPpacsdLNOs/hopnSbPgb84+iNcjeNnYq4pcgLqUORHhg+lo0a2vii+eZz37pD9IOvyM4fwoc8Jsq5wBxsdDnHr5tscJmg787Nz8ihxfcDthYdTh5TSvLmQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745975257; c=relaxed/simple;
	bh=wGnFCn0Ss0LN/Cc0ckg9LVkcpEliQDeJzl9ddMi3emU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgttzUd1Fuygr/asThNHZrNWZWCC+dUTAxiNIbP/LpET0fxuYSo032E2hY5rSz8UlNd1QJAp+/6FBOU7Oz3ts1qSRmE8YRobyHSc9Ejwm8+WhGTlKOm4QlP2dWclfEiIFahfPcd5ZXC7gFarRl2ExQt9Zh3CAf95xUsEAr/TwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFyuVUnr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFyuVUnr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745975254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HQJY3nMpVYCqNw6j1Aop7PIKVATwbNC9nuKa03McBLo=;
	b=KFyuVUnr3JiHvJerYAkwfvzr0pyrfDmgwRirvkGK4PfYC8CgIRnl4MoO6Ncub6lfTDw6oG
	VlxVZyck/SUOB2U+/9OEXofj84HeWvGRHyxsMClw0JEtTIt9TiwHJBWou8vo4QWlsY18rU
	RQf1iJigbwvUawiU+qPktiOclurgEI0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-xsuIl8MSNdmouDStFaL4Xw-1; Tue,
 29 Apr 2025 21:07:29 -0400
X-MC-Unique: xsuIl8MSNdmouDStFaL4Xw-1
X-Mimecast-MFC-AGG-ID: xsuIl8MSNdmouDStFaL4Xw_1745975248
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0FDE180036F;
	Wed, 30 Apr 2025 01:07:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6490180045B;
	Wed, 30 Apr 2025 01:07:23 +0000 (UTC)
Date: Wed, 30 Apr 2025 09:07:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH V3 15/20] block: fail to show/store elevator sysfs
 attribute if elevator is dying
Message-ID: <aBF3xsCL6QP5WnR_@fedora>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-16-ming.lei@redhat.com>
 <20250425183614.GA26393@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425183614.GA26393@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Apr 25, 2025 at 08:36:14PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 24, 2025 at 11:21:38PM +0800, Ming Lei wrote:
> > +	if (test_bit(ELEVATOR_FLAG_DYING, &e->flags))
> > +		error = -ENODEV;
> > +	else
> > +		error = e->type ? entry->show(e, page) : -ENOENT;
> 
> Weird style mix, I'd expand the check for ->type to a proper else
> if here as well.  But how can e->type actually be NULL here to start
> with?

You are right, e->type can't be NULL, which is assigned in its allocation,
never get cleared.


Thanks,
Ming

