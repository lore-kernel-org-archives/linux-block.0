Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0A3DEAE6
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969663; cv=none; b=Hc94KVnLJPP2I9xeB5szh5P370z63rSBYsr/WfCDFyBNBMK7oBUEe5GiFC/5WEBYfSuGbgkXmqaKqu1s0sLYeehjsqLuVTpUurrxD8BX57GMKx3YEl/fRWQN1oYzOYNcVKpRcGcVQmEY0X1Jnmv5qbjjUxonPS7n82HQr/5gNlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969663; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIFQqwwEtsSCD44SwlMt/qKWHhz+rd37IT4e7NcVsUmAcQcMRXC/oa66gDy7jPAzk5y58lnuXBZ1CmMnJdAvowfHvy2x3R/pvUU4Ln47bgbb+gA+yhbuAfm+ni3w9KPFzYCvospqT3PxcXoRvpsSgA2Pj0SzpowDv5Uhp67H4EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b1vfivYB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b1vfivYB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=b1vfivYBRqsffpDGrrry2hl7rs
	TWqN/8pxHnzFI+7zDqTtLOR8vd7GUT5SC1xd+zDe/6lY4ydI7fVynYKGsheSSe+ortUjbBN3dBX1s
	OvuMx2MjEiSxwDgFvwosmrPWI8hkD66JXL5bMjE9DK/LXeoHW0TiPAKYE/Q7Xqnieuo36PgleYrfS
	wkvsCypJ+oIi4XGw2CO3ph5HyDAPeYDv2QHDazAGpRZoL0f9YID7a4tFg1l11/DYz46+3wRbtvs6K
	zfxwbMzA/5stuMRlLmQToPY3bxUL3YqOtKMTAsn+b6UG8c+ek8lOmYbtuPa6m+TTiA3Zz+an3+P7p
	X1BB98fA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7agt-0000000D9BB-46d5;
	Tue, 31 Mar 2026 15:07:40 +0000
Date: Tue, 31 Mar 2026 08:07:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	Qu Wenruo <wqu@suse.com>, Avinesh Kumar <avinesh.kumar@suse.com>
Subject: Re: [PATCH v3] zram: do not forget to endio for partial discard
 requests
Message-ID: <acvjOxXdmMRebccm@infradead.org>
References: <20260331074255.777019-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331074255.777019-1-senozhatsky@chromium.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
