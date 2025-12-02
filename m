Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824B311C0C
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678586; cv=none; b=bWWc2nTTspwiVdsY2dlZiLNZrou1lWYFvd6S7dtfX68TBgpYX1uLuH6+7oYrFH6uv6zOf/J1NJijYkpHGQ22YD8Tu9gnvvMZiZ2I9qZrdu6wZS5U8Jcge5Kev6WNTA4XWKIKAIET6tquc1RZK35znmiudiropqAWbFdaa+80ei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678586; c=relaxed/simple;
	bh=TF8nWUFVuVBGUHo5tIDl1wDlfnyt6FWtSp2znY+xa/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TynIRDOaRdgm+6aP4syUhwwAS1bnnAYJFRogByJiU5zbirVt/GOgS0sdHeRVQR225FJmPcda5irR8h7HGxb4KlcZxp7xgGQywDqVDFuQSP00b0onrof3InVmvkcbf+uEd5Xj/aRsiq1M/t3pvsrKe5vQjYYSw2wCxS86we0qW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZXFCCzY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZXFCCzY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764678583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8tjEPao00usBvup5VM9VHSHTHPBO1xju8audPJ9uA4=;
	b=XZXFCCzYXQFIyVxY6NGoyLWcjmdkwNDVut0UPgksJ28k4UB3CIMjVQaVBXHaRx+qKs/DCM
	9EvyLxxF8wR40Qz7e2i1vs0w5G0deykiWAHknc6YefODJcQHBhh8242TAVeAlXQuFIwXwP
	SQBNla4sLD/7OY3VjAMIfdCPtNCLIaE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-LVROzGl0MFmCECPB-GhdBw-1; Tue,
 02 Dec 2025 07:29:38 -0500
X-MC-Unique: LVROzGl0MFmCECPB-GhdBw-1
X-Mimecast-MFC-AGG-ID: LVROzGl0MFmCECPB-GhdBw_1764678577
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14927195605C;
	Tue,  2 Dec 2025 12:29:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0E793001E83;
	Tue,  2 Dec 2025 12:29:29 +0000 (UTC)
Date: Tue, 2 Dec 2025 20:29:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-arm-msm@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	pavan.kondeti@oss.qualcomm.com
Subject: Re: [PATCH] blk-mq: Abort suspend when wakeup events are pending
Message-ID: <aS7bmjmqBEV2CTEy@fedora>
References: <20251202-blkmq_skip_waiting-v1-1-f73d8a977ce0@oss.qualcomm.com>
 <aS6vYCg2Gks2BGHn@fedora>
 <d010fa56-3c7d-428a-810c-02ff8b1091a1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d010fa56-3c7d-428a-810c-02ff8b1091a1@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Dec 02, 2025 at 05:48:21PM +0800, Cong Zhang wrote:
> 
> 
> On 12/2/2025 5:20 PM, Ming Lei wrote:
> > On Tue, Dec 02, 2025 at 11:56:12AM +0800, Cong Zhang wrote:
> >> During system suspend, wakeup capable IRQs for block device can be
> >> delayed, which can cause blk_mq_hctx_notify_offline() to hang
> >> indefinitely while waiting for pending request to complete.
> >> Skip the request waiting loop and abort suspend when wakeup events are
> >> pending to prevent the deadlock.
> >>
> >> Fixes: bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
> >> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> >> ---
> >> The issue was found during system suspend with a no_soft_reset
> >> virtio-blk device. Here is the detailed analysis:
> >> - When system suspend starts and no_soft_reset is enabled, virtio-blk
> >>   does not call its suspend callback.
> >> - Some requests are dispatched and queued. After sending the virtqueue
> >>   notifier, the kernel waits for an IRQ to complete the request.
> >> - The virtio-blk IRQ is wakeup-capable. When the IRQ is triggered, it
> >>   remains pending because the device is in the suspend process.
> > 
> > Can you explain a bit for above point? Why does the IRQ remains pending
> > and not get handled?
> > 
> 
> The wakeup capable IRQ is not masked during suspend. When the IRQ is
> triggered, the kernel does not call its IRQ handler, instead kernel only
> marks the IRQ as a wakeup event in pm_system_irq_wakeup(). By checking
> pm_wakeup_pending() suspend process can abort if a wakeup event is
> detected. That means the actual IRQ handler is not called during the
> checking of blk_mq_hctx_has_requests, which cause the issue.

Thanks for the explanation!

Can you document it around `if (pm_wakeup_pending)`?

Otherwise, this patch looks fine for me.


Thanks,
Ming

