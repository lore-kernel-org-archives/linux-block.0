Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B52BF017
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662429; cv=none; b=hDu4hO3d+0U2Q074w7oozsSBj0n+kXYL7lFYR0b4kCZwt44f6ET0DQYkeR0ahcCqWjxZLVyznqWvffQXPJBg4M9UJwdHt5U+AYajxGvHwjey64mhdC/Yscg5pSjnIWUJcOtSH7oLlHdzp6wY6PKjB1PsKwtDPS8sGzfCH6jwQI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662429; c=relaxed/simple;
	bh=mu1ScGbck9q9MWwoSAExzCntTfv6hbeKLVl0usR+ybc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3iUZnpdMcxoNobsCY9OCH0NgotxEHeyMmKoekDjlqb41X7/x4TaAYm8BlOL8pNDMHYR0QHQuV6jBluFAQR75TsNshxVpLMZY9J+y+xLj/JhPZxHlplISwwPbvZ/S9joBJAgZdwLRrFjuqrL67NeQ28bkcPkQCmJcp73NCb50F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YoaOnCDG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoaOnCDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752662427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUmwdkpVWgrx6g8+0Yxmx/sQbjsE7kvd7nlNgws5rzs=;
	b=YoaOnCDGktfAFCMBbJfol6T2clPPjj8jaRmc1LTuVjcbrs5q9bvT5jeZBlR9nbti+t0Yah
	o6eh5t05Vjk3S7huciPQNHZwO2ckseiC88Vu9MqQRJowXWEM1MOr38znEuiDjDJ0bcHFBV
	aNfN/MwQ1YRk+c5MjUv5IvFAlsqBVd0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-LU0V9BbOMYyo4t5irbC1kw-1; Wed,
 16 Jul 2025 06:40:23 -0400
X-MC-Unique: LU0V9BbOMYyo4t5irbC1kw-1
X-Mimecast-MFC-AGG-ID: LU0V9BbOMYyo4t5irbC1kw_1752662422
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C22221956089;
	Wed, 16 Jul 2025 10:40:21 +0000 (UTC)
Received: from fedora (unknown [10.72.116.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9131B195E772;
	Wed, 16 Jul 2025 10:40:15 +0000 (UTC)
Date: Wed, 16 Jul 2025 18:40:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [bug report] kmemleak issue observed during blktests
Message-ID: <aHeBiu9pHZwO95vW@fedora>
References: <CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com>
 <d52a8216-dd70-4489-a645-55d174bcdd9e@kernel.dk>
 <08f3f802-e3c3-b851-b4ee-912eade04c6f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08f3f802-e3c3-b851-b4ee-912eade04c6f@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Jul 16, 2025 at 03:50:34PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/07/16 9:54, Jens Axboe 写道:
> > unreferenced object 0xffff8882e7fbb000 (size 2048):
> >    comm "check", pid 10460, jiffies 4324980514
> >    hex dump (first 32 bytes):
> >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >    backtrace (crc c47e6a37):
> >      __kvmalloc_node_noprof+0x55d/0x7a0
> >      sbitmap_init_node+0x15a/0x6a0
> >      kyber_init_hctx+0x316/0xb90
> >      blk_mq_init_sched+0x416/0x580
> >      elevator_switch+0x18b/0x630
> >      elv_update_nr_hw_queues+0x219/0x2c0
> >      __blk_mq_update_nr_hw_queues+0x36a/0x6f0
> >      blk_mq_update_nr_hw_queues+0x3a/0x60
> >      find_fallback+0x510/0x540 [nbd]
> 
> This is werid, and I check the code that it's impossible
> blk_mq_update_nr_hw_queues() can be called from find_fallback().

Yes.

> Does kmemleak show wrong backtrace?

I tried to run blktests block/005 over nbd, but can't reproduce this
kmemleak report after setting up the detector.

Yi, can you share your reproducer?


Thanks
Ming

