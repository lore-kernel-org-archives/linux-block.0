Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8BD22AE7A
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 01:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517172; cv=none; b=roA+l1JF8Rle6HHB9HpKJITGjkv7OOfSUXBXgjlIKBUZ5hmYUiddRksJEEwrcJqjLTh1lDAgwGtiJrP9lo9XF2y3K/vwrnVYVIMO9Wc36Ab3Vi3AcaAJrVHkm56Syd7alBrlkBE9cj/JODRavemu2PnepvDOZgePryF2CzcLBm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517172; c=relaxed/simple;
	bh=LEzpLo1hUxryXT8cMpe80ker7J7M+LCuwGcuDq4/zvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDsh1eB1ZZ2DW/eAX3hfl9R4enXuxGhHnAvssvF+YTjIxA3aIY+3xSoh/EpqhwrY6T82B/ss5ZAjsZhXKJyVO4g1JvueBx4bQtPOF5V1P9XkbuqwdvTON5N5r3iEeqXSDb/k9mXtRH/FijvdlxiswEALXXs/4ovDN66jj0R/iC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fndKsSeX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fndKsSeX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763517168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aj/ywx73k81CNsOcA+I92pYtR8bwljudVgYjAUUAFmg=;
	b=fndKsSeXSCtyRz6iPvU2W1zfpR682l7SaorvsFCBSb8l23ErFwbgmamXKSAwLHv9WzSauO
	CGlOJe5ScaSIPOu0plhSPa1b3eqJMI6myeLyv3Aexgw7sgUK5/agdKqtEr/uPUrT5en5qN
	swsR5PAQo1RI3R3jLtwASFnB16gnHV4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-vRIljo3vNcaB4O5-uj7jAg-1; Tue,
 18 Nov 2025 20:52:42 -0500
X-MC-Unique: vRIljo3vNcaB4O5-uj7jAg-1
X-Mimecast-MFC-AGG-ID: vRIljo3vNcaB4O5-uj7jAg_1763517160
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38F9718AB400;
	Wed, 19 Nov 2025 01:52:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFC67195608E;
	Wed, 19 Nov 2025 01:52:30 +0000 (UTC)
Date: Wed, 19 Nov 2025 09:52:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Guo, Wangyang" <wangyang.guo@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, Tianyou Li <tianyou.li@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Dan Liang <dan.liang@intel.com>
Subject: Re: [PATCH RESEND] lib/group_cpus: make group CPU cluster aware
Message-ID: <aR0i2f91VGv47swo@fedora>
References: <20251111020608.1501543-1-wangyang.guo@intel.com>
 <aRKssW96lHFrT2ZN@fedora>
 <b94a0d74-0770-4751-9064-2ef077fada14@intel.com>
 <aRMnR5DRdsU8lGtU@fedora>
 <a101fe80-ca0b-4b4b-94b1-f08db1b164fc@intel.com>
 <aRU2sC5q5hCmS_eM@fedora>
 <da1d6b4e-038c-48dc-830d-5eadb3ac943f@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da1d6b4e-038c-48dc-830d-5eadb3ac943f@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Nov 18, 2025 at 02:29:20PM +0800, Guo, Wangyang wrote:
> On 11/13/2025 9:38 AM, Ming Lei wrote:
> > On Wed, Nov 12, 2025 at 11:02:47AM +0800, Guo, Wangyang wrote:
> > > On 11/11/2025 8:08 PM, Ming Lei wrote:
> > > > On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
> > > > They still should share same L3 cache, and cpus_share_cache() should be
> > > > true when the IO completes on the CPU which belong to different L2 with the
> > > > submission CPU, and remote completion via IPI won't be triggered.
> > > Yes, remote IPI not triggered.
> > 
> > OK, in my test on AMD zen4, NVMe performance can be dropped to 1/2 - 1/3 if
> > remote IPI is triggered in case of crossing L3, which is understandable.
> > 
> > I will check if topo cluster can cover L3, if yes, the patch still can be
> > simplified a lot by introducing sub-node spread by changing build_node_to_cpumask()
> > and adding nr_sub_nodes.
> 
> Do you mean using cluster as "NUMA" nodes to spread CPU, instead of two
> level NUMA-cluster spreading?

Yes, I think the change may be minimized by introducing sub-numa-node for
covering it, what do you think of this approach?

However, it is bad to use cluster as sub-numa-node at default, because cluster
is aligned with CPUs sharing L2 cache, so there could be too many clusters
for many systems in which one cluster just includes two CPUs, then the finally
calculated mapping crosses clusters inevitably because nr_queues is
less than nr_clusters.

I'd suggest to map CPUs sharing L3 cache into one sub-numa-node.

For your case, either adding one kernel parameter, or adding group_cpus_cluster()
API for the unusual case by sharing single code path.


Thanks,
Ming

