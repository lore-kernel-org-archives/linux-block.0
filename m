Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273C7289343
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713155; cv=none; b=T0jNq1EH8XcCdKxXZSa1K631qwcYL/psZlNU76JpJWpi/dd7QcgocdTzPsiPhgZ/co+OuQWwsPlKFXBu70/iDqU/aVPNFVQBi++hgAf32/1XnXTwfk444RuNh8o61Z67ey7ulLJsH5YVoziJmWtfPVXqPFf5MVIqT1BmKnlRrPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713155; c=relaxed/simple;
	bh=ddAvig6JMZWhtXEbaBykEsU32GMw/wFANUsuiyW8IxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfrTJ/0vPf8zdX+6THzoyvqwkVaBJNedBJsv2IZvpId/nVi7UiHtiYLPZxSozo3U6C0lGKtXI//T1gymngx2meDoiOCkUHwZFSXNZxLEpe74zSIsS07NMMTmql43aghIp1gyTtfw9r4u9tLuFcD7fCWHlZqMYo2XSb6+R90A7tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MK5Jh81l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MK5Jh81l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744713151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3f3QdyfqiNdpltNL6wuLct4P1WHUYudSVH9Uhq8+LM=;
	b=MK5Jh81lo1mxrwLAo+Ebbgu4Ed6/PgjPtiT2pUR9gZ0XzXn67v36Axi42bkNKA0sLXUHML
	8R0lrM99/mtYlgMsqHLwYLZRbM1QHuA8HmMoD9agxPzWlPmoaNRPPPdxio6YIo6m7NI/uf
	NdnVyS2HhOjXSJiih9OG3bPyKyp09TU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-ucDHObrAP_qOIpXPNUhBYQ-1; Tue,
 15 Apr 2025 06:32:27 -0400
X-MC-Unique: ucDHObrAP_qOIpXPNUhBYQ-1
X-Mimecast-MFC-AGG-ID: ucDHObrAP_qOIpXPNUhBYQ_1744713146
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 539BC195605E;
	Tue, 15 Apr 2025 10:32:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.70])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2432A1808867;
	Tue, 15 Apr 2025 10:32:21 +0000 (UTC)
Date: Tue, 15 Apr 2025 18:32:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/15] block: move elv_register[unregister]_queue out of
 elevator_lock
Message-ID: <Z_41sMjRX8BChbC5@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-12-ming.lei@redhat.com>
 <43e99891-94f2-4b31-a073-f7e717afbdd7@linux.ibm.com>
 <Z_xj6OAZ9o142Dvl@fedora>
 <c54867c4-d2df-4fc9-adce-348918b58349@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54867c4-d2df-4fc9-adce-348918b58349@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Apr 15, 2025 at 03:09:12PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/14/25 6:54 AM, Ming Lei wrote:
> > On Sat, Apr 12, 2025 at 12:50:10AM +0530, Nilay Shroff wrote:
> >>
> >>
> >> On 4/10/25 7:00 PM, Ming Lei wrote:
> >>> +int elevator_change_done(struct request_queue *q, struct elev_change_ctx *ctx)
> >>> +{
> >>> +	int ret = 0;
> >>> +
> >>> +	if (ctx->old) {
> >>> +		elv_unregister_queue(q, ctx->old);
> >>> +		kobject_put(&ctx->old->kobj);
> >>> +	}
> >>> +	if (ctx->new) {
> >>> +		ret = elv_register_queue(q, ctx->new, ctx->uevent);
> >>> +		if (ret) {
> >>> +			unsigned memflags = blk_mq_freeze_queue(q);
> >>> +
> >>> +			mutex_lock(&q->elevator_lock);
> >>> +			elevator_exit(q);
> >>> +			mutex_unlock(&q->elevator_lock);
> >>> +			blk_mq_unfreeze_queue(q, memflags);
> >>> +		}
> >>> +	}
> >>> +	return 0;
> >>> +}
> >>> +
> >> We could have sysf elevator attributes simultaneously accessed while this function 
> >> adds/removes sysfs elevator attributes without any protection. In fact, the show/store
> >> methods of elevator attributes runs with e->sysfs_lock held. So it seems moving 
> >> the above function out of lock protection might cause crash or other side effects?
> > 
> > sysfs/kobject provides such protection, and kobject_del() will drain any
> > in-flight attribute access.
> > 
> Okay, so in that case do we now really need e->sysfs_lock protection while accessing 
> elevator attributes? 

Yeah, I think so, elevator_exit() is always called after elevator kobject
is deleted.

However, this patchset moves elv_unregister_queue() after blk_mq_exit_sched(),
we may need this lock for failing elevator's attribute ->show() & ->store()
by adding one '->exiting' flag to 'struct elevator_queue'.

Thanks,
Ming

