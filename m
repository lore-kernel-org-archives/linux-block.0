Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D781F5825;
	Thu, 24 Apr 2025 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494299; cv=none; b=h4/u3QzOhx+mpbXIQoNYRk5YpCXfRgJUQ/rURDq6qvVlDLNEWAGDzMacJvy13XuBjJ4sUPNO7HJNLVXrX3o/Ym9S59od5NZ1ADflLQqW1jo4dDislE63xpIe4vgUKalbD/Pljc+02ZZmga0DQjA7wjCVoKhLrcr38By65ao5V0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494299; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIZCthncaTpRvvdm6BjVBryfAPacgzwyd/cWxwtxSxRSKLdkYVzyG1RZklhmb6S27xch+vTL2plFrywHYoKcKrmhhkbaUPlWF5kWW3BXm5jwqzuxtjIzSbA3mhV4wgrHu62+e/4PnIOMQb4BtIlYYh4nnrOcXoABxXVBDIDYIb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=33ytmgKb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="33ytmgKb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=33ytmgKbgH5rcros1IE8DC6Tn5
	/k5F6vL2/Pg1y1wLwQ5xxhKpqYL0iqSIg6v2Tgh45rKkmTe5463jjP5s8R8pd10x5h0qKw1nkLAHb
	QkhPp2jhBSpdmsAB8F1FsfxVLbScgCYmt06h6eRUl4HMte4gKPur8HPqkWX9Euhe3//2tI1uDAd4G
	u46B1WzP2w6c0Xg1pbVbIB/7ett2lu8ghfKMl/Sxp/PWWCFOeR86sOigO8cUNW4NX7hs3Pl8Mnqkm
	tterEqV/5fCkpyha/aguaXWlSDR3SwLqif59wTWW2TD6VB0kPWlSFr89vO+GzhCOKXvtloOXqx9GS
	SRQNI6oQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7unp-0000000DrfZ-1X4i;
	Thu, 24 Apr 2025 11:31:37 +0000
Date: Thu, 24 Apr 2025 04:31:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] block: factor out blk_mq_dispatch_queue_requests()
 helper
Message-ID: <aAohGZaxXh52LuNO@infradead.org>
References: <20250423205127.2976981-1-csander@purestorage.com>
 <20250423205127.2976981-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423205127.2976981-3-csander@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
