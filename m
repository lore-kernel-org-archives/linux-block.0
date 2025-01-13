Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A422F19
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760306; cv=none; b=Va6kBunr3MHuI3J/LuXenfWclBCPl27XlNUTAEFUBlkzCYpQMEoVAH2UGMTHk402kY1PsfJW9eerjtsBOHxXC1d7HxYvyMij871D7xpA3ugIXUwWfXxGx9UbvWJvPPS5RT9iPdd1J1+BO5Wc2nwEc8dzHywG1LOuFjJWPHoUrcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760306; c=relaxed/simple;
	bh=pBVdBbrQS2kiPBVCU0ZscqbOdcg5mLrCpxccaRrib7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9CrWv+EWuWGlMlWeCBHkkLI0Q7GC2McS21ZVI8wAQiMOtULTfDuCWEA9y5N+YypZ9MiCdNV0VzuaLqHc/EW2mOgvBkvXHWfP7vyp1J7q3ZQ5NIHDTZhYPjvFRSQ+Mt3fDxajukKXNZ5BYIeqD4v4egdCm1g79oieXUqtCD8Om8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQ039XyG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQ039XyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736760303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhbbUyod6VE7lZuKtaz3uearCseKfcpZdslM20VcA8Q=;
	b=XQ039XyG2iC62/t9n55Q2ehQPUq9hRRuQd2kST9BI5ZTh9uGxwLPMzKenK4eWjpXjzC+nh
	QPYJOP+MYJveGtCBIJVxDP+RP7yBh98l/z3MFCUnTZQXLN1p2Mec3nzyAV5Iyh4E43WEUO
	P9zmmhaFMd0XubmA02VMZzisfB2rtpY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-drS-d540PhGVnFVyvxjGkw-1; Mon,
 13 Jan 2025 04:24:59 -0500
X-MC-Unique: drS-d540PhGVnFVyvxjGkw-1
X-Mimecast-MFC-AGG-ID: drS-d540PhGVnFVyvxjGkw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D127719560B8;
	Mon, 13 Jan 2025 09:24:57 +0000 (UTC)
Received: from fedora (unknown [10.72.116.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9B6630001BE;
	Mon, 13 Jan 2025 09:24:51 +0000 (UTC)
Date: Mon, 13 Jan 2025 17:24:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH] loop: don't call vfs_flush() with queue frozen
Message-ID: <Z4Tb3pmnXMk_z2Fm@fedora>
References: <20250113022426.703537-1-ming.lei@redhat.com>
 <Z4Spc75EiBXowzMu@infradead.org>
 <Z4TNW2PYyPUqwLaD@fedora>
 <Z4TaSGZDu_B2GS1c@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4TaSGZDu_B2GS1c@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jan 13, 2025 at 01:18:00AM -0800, Christoph Hellwig wrote:
> On Mon, Jan 13, 2025 at 04:22:51PM +0800, Ming Lei wrote:
> > On Sun, Jan 12, 2025 at 09:49:39PM -0800, Christoph Hellwig wrote:
> > > On Mon, Jan 13, 2025 at 10:24:26AM +0800, Ming Lei wrote:
> > > > If vfs_flush() is called with queue frozen, the queue freeze lock may be
> > > > connected with FS internal lock
> > > 
> > > What "FS internal lock" ?
> > 
> > Please see the report:
> > 
> > https://lore.kernel.org/linux-block/359BC288-B0B1-4815-9F01-3A349B12E816@m.fudan.edu.cn/T/#u
> 
> Please state the locks.  Nothing fs internal here, that report is
> about i_rwsem.  And a false positive because it is about ordering
> of i_rwsem on the upper file system sitting on the loop device vs the
> one on the lower file systems sitting below the block device.  These
> obviously can't deadlock, we just need to tell lockdep about that fact.

How can you guarantee that some code won't submit IO by grabbing the
i_rwsem?

As I explained, it is fine to move out vfs_fsync() out of freeze queue.

Actually any lock which depends on freeze queue needs to take a careful
look, because freeze queue connects too many global/sub-system locks.

Thanks,
Ming

