Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42AB1798F
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004312; cv=none; b=Oqo5qhoPcpaZWTI2MriWwfIGZ9g7XnE6tT3Jtg2O18+INghoFLrKmKxHgWi51o1JoTxUrk5lVaVPR7v9pkPdIV9Bs76bRlZezgFtWT4PswqHN6dHQIxZfPzb7TfcnTBBgQdMl9emeK6bjnReyQTHB2+qcxmo5vrgDFy8H5XtZd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004312; c=relaxed/simple;
	bh=SKxbFZ6OE433woyCGVk11C44GwMu/eZC0uJEcZsSSAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omfkGpe9Az8qtk7XUEgPgh4AQYULAJ65h9KSGUf9AFWxLyQoyexpLOnOwNTHWW2OWi45HOpjqovd8Ydz716hPJC2o5T02X+BQFGbo+seCpOebsxo/yIELgWPWuut7iOjB+NnvF2p6ljzKSZ8cM01TPAGFRhP/7xpqMJBMvEf9Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UUiWB+Kj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UUiWB+Kj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zQi+/yTSQuFP8AFNEoEKIllKprmzq7/DcSu2cdh8yOo=; b=UUiWB+Kjyk6PrCXRn2rfXmuQgp
	4HnK2pk6jLltahdtLcwb8hVk0ejanjtWWVFdHpFIylJ/0U0sxGjrHX07fhocYHVU+FE4ztMqr+sCY
	8iUVBs5gNx+5x80cZbPnJv2UmWNZ87LedFXoGfKb0G3ZEWBJUxLL0MjfJYtfNL1VsVd56X2G0a1z+
	svek8OLcaRqcQQrlKubUoswIMqwp22IIU+vI3joebnqJy3wRkSEvia9ZkmlcCJnvXnc4NfXMnCsuW
	ajsjZf/0NoXnmQJp7do7H76E5FmfMjiDVT0bINyJDcF/24P7mpV2TlI3ETimiJZcrR8smwyltULKh
	wArsvW8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIRlu-00000003qOW-0f0X;
	Fri, 23 May 2025 12:45:10 +0000
Date: Fri, 23 May 2025 05:45:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aDBt1qXj90JO1y2v@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521223107.709131-2-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 21, 2025 at 03:31:03PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide a basic block level api to copy a range of a block device's
> sectors to a new destination on the same device. This just reads the
> source data into host memory, then writes it back out to the device at
> the requested destination.

As someone who recently spent a lot of time on optimizing such loops:
having a general API that allocates a buffer for each copy is a bad
idea.  You'll want some kind of caller provided longer living allocation
if you do regularly do such copies.

Maybe having common code is good to avoid copies, but I suspect most
real users would want their own.
