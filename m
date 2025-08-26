Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31560308F34
	for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199305; cv=none; b=f6285OItJ4X0eFJRqKHdpOZ6hLJOZyQmLRNwoGg6OclkS/OZ9BlS8Rd9HOjASRPtZJ+Dit9VIjR9jh34KI2Cweck09+MsfVGMOQEFiGR+TYf1iq40YGoAGaoKpWfy/DGiyG/NPqFFzvA7E3zKPyIAMIxofv8peFL5BibBkDxJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199305; c=relaxed/simple;
	bh=GN5uQD4JD6djLG9PPbtEplS2jSso9GU5V0zzpg+K9Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbuO1QPSqXWftDHBpiaF9g9jSubMQMiVlUM0tw+nr3DwrUvaheeqhBWas+daPLW23aeuaUamXjJsaQcIY74FfWDinO/xBiZp+9NFXnjL7q3T/SPdNe9miSlJ34JIijEy0ckwmXZxtxNfXz07zl5vfmTq7ZS37KSMNYT86LhPtz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrY7fxji; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrY7fxji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756199303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgK6zVCaewV2AgflcmKRv9pWzRpDi+X/xM0/4eUVBak=;
	b=RrY7fxjiKFwwdN25ZvvqKwf286LFVlNiXXnt5VqscYPcBsivjwAm/PDZxOVg4NGwobtPwr
	Ogk11aDI/9kY/9Y+OuVzSGS3HdLb8q4AAWdT6Lh2vnIaEppUEBeei9i3JwHMQSfKuwHOLS
	lRRBdCJp49sxr86Fh5BdlSNnp0Egbwo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-bkekoeDEPDS-J6oAGgdWIQ-1; Tue,
 26 Aug 2025 05:08:19 -0400
X-MC-Unique: bkekoeDEPDS-J6oAGgdWIQ-1
X-Mimecast-MFC-AGG-ID: bkekoeDEPDS-J6oAGgdWIQ_1756199298
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB241195419B;
	Tue, 26 Aug 2025 09:08:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A231919560AB;
	Tue, 26 Aug 2025 09:08:12 +0000 (UTC)
Date: Tue, 26 Aug 2025 17:08:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Subject: Re: [blktest/nvme/058] Kernel OOPs while running nvme/058 tests
Message-ID: <aK15dbUiEyr0O2Ka@fedora>
References: <3a07b752-06a4-4eee-b302-f4669feb859d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a07b752-06a4-4eee-b302-f4669feb859d@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Aug 26, 2025 at 02:00:56PM +0530, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> 
> IBM CI has reported a kernel OOPs, while running blktest suite(nvme/058
> test).
> 
> 
> Kernel Repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> 
> Traces:
> 
> 
> [37496.800225] BUG: Kernel NULL pointer dereference at 0x00000000
> [37496.800230] Faulting instruction address: 0xc0000000008a34b0
> [37496.800235] Oops: Kernel access of bad area, sig: 11 [#1]

...

> [37496.800365] GPR28: 0000000000000001 0000000000000001 c0000000b005c400
> 0000000000000000
> [37496.800424] NIP [c0000000008a34b0] __rq_qos_done_bio+0x3c/0x88

It looks regression from 370ac285f23a ("block: avoid cpu_hotplug_lock depedency on freeze_lock"),
For nvme mpath, same bio crosses two drivers, so QUEUE_FLAG_QOS_ENABLED & q->rq_qos check can't
be skipped.


Thanks,
Ming

