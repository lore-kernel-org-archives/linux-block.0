Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411BE12EBE1
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436496; cv=none; b=gXkJQUrZjVQLLTDGGKUvQlEU8YqWvS1Q32OiTjFnxlP6XezQDCKGYZyqDUR7QaYEZz0pQsbVk22JiQiRzdbj6OWxlg3cai25XWbrS1yHaWDbSt72U17OSOW3us16bIXjVgy45mNUaAS7RV/mHyJgl4mO/yW0upCekTorHYiscoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436496; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSQEvbX1HsVgMj6nuo0VHZ4jkWULeezQh4TZeJ8kiq3YpGYxBNS4flWfjM7dvTbEMmU/Am+4dbfL/y9Na+nLLe5PAWIWhjtr5827vd1HUAOTJ+P+4YHOdfzqWpykyGvsy4h1BoBHAvbtLBMtYcvyh3I/j1oSMiXfZ1w8rmKgA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=reHnsgMc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="reHnsgMc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=reHnsgMcWAONE84mAa2lccJYjp
	8/YuyM4RAJkLZv0TAZqJEirOFubdSGHYZRQKHLVo8AW7oNy92PBPkFSqo8UY11EgPTAbvHBsQ3vA+
	8w64an4qgeDeRYkpCbb5G20E0jJxzxX3pvtIko9iic3vq5is/5AM/BXTXzkbpi1r4R8GQ6h5WCLUu
	pAEPAuIGSmQ4e0yhQdphN/BJwxNoYyOJoYtPgJGcbKWpCcGZlmSPXThSSK72E+P0yz/cnaru743Bp
	mfMGKQ6vuppiDqsegsB72dcHfdhYcwA0s56PMbvW2ROMIvgJQYLZSqS/DjiWkqpvAqa8N5F2aGaev
	wv5CKrFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp0oQ-00000003Ml4-3Xv1;
	Tue, 26 Mar 2024 07:01:34 +0000
Date: Tue, 26 Mar 2024 00:01:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Make blk_rq_set_mixed_merge() static
Message-ID: <ZgJyzs39EvDrQjk0@infradead.org>
References: <20240325083501.2816408-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325083501.2816408-1-john.g.garry@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

