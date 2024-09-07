Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE63015B561
	for <linux-block@vger.kernel.org>; Sat,  7 Sep 2024 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725707703; cv=none; b=JQqgYUJ4IaaeaoxiSoKKBpuKMzgfkB5gcCaw1NyrDustHd9t9PDo2h1E7hy9vRoAcx/ToN0+Kr6r2Y9/GEkXHGDWU+c58b1T1zEDDkc2Z0Ka1hBPIELQ76tCVTeagZcfTOzlfxQXABE34aLT+ZsPQQcALic5Mnxs/ICNDzJtyQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725707703; c=relaxed/simple;
	bh=0y/xcHhNcRMf2nacOTb8zfn443zNdr18JxRqLXAr0yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mmf/h1+1yT62M+SfuXKNPyj+lWB4dVAWE2C74oUnorOUQhHcAplqdaa8u5pmQ4MbJa3DxP6A1zD4UXma+NpXYNPqc2daXWD7RFkKX5Qyj14UGO14dbGWZfJDNJFqOL5bjWLWZbnVzBIZlF/oNRgO0BJ8J1xLUTS1KrW08fWUG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GgCR/2i1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgCR/2i1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725707700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0rjfLojyLsnbSHPzIWGkUlS2d1urV+9JnF4egRyTns4=;
	b=GgCR/2i1iAOWyGV8vkvIDtvyQdqekYTd4IBmzvfwqNhvmyikl7MWu6GH7NbyKg/LZLRFfg
	uOVmXFNUfbOlf/ZyoxTMcsJKJ1xd8U0QvQIFurGEfxgISQ8TjBR0NADaPf3a5ZIhqcYs1B
	zDcU9TgFNmH6BN+3pgw8om3cyxPhzI8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-m6xw1CXYP_6x7w_UWZ0RAg-1; Sat,
 07 Sep 2024 07:14:57 -0400
X-MC-Unique: m6xw1CXYP_6x7w_UWZ0RAg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C6F51956089;
	Sat,  7 Sep 2024 11:14:56 +0000 (UTC)
Received: from localhost (unknown [10.42.28.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 261411956048;
	Sat,  7 Sep 2024 11:14:54 +0000 (UTC)
Date: Sat, 7 Sep 2024 12:14:53 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
	Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] block: elevator: avoid to load iosched module from this
 disk
Message-ID: <20240907111453.GA1450@redhat.com>
References: <20240907014331.176152-1-ming.lei@redhat.com>
 <20240907073522.GW1450@redhat.com>
 <ZtwHwTh6FYn+WnGD@fedora>
 <4d7280eb-7f26-4652-a1d4-4f82c4d99a4c@kernel.org>
 <ZtwhfCtDpTrBUFY+@fedora>
 <20240907100213.GY1450@redhat.com>
 <Ztwl2RvR0DGbNuex@fedora>
 <20240907103632.GZ1450@redhat.com>
 <ZtwyxukuaXAscXsz@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtwyxukuaXAscXsz@fedora>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sat, Sep 07, 2024 at 07:02:30PM +0800, Ming Lei wrote:
> BTW, the issue can be reproduced 100% by:
> 
> echo "deadlock" > /sys/block/$ROOT_DISK/queue/scheduler

That doesn't reproduce it for me (reliably).  Although I'm not
surprised as this bug has been _very_ tricky to reproduce!  Sometimes
I think I have a definite reproducer, only for it to go away when some
tiny detail changes.

> > This seems like the neatest (or shortest) fix so far, but doesn't it
> > "mix up layers" by checking elv_iosched_store?
> 
> It is just one exception for 'scheduler' sysfs attribute wrt. freezing
> queue for storing, and the check can be done via the attribute
> name("scheduler") too.

Fair enough.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

