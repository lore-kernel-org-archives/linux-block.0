Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C013FD130;
	Mon,  2 Mar 2026 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461782; cv=none; b=go8zbOeSnQSxHxchnLFQljq+h2yUCAXjVA9x1t6LirZf9V5mU1yTJbZ4+0ZVmIDBwiRqkvVOHVOiaT+wzANWA53F25TRSs6mjgA8eZbwtveouQHkrQVOShW72Yx6EM9eST1Q/yR3lyidtJF7yttX4GdDYFpjRUL3PqF1NE8t/G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461782; c=relaxed/simple;
	bh=9kU21AsxhowNEJaEqoI3FqkRtlcxWGTsDkfg3V6BtA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFBlSLboHb55X+N9pMz6AyPWCZECy1DS33r1vPyjNb6xt1v/4WlzXMgsK8bs93l2SMaylMb8PhAoDimG45Wfn+J33ilq9rX4l7FbdKzDbQ2ptVuFJ6AUBfW0X00AgUV1rSam+qhVHkhs77KnvMFtF8bBIOrkBslZgUfN6H3S47g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qMxpX3Va; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qMxpX3Va"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sFdR4sdgk264z4O4HPICrALzQhQb7goQVAr6GJ5BlOc=; b=qMxpX3VaorqWRddb5pftIav8yq
	9grcS2zdOqZ2V4B5Z1lTbe5TFN/iG7d+IWwxVSBeU8lTg+B3pQp39RM34zpF41/q63KjTkE7ipFrM
	T3pJxio4mCFgyd4splGECCVBrAkc95RR2mYMrxf8mKRWY13GqGp5H5Cx1O1UYRHUS8uM7y7sxEBbD
	5CRHEbCB/ODYXarRUElW/jlaxj3e2AXy5IzbwujgT+mIHp17CeG88mXPMksMwIFzkqF6gKTb135fm
	Lz8/QgWFXX43eGA8Em56UHiRO+7nx0QPG/NiaYUdD6IT+93yN7LWaoVHcHGygLFXsBxwGac4RMhKz
	4K0gsRRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx4HE-0000000DEjm-1paI;
	Mon, 02 Mar 2026 14:29:40 +0000
Date: Mon, 2 Mar 2026 06:29:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, jiucheng.xu@amlogic.com,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com,
	tuan.zhang@amlogic.com, Gao Xiang <xiang@kernel.org>,
	linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] block: avoild hang when bio_list is non-NULL in
 submit_bio_wait()
Message-ID: <aaWe1PsmzYatc_zR@infradead.org>
References: <20260302-for-next-v1-1-eb9339e8dc99@amlogic.com>
 <aaWVwH_Xna22DTAq@infradead.org>
 <dddf1754-d575-4f4b-a11c-09847d0d0475@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dddf1754-d575-4f4b-a11c-09847d0d0475@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 02, 2026 at 10:23:04PM +0800, Gao Xiang wrote:
> > > I've trimmed down the call stack, as follows:
> > > 
> > > f2fs_submit_read_io
> > >    submit_bio
> > >      mmc_blk_mq_recovery
> > >        z_erofs_endio
> > >          vm_map_ram
> > 
> > ->bi_end_io code really should not be having random in_atomic()
> > checks that make it completely different, but even if they have
> 
> Thanks for the head-up.
> 
> For this part, I'm pretty sure we need this particular one
> otherwise the scheduling performance (latency sensitive)
> is unacceptable for all Android phone users.

Where do you regularly get user context calls to ->bi_end_io?

