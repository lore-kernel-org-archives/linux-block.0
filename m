Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18287802
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 01:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361704; cv=none; b=RJ4EILupB2yjlhaEgm0HTrHgF9dLv4SHUdawGJUu05huHD3R5/MBEDKMVFXKQs+FQgKSNWVUODHf2O/pE+y/mhhl/myCVsg4DmnHAH8DWKh2I8VfL6icz0KsfT5c03QB04RlIoPWZM3PQ/aMEpsU5eA2ncipmaLS3PGb7EucgmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361704; c=relaxed/simple;
	bh=ksREb5QRYrWx1KvfQRXcLDNHRCMSE+C4SJgwCl/H2lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myyizb+mJ2souzIpk4ePNs68GazOz1YPtgeQik2cIKjGdRh82REovtJEL5NtVd3qGYcAKGt/Qn/fEvVOyIeblsPHbxfPHyIih4kw3GQ5vSYu92z2xFqijx2KK8JOJtkeX4rzl+PP04qZGZ/DBTD4axfqWPA7Qk6MZmS7fw9TqTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ili+xljY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ili+xljY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740361702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0t2gtl47zVjlu4/fj1jDYJiit/Ra/za3+mFMCoj3kkE=;
	b=ili+xljYGuO6LLLprAWHEvNAdprQQs7JKOksy16abwO4KRId3+RcDQvAukH06Xt2iTOmyg
	TmxQir4X0UTXAoRCNX1u18CC3bMBqIN+QmkOEdukZkUP14V4d97PrEfKFHnqzYvYcf4dGP
	UNUVgj3m6cxIwzZ5Yny4G9ep3T4L36o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-c8AMEkFIOM6bxdYgiRXsjA-1; Sun,
 23 Feb 2025 20:48:18 -0500
X-MC-Unique: c8AMEkFIOM6bxdYgiRXsjA-1
X-Mimecast-MFC-AGG-ID: c8AMEkFIOM6bxdYgiRXsjA_1740361697
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5216419373D8;
	Mon, 24 Feb 2025 01:48:17 +0000 (UTC)
Received: from fedora (unknown [10.72.120.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 639241800352;
	Mon, 24 Feb 2025 01:48:09 +0000 (UTC)
Date: Mon, 24 Feb 2025 09:48:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Daniel Gomez <da.gomez@kernel.org>,
	Paul Bunyan <pbunyan@redhat.com>, Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V4] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z7vP1MdHRQo0Kj7U@fedora>
References: <20250219024409.901186-1-ming.lei@redhat.com>
 <Z7jeOpW882Old2Eh@bombadil.infradead.org>
 <Z7vDnAtt9K14pZMz@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7vDnAtt9K14pZMz@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sun, Feb 23, 2025 at 04:55:56PM -0800, Luis Chamberlain wrote:
> On Fri, Feb 21, 2025 at 12:12:44PM -0800, Luis Chamberlain wrote:
> > WARNING: CPU: 2 PID: 397 at block/blk-settings.c:339 blk_validate_limits+0x364/0x3c0                                                                                           
> > Modules linked in: mmc_block(+) rpmb_core crct10dif_ce ghash_ce sha2_ce dw_mmc_bluefield sha256_arm64 dw_mmc_pltfm sha1_ce dw_mmc mmc_core nfit i2c_mlxbf sbsa_gwdt gpio_mlxbf2
> > f_tmfifo dm_mirror dm_region_hash dm_log dm_mod
> > CPU: 2 UID: 0 PID: 397 Comm: (udev-worker) Not tainted 6.12.0-39.el10.aarch64+64k #1
> > Hardware name: https://www.mellanox.com BlueField SoC/BlueField SoC, BIOS BlueField:3.5.1-1-g4078432 Jan 28 2021
> > ng pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)                                                                                                          
> > pc : blk_validate_limits+0x364/0x3c0                                                                                                                                           
> > p.service                                                                                                                                                                      
> > lr : blk_set_default_limits+0x20/0x40                                                                                                                                      
> > Setup...                                                                                                                                                                       
> > sp : ffff80008688f2d0                                                                                                                                                          
> > x29: ffff80008688f2d0 x28: ffff000082acb600 x27: ffff80007bef02a8                                                                                                              
> > x26: ffff80007bef0000 x25: ffff80008688f58e x24: ffff80008688f450                                                                                                              
> > x23: ffff80008301b000 x22: 00000000ffffffff x21: ffff800082c39950                                                                                                              
> > x20: 0000000000000000 x19: ffff0000930169e0 x18: 0000000000000014                                                                                                              
> > x17: 00000000767472b1 x16: 0000000005a697e6 x15: 0000000002f42ca4                                                                                                              
> > x11: 00000000de7f0111 x10: 000000005285b53a x9 : ffff800080752908                                                                                                              
> > x8 : 0000000000000001 x7 : 0000000000000000 x6 : 0000000000000200                                                                                                              
> > x5 : 0000000000000000 x4 : 000000000000ffff x3 : 0000000000004000                                                                                                              
> > x2 : 0000000000000200 x1 : 0000000000001000 x0 : ffff80008688f450                                                                                                              
> > Call trace:                                                                                                                                                                    
> >  blk_validate_limits+0x364/0x3c0                                                                                                                                               
> >  blk_set_default_limits+0x20/0x40                                                                                                                                              
> >  blk_alloc_queue+0x84/0x240                                                                                                                                                    
> >  blk_mq_alloc_queue+0x80/0x118                                                                                                                                                 
> >  __blk_mq_alloc_disk+0x28/0x198                                                                                                                                                
> >  mmc_alloc_disk+0xe0/0x260 [mmc_block]                                                                                                                                         
> > ...                                                                                                                                                                                           
> > mmcblk mmc0:0001: probe with driver mmcblk failed with error -22  
> 
> I'm left still a bit perplexed with one question still, this is a known
> issue now with using large page systems with smaller DMA max segment
> sized devices either eMMC and Exynos UFS, does your patch just fix the
> probe issue on eMMC?

Yes.

> What about functionality?

It works just fine, as you saw Paul's tested-by, or do you think there
are other areas not covered by this patch.

> What aspsect of Bart's
> series is now not needed?

You can see this single patch as Bart's next version because of block
layer's evolution.

> 
> Bart's series were NACK'd as the changes were deemed too intrusive to
> maintain on the block layer, so I am curious what has changed here to
> enable eMMC.

Basically, the following patches help much on the progress:

commit 6aeb4f836480 ("block: remove bio_add_pc_page")
commit 02ee5d69e3ba ("block: remove blk_rq_bio_prep")
commit b7175e24d6ac ("block: add a dma mapping iterator")

They changes passthrough code path to use split, so Bart's original
change in passthrough part isn't necessary.

> Will 16k page size systems with Exynos UFS work now?

It is supposed to be true.


Thanks,
Ming

