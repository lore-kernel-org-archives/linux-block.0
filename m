Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D5157E87
	for <linux-block@vger.kernel.org>; Sat,  7 Sep 2024 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725706889; cv=none; b=rdpFnMYfGX7m3e1UfXwb4tb/PAE+34BEZPF+8xPnNMhOcX4HanKPE6J17AW8+Lt69mevVhgkji5psx1Z/fQN4NhKrJeh2YJV8LrzRj2HtJS7i8PHiFRhhHqg1256+t27AhqVoaJcAgss78hHc8WQgn72SrUhddZ4jpTrKaKwrus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725706889; c=relaxed/simple;
	bh=nIzvUDWzTmIDcav2TmN/dZ4gyWJb6CNMCD2UVLcfnm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhG/tyeOAy4kwAYpFANAsUnk0hrsfbjaGKvAmq6oHMNvArFcO7MNW14L2ZqCMJglMWTY3XZJRGtkE1RgcorP4N6VkFfNf5GfqsNTHsopWV2L+JJ2sK/MA7K0/Q0rCl/3JGOSxqcwQRyH9TFGKt01Ylbu7/muxX/iY16INRqa8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JEHqEwC3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEHqEwC3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725706887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hLhHgWR0eVG2JRPZllJ+wNuDEYhirhDqR9BGvixqGqI=;
	b=JEHqEwC3jhdIvkD5KUKYYwix1bE66rJHTWtuc7994XNbr6P2acJ1+cQA3zRVfIYbrHcHyr
	AONIPKnOt/M9STKnSM9bslZdjokyUBDj4WhU5ZeC/Z6NehpHXiTS+YbPvfxOfrdeIkkfQ8
	hK295cct9Uv6NTvefgD8jZ3HrH+2DFs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-fk6ew0WsNk6Qg1zbOBbc2g-1; Sat,
 07 Sep 2024 07:01:23 -0400
X-MC-Unique: fk6ew0WsNk6Qg1zbOBbc2g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BD4F19560B1;
	Sat,  7 Sep 2024 11:01:22 +0000 (UTC)
Received: from localhost (unknown [10.42.28.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3DDB33000239;
	Sat,  7 Sep 2024 11:01:20 +0000 (UTC)
Date: Sat, 7 Sep 2024 12:01:19 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
	Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] block: elevator: avoid to load iosched module from this
 disk
Message-ID: <20240907110119.GE5140@redhat.com>
References: <20240907014331.176152-1-ming.lei@redhat.com>
 <20240907073522.GW1450@redhat.com>
 <ZtwHwTh6FYn+WnGD@fedora>
 <4d7280eb-7f26-4652-a1d4-4f82c4d99a4c@kernel.org>
 <ZtwhfCtDpTrBUFY+@fedora>
 <20240907100213.GY1450@redhat.com>
 <Ztwl2RvR0DGbNuex@fedora>
 <20240907103632.GZ1450@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907103632.GZ1450@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Sep 07, 2024 at 11:36:32AM +0100, Richard W.M. Jones wrote:
> I'm still running the test (takes 5,000 boot iterations before I can
> be "sure"), but so far it seems flipping this test fixes the bug.

This passed 5,000 iterations.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top

