Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0024EA9F
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690307; cv=none; b=S3DADa3f4UWIJfHf0u2VYGaSeggqKfikY2YD1CX6GAy1rV8rld+RKEwtJUNWo4ShKG41/j6w6SoKHAGWMTIWJxRklZ6yllVnjvkqrsewBAGmKo48OLdGivczX8Xtxk0seTbWXh9TelrtS/qZkvS1yRjNlgMC2x9IDmtRyHU4l44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690307; c=relaxed/simple;
	bh=U+AvKGY4oJFga+mcXMkXaBYtgGkRgcY35eDONObHS00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIjtNNxza99vjZNVqCHExrZ5mJxCsH+pX6Nt4cpd84PO8Kf0RhSu83l06aCm3+GLyhPnGzmQSlVNONeiSB97OJFDXvy+yyMUjj35CNpn0Kma4KW23YSuZeFZh5IWARCeSsk1a/CRONscjn3+57DODw/e3AWWYV3PsRlHFXXUe8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zr6uVNdX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zr6uVNdX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743690304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fEIO8Zvlm6MFPSfbl8DUD3Zz7gRPLujnYomp55RkYsY=;
	b=Zr6uVNdXpsJf+Pht/mbJVrs0F8gYQEjKwI/kukYJx9jxpgafg0zGF52Uxwe5Hyl6MdW+2z
	8R29LtIhGWBPDFG32DrAt6WCD4DmfgwfyUQv6Mec1QDguyKJHzWuZjpZvUBq8PSMLwfoaP
	Zr2kfcNqH4K3BFMptyy21lJwsJzTSFU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-uW0KmPwfOP6f2bMl6kj2EQ-1; Thu,
 03 Apr 2025 10:25:01 -0400
X-MC-Unique: uW0KmPwfOP6f2bMl6kj2EQ-1
X-Mimecast-MFC-AGG-ID: uW0KmPwfOP6f2bMl6kj2EQ_1743690300
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1259D195609F;
	Thu,  3 Apr 2025 14:25:00 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 182A03001D0E;
	Thu,  3 Apr 2025 14:24:54 +0000 (UTC)
Date: Thu, 3 Apr 2025 22:24:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
Message-ID: <Z-6aMa6vqzsLJMNm@fedora>
References: <20250403105402.1334206-1-ming.lei@redhat.com>
 <9933c2e6-1cbd-464c-a519-b7fa722a8e4d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9933c2e6-1cbd-464c-a519-b7fa722a8e4d@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Apr 03, 2025 at 06:49:05PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/3/25 4:24 PM, Ming Lei wrote:
> > ->elevator_lock depends on queue freeze lock, see block/blk-sysfs.c.
> > 
> > queue freeze lock depends on fs_reclaim.
> > 
> > So don't grab elevator lock during queue initialization which needs to
> > call kmalloc(GFP_KERNEL), and we can cut the dependency between
> > ->elevator_lock and fs_reclaim, then the lockdep warning can be killed.
> > 
> > This way is safe because elevator setting isn't ready to run during
> > queue initialization.
> > 
> > There isn't such issue in __blk_mq_update_nr_hw_queues() because
> > memalloc_noio_save() is called before acquiring elevator lock.
> > 
> > Fixes the following lockdep warning:
> > 
> > https://lore.kernel.org/linux-block/67e6b425.050a0220.2f068f.007b.GAE@google.com/
> > 
> > Reported-by: syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
> > Cc: Nilay Shroff <nilay@linux.ibm.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> > 
> I think you earlier posted this same patch here:
> https://lore.kernel.org/linux-block/Z-dUCLvf06SfTOHy@fedora/
> 
> I tested that earlier patch and got into another lockdep splat as reported here: 
> https://lore.kernel.org/linux-block/462d4e8a-dd95-48fe-b9fe-a558057f9595@linux.ibm.com/

That is another different one, let's fix this one first.

The ->elevator_lock in blk_register_queue() should be for avoiding race
with updating nr_hw_queues, right?

That is why I think the dependency between elevator lock and freeze lock
is one trouble.

> 
> I don't know why we think your earlier fix which cut dependency between 
> ->elevator_lock and ->freeze_lock doesn't work. But anyways, my view
> is that we've got into these lock chains from two different code paths:

As I explained, blk_mq_enter_no_io() is same with freeze queue, just the
lock in __bio_queue_enter() isn't modeled. If it is done, every lockdep
warning will be re-triggered too.

> 
> path1: elevator_lock 
>          -> fs_reclaim (GFP_KERNEL)
>            -> freeze_lock
> 
> path2: freeze_lock(memalloc_noio) 
>          -> elevator_lock 
>            -> fs_reclaim (this becomes NOP in this case due to memalloc_noio)

No, there isn't fs_reclaim in path2, and memalloc_noio() will avoid it.


Thanks,
Ming

