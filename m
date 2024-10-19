Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A87462
	for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729342252; cv=none; b=F3laY4KAIrti3B+pVKozyR/q4oio8smZgjsm0lrbDTGwPMcwKbQbjucKVzBM2G/vmj6kaRC/IF7cy87qtFxQ4mLXqycyQHijEnmBM4qwl4J+b2NFXUPAncyEBf288TFrh7Dj4eJUeSH6xrsG5FqXrQZzyL6D5Q6OQ8ih11FrQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729342252; c=relaxed/simple;
	bh=bbMx99ElYP//RCD6kpDAmOB+OR5dYCSs+Q5RM4Izk3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOAR2TTvKOaRa8//bAzEBwmMRKalSwrkjDoDRBi9K8HoaBJRW8cVMOVM8YIB0eEFzBLIHcyU89e+MfPgLOd0wfTjU7gUBRKb63FZWZ4GkHyuyE/dpIjgAYcAvbfJQ/edNGV8VDWYCABzgZMEKsv8VmoZa3VrBkmZ0mI1tbU2gzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EldNwEXt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EldNwEXt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729342249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3dfRYAC5kdb+8Wh0uxc69PbWR6OcDcGW2U1Unmcf8cI=;
	b=EldNwEXtTMYx9GJinkwraXPzXVhqJabwIyQbwPd1dgsqk0sEevkWK59LnE0urTOEUTk8eL
	OMyFS8HRud2sdy8u6VW+nWCZaq8fUx8UAVtidQ4/KAuVj1MhMGl9leBXEKIXsNvoRrbn1a
	ddMkj0ohuFiQ833vSGrDzdWl7M1heDw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-HKsxzfPnNgSdyniSbreECw-1; Sat,
 19 Oct 2024 08:50:45 -0400
X-MC-Unique: HKsxzfPnNgSdyniSbreECw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56F08195608B;
	Sat, 19 Oct 2024 12:50:44 +0000 (UTC)
Received: from fedora (unknown [10.72.116.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C63919560A2;
	Sat, 19 Oct 2024 12:50:38 +0000 (UTC)
Date: Sat, 19 Oct 2024 20:50:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <ZxOrGeZnI52LcGWF@fedora>
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-2-hch@lst.de>
 <Zw_BBgrVAJrxrfpe@fedora>
 <20241019012541.GD1279924@google.com>
 <ZxOmzVLWj0X10_3G@fedora>
 <20241019123727.GE1279924@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019123727.GE1279924@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Oct 19, 2024 at 09:37:27PM +0900, Sergey Senozhatsky wrote:
> On (24/10/19 20:32), Ming Lei wrote:
> [..]
> > > > When ->release() waits in blk_enter_queue(), the following code block
> > > > 
> > > > 	mutex_lock(&disk->open_mutex);
> > > > 	__blk_mark_disk_dead(disk);
> > > > 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
> > > > 	        drop_partition(part);
> > > > 	mutex_unlock(&disk->open_mutex);
> > > 
> > > blk_enter_queue()->schedule() holds ->open_mutex, so that block
> > > of code sleeps on ->open_mutex. We can't drain under ->open_mutex.
> > 
> > We don't start to drain yet, then why does blk_enter_queue() sleeps and
> > it waits for what?
> 
> Unfortunately I don't have a device to repro this, but it happens to a
> number of our customers (using different peripheral devices, but, as far
> as I'm concerned, all running 6.6 kernel).

I can understand the issue on v6.6 because it doesn't have commit
7e04da2dc701 ("block: fix deadlock between sd_remove & sd_release").

But for the latest upstream, I don't get idea how it can happen.


Thanks,
Ming

