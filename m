Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C815748F
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746691461; cv=none; b=P00bO7VwdDMM0bMpT2S8obC+TdmK/LP81A8x72GJRDf5WdiFXUL1Pg7uqnMv9pdl8x0xePqO2nS3Ks5nGj6mfis0m3gUFWAYuGCX7CuyTbj7WgyEZ7QVfMdOLfcdW6SIdtZSxjqQ3hyBEPhsXBAqL13EFn5dSP0+hFcmfLn7CSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746691461; c=relaxed/simple;
	bh=SY7s85Yp+JuhVPzfHfUkzqQ3d+ZPIIkZzob4Xo6dHVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIGidRklaB8XKRYuiojoLDJ43B8LeW17NbwouXtjI+V8kmnan7EDs5lCPXxN6O77o09lTRkWAOiqsewtiZ231Jn747Sf7KrYnZvVQaXad7W0iy9AeBBwbZcWqPL5g3vkY74ZpIABFuGoqNUB6JycoqQeAICvodA8s843IB765EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epCg0bpX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epCg0bpX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746691454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+S4iUnyWRIBBL2RMuVyr2IVpguXXa8m5C9Z3FBtc8I=;
	b=epCg0bpXocF+5xs781/grJsYMZ/FidXNNHWWh+IKc3vZ83AS/MObDy4BtcVQFgTWIQg53r
	5a6S8HV6uRVW/H4950fyciE4mDivgHtujzE9yp+0xdH/hk0MatUixueSMT2LpBq2qvlb45
	PT2AyYkTp6n7LXNjYOM4mawxsUKLWVk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-58zpIT3cOGuWMn576sJeVA-1; Thu,
 08 May 2025 04:04:09 -0400
X-MC-Unique: 58zpIT3cOGuWMn576sJeVA-1
X-Mimecast-MFC-AGG-ID: 58zpIT3cOGuWMn576sJeVA_1746691445
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 537DA18004AD;
	Thu,  8 May 2025 08:04:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.149])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F60619560B3;
	Thu,  8 May 2025 08:04:01 +0000 (UTC)
Date: Thu, 8 May 2025 16:03:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/2] block: move queue quiesce into elevator_change()
Message-ID: <aBxlbJIAYZ6s4L9y@fedora>
References: <20250507120406.3028670-1-ming.lei@redhat.com>
 <20250507120406.3028670-2-ming.lei@redhat.com>
 <20250507135349.GA1019@lst.de>
 <aBtuCDKTQK1PReDg@fedora>
 <20250508050317.GA27049@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508050317.GA27049@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, May 08, 2025 at 07:03:17AM +0200, Christoph Hellwig wrote:
> On Wed, May 07, 2025 at 10:28:24PM +0800, Ming Lei wrote:
> > On Wed, May 07, 2025 at 03:53:49PM +0200, Christoph Hellwig wrote:
> > > On Wed, May 07, 2025 at 08:04:02PM +0800, Ming Lei wrote:
> > > > blk_mq_freeze_queue() can't be called on quiesced queue, otherwise it may
> > > > never return if there is any queued requests.
> > > > 
> > > > Fix it by moving queue quiesce int elevator_change() by adding one flag to
> > > > 'struct elv_change_ctx' for controlling this behavior.
> > > 
> > > Why do we even need to quiesce the queue here, and not anywhere else?
> > 
> > Quiesce is for draining the in-progress critical area, which can't be
> > covered by queue freeze.
> 
> I know.  But why do we care about that for removing a scheduler, but
> not for changing it?

Actually elevator_switch() does quiesce queue, so we can just remove the
queue quiesce around elevator_set_none().


Thanks, 
Ming

