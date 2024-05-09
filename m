Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687813AD33;
	Thu,  9 May 2024 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258527; cv=none; b=Wz7Pk6zObtkBWfPRZmON7/c82r+5EQe+R+efo9BITe2iguLaRbmQ6dBoiEbJdIuThyuz0yzYZCR9XONL8jTscxM0rHbZlxusmulCKcQukuVFmzqQuH8lTlqx4F+Rh0xRCW35cktjlPic/BjHGyrFU2+S46LO0wPX+9W5dQN5BIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258527; c=relaxed/simple;
	bh=uOTQxuvQ8i7Oz5Vhw1Nb5t6RYRONDIv98MsW+Ken0ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8shlIUDVoyfppY/QjhOVpsEBf7GlZkUbwuFp78lg81rp7YgtKi5mlTmQ2PN8ED+velXxQm3/v7/qLg6bdK1i9ZbwZljfI1mYWtboVer4+bNdwacwvZNFWJw5hCYwouM2hJxRXfGH4qGy68pZ9WUMPilUbhNuUNymqvCZlh01i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MCsHHGGA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MCsHHGGA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/NQShJ2vBOZuOn/Cc2uD7FM4Dkx1Wb4jgFli6QGjY7w=; b=MCsHHGGAephGlLZzNPjbmC4PGG
	cjRzOpuDOZrEM9vsWhhzhq7GlEQsd2S63naSVU5QM/MmgmmEfy3V1rkQK5BFq8Fq6CZ53kCi73tp5
	3wJhESpoyK2expDWbcVG0sKx5LtgIQv0PZHQzd7I9OnQOS7JdpghLp9hDcsRR//d3DMIhEq86Maqz
	pkLyo4x8vBsgXtiOxeGBiNBO+vKu2H9OxLJMfXmB6RPheI7wtmr9wxx7pp2cSr1Mywib6kNdh/sHr
	ugoX69LDlnd/gndbMiFKVsjEOhS2Jb1F1KJgSvk7cEGAPyMfBbrqRoDusn9IyS9xMRLg3XCgpOJJn
	snTSSQPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5365-00000001SrE-1Dn6;
	Thu, 09 May 2024 12:42:05 +0000
Date: Thu, 9 May 2024 05:42:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv3 08/19] zram: add 842 compression backend support
Message-ID: <ZjzEnbHGO_hYQN11@infradead.org>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
 <20240508074223.652784-9-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508074223.652784-9-senozhatsky@chromium.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 08, 2024 at 04:42:01PM +0900, Sergey Senozhatsky wrote:
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Not a very useful commit message, made worse by the magic '842'
name.  How is anyone stumbling over git-blame or looking at git
logs supposed to make sense of this?

