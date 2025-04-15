Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA62750F2
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720926; cv=none; b=PS6ULupiWW9wSPx5ktdK+yZVNYtRE1gX/vW99oy0cNVRR0PAxK8P4MUk2RR1UOXaoJRUhUtFY9Y1W9F5aaqtIUp95AHDO2RToEB/JDCh/ddKmnRKXg8n+l0ZZfzsLmk5lP6nNytF7IGOcnntUsXPsyZMAV0nkLzYAhLYlt5oKCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720926; c=relaxed/simple;
	bh=A8xeEAv89ZFYCUUEx8QlXYd/u+pTGF/YLkVTtGGsFGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyzpBze4F6fSNeS/uGcnbYKSdXJNsQ2WDoBxxOFqmYSuWGj+4dZ1P6IQrlwWb7whRpvbjPPSG2Nl7x7B97OlDOw0oIw2KktUBomv0bXvJshNsgPnG8Oxtqkju48SB8Yd4iuErrOUhN7o0BbZvAnkVb6KFgbHU8GtD4yobBsmkKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYg19mUY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYg19mUY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744720923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kZBPt4X22EQpa9MuR3eyN/P6OWQOPMjJX1tHfDg8bo=;
	b=EYg19mUYOFXWI3MxMgZy4Atwv1+x+jAzy52jhJTboqDy/GTem9RECvbv0mcOjSHJCh5QAC
	RNPYIkH7JJxGHI44v2jGGswKMNDNNRpnVTNsRA74xVXn5DOyXKczYlmtozhrFhY84jtOJJ
	gH9wY7K/9Hs7zI4uQ70TapmQ799Nypg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-dMY5t9OsOj2PJyO6NCDn3g-1; Tue,
 15 Apr 2025 08:42:00 -0400
X-MC-Unique: dMY5t9OsOj2PJyO6NCDn3g-1
X-Mimecast-MFC-AGG-ID: dMY5t9OsOj2PJyO6NCDn3g_1744720919
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05166180AF4D;
	Tue, 15 Apr 2025 12:41:59 +0000 (UTC)
Received: from fedora (unknown [10.72.116.70])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39D9F1801766;
	Tue, 15 Apr 2025 12:41:53 +0000 (UTC)
Date: Tue, 15 Apr 2025 20:41:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/15] block: move debugfs/sysfs register out of freezing
 queue
Message-ID: <Z_5UDa_d5Fubx2_j@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-13-ming.lei@redhat.com>
 <b28d98a6-b406-45b0-a5db-11bc600be75f@linux.ibm.com>
 <Z_xn-Zl5FDGdZ_Bk@fedora>
 <96d870d2-19f2-489e-951f-b92a56b59bf6@linux.ibm.com>
 <Z_4vwU7HMLCShZUO@fedora>
 <bf874ae8-d26c-4b00-92ac-acbd3e6f4c3c@linux.ibm.com>
 <Z_5I3oSmT9jRVu4Z@fedora>
 <43325beb-6147-4f51-8e79-0c31db2ef742@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43325beb-6147-4f51-8e79-0c31db2ef742@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Apr 15, 2025 at 05:51:07PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/15/25 5:24 PM, Ming Lei wrote:
> >>>
> >>> Why is updating nr_requests related with removing hctx attributes?
> >>>
> >>> Can you explain the side effect in details?
> >> Thread 1:
> >> writing-to-blk-mq-sysfs-attribute-nr_requests 
> >>   -> queue_requests_store ==> freezes queue and acquires ->elevator_lock 
> >>     -> blk_mq_update_nr_requests 
> >>       -> blk_mq_tag_update_depth
> >>         -> blk_mq_alloc_map_and_rqs
> >>           -> blk_mq_alloc_rq_map
> >>             -> blk_mq_init_tags ==> updates ->nr_tags and ->nr_reserved_tags 
> >>
> >> Thread2:
> >> blk_mq_update_nr_hw_queues
> >>   -> __blk_mq_update_nr_hw_queues
> >>     -> blk_mq_realloc_tag_set_tags
> >>       -> __blk_mq_alloc_map_and_rqs
> >>         -> blk_mq_alloc_map_and_rqs
> >>           -> blk_mq_alloc_rq_map
> >>             -> blk_mq_init_tags ==> updates ->nr_tags and ->nr_reserved_tags 
> >>
> >> Thread 3:
> >> reading-hctx-sysfs-attribute-nr_tags
> >>   -> blk_mq_hw_sysfs_show ==> acquires ->elevaor_lock
> >>     ->  blk_mq_hw_sysfs_nr_tags_show ==> access nr_tags 
> >>
> >> Thread 4:
> >> reading-hctx-sysfs-attribute-nr_reserved_tags
> >>   -> blk_mq_hw_sysfs_show ==> acquires ->elevaor_lock
> >>     -> blk_mq_hw_sysfs_nr_reserved_tags_show ==> access nr_reserved_tags
> > 
> > `hctx->tags` is guaranteed to be live if above ->show() method, and the
> > elevator lock is actually not needed, which isn't supposed to protect
> > hctx->tags too.
> > 
> I think, the ->elavtor_lock would still be needed for protecting updates to 
> hctx->tags from thread # 1 above and simultaneously reading the hctx->tags from 
> thread #3 and #4 above.

update_nr_requests() can just reduce ->tags.sbitmap size, please see
blk_mq_tag_update_depth(), even it won't change hctx->tags->nr_tags, so there
isn't race.

More importantly ->elevator_lock shouldn't cover ->tags which isn't related
with scheduler, one exception is blk-mq debugfs, in which request may be
allocated from ->sched_tags, even ->tags is visiting.


Thanks, 
Ming

