Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A825771
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 00:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752710581; cv=none; b=CfpZUeQ/49pWaG/Vvrw6R95X9A8dWvKC+SelF06/rmL5OFj4j9BTugi4XwXDUyZ36xj7MbOJezqj5ct6eUiMlGTt5hVrY1FaG1sfYbDO+tXFn8y49tWcICCSCNzK08COHfGC6gPOrjcsdCMVevETpOvYGl7BZYB0p73JVD5/4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752710581; c=relaxed/simple;
	bh=dyvDs2SZjPnLqn4XcQZSkbfAgPKZ1RRAqxf2xN3AxyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grKU3Vn6Ir0CiMT11geMQCc/cPq2MeGE1mTVYNufak/h/vIpnMpY3UTbzUs1t/6UlkayZG1W6JjMAmCC1gpuFPYD4yXxX5eh665ETXgsl632uGpaJKM9yLk6HHkv4cyMeZHKMkde+gozAdlqIpCCGhROihyPv/WztmcyTw4DVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUcyaLoN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUcyaLoN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752710578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iwoJely0sj+ENueBdxmhwbrKhyv7FpZIrRK6hoyrMvQ=;
	b=BUcyaLoNSxlA0l7EaYBvozKRyKvnIVIhHZxu+f4b5AWPxyZYvq6IWSc+rEuUlYP7v34MJW
	00lVwG5d+jWtiTS9M+2qU/cZRput5pfsbJcJVqFCtvJQNrtihUP3thuf//QUu4Dwt2zapI
	pzQXCIA/lDXjiQPBBVu7xgMfuBkmnSM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-T06VplQVMdWLPwESWCNNhw-1; Wed,
 16 Jul 2025 20:02:54 -0400
X-MC-Unique: T06VplQVMdWLPwESWCNNhw-1
X-Mimecast-MFC-AGG-ID: T06VplQVMdWLPwESWCNNhw_1752710573
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC70F19560B3;
	Thu, 17 Jul 2025 00:02:52 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5638C1955F16;
	Thu, 17 Jul 2025 00:02:46 +0000 (UTC)
Date: Thu, 17 Jul 2025 08:02:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
	Yi Zhang <yi.zhang@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [bug report] kmemleak issue observed during blktests
Message-ID: <aHg9oRFYjSsNvY0_@fedora>
References: <CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com>
 <d52a8216-dd70-4489-a645-55d174bcdd9e@kernel.dk>
 <08f3f802-e3c3-b851-b4ee-912eade04c6f@huaweicloud.com>
 <aHeBiu9pHZwO95vW@fedora>
 <99b5326f-7ef6-46d8-a423-95b1b4e7c7fb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99b5326f-7ef6-46d8-a423-95b1b4e7c7fb@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jul 17, 2025 at 12:54:31AM +0530, Nilay Shroff wrote:
> 
> 
> On 7/16/25 4:10 PM, Ming Lei wrote:
> > On Wed, Jul 16, 2025 at 03:50:34PM +0800, Yu Kuai wrote:
> >> Hi,
> >>
> >> 在 2025/07/16 9:54, Jens Axboe 写道:
> >>> unreferenced object 0xffff8882e7fbb000 (size 2048):
> >>>    comm "check", pid 10460, jiffies 4324980514
> >>>    hex dump (first 32 bytes):
> >>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>>    backtrace (crc c47e6a37):
> >>>      __kvmalloc_node_noprof+0x55d/0x7a0
> >>>      sbitmap_init_node+0x15a/0x6a0
> >>>      kyber_init_hctx+0x316/0xb90
> >>>      blk_mq_init_sched+0x416/0x580
> >>>      elevator_switch+0x18b/0x630
> >>>      elv_update_nr_hw_queues+0x219/0x2c0
> >>>      __blk_mq_update_nr_hw_queues+0x36a/0x6f0
> >>>      blk_mq_update_nr_hw_queues+0x3a/0x60
> >>>      find_fallback+0x510/0x540 [nbd]
> >>
> >> This is werid, and I check the code that it's impossible
> >> blk_mq_update_nr_hw_queues() can be called from find_fallback().
> > 
> > Yes.
> > 
> >> Does kmemleak show wrong backtrace?
> > 
> > I tried to run blktests block/005 over nbd, but can't reproduce this
> > kmemleak report after setting up the detector.
> 
> I have analyzed this bug and found the root cause:
> 
> The issue arises while we run nr_hw_queue update,  Specifically, we first
> reallocate hardware contexts (hctx) via __blk_mq_realloc_hw_ctxs(), and 
> then later invoke elevator_switch() (assuming q->elevator is not NULL). 
> The elevator switch code would first exit old elevator (elevator_exit)
> and then switch to new elevator. The elevator_exit loops through
> each hctx and invokes the elevator’s per-hctx exit method ->exit_hctx(),
> which releases resources allocated during ->init_hctx().
> 
> This memleak manifests when we reduce the num of h/w queues - for example,
> when the initial update sets the number of queues to X, and a later update
> reduces it to Y, where Y < X. In this case, we'd loose the access to old 
> hctxs while we get to elevator exit code because __blk_mq_realloc_hw_ctxs
> would have already released the old hctxs. As we don't now have any reference
> left to the old hctxs, we don't have any way to free the scheduler resources
> (which are allocate in ->init_hctx()) and kmemleak complains about it.
> 
> Regarding reproduction, I was also not able to recreate it using block/005
> but then I wrote a script using null-blk driver which updates nr_hw_queue
> from X to Y (where Y < X) and I encountered this memleak. So this is not
> an issue with nbd driver.
> 
> I've implemented a potential fix for the above issue and I'm unit 
> testing it now. I will post a formal patch in some time.

Great!

Looks it is introduced in commit 596dce110b7d ("block: simplify elevator reattachment
for updating nr_hw_queues"), but easy to cause panic with that patchset.

One simple fix is to restore to original two-stage elevator switch, meantime saving
elevator name in xarray for not adding boilerplate code back.


Thanks,
Ming

