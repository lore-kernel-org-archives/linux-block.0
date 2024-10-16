Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713B522A
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082963; cv=none; b=Gc4jHyfqs6JNvWrW2x3erhD5gPqvpAVQ+p/8gaopd3vB7W7KuDuZ6g+LX5t7BFM9+rJp/qrLYwUi/qbGOGTpQz56l0iKo90hgGEGgg/x+U/HOBvCpzUB4v1jLaV0vLrl79OIJkgR6Y0i2p8cbBccl3OQ++qxS84Pfpe6ikOicMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082963; c=relaxed/simple;
	bh=80wiPl4msXFmyAT5kl1vePgH5cead6QJDvmpR/EzHNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyYU6BrnsrSek0eNlZeUxwi6TZIkVNmwH1T3VP/gqaNDnFE0cEB/ds99lNdZgPTfiWcbkeyRfLwXwIK0omWwF94VB5qhq2ROapWxCpTeh6wN9dtwiURDtMxXKbXrYrGphDUJPDPCuUb76+UZ5KDnTA7zsKughaIYNvwGZSR/wlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9A1L9Rd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9A1L9Rd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729082960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6XdTmtevG+KsG5Rhnpcogk/LfezfLUfAWE93G6xIHWI=;
	b=W9A1L9RdutJb+7nBrR6JKKVrW+JBTEt5OUpitEauvVb2/uYIH4H6/VSTwnhjh8+i1N8pc+
	PGr3Yvax5ifQX/E435tNXnP4OuaQbrVFLHYd57ZMQFpvRWmJE0G5euCgbZu+CZUju0KPSw
	GTG8WYdnSLQmHwAmjiroQIDCiQ8eMec=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-ipTMLM48PsWrXy0g9f_Tkw-1; Wed,
 16 Oct 2024 08:49:19 -0400
X-MC-Unique: ipTMLM48PsWrXy0g9f_Tkw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3311319560BF;
	Wed, 16 Oct 2024 12:49:18 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47F4919560A3;
	Wed, 16 Oct 2024 12:49:12 +0000 (UTC)
Date: Wed, 16 Oct 2024 20:49:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <Zw-2Q1WeTtgJO_NI@fedora>
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-2-hch@lst.de>
 <Zw-e_CtNKeLJ3q1a@fedora>
 <20241016123240.GB18219@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016123240.GB18219@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Oct 16, 2024 at 02:32:40PM +0200, Christoph Hellwig wrote:
> On Wed, Oct 16, 2024 at 07:09:48PM +0800, Ming Lei wrote:
> > Setting QUEUE_FLAG_DYING may fail passthrough request for
> > !GD_OWNS_QUEUE, I guess this may cause SCSI regression.
> 
> Yes, as clearly documented in the commit log.

The change need Cc linux-scsi.

> As the disk is going away there is no real point in sending these
> commands, but we have no really good way to distinguish between the
> cases.  

scsi request queue has very different lifetime with gendisk, not sure the
above comment is correct.


Thanks,
Ming

