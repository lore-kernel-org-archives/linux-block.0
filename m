Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5AF19E7F7
	for <linux-block@vger.kernel.org>; Thu,  7 Aug 2025 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754532775; cv=none; b=A6kx9eHGRHc5PW4cAaiFF1joDF0D3IFgh7+XZbXXr6HuPvMshLE4ZGaUUULpSowGib74lqjhvjm+eQ+Z9bE6wt6O9pUmtbEmkJXzcc1ROU5uN0VZgJcB1e8DnbzOH4czZlI2DUcmixZRalVFjR15Rur9PnspRJQcEJcFqezsWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754532775; c=relaxed/simple;
	bh=jdNZ94Uo1O41TEjfDTKlwfbFfBn8iCcSKb+u11wveGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzKL6SU0ZNpsZFPx+IUg4g0kc5E/f0ag3j3J7U8dlBfcCqQalFrbEMROKb1tHYRq00PLV1MI4W4CIhH+JLnN+gtsQ0jlbI0wGsCE+C8BGcCzm4RPT9h8GpOnhT4KoeRe61fWNiCo94G8GyDjy0M+pGVW8HA5U22cEbghNmZwLv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIkZWeTq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIkZWeTq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754532772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWH6Du5vfkiu6EJyqpA38NXSuK0ucfqq353GutkoQio=;
	b=aIkZWeTqjiy0foAxlYp/doUBB22X/YoIhh2Ay901bJOO0239kW6+1Jt4czf43VR2DJh/ln
	M2D0GUWA7b4yIpW6X43Xi3g+bduOK0iXxaYe7Hucj2VTOh0Fp6Vw1qUDNv+esxaNhfqiA7
	t/leW/5ypevLLZxT4IMfDE6YEHvSQVM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-eBrPlbwEOoqi50syY0QABg-1; Wed,
 06 Aug 2025 22:12:49 -0400
X-MC-Unique: eBrPlbwEOoqi50syY0QABg-1
X-Mimecast-MFC-AGG-ID: eBrPlbwEOoqi50syY0QABg_1754532768
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0987D19560A2;
	Thu,  7 Aug 2025 02:12:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.100])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0478D1956094;
	Thu,  7 Aug 2025 02:12:37 +0000 (UTC)
Date: Thu, 7 Aug 2025 10:12:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	John Garry <john.garry@huawei.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 5/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators
Message-ID: <aJQLkDTiHVboo6CT@fedora>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-6-ming.lei@redhat.com>
 <c86b6974-fcd6-0a96-a69a-1831f6c6d8d8@huaweicloud.com>
 <aJNYmjoJsarvObBy@fedora>
 <700b6ab7-c0c0-58ea-fccf-fd9c3d806d59@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <700b6ab7-c0c0-58ea-fccf-fd9c3d806d59@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Aug 07, 2025 at 09:23:24AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/06 21:28, Ming Lei 写道:
> > On Wed, Aug 06, 2025 at 05:21:32PM +0800, Yu Kuai wrote:
> > > Hi,
> > > 
> > > 在 2025/08/01 19:44, Ming Lei 写道:
> > > > Replace the spinlock in blk_mq_find_and_get_req() with an SRCU read lock
> > > > around the tag iterators.
> > > > 
> > > > This is done by:
> > > > 
> > > > - Holding the SRCU read lock in blk_mq_queue_tag_busy_iter(),
> > > > blk_mq_tagset_busy_iter(), and blk_mq_hctx_has_requests().
> > > > 
> > > > - Removing the now-redundant tags->lock from blk_mq_find_and_get_req().
> > > > 
> > > > This change improves performance by replacing a spinlock with a more
> > > > scalable SRCU lock, and fixes lockup issue in scsi_host_busy() in case of
> > > > shost->host_blocked.
> > > > 
> > > > Meantime it becomes possible to use blk_mq_in_driver_rw() for io
> > > > accounting.
> > > > 
> > > > Signed-off-by: Ming Lei<ming.lei@redhat.com>
> > > > ---
> > > >    block/blk-mq-tag.c | 12 ++++++++----
> > > >    block/blk-mq.c     | 24 ++++--------------------
> > > >    2 files changed, 12 insertions(+), 24 deletions(-)
> > > 
> > > I think it's not good to use blk_mq_in_driver_rw() for io accounting, we
> > > start io accounting from blk_account_io_start(), where such io is not in
> > > driver yet.
> > 
> > In blk_account_io_start(), the current IO is _not_ taken into account in
> > update_io_ticks() yet.
> 
> However, this is exactly what we did from coding for a long time, for
> example, consider just one IO:
> 
> t1: blk_account_io_start
> t2: blk_mq_start_request
> t3: blk_account_io_done
> 
> The update_io_ticks() is called from blk_account_io_start() and
> blk_account_io_done(), the time (t3 - t1) will be accounted into
> io_ticks.

That still may not be correct, please see "Documentation/block/stat.rst":

```
io_ticks        milliseconds  total time this block device has been active
```

What I meant is that it doesn't matter wrt. "io accounting from
blk_account_io_start()", because the current io is excluded from `inflight ios` in
update_io_ticks() from blk_account_io_start().

> 
> And if we consider more IO, there will be a mess:
> 
> t1: IO a: blk_account_io_start
> t2: IO b: blk_account_io_start
> t3: IO a: blk_mq_start_request
> t4: IO b: blk_mq_start_request
> t5: IO a: blk_account_io_done
> t6: IO b: blk_account_io_done
> 
> In the old cases that IO is inflight untill blk_mq_start_request, the
> io_ticks accounted is t6 - t2, which is werid. That's the reason I
> changed the IO accouting, and consider IO inflight from
> blk_account_io_start, and this will unify all the fields in iostat.

In reality implementation may include odd things, but the top thing is that
what/how 'io_ticks' should be defined in theory? same with util%.

> > 
> > Also please look at 'man iostat':
> > 
> >      %util  Percentage  of  elapsed time during which I/O requests were issued to the device (bandwidth utilization for the device). Device
> >             saturation occurs when this value is close to 100% for devices serving requests serially.  But for devices serving requests  in
> >             parallel, such as RAID arrays and modern SSDs, this number does not reflect their performance limits.
> > 
> > which shows %util in device level, not from queuing IO to complete io from device.
> > 
> > That said the current approach for counting inflight IO via percpu counter
> > from blk_account_io_start() is not correct from %util viewpoint from
> > request based driver.
> > 
> 
> I'll prefer to update the documents, on the one hand, util is not

Can we update every distributed iostat's man page? And we can't refresh
every user's mind about %util's definition in short time.

Also what/how should we update the document to? which is one serious thing.

Thanks, 
Ming

