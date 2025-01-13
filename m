Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE542297EF
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780881; cv=none; b=KqSm3+tMWgktbj9OWAMXiHRv4QD2B4zeqkpdwqC2qA8FRlDINSBh9giTb9q/84GHdj8A5iB60hop9T4Zjw8pHUUHsWyUyEdCTtNcke1XBohpv162/nkoDjySn4dF++5JaVG9/kPYUrGPnAsBgaz9IZ04r/r5XAJs3MDdmT3Uw2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780881; c=relaxed/simple;
	bh=7nqGFBDoHOD6PhaWePuqGvZM2HuXu379XZrqY3Y/nBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbZ1mWI9V5FRIT9E5SMjrq9fBL6kaSHVXcqfSuXhW3r+tqO4t9kXrXfaWqhbEWyNqfBd+Cwdzup4JbCYVeBPDLRJK7oxZkYhRlQmUXqlcJfLzqvOJksWANeWk0Zn0Zw1oLWAuR9s+Fp5CHu4YTlXYn4b1DzbWptCubZL47VM0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwlIW5FN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwlIW5FN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736780879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eUc9WhIO5oV4xpjYMESJDeB1+O60zmuFN29kFOoD2gA=;
	b=BwlIW5FNqB3Qj7QJOGqzRYbJOpik8vXjdgKQtUWKGxHsHsNhy7NfpqggtfVnjOpZI4hNfh
	55sznOflxhAeLbuc3S0DVsIYK/n+8E1e8NhVHAkYri+WQXKHDy28z4D6f0ylJyV5FGyU91
	a+KNWpNJKqqOwJxJRcIoQ48Gs5GI80A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-74Q76gM2MJu1MCVr1hO_gA-1; Mon,
 13 Jan 2025 10:07:55 -0500
X-MC-Unique: 74Q76gM2MJu1MCVr1hO_gA-1
X-Mimecast-MFC-AGG-ID: 74Q76gM2MJu1MCVr1hO_gA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00B48195606F;
	Mon, 13 Jan 2025 15:07:54 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB32819560A3;
	Mon, 13 Jan 2025 15:07:48 +0000 (UTC)
Date: Mon, 13 Jan 2025 23:07:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH] loop: don't call vfs_flush() with queue frozen
Message-ID: <Z4UsPor30ss0ML9s@fedora>
References: <20250113022426.703537-1-ming.lei@redhat.com>
 <Z4Spc75EiBXowzMu@infradead.org>
 <Z4TNW2PYyPUqwLaD@fedora>
 <Z4TaSGZDu_B2GS1c@infradead.org>
 <Z4Tb3pmnXMk_z2Fm@fedora>
 <Z4UZ947fLqHusJzv@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4UZ947fLqHusJzv@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jan 13, 2025 at 05:49:43AM -0800, Christoph Hellwig wrote:
> On Mon, Jan 13, 2025 at 05:24:46PM +0800, Ming Lei wrote:
> > > Please state the locks.  Nothing fs internal here, that report is
> > > about i_rwsem.  And a false positive because it is about ordering
> > > of i_rwsem on the upper file system sitting on the loop device vs the
> > > one on the lower file systems sitting below the block device.  These
> > > obviously can't deadlock, we just need to tell lockdep about that fact.
> > 
> > How can you guarantee that some code won't submit IO by grabbing the
> > i_rwsem?
> 
> ?  A lot of the I/O will grab i_rwsem on the underlying device.
> Basically all writes, and for many file systems also on reads.  But
> that is an entirely different i_rwsem as the one held the bio submitter
> as that is in different file system.  There is no way the top file
> system can lock i_rwsem on the lower file system except through the
> loop driver, and that always sits below the freeze protection.
> 
> > As I explained, it is fine to move out vfs_fsync() out of freeze queue.
> > 
> > Actually any lock which depends on freeze queue needs to take a careful
> > look, because freeze queue connects too many global/sub-system locks.
> 
> For block layer locks: absolutely.  For file systems lock: not at all,
> because we're talking about different file systems instances.  The only
> exception would be file systems taking global locks in the I/O path,
> but I sincerely hope no one does that.
 
Didn't you see the report on fs_reclaim and sysfs root lock?

https://lore.kernel.org/linux-block/197b07435a736825ab40dab8d91db031c7fce37e.camel@linux.intel.com/


Thanks, 
Ming

