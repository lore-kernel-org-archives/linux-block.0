Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705E12F23;
	Thu,  4 Jul 2024 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720073929; cv=none; b=RziOSmM+Fm7EtswXHQuVTGhjlkIsHLr8u9++1dUevD4hePq26BM1FDw1mcbCYkhjDAPraPcUpdCcqn2cTpyI0R5JXt6i1cChKQ90rRvk3kRnsHfFVza2mwIdc3POD/zjybMyf8sLKeKBMq4Dzz8RYxyk1veLkomn2/XmX/JuYRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720073929; c=relaxed/simple;
	bh=vpbOpISekpKvtUgymf67XtTxfvfyNXM+06PSwqJXh5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cm+maLdm17UweI610wLOqwtxYYYwCAYXauozBwkgtykTH9sH/2gFbroNEJtEhjDJ9fRJDAqagfQi9NnipOvrHfg7/nvJBR1iagx4PspMBu25vnsaVIjI2Mcs7/hAb44FJPMZELWKAsuMXW4OBGcUUhWRhCwuPOYwQrSRMD+xRmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jn/6o6oq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jn/6o6oq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vpbOpISekpKvtUgymf67XtTxfvfyNXM+06PSwqJXh5I=; b=jn/6o6oqZuaWLVLRsK1kWuUPZk
	3SdU16q5AMCvPlpQzee/i18+FtGPnCXw+XeTW7byShE0XFb4LrPpwzcgcXDyRrf10JhgeAXPTbb05
	JtxlfWISv/Vz8geO1NBzq4Xn/8ZZvpJ4aSWv/Afov4C7mPRKJMqX4CtdUGdEjDrmDGlBmGE9A3BXG
	jLt2moYpFTjDyEYG+XkPAgu4SBWvYZGPz0Cwl+mq+t/rsZz93G6r0jrdbW3dYkLyDDWOOKwKX0tDo
	aQ3KGbPbk4meOBtRjaJEbyI9Wdr5wsJQ7Poch+RCYuzgRYbATqGKqrczj5FPGaNvrVEF7D2wrNJkq
	e9S7Tq6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPFnr-0000000CJDt-39nR;
	Thu, 04 Jul 2024 06:18:47 +0000
Date: Wed, 3 Jul 2024 23:18:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: blk_validate_limits validation of block size (was Re: [PATCH v2]
 null_blk: fix validation of block size)
Message-ID: <ZoY-x-mtBoLW30yb@infradead.org>
References: <20240603192645.977968-1-nmi@metaspace.dk>
 <Zl4dxaQgPbw19Irk@kbusch-mbp.dhcp.thefacebook.com>
 <Zl6cHI48ye7Tp1-C@infradead.org>
 <8f8f8f78-fcd4-4e71-8dd5-bae03a627a34@oracle.com>
 <Zn-Wpq2AzBo6rcgd@infradead.org>
 <43aab70c-8521-4dfa-847a-1175d31a55d1@oracle.com>
 <ZoVP5NZhCmMH6qBp@infradead.org>
 <b7054e7b-9db1-46d4-ad19-8ced0eecf2e5@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7054e7b-9db1-46d4-ad19-8ced0eecf2e5@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 03, 2024 at 06:28:48PM +0100, John Garry wrote:
> ok, fine. It's a bit unfortunate that blk_validate_block_size() won't be
> internal to the block layer.

It is a completely trivial helper not really exposing any internals.
In theory we could just open code, but with the PAGE_SIZE limit that
people are trying to remove with large block size support that might
actually create more problems than it solves.
