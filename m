Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B12199EAD
	for <linux-block@vger.kernel.org>; Sat, 16 Aug 2025 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755311040; cv=none; b=t2oJ4kKsLtJIVgeyi9+k01Tk/51sV+kxSMdny6dAHRWyDqqIg7mpQAfKl2JlgGL/pxEOd7+xyKdb2tMcYMfN2XHrZlu5kJKLjYuUEgbyoOOJRgklf99OtwvBhA12wEcKf9ZDktgTiCcpe+ryF0GRsSkOzN5zkz+GQyBfmABySpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755311040; c=relaxed/simple;
	bh=cwvy8LNX0+gWKVVtKwa8NFcDuLeooua2YVm9pHhGFao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qa9n1XbOERxC4+4iOiIkIxejdY8MeXclz8TXCrLusN2h1kFzTKPAFj8QfO5xsIUAzvTMRHJVLqrylfTW0NUrS6eWqXgz1f+j3UWSBwgFFLWNt/xW49iaebIzq6YTkAODGrkfsUGCHJ6LoineQbAnoEjsjYAKhw2uecFoHAJDjyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUQlHHvr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUQlHHvr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755311036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Dpi5ZHKfghBpcOVRAjbqbdx06jFHQ+sRD+gaD//bbg=;
	b=FUQlHHvrMBwzj7T1YEI1NoWxCqhf2xMV5DkTG1+hLi6A91sArTPsVbazoVtv05s/IlqMI7
	FdDSpx1Inb7UVrzifqPuhi5kY+AjH69OkbuXrJnBhkRW3fFkromcjoaZo9x715WkhY1JA2
	Iex9ife8ylwSEgPXxbokmSf+LWzq3kw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-bx0jFcx4OZyMiSe9l9-xsw-1; Fri,
 15 Aug 2025 22:23:52 -0400
X-MC-Unique: bx0jFcx4OZyMiSe9l9-xsw-1
X-Mimecast-MFC-AGG-ID: bx0jFcx4OZyMiSe9l9-xsw_1755311031
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6CF51800451;
	Sat, 16 Aug 2025 02:23:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47BF019327C0;
	Sat, 16 Aug 2025 02:23:41 +0000 (UTC)
Date: Sat, 16 Aug 2025 10:23:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@kernel.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hare@suse.de,
	nilay@linux.ibm.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 04/10] blk-mq: serialize updating nr_requests with
 update_nr_hwq_lock
Message-ID: <aJ_rqOrxMsi3nDqq@fedora>
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
 <20250815080216.410665-5-yukuai1@huaweicloud.com>
 <aJ9IkylydqSNZqwC@fedora>
 <9194a254-5cbc-4adc-8710-271d95395b96@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9194a254-5cbc-4adc-8710-271d95395b96@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sat, Aug 16, 2025 at 08:49:41AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/8/15 22:47, Ming Lei 写道:
> > On Fri, Aug 15, 2025 at 04:02:10PM +0800, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > request_queue->nr_requests can be changed by:
> > > 
> > > a) switching elevator by update nr_hw_queues
> > > b) switching elevator by elevator sysfs attribute
> > > c) configue queue sysfs attribute nr_requests
> >   ->elevator_lock is grabbed for updating ->nr_requests except for queue
> > initialization, so what is the real problem you are trying to solve?
> > 
> In order to fix the regression and prevent deadlock, we'll have to allocate
> memory
> 
> in the case bitmap tags grow before freezing the queue, also prevent
> nr_requests
> 
> to be updated by case a and b concurrently.

Yeah, that is potential deadlock issue in updating nr_request.

I feel the patch title is a bit confusing because q->nr_requests updating
is already serialized.


Thanks,
Ming

