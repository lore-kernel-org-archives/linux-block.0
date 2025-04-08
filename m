Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048FC22258E
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097907; cv=none; b=RaM300S5awaIuQYpuOiTMoFtW8UGsAL9YhfuQPLdn0XqeRFy+Lpwf+RouKZ3/5A7tR2Be6XJZR7GEONb0bYmR+H+XWWyhTyXG++wMr57I/MnhC6iMnpa8fswG4+uEmtWYwbeORiztgphGuluqV+zNivLOS0gigIOm/kB0r5Gl3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097907; c=relaxed/simple;
	bh=+P8Z5kaWUVhwhYVkNIzX5S/o57JxKd3RpuLs6ENylEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDjDSNAv1EQ7kr5WfxrnBEhy20YsKSNRpWcv4avlwTeAY9Uq75cMCAJA4PxKc0mrIfzblc+RtFZoE61TFroX0WxIwfcviz7OYvBSjWAmZ6Kseqc8wjPi+zBBRtkp7nm0IVLHP67AJsxj7FBbvpWuLF9tyVzV2/1J73eoKghAI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KsEuwldS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsEuwldS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744097904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjIPp6KSR1vBMh7tSaGc/rtctspnYim+NPInm2VeDOQ=;
	b=KsEuwldS512WO5wy4G/T54zwJpWECijkDwCPBE2EEqqEWphyRijc00/JWKYdHZi0+R6mGI
	wbE9HpFNiVGzRLU3VQam/AMZLVE5woBUS5N3PiJGWNcw1CliTRJ3hT7uUfjxLfzd2XxUhy
	eyJfBrCDXUSSgx84nL/138mCVfdHrlM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-SwRlVUTbNOmkozV8O9XF9g-1; Tue,
 08 Apr 2025 03:38:20 -0400
X-MC-Unique: SwRlVUTbNOmkozV8O9XF9g-1
X-Mimecast-MFC-AGG-ID: SwRlVUTbNOmkozV8O9XF9g_1744097899
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B79BE180034D;
	Tue,  8 Apr 2025 07:38:18 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C61D61955DCE;
	Tue,  8 Apr 2025 07:38:14 +0000 (UTC)
Date: Tue, 8 Apr 2025 15:38:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
Message-ID: <Z_TSYOzPI3GwVms7@fedora>
References: <20250403105402.1334206-1-ming.lei@redhat.com>
 <20250404091037.GB12163@lst.de>
 <92feba7e-84fc-4668-92c3-aba4e8320559@linux.ibm.com>
 <Z_NB2VA9D5eqf0yH@fedora>
 <ea09ea46-4772-4947-a9ad-195e83f1490d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea09ea46-4772-4947-a9ad-195e83f1490d@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Apr 07, 2025 at 01:59:48PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/7/25 8:39 AM, Ming Lei wrote:
> > On Sat, Apr 05, 2025 at 07:44:19PM +0530, Nilay Shroff wrote:
> >>
> >>
> >> On 4/4/25 2:40 PM, Christoph Hellwig wrote:
> >>> On Thu, Apr 03, 2025 at 06:54:02PM +0800, Ming Lei wrote:
> >>>> Fixes the following lockdep warning:
> >>>
> >>> Please spell the actual dependency out here, links are not permanent
> >>> and also not readable for any offline reading of the commit logs.
> >>>
> >>>> +static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> >>>> +				   struct request_queue *q, bool lock)
> >>>> +{
> >>>> +	if (lock) {
> >>>
> >>> bool lock(ed) arguments are an anti-pattern, and regularly get Linus
> >>> screaming at you (in this case even for the right reason :))
> >>>
> >>>> +		/* protect against switching io scheduler  */
> >>>> +		mutex_lock(&q->elevator_lock);
> >>>> +		__blk_mq_realloc_hw_ctxs(set, q);
> >>>> +		mutex_unlock(&q->elevator_lock);
> >>>> +	} else {
> >>>> +		__blk_mq_realloc_hw_ctxs(set, q);
> >>>> +	}
> >>>
> >>> I think the problem here is again that because of all the other
> >>> dependencies elevator_lock really needs to be per-set instead of
> >>> per-queue which will allows us to have much saner locking hierarchies.
> >>>
> >> I believe you meant here q->tag_set->elevator_lock? 
> > 
> > I don't know what locks you are planning to invent.
> > 
> > For set->tag_list_lock, it has been very fragile:
> > 
> > blk_mq_update_nr_hw_queues
> > 	set->tag_list_lock
> > 		freeze_queue
> > 
> > If IO failure happens when waiting in above freeze_queue(), the nvme error
> > handling can't provide forward progress any more, because the error
> > handling code path requires set->tag_list_lock.
> 
> I think you're referring here nvme_quiesce_io_queues and nvme_unquiesce_io_queues

Yes.

> which is called in nvme error handling path. If yes then I believe this function 
> could be easily modified so that it doesn't require ->tag_list_lock. 

Not sure it is easily, ->tag_list_lock is exactly for protecting the list of "set->tag_list".

And the same list is iterated in blk_mq_update_nr_hw_queues() too.

> 
> > 
> > So all queues should be frozen first before calling blk_mq_update_nr_hw_queues,
> > fortunately that is what nvme is doing.
> > 
> > 
> >> If yes then it means that we should be able to grab ->elevator_lock
> >> before freezing the queue in __blk_mq_update_nr_hw_queues and so locking
> >> order should be in each code path,
> >>
> >> __blk_mq_update_nr_hw_queues
> >>     ->elevator_lock 
> >>       ->freeze_lock
> > 
> > Now tagset->elevator_lock depends on set->tag_list_lock, and this way
> > just make things worse. Why can't we disable elevator switch during
> > updating nr_hw_queues?
> > 
> I couldn't quite understand this. As we already first disable the elevator
> before updating sw to hw queue mapping in __blk_mq_update_nr_hw_queues().
> Once mapping is successful we switch back the elevator.

Yes, but user still may switch elevator from none to others during the
period, right?


thanks,
Ming

