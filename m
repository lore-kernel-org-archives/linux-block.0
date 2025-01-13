Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC7231CA3
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736759882; cv=none; b=ZrfjzzACU4XFd+/vGRlD7gT8hyj9DNsif+1k8zuTDY58qrbe6oHo0USYgGCwGTIpW6NvuuPyMm6dEheVSOYOI9W78yXRWms4+QQCbr1ftsL9F7LI0fVzyBLGzsluNzjVRmY9zg+O/mEfHAXA3LAw4vU2w7D81KgdHeM90r79Ssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736759882; c=relaxed/simple;
	bh=43uGB/HhwRUKHgVKPWEkOb5cQyvFtE5S+GdS2in77D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU6m6t7bY6gnkWvRGIER4AP0lKRctrOZTBzx4UodlSB/yoeoNKsmUryEqDvap7HWv5QU7Hi3NnOuthmeIS4K39jwsfZSCMQ/b7DXi3W1ygJ4IVehQt7eLRDf3owIcpO3nB298QVGwdzzKYy2XtfgqPYqeswpG5Q2qnxiUeq9O3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=no/r6dT6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="no/r6dT6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WvlwDyPLi1RxE19yAabDwwBkEOxpzX3iFDREonTBLPY=; b=no/r6dT60vGmerSjMLpOQQHC1Z
	8LASoHV6P6QofHZZO+KOs9BRMcPq2dcnZ/xxV2WAFYi/AfMmVG5D+BIRuntV04WcWU1fyg3Cj5SGD
	8f2cXTs9X63wDhpLyeezRGkt9/aDTDq8bcj1rqau0f7fe3xTWxeNTrNCndtYnyh3kPRp852WkKolu
	tKX/lNk+xuNgDF87YrQAEUhFTy7mupx0x1/UKkljUJO/Lv/IwnBhVCC/immLlX5YFvdfjpeFeZz23
	1KIm06oqKK2aeOWJuLEPDIT0fh9WZ1lhB56z6yugWLJhn0XrHvOFtqVkmzdxsagtmSL7KLGvvpB1f
	sLXyKYBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXGa8-00000004ZUz-0DgL;
	Mon, 13 Jan 2025 09:18:00 +0000
Date: Mon, 13 Jan 2025 01:18:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Kun Hu <huk23@m.fudan.edu.cn>,
	Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH] loop: don't call vfs_flush() with queue frozen
Message-ID: <Z4TaSGZDu_B2GS1c@infradead.org>
References: <20250113022426.703537-1-ming.lei@redhat.com>
 <Z4Spc75EiBXowzMu@infradead.org>
 <Z4TNW2PYyPUqwLaD@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4TNW2PYyPUqwLaD@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 13, 2025 at 04:22:51PM +0800, Ming Lei wrote:
> On Sun, Jan 12, 2025 at 09:49:39PM -0800, Christoph Hellwig wrote:
> > On Mon, Jan 13, 2025 at 10:24:26AM +0800, Ming Lei wrote:
> > > If vfs_flush() is called with queue frozen, the queue freeze lock may be
> > > connected with FS internal lock
> > 
> > What "FS internal lock" ?
> 
> Please see the report:
> 
> https://lore.kernel.org/linux-block/359BC288-B0B1-4815-9F01-3A349B12E816@m.fudan.edu.cn/T/#u

Please state the locks.  Nothing fs internal here, that report is
about i_rwsem.  And a false positive because it is about ordering
of i_rwsem on the upper file system sitting on the loop device vs the
one on the lower file systems sitting below the block device.  These
obviously can't deadlock, we just need to tell lockdep about that fact.

