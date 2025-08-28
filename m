Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E2130FF13
	for <linux-block@vger.kernel.org>; Thu, 28 Aug 2025 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382963; cv=none; b=Bgssg2kAJ/Kypzapemwz67EOzBB0HKYy6qMDIyRRyKky2hBN4b9ZtPGUYnCCfrZv+AWRqfK4eV+n0JEwOzygk1QJHMOzAxp+tJ9dQWZrDO+k8QgYTL2Zqo1JqTo9oHABg4G9wNOqA6Qf963VCHc03Tu2H8u5qnwrJQH70aIn7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382963; c=relaxed/simple;
	bh=00isV9pgMOT+EOxLZrvOcj/hyY1mQftLr8hMFssxPt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s664h4fpZt180qv9F+DD9A7C9gQKHKJNaInpR4foQAYGqAtYA9KWZ6iUAd50B1MUGWDs7PF8AQA8r73FAQNvyrfEx3PRv4qegyYTQLfsgIWHu7FqirAUM5gMyEa6TDngvigIcfsxx6xxamiwojIwtIYMeXU6XuRPNIb/oIsDPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QjK14zkF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjK14zkF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756382960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeaggWAAFNQCZlCBo2LizV3WKfNjpyXN5B4dcdfNqIM=;
	b=QjK14zkFgdVxquX8B0/VGvz0rdvHdY0t2IXn6YSEKIs0iZReaa1AhD8PGLNfgEbu093dtD
	sttLAijijFsG2CqqcB1kba9KfRlFiap5eAGtEp5cZ6nzcpuvwSafUoFVU1aXxus2OKJPAd
	hbOAqLazPqatP2cDc7MW/xMpBg5rA3c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-h4rSok_AP3y182jUk-5QhA-1; Thu,
 28 Aug 2025 08:09:14 -0400
X-MC-Unique: h4rSok_AP3y182jUk-5QhA-1
X-Mimecast-MFC-AGG-ID: h4rSok_AP3y182jUk-5QhA_1756382953
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A1271800291;
	Thu, 28 Aug 2025 12:09:12 +0000 (UTC)
Received: from fedora (unknown [10.72.116.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F11C51800447;
	Thu, 28 Aug 2025 12:09:02 +0000 (UTC)
Date: Thu, 28 Aug 2025 20:08:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Li Nan <linan666@huaweicloud.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
	jianchao.w.wang@oracle.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-mq: check kobject state_in_sysfs before deleting in
 blk_mq_unregister_hctx
Message-ID: <aLBG2VCNZEnSYxx9@fedora>
References: <20250826084854.1030545-1-linan666@huaweicloud.com>
 <aK5YH4Jbt3ZNngwR@fedora>
 <3853d5bf-a561-ec2d-e063-5fbe5cf025ca@huaweicloud.com>
 <aK5g-38izFqjPk9v@fedora>
 <b5f385bc-5e16-2a79-f997-5fd697f2a38a@huaweicloud.com>
 <aK69gpTnVv3TZtjg@fedora>
 <fc587a1a-97fb-584c-c17c-13bb5e3d7a92@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc587a1a-97fb-584c-c17c-13bb5e3d7a92@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Aug 28, 2025 at 05:28:26PM +0800, Li Nan wrote:
> 
> 
> 在 2025/8/27 16:10, Ming Lei 写道:
> > On Wed, Aug 27, 2025 at 11:22:06AM +0800, Li Nan wrote:
> > > 
> > > 
> > > 在 2025/8/27 9:35, Ming Lei 写道:
> > > > On Wed, Aug 27, 2025 at 09:04:45AM +0800, Yu Kuai wrote:
> > > > > Hi,
> > > > > 
> > > > > 在 2025/08/27 8:58, Ming Lei 写道:
> > > > > > On Tue, Aug 26, 2025 at 04:48:54PM +0800, linan666@huaweicloud.com wrote:
> > > > > > > From: Li Nan <linan122@huawei.com>
> > > > > > > 
> > > > > > > In __blk_mq_update_nr_hw_queues() the return value of
> > > > > > > blk_mq_sysfs_register_hctxs() is not checked. If sysfs creation for hctx
> > > > > > 
> > > > > > Looks we should check its return value and handle the failure in both
> > > > > > the call site and blk_mq_sysfs_register_hctxs().
> > > > > 
> > > > >   From __blk_mq_update_nr_hw_queues(), the old hctxs is already
> > > > > unregistered, and this function is void, we failed to register new hctxs
> > > > > because of memory allocation failure. I really don't know how to handle
> > > > > the failure here, do you have any suggestions?
> > > > 
> > > > It is out of memory, I think it is fine to do whatever to leave queue state
> > > > intact instead of making it `partial workable`, such as:
> > > > 
> > > > - try update nr_hw_queues to 1
> > > > 
> > > > - if it still fails, delete disk & mark queue as dead if disk is attached
> > > > 
> > > 
> > > If we ignore these non-critical sysfs creation failures, the disk remains
> > > usable with no loss of functionality. Deleting the disk seems to escalate
> > > the error?
> > 
> > It is more like a workaround by ignoring the sysfs register failure. And if
> > the issue need to be fixed in this way, you have to document it. >
> > In case of OOM, it usually means that the system isn't usable any more.
> > But it is NOIO allocation and the typical use case is for error recovery in
> > nvme pci, so there may not be enough pages for noio allocation only. That is
> > the reason for ignoring sysfs register in blk_mq_update_nr_hw_queues()?
> > 
> > But NVMe has been pretty fragile in this area by using non-owner queue
> > freeze, and call blk_mq_update_nr_hw_queues() on frozen queue, so it is
> > really necessary to take it into account?
> 
> I agree with your points about NOIO and NVMe.
> 
> I hit this issue in null_blk during fuzz testing with memory-fault
> injection. Changing the number of hardware queues under OOM is extremely
> rare in real-world usage. So I think adding a workaround and documenting it
> is sufficient. What do you think?

Looks fine for me.


Thanks, 
Ming

