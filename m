Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96A10E0
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 02:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745720886; cv=none; b=R60E2EvCkihej6wxo7YDuR5r44nkCiANbasia+fwsczbLWV0sPud44RB1TXs6OH5yzTIFG2/EFokb7r+f1dbxc3lTB6sjHab5zqqxeGeEBtHLzkWklA74I8mZooUlNQYpUu+9o7HI90XLP0jfvwodls7J8LhzzC8p6uNbsHWuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745720886; c=relaxed/simple;
	bh=4n2S5ZUkjlNjLGFV7iru2NgvfgzoJQEyD0nmiuXuFz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWPKEJR77pW6RhAbWIk7w/t1BikTsjOh7869mng2ZtxWK6HwNB6EgCJuv0XE1j6iZ2753OFbf1EJNyW4DSCa1cMEH3esxQztitd7A0q5C/FjCu3HqeKmXeekTdexCx6nC5HpAIE0eZiYGwprjffWEjDvQaGz5n3i2aWmWZ6qnRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZ+oOZJJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZ+oOZJJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745720883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLKXhYIPwsLJ3tXNG8rbtsFqMEchlwn75cIzhXLT5Lo=;
	b=PZ+oOZJJjfmG6dwrWqJZyGB/Ildcn15c6h2QgGYHF/XFnyV9D3avSY4i2Yonfbct18QzcE
	0SdUOESgjvDDM2x7wOZMwMH7FPq+G0UJwsmHI66tOB5rs5wglcvMp6+6CIwNVIJ5FlUVk9
	6hXDLf6Sb8EKhz1zgCxFtWHRst3+C8Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-mrAYYaiCP3SQ8_xdalIWDw-1; Sat,
 26 Apr 2025 22:27:58 -0400
X-MC-Unique: mrAYYaiCP3SQ8_xdalIWDw-1
X-Mimecast-MFC-AGG-ID: mrAYYaiCP3SQ8_xdalIWDw_1745720877
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 529BC1800368;
	Sun, 27 Apr 2025 02:27:56 +0000 (UTC)
Received: from fedora (unknown [10.72.116.41])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 102E41956094;
	Sun, 27 Apr 2025 02:27:51 +0000 (UTC)
Date: Sun, 27 Apr 2025 10:27:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 08/20] block: don't allow to switch elevator if
 updating nr_hw_queues is in-progress
Message-ID: <aA2WIiHJprr_bmJ5@fedora>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-9-ming.lei@redhat.com>
 <748f3e46-51c1-47f8-8614-64efb30dd4ff@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <748f3e46-51c1-47f8-8614-64efb30dd4ff@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Apr 25, 2025 at 06:18:33PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/24/25 8:51 PM, Ming Lei wrote:
> > Elevator switch code is another `nr_hw_queue` reader in non-fast-IO code
> > path, so it can't be done if updating `nr_hw_queues` is in-progress.
> > 
> > Take same approach with not allowing add/del disk when updating
> > nr_hw_queues is in-progress, by grabbing read lock of
> > set->update_nr_hwq_sema.
> > 
> > Take the nested variant for avoiding the following false positive
> > splat[1], and this way is correct because:
> > 
> > - the read lock in elv_iosched_store() is not overlapped with the read lock
> > in adding/deleting disk:
> > 
> > - kobject attribute is only available after the kobject is added and
> > before it is deleted
> > 
> >   -> #4 (&q->q_usage_counter(queue){++++}-{0:0}:
> >   -> #3 (&q->limits_lock){+.+.}-{4:4}:
> >   -> #2 (&disk->open_mutex){+.+.}-{4:4}:
> >   -> #1 (&set->update_nr_hwq_lock){.+.+}-{4:4}:
> >   -> #0 (kn->active#103){++++}-{0:0}:
> > 
> > Link: https://lore.kernel.org/linux-block/aAWv3NPtNIKKvJZc@fedora/ [1]
> > Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Closes: https://lore.kernel.org/linux-block/mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc/
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/elevator.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/block/elevator.c b/block/elevator.c
> > index 4400eb8fe54f..56da6ab7691a 100644
> > --- a/block/elevator.c
> > +++ b/block/elevator.c
> > @@ -723,6 +723,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
> >  	int ret;
> >  	unsigned int memflags;
> >  	struct request_queue *q = disk->queue;
> > +	struct blk_mq_tag_set *set = q->tag_set;
> >  
> >  	/*
> >  	 * If the attribute needs to load a module, do it before freezing the
> > @@ -734,6 +735,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
> >  
> >  	elv_iosched_load_module(name);
> >  
> > +	down_read_nested(&set->update_nr_hwq_sema, 1);
> 
> Why do we need to add nested read lock here? The lockdep splat[1] which
> you reported earlier is possibly due to the same reader lock being acquired
> recursively in elv_iosched_store and then elevator_change? 

The splat isn't related with the nested read lock.

If you replace down_read_nested() with down_read(), the same splat can be
triggered again when running `blktests block/001`.

>  
> On another note, if we suspect possible one-depth recursion for the same 
> class of lock then then we should use SINGLE_DEPTH_NESTING (instead of using
> 1 here) for subclass. But still I am not clear why this lock needs nesting.

It is just one false positive, because elv_iosched_store() won't happen
when adding disk.


Thanks,
Ming

