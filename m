Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FF5313E28
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282269; cv=none; b=Jxd/mla1wNcSZPrndnV0SViZNW1DRF9sDTj+wc8SHNTgY8axmq77xeTEsQZpbxyDX4lJGrKW5KsDU+E/F12DvBDBmEP4tD1iKzEYDIgd72bIqNpxsSLeOgIiiDCoI1D2fx+G27qe5cFT7FX+qlbKKra9RIC198dLzXf6GIctl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282269; c=relaxed/simple;
	bh=JXICbYhdmChLc41AgM4Z3BbjQKBNTd50BLRpu+QU3ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgMyRkYa6NEtyMilD0zCkacmkCFokPup+iUcS5bjeaIJxiXmbDizCANSZAnwrV1qpVHdrcTd8lMHG+dpKMGooY9oiMCjDQJUeS/RCXTLhTpmlH14HWOv7CCz96sNjGPAZ45CrQ5RLn/lgvpG7VjCbOoTQHsgikVMyEgguVFjJPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DU/TAB6t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DU/TAB6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756282266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQE71pYJ0Ki8BlgkgxpbmRY9eNjrqJ40gZ/eBOhq1WU=;
	b=DU/TAB6tYpTEqu0aisYE/rIl7Ht78AfnteCv2d9pwYpqPvCCMTBYIIApiMNJf8eJr03200
	CvjVgfq45TwsOZz8arJ9Q6RtXk9HfqztYOJiaAEHR8ZVZ/y4P0XWuzdw5F6mTBjXjrASrk
	KTdpdk1kgKt4tyCH5C4UZSTF1HeJ+7g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-WWUC8apGN9KI_Emm32ol9g-1; Wed,
 27 Aug 2025 04:11:00 -0400
X-MC-Unique: WWUC8apGN9KI_Emm32ol9g-1
X-Mimecast-MFC-AGG-ID: WWUC8apGN9KI_Emm32ol9g_1756282259
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 242EE1956087;
	Wed, 27 Aug 2025 08:10:58 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CDF31800291;
	Wed, 27 Aug 2025 08:10:48 +0000 (UTC)
Date: Wed, 27 Aug 2025 16:10:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Li Nan <linan666@huaweicloud.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
	jianchao.w.wang@oracle.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-mq: check kobject state_in_sysfs before deleting in
 blk_mq_unregister_hctx
Message-ID: <aK69gpTnVv3TZtjg@fedora>
References: <20250826084854.1030545-1-linan666@huaweicloud.com>
 <aK5YH4Jbt3ZNngwR@fedora>
 <3853d5bf-a561-ec2d-e063-5fbe5cf025ca@huaweicloud.com>
 <aK5g-38izFqjPk9v@fedora>
 <b5f385bc-5e16-2a79-f997-5fd697f2a38a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5f385bc-5e16-2a79-f997-5fd697f2a38a@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Aug 27, 2025 at 11:22:06AM +0800, Li Nan wrote:
> 
> 
> 在 2025/8/27 9:35, Ming Lei 写道:
> > On Wed, Aug 27, 2025 at 09:04:45AM +0800, Yu Kuai wrote:
> > > Hi,
> > > 
> > > 在 2025/08/27 8:58, Ming Lei 写道:
> > > > On Tue, Aug 26, 2025 at 04:48:54PM +0800, linan666@huaweicloud.com wrote:
> > > > > From: Li Nan <linan122@huawei.com>
> > > > > 
> > > > > In __blk_mq_update_nr_hw_queues() the return value of
> > > > > blk_mq_sysfs_register_hctxs() is not checked. If sysfs creation for hctx
> > > > 
> > > > Looks we should check its return value and handle the failure in both
> > > > the call site and blk_mq_sysfs_register_hctxs().
> > > 
> > >  From __blk_mq_update_nr_hw_queues(), the old hctxs is already
> > > unregistered, and this function is void, we failed to register new hctxs
> > > because of memory allocation failure. I really don't know how to handle
> > > the failure here, do you have any suggestions?
> > 
> > It is out of memory, I think it is fine to do whatever to leave queue state
> > intact instead of making it `partial workable`, such as:
> > 
> > - try update nr_hw_queues to 1
> > 
> > - if it still fails, delete disk & mark queue as dead if disk is attached
> > 
> 
> If we ignore these non-critical sysfs creation failures, the disk remains
> usable with no loss of functionality. Deleting the disk seems to escalate
> the error?

It is more like a workaround by ignoring the sysfs register failure. And if
the issue need to be fixed in this way, you have to document it.

In case of OOM, it usually means that the system isn't usable any more.
But it is NOIO allocation and the typical use case is for error recovery in
nvme pci, so there may not be enough pages for noio allocation only. That is
the reason for ignoring sysfs register in blk_mq_update_nr_hw_queues()?

But NVMe has been pretty fragile in this area by using non-owner queue
freeze, and call blk_mq_update_nr_hw_queues() on frozen queue, so it is
really necessary to take it into account?

Thanks,
Ming

