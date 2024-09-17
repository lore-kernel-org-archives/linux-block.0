Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7144716B38B
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578179; cv=none; b=mzrQQNDxB8w/FSygK94TRVWQql5I+tbbH4nwftUQ2YdWqfGwBrFldH33Ba7y8BPnrZDVtRW73yJvnbjMRv2ouJ7zXPz4wBW6uheU3eXIpx5zvC9m405C45I3iaVB/+BGLqcBVLiTwidHq2hZPU6pC8dagoLF8/mYiXfR6OA+Lpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578179; c=relaxed/simple;
	bh=x+xbC+PB4cV2R7+gSIx9WXHHYsod8ahiFnkX2bA4RXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6xHGlBA4Mto04iPL9bmdnWIxxpo/kRhWk9/Cg4fvoWqnsWRAG9Bqm1MoYdlwbj0Pb5LWNfNWeyXE+PpsIqBj/WRt/KExe1fZtDz9OKTKZR4/sDHQYLEZTfbAuzPx7ocPZOCGyGewLVMQzI9Dvj5AD+QXfcNuZXomPcS7hVfBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g1sxRNL1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1sxRNL1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726578176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=81Gj3O3kbtdZa4nDSPY1LnR32lX93cZKq8azMnYLsck=;
	b=g1sxRNL1IwlTrleBMciDYj4EO0cTZ9J7YN7MLwZkJ4PQIksv+Jqjk4XMWGRBZnW3KVTVLk
	k3oR+/+oDzBPfkX4lC77F3xN0eY+ZnOmGgpLuSopy6y2kLZPErm95z7pKkGslztFadtGq1
	sA0RGJ05DokhT0TCvpV4uemMItB065E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-zugg3eFkOQGkwxLs2AW3tA-1; Tue,
 17 Sep 2024 09:02:53 -0400
X-MC-Unique: zugg3eFkOQGkwxLs2AW3tA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A8611944AAD;
	Tue, 17 Sep 2024 13:02:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0836830001A4;
	Tue, 17 Sep 2024 13:02:41 +0000 (UTC)
Date: Tue, 17 Sep 2024 21:02:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Jeff Moyer <jmoyer@redhat.com>, Jiri Jaburek <jjaburek@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block: Fix elv_iosched_local_module handling of "none"
 scheduler
Message-ID: <Zul97FvBsVuC1_h3@fedora>
References: <20240917053258.128827-1-dlemoal@kernel.org>
 <20240917055331.GA2432@lst.de>
 <CAFj5m9JZe5g07YNVh6BL8ZixabRTrhx-AELxTxFNm9STM7gNzA@mail.gmail.com>
 <5ff26f49-dea6-4667-ae90-7b61908f67cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ff26f49-dea6-4667-ae90-7b61908f67cf@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Sep 17, 2024 at 02:48:06PM +0200, Damien Le Moal wrote:
> On 2024/09/17 14:33, Ming Lei wrote:
> > On Tue, Sep 17, 2024 at 1:53 PM Christoph Hellwig <hch@lst.de> wrote:
> >>
> >> On Tue, Sep 17, 2024 at 02:32:58PM +0900, Damien Le Moal wrote:
> >>> Commit 734e1a860312 ("block: Prevent deadlocks when switching
> >>> elevators") introduced the function elv_iosched_load_module() to allow
> >>> loading an elevator module outside of elv_iosched_store() with the
> >>> target device queue not frozen, to avoid deadlocks. However, the "none"
> >>> scheduler does not have a module and as a result,
> >>> elv_iosched_load_module() always returns an error when trying to switch
> >>> to this valid scheduler.
> >>>
> >>> Fix this by checking that the requested scheduler is "none" and doing
> >>> nothing in that case.
> >>
> >> The old code before this commit simply ignored the request_module,
> >> just as most callers of it do.  I think that's the right approach
> >> here as well.
> > 
> > freeze queue is actually easy to cause deadlock, and old code is to not
> > do it everywhere.
> > 
> > Probably it may be more reliable to replace 'load_module' with 'no_freeze',
> > and not to freeze queue in case that 'no_freeze' is set in queue_attr_store().
> 
> load_module or whatever the name you prefer, should NOT imply that freezing the
> queue is not necessary. Switching the IO scheduler is really one such case.
> Switching the scheduler really needs to be done with the queue frozen, but the
> scheduler module loading needs to be done with the queue live.

Here 'no_freeze' means that automatic 'freeze queue' isn't needed, or
it can be named as 'no_auto_freeze'.

Again, 'load_module' is one bad name from interface viewpoint, which is just
needed by 'scheduler' only.

> 
> > queue_wb_lat_store() need no_freeze too since there is GFP_KERNEL
> > allocation involved.
> 
> No, because again the attribute may need to have the queue frozen to correctly
> be changed. To avoid hangs, what is needed is to force a GFP_NOIO context before
> calling the attribute ->store() operation. Doing so, any memory allocation that
> the attribute change may need will not cause re-entry into a frozen queue (which
> would result in a hang).
> 
> This is easy to do with memalloc_noio_save()/memalloc_noio_restore().

But why do we need that? Just for paper over the problem caused by the
unnecessary freeze queue?


Thanks,
Ming

