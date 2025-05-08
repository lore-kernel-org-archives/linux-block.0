Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7A91D63F2
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746673352; cv=none; b=KrMqp+xOzdFB8UrgqcRnRtWHdnOJznNNwRdbosnQbZ1VkuVKYZv39RZ2hw0N2HZ0n90gkoHK/2eNkEg9kMuGh/FeopdXxJj4yLHRiOxvm+9r32XLavAHmysqblTnixP80XLqa4N6aE0nYMk5usKbjETq06y3h0LMXpBwpvi5xZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746673352; c=relaxed/simple;
	bh=8rqqyvo/gK7dKv4DhJzkQFqKd4/bLo1dCQJ8ZZGoye8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2tUA1hw7vufhpuqPjkJ3POluTw1urH43QG/ZdLtwQLkl2xM1moTw8NPPWPzvfqNO0dITXvJzfmh0Q71iZHeaoiOCbO/4oJlLpiKAh8rJ3iUZwvhIUSV4inzI/1jCSr1pDT7QXWEN/PttjaQj0+ONGnItxTDmSvZ35n/9AwTAOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gF+tkCse; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gF+tkCse"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746673349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgGnRzi48qol7lro6GmQxHttnliuxFJCeZWZwZmgPXQ=;
	b=gF+tkCseyUtTluXj58l9KX/E+RYYzW7p/gdaP5xPism/b48MZMYdOGWaipNKgZxc6rJQAj
	oOvWIfUMJEBqMc6B1vdyU+LadcYJnqRnrUrGA1D9pxjVRsz80wbXq8KQDwm2Sd5aRRJuYp
	vWQqj/YrIY6F2ZpBY5S1SBAwrigQ6ig=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-BsMsHKuwOD-SkjRTKxaZzQ-1; Wed,
 07 May 2025 23:02:26 -0400
X-MC-Unique: BsMsHKuwOD-SkjRTKxaZzQ-1
X-Mimecast-MFC-AGG-ID: BsMsHKuwOD-SkjRTKxaZzQ_1746673345
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EC491800446;
	Thu,  8 May 2025 03:02:25 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E612018003FC;
	Thu,  8 May 2025 03:02:21 +0000 (UTC)
Date: Thu, 8 May 2025 11:02:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: move queue quiesce into elevator_change()
Message-ID: <aBweuFKT8nlhHWB1@fedora>
References: <20250507120406.3028670-1-ming.lei@redhat.com>
 <20250507120406.3028670-2-ming.lei@redhat.com>
 <20250507135349.GA1019@lst.de>
 <aBtuCDKTQK1PReDg@fedora>
 <70c4554e-f578-44d6-b96c-bface94604f1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70c4554e-f578-44d6-b96c-bface94604f1@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, May 08, 2025 at 12:35:21AM +0530, Nilay Shroff wrote:
> 
> 
> On 5/7/25 7:58 PM, Ming Lei wrote:
> > On Wed, May 07, 2025 at 03:53:49PM +0200, Christoph Hellwig wrote:
> >> On Wed, May 07, 2025 at 08:04:02PM +0800, Ming Lei wrote:
> >>> blk_mq_freeze_queue() can't be called on quiesced queue, otherwise it may
> >>> never return if there is any queued requests.
> >>>
> >>> Fix it by moving queue quiesce int elevator_change() by adding one flag to
> >>> 'struct elv_change_ctx' for controlling this behavior.
> >>
> >> Why do we even need to quiesce the queue here, and not anywhere else?
> > 
> > Quiesce is for draining the in-progress critical area, which can't be
> > covered by queue freeze. Typically, all requests are freed, the run queue
> > activity isn't finished yet, so schedule data can be touched by the un-finished
> > code path.
> > 
> > We did fix this kind of bugs by queue quiesce several times.
> > 
> Technically after freezing the queue, we don't have any in-flight request when 
> blk_mq_freeze_queue returns. Yes we may still have some dispatch operations
> running and so we want to wait for it to finish. In that case, we may just call
> synchronize_rcu/synchronize_srcu (instead of blk_mq_quiesce_queue) to ensure that
> all in-progress dispatch operations are finished. That way we can also avoid
> calling blk_mq_unquiesce_queue later when we finish switching elevator. 

synchronize_rcu/synchronize_srcu can't be better than blk_mq_quiesce_queue,
because it can't prevent from entering new rcu/srcu read lock critical area.


Thanks,
Ming

