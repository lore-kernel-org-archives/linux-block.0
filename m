Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D722EB859
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918670; cv=none; b=GMCg+u9LUnvLJmfH2p/SyrHRzVRbv2f6p5sMUQmxB7pGP7jI8VAcf3uv2joo1hpzObAxDQnZC5FciupxAM/DKPGU9gGABFDrxEvDWhSo5CmK7yM3N240poDMwbsY6l3WMN2c/fXZHkgR18o6/rX2y0aIYYlPM4fxBD/wCYTPoXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918670; c=relaxed/simple;
	bh=PCa2PS2etpRQFlH/swlzWO2rb659EkMoUsiwySHV/k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFrp1jnzSJsT0aRTM42fHRRUJL5ABKcItRMXUjh+iFU2tbjAm4UVx3/ppmIyvH+qU6NEYG4BvDV1QSL5/U3BaYfUlFN8exeMgsDIODhjXakiXPF+W7Ra4lgMoEIXmwO/ccva0xUEFpDgrLL98TN9QYSHaZSR7sFAHPwn95rMcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HD+B9tjd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HD+B9tjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774918667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3KyIR523p7rYWqIIZEkyqHFsjWsGiKLRXiLRRYuTMUU=;
	b=HD+B9tjdr0hZLUjCcceXvpEIBmUJipwrL/I46G92+bWG1OJkP01MjCpKEOV1U2l/q4DiVu
	zuZkGc8NpTzB032pZPICPEIx3HxXPdopDUgK47fndmKOvRrZUKRk+z6n36bFG5dRR//NqC
	N/yX7OBRLhZHsJpaPwqmOG/As6AjFfE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-Vkbz3qlqO9OjuuaHyDSTkQ-1; Mon,
 30 Mar 2026 20:57:44 -0400
X-MC-Unique: Vkbz3qlqO9OjuuaHyDSTkQ-1
X-Mimecast-MFC-AGG-ID: Vkbz3qlqO9OjuuaHyDSTkQ_1774918663
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6331B195608B;
	Tue, 31 Mar 2026 00:57:43 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 586CD1954102;
	Tue, 31 Mar 2026 00:57:38 +0000 (UTC)
Date: Tue, 31 Mar 2026 08:57:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 4/6] block: Reduce the minimum value for the maximum
 DMA segment size
Message-ID: <acsb_mLxDz8RpXF1@fedora>
References: <20260327211349.2239633-1-bvanassche@acm.org>
 <20260327211349.2239633-5-bvanassche@acm.org>
 <ack5VqUS_gRuxodF@fedora>
 <7fe454fa-d39b-4d2f-a238-297df2261cdd@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe454fa-d39b-4d2f-a238-297df2261cdd@acm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Mar 30, 2026 at 12:49:33PM -0700, Bart Van Assche wrote:
> On 3/29/26 7:38 AM, Ming Lei wrote:
> > On Fri, Mar 27, 2026 at 02:13:44PM -0700, Bart Van Assche wrote:
> > > All block devices that are supported by the Linux kernel have a DMA engine
> > > that supports DMA segments of 4 KiB or larger. Allow smaller DMA segment
> > > sizes because these are useful for block layer testing. Reject values below
> > 
> > Can you share why/what it is useful just for test purpose?
> 
> Your commit 889c57066cee ("block: make segment size limit workable for >
> 4K PAGE_SIZE") adds support for devices with a maximum segment size
> limit that is less than the virtual memory page size. With
> BLK_MIN_SEGMENT_SIZE == 4096, it is not possible to test the code paths
> added by this commit if PAGE_SIZE == 4096. Allowing a segment size limit
> that is less than 4096 bytes makes it possible to test the new code
> paths on systems with PAGE_SIZE == 4096, e.g. an x86 VM.

lim->min_segment_size is <= PAGE_SIZE and BLK_MIN_SEGMENT_SIZE is same with
4096, so 889c57066cee basically changes nothing for 4096 PAGE_SIZE.

What is the exactly code path you are trying to cover by changing
BLK_MIN_SEGMENT_SIZE?

Thanks, 
Ming

