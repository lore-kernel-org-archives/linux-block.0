Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAE17BA5
	for <linux-block@vger.kernel.org>; Wed, 19 Feb 2025 03:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739935505; cv=none; b=HtFzmqafvLtGrxONiHhG9fgEET8nSHGNKT2qsvvh7AX9xawlaqoreIszkRMpZAeNEDNC6PghTxGviiO3dWU550mnNPt4Tv9x2lOVFpwMhgfY9go9gQJ4ouKOCdi46qDVzXeqdmY0LAsS0XBKVxUxZQP+qE2yJBO8Lc1czN2dU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739935505; c=relaxed/simple;
	bh=l6Qs5peq65OdkVVGychf0najUekC0/xEilG5tmLBZv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5ejE9hLJr9wlMuCVPvAUO7WjFUsraBd84U/RunTl0qf4nnz7zlGbAYFhR2xfzQEfw1zGRN7LMmlWN09O58Gis1rtD8RuDG/BYNInEG2o9GYlj1u2N2W9VPD+02aBGVHrW5mEf8NnqhDvdGGJQAVEGaskWclLScKoLIsrV1vego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fh9OKJXC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fh9OKJXC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739935501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qw1s5HogM2trFILpr5tDS0SJvrDPzpzaaF5dp81g8yc=;
	b=fh9OKJXCb1xy2GONdZHm8WZ0508aO6EJQU0+iWITIdyhlyaeVRDFPgG82qIDpbkvBY8OAM
	J5SZ4Jr3wj9Uek/w8zJiD0ETNBjP1i7/B1fEDBCkEIZ0Hj03BiL+xCyUpBaIKAICPOWGcQ
	EM4ti47L6R7Eh7v9cB7UUrO+KGDzHZY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-BnUioE-KOE6csj5McrFT_g-1; Tue,
 18 Feb 2025 22:24:56 -0500
X-MC-Unique: BnUioE-KOE6csj5McrFT_g-1
X-Mimecast-MFC-AGG-ID: BnUioE-KOE6csj5McrFT_g_1739935494
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F35919039C1;
	Wed, 19 Feb 2025 03:24:54 +0000 (UTC)
Received: from fedora (unknown [10.72.120.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56FD630001A6;
	Wed, 19 Feb 2025 03:24:48 +0000 (UTC)
Date: Wed, 19 Feb 2025 11:24:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv2 1/6] blk-sysfs: remove q->sysfs_lock for attributes
 which don't need it
Message-ID: <Z7VO-z1cZfFLYaMt@fedora>
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-2-nilay@linux.ibm.com>
 <Z7R4sBoVnCMIFYsu@fedora>
 <5b240fe8-0b67-48aa-8277-892b3ab7e9c5@linux.ibm.com>
 <Z7SO3lPfTWdqneqA@fedora>
 <20250218162953.GA16439@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218162953.GA16439@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Feb 18, 2025 at 05:29:53PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 18, 2025 at 09:45:02PM +0800, Ming Lei wrote:
> > IMO, this RO attributes needn't protection from q->limits_lock:
> > 
> > - no lifetime issue
> > 
> > - in-tree code needn't limits_lock.
> > 
> > - all are scalar variable, so the attribute itself is updated atomically
> 
> Except in the memory model they aren't without READ_ONCE/WRITE_ONCE.

RW_ONCE is supposed for avoiding compiler optimization, and scalar
variable atomic update should be decided by hardware.

> 
> Given that the limits_lock is not a hot lock taking the lock is a very
> easy way to mark our intent.  And if we get things like thread thread
> sanitizer patches merged that will become essential.  Even KCSAN
> might object already without it.

My main concern is that there are too many ->store()/->load() variants
now, but not deal if you think this way is fine, :-)

Thanks,
Ming

