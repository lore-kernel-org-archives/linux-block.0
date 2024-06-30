Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736A13E034
	for <linux-block@vger.kernel.org>; Sun, 30 Jun 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719754823; cv=none; b=a1tCl5PV/ZMhw1UCo99awcz5Xyo3856A4BmtxhJWH1xz/hvCNo+ZxrJP2OT06uLrmSl4XK8g+DZmFJcREkij9UrYN3+qWDSAhUa0ubfG/8RTSxPz/nOp6W8MTE8yw33JVjyK/IQQxatXy7A1ip6w1QuwUjhDwFwRAksSXGfHpZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719754823; c=relaxed/simple;
	bh=wFNUxVnJfRBSh6KLectcbHL1hfVs72pwsT9+tRhzKWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uB6ttub9V9m4yWpccC1YGRIabRLayQI7uDoms410SFpKsYp/0WkRjsEuH3Ly6mg3s//QsDMktDUKtwWTrIAACh8DbUDNorSF0EUdWAKbBgUtUQFFA5mXJcRipLne/mwmc8j+x+GYGZ/GyCVE8ehtlySUoPcAolt8VzRduyGItFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gt5hlsAz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gt5hlsAz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719754820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PpJVArXnfD1gJGwSlZy8hYot2UR3RMaatDvx0IO2VfU=;
	b=Gt5hlsAzMhuiYL7BmOFfIXH3fylLjiaZPzrtpzJtit3+cm98Li0unK/dH9crr2As2I7CRb
	31/SoU5xVPB0zeXs0rM59U4fuIYpAIkB2kMkryHqvlcAzI2FlBFzYxljM6xSjjG+xU7N5m
	19+pVSibrR6N3jabCXJPqucY3MUzSd8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-JUCwpazyNwCOoI7ZaS9hkw-1; Sun,
 30 Jun 2024 09:40:17 -0400
X-MC-Unique: JUCwpazyNwCOoI7ZaS9hkw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47FCA19560B4;
	Sun, 30 Jun 2024 13:40:14 +0000 (UTC)
Received: from fedora (unknown [10.72.112.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 022E719560AA;
	Sun, 30 Jun 2024 13:40:04 +0000 (UTC)
Date: Sun, 30 Jun 2024 21:39:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
Message-ID: <ZoFgLxGXrk4VCR03@fedora>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jun 27, 2024 at 04:10:53PM +0200, Daniel Wagner wrote:
> group_cpus_evenly distributes all present CPUs into groups. This ignores

The above isn't true, it is really cpu_possible_mask which is
distributed, instead of all present CPUs.

> the isolcpus configuration and assigns isolated CPUs into the groups.
> 
> Make group_cpus_evenly aware of isolcpus configuration and use the
> housekeeping CPU mask as base for distributing the available CPUs into
> groups.
> 
> Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")

isolated CPUs are actually handled when figuring out irq effective mask,
so not sure how commit 11ea68f553e2 is wrong, and what is fixed in this
patch from user viewpoint?


Thanks, 
Ming

