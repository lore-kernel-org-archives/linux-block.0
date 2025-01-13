Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7722CF0B
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776186; cv=none; b=TgoXeeDsD0BaNJVU+bgPGPA9dJLMa3PMJKRU94yQqeHnGvNd2a8sT1MQMNeVUkclu/8fPQvJbV5fjSI8KAr4FxeX6iW295IQXQvdqC96u8bWhZ08ARMVCZO/CUj505FeaEpT8Hz1DNp5NfFlVIhHV0BOxQgwqS/h+puFBYmpmoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776186; c=relaxed/simple;
	bh=en/J+whLbO9+tPgMBq/UtdveO4S2TLshZ3YUw4LMwos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjTibVGmYRyTNNJJJxQTbVpt9rXJRFfWn/m8Qna3/qIO0mff/r+Y//ffTge9hRfZrjIikTOKvnS92l5K4bWoLdKW16quyaHH0zBB3rjPGekCpJi70SXssgMPSMkMZ1BVH58P31h0JFVt0SGeuEVyMf5ZYUCmOIUO3pCYOQAH7xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=w7rWlzIZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w7rWlzIZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k+ZWg2q/FranFlEESifmyYALtYJ9oQgh/Boh/NwiJYc=; b=w7rWlzIZLjUbSzUKsxoMZ/GIRT
	JujTc5Q6ecKkWPL0v+qKKxxtH2reIN+jh4LjJ1bScTsGvmTHQOeloFhnqGLDt9XUUjahOfNBYIDOr
	PfS4uboUoO0+dKCVD24V3nQs3M7f9m3puXbhg6Gd9zX86uIvf2oCBGSZDZrkai6ZAckhEL42Sv2sV
	qosdFB5WHDcqcTKcMVkE6O2niIqEgX2K53bf69ZNnyDV4ZSnCf/uToWqujkf9M2DwEsjU2OMW4Ia+
	WlTxkA3gJYnXp8k2Gifk4ml1H6/cd6Bp5ZgEwVS5qyWEoGiYvxJINfZ5B6tAZiffOOHqtCFesY53/
	ADwGlO7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXKp5-00000005JDf-18lK;
	Mon, 13 Jan 2025 13:49:43 +0000
Date: Mon, 13 Jan 2025 05:49:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Kun Hu <huk23@m.fudan.edu.cn>,
	Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH] loop: don't call vfs_flush() with queue frozen
Message-ID: <Z4UZ947fLqHusJzv@infradead.org>
References: <20250113022426.703537-1-ming.lei@redhat.com>
 <Z4Spc75EiBXowzMu@infradead.org>
 <Z4TNW2PYyPUqwLaD@fedora>
 <Z4TaSGZDu_B2GS1c@infradead.org>
 <Z4Tb3pmnXMk_z2Fm@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Tb3pmnXMk_z2Fm@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 13, 2025 at 05:24:46PM +0800, Ming Lei wrote:
> > Please state the locks.  Nothing fs internal here, that report is
> > about i_rwsem.  And a false positive because it is about ordering
> > of i_rwsem on the upper file system sitting on the loop device vs the
> > one on the lower file systems sitting below the block device.  These
> > obviously can't deadlock, we just need to tell lockdep about that fact.
> 
> How can you guarantee that some code won't submit IO by grabbing the
> i_rwsem?

?  A lot of the I/O will grab i_rwsem on the underlying device.
Basically all writes, and for many file systems also on reads.  But
that is an entirely different i_rwsem as the one held the bio submitter
as that is in different file system.  There is no way the top file
system can lock i_rwsem on the lower file system except through the
loop driver, and that always sits below the freeze protection.

> As I explained, it is fine to move out vfs_fsync() out of freeze queue.
> 
> Actually any lock which depends on freeze queue needs to take a careful
> look, because freeze queue connects too many global/sub-system locks.

For block layer locks: absolutely.  For file systems lock: not at all,
because we're talking about different file systems instances.  The only
exception would be file systems taking global locks in the I/O path,
but I sincerely hope no one does that.
