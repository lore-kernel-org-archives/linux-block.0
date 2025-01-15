Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D58143C72
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736908647; cv=none; b=bJSxD4ZzsUuurLbkh9vF1W7iyqscgI4sh4leGV+86/dK6PMbVo7Nmwia7XG4HoezYBLNvFtey/GqWC96azuuOKAO60kxEmKl4s2QQF3v0136xSWqyi3PJuBeVEdXMERAYlMbdQhwPh8E3PbD4ZH6DnhBKshvm3kL7DkEGiMSGbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736908647; c=relaxed/simple;
	bh=htuMfKR2U8cfmMewe1gTC7uvjA+MTc4mIHrDMHRiiJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0E8aHPvh3e3G4c00iOvRi8M7+AToS8prn3IE6cTd/TTGcxBm+bm13ha+8ly1QDKhLAlBx+tbowBMGaeflWwoNctKfeQX25IlyR+YAtEtQiZps/Re1N3ti2Wd9zW5CUdZUSXV/kM1B6ghbLYbKi19ic3lvXhRn1mV39gnYHVqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9Rup6vI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9Rup6vI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736908644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jjHXv2HR0JqVwq0k2LAuVaOqNtuehZk36JETXcEViQo=;
	b=h9Rup6vISr+vd1AyXSrLOjTVplL9A6IjnUig8je6eJDqa7mDafukzy+AQV34lqZjca0jlo
	T+ZO14JN8D9cUmK2PkcGlN7VqhURY0XbBLJIEGnc05kBZrPp7/uXsFgA91y0Q1qN/M3gea
	fRNnbolMHHebL/cVVP/WkZnW05Epox8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-1r_VQgWkP3m-gKC2IuNOQQ-1; Tue,
 14 Jan 2025 21:37:20 -0500
X-MC-Unique: 1r_VQgWkP3m-gKC2IuNOQQ-1
X-Mimecast-MFC-AGG-ID: 1r_VQgWkP3m-gKC2IuNOQQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C26019560B8;
	Wed, 15 Jan 2025 02:37:18 +0000 (UTC)
Received: from fedora (unknown [10.72.116.97])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4049195608E;
	Wed, 15 Jan 2025 02:37:13 +0000 (UTC)
Date: Wed, 15 Jan 2025 10:37:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH] loop: don't call vfs_flush() with queue frozen
Message-ID: <Z4cfVBrd9OJiYYG-@fedora>
References: <20250113022426.703537-1-ming.lei@redhat.com>
 <Z4Spc75EiBXowzMu@infradead.org>
 <Z4TNW2PYyPUqwLaD@fedora>
 <Z4TaSGZDu_B2GS1c@infradead.org>
 <Z4Tb3pmnXMk_z2Fm@fedora>
 <Z4UZ947fLqHusJzv@infradead.org>
 <Z4UsPor30ss0ML9s@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4UsPor30ss0ML9s@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jan 13, 2025 at 11:07:42PM +0800, Ming Lei wrote:
> On Mon, Jan 13, 2025 at 05:49:43AM -0800, Christoph Hellwig wrote:
> > On Mon, Jan 13, 2025 at 05:24:46PM +0800, Ming Lei wrote:
> > > > Please state the locks.  Nothing fs internal here, that report is
> > > > about i_rwsem.  And a false positive because it is about ordering
> > > > of i_rwsem on the upper file system sitting on the loop device vs the
> > > > one on the lower file systems sitting below the block device.  These
> > > > obviously can't deadlock, we just need to tell lockdep about that fact.
> > > 
> > > How can you guarantee that some code won't submit IO by grabbing the
> > > i_rwsem?
> > 
> > ?  A lot of the I/O will grab i_rwsem on the underlying device.
> > Basically all writes, and for many file systems also on reads.  But
> > that is an entirely different i_rwsem as the one held the bio submitter
> > as that is in different file system.  There is no way the top file
> > system can lock i_rwsem on the lower file system except through the
> > loop driver, and that always sits below the freeze protection.

Actually some FSs may call kmalloc(GFP_KERNEL) with i_rwsem grabbed,
which could call into real deadlock if IO on the loop disk is caused by
the kmalloc(GFP_KERNEL).

So it is not one false positive.

> > 
> > > As I explained, it is fine to move out vfs_fsync() out of freeze queue.
> > > 
> > > Actually any lock which depends on freeze queue needs to take a careful
> > > look, because freeze queue connects too many global/sub-system locks.
> > 
> > For block layer locks: absolutely.  For file systems lock: not at all,
> > because we're talking about different file systems instances.  The only
> > exception would be file systems taking global locks in the I/O path,
> > but I sincerely hope no one does that.
>  
> Didn't you see the report on fs_reclaim and sysfs root lock?
> 
> https://lore.kernel.org/linux-block/197b07435a736825ab40dab8d91db031c7fce37e.camel@linux.intel.com/

There are more, such as mm->mmap_lock[1], hfs SB 'cat_tree' lock[2]...


[1] https://lore.kernel.org/linux-block/67863050.050a0220.216c54.006f.GAE@google.com/
[2] https://lore.kernel.org/linux-block/67582202.050a0220.a30f1.01cb.GAE@google.com/

Thanks,
Ming

