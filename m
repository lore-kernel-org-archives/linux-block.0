Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90A020F08C
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 02:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761619439; cv=none; b=J063hsn9n1M4UsoY2LlZVz1wA37ZcnOxr0whnMlMQjbrOq0tK0UT8eNiNtDHxFCGKaP1PfrZlvqiZIi6jtp/7tzSHKoQrFbkCB4CzoT8FpnuVUBx9bjiFgsv1OtCFf7TbK4ss8Gx9KRJ+Mb1HtvnMNGN+rmsPrAvNlLXRXy3SEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761619439; c=relaxed/simple;
	bh=23QlVBHlLIdw5zi75jhvVxlCy5RQkkV3FCk0YLh9Geo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw8pl6oFdfF9zEyXv726RZybqdfeNVQ+hiDLiHsBzHKiBC24ZelARDfj4AGYeWF8VJ24lWwrvmu0GOAfzpAb2Xkmtk1S24rAGxaaPXKOJFhw99r1vFVFxcqGDLcfnAmUHfsi3rEivAdsxIZ4tLl9bCrTF+RH2kQ3+s4vR25Z8B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lb1xPQKt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lb1xPQKt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761619436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMiqr9dKXJX66y7qwfiDCoXMKl7qrd2HrbiYTjdRXAI=;
	b=Lb1xPQKtW9t2cv+rVAbMdPtjWUUJh6+LXhSCxlE7V/pPceCSo3mpQ8W2gP8Gng6yLUWmEW
	v57h+X7tD8S7AZnXaDUIgBdWdw1rqnnK+huH+zjx0eQpmi8VHvKusNPVOXtlcyO0+1ZkaN
	yJUgZW/GpLYIGqeuwEhEDhnOznHhtdg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-5NQyWmpQP1K3ucyPpIuJXg-1; Mon,
 27 Oct 2025 22:43:52 -0400
X-MC-Unique: 5NQyWmpQP1K3ucyPpIuJXg-1
X-Mimecast-MFC-AGG-ID: 5NQyWmpQP1K3ucyPpIuJXg_1761619431
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B043180035A;
	Tue, 28 Oct 2025 02:43:50 +0000 (UTC)
Received: from fedora (unknown [10.72.120.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59C371800353;
	Tue, 28 Oct 2025 02:43:43 +0000 (UTC)
Date: Tue, 28 Oct 2025 10:43:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, yukuai1@huaweicloud.com,
	axboe@kernel.dk, yi.zhang@redhat.com, czhong@redhat.com,
	gjoyce@ibm.com
Subject: Re: [PATCH 2/3] block: introduce alloc_sched_data and
 free_sched_data elevator methods
Message-ID: <aQAt2rOO4dgkW10o@fedora>
References: <20251016053057.3457663-1-nilay@linux.ibm.com>
 <20251016053057.3457663-3-nilay@linux.ibm.com>
 <aPhgAMxgG2q0DKcv@fedora>
 <29e11529-aa37-47e1-a5c4-20fa100ae6cc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29e11529-aa37-47e1-a5c4-20fa100ae6cc@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Oct 27, 2025 at 11:08:13PM +0530, Nilay Shroff wrote:
> Hi Ming,
> 
> On 10/22/25 10:09 AM, Ming Lei wrote:
> > On Thu, Oct 16, 2025 at 11:00:48AM +0530, Nilay Shroff wrote:
> >> The recent lockdep splat [1] highlights a potential deadlock risk
> >> involving ->elevator_lock and ->freeze_lock dependencies on -pcpu_alloc_
> >> mutex. The trace shows that the issue occurs when the Kyber scheduler
> >> allocates dynamic memory for its elevator data during initialization.
> >>
> >> To address this, introduce two new elevator operation callbacks:
> >> ->alloc_sched_data and ->free_sched_data.
> > 
> > This way looks good.
> > 
> >>
> >> When an elevator implements these methods, they are invoked during
> >> scheduler switch before acquiring ->freeze_lock and ->elevator_lock.
> >> This allows safe allocation and deallocation of per-elevator data
> > 
> > This per-elevator data should be very similar with `struct elevator_tags`
> > from block layer viewpoint: both have same lifetime, and follow same
> > allocation constraint(per-cpu lock).
> > 
> > Can we abstract elevator data structure to cover both? Then I guess the
> > code should be more readable & maintainable, what do you think of this way?
> > 
> > One easiest way could be to add 'void *data' into `struct elevator_tags`,
> > just the naming of `elevator_tags` is not generic enough, but might not
> > a big deal.
> > 
> I realized that struct elevator_tags is already a member of struct elevator_queue,
> and we also have a separate void *elevator_data member within the same structure.
> 
> So, adding void *data directly into struct elevator_tags may not be ideal, as it
> would mix two logically distinct resources under a misleading name. Instead, we
> can abstract both — void *elevator_data and struct elevator_tags — into a new
> structure named struct elevator_resources. For instance:
> 
> struct elevator_resources {
>     void *data;
>     struct elevator_tags *et;
> };
> 
> struct elv_change_ctx {
> 	const char *name;
> 	bool no_uevent;
> 	struct elevator_queue *old;
> 	struct elevator_queue *new;
> 	struct elevator_type *type;
> 	struct elevator_resources res;
> };
> 
> I've just sent out PATCHv3 with the above change. Please review and let me know
> if this approach looks good to you.

It is fine to add `struct elevator_resources` for further abstraction, but
you need to abstract related methods too, otherwise the patch 3 still becomes
hard to follow: the existing blk_mq_free_sched_tags can be renamed to
blk_mq_free_sched_resource first, then you can call blk_mq_free_sched_data()
from blk_mq_free_sched_resource() inside only, instead of calling it
following every blk_mq_free_sched_tags().

Same with blk_mq_alloc_sched_tags_batch()/blk_mq_free_sched_tags_batch(),
you can make universal blk_mq_alloc_sched_res_batch/blk_mq_free_sched_res_batch()
to cover both tags & schedule data, and it is easier to extend in future too.




thanks
Ming

