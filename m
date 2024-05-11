Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CEB17548
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715468253; cv=none; b=Kt5BpWLBf2PBHHtifx9ObS2Nl4TkIENjl/mZGU9rdNdULI9DZBHVX0Qrz41hjLhMVeJ+uPRnz7T2a3kdipH65vyPJ8DmQ+/BzTQQ2f7Ma447EaFBTte92mNrTOWXrnooYngTxiioJ7R+VllS1dShLGdFqI70IjTa4YMv6t4W0Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715468253; c=relaxed/simple;
	bh=h4RQP0T1mBOZ7il2kbA1VmWUz1ykojRjpTawOUgbWTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+G96fGuFwWDsiRE1ggCHQXDJX8IWKEB0BSg4Alygpeo3dDp4Mk+K3vurSLBZame6ltJpeCUWaG8YiwMSNeAjNt3Xcf07eep4Ceu7xeEtMthfvcfFFLjMquk0jwHXWEkqAaOFKRWIVbg7siclYWdi9+9Y8cM8rdQvNroQ0eRCL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2pWXLkDe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2pWXLkDe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h4RQP0T1mBOZ7il2kbA1VmWUz1ykojRjpTawOUgbWTU=; b=2pWXLkDerDBB4F3sGLRZmJW9Cp
	JFwh8Tuie2cv+obMoeChzBrI+7ckkPlSV9tpBPAaWmqe9RDhFt+xuQ4DrABip0PH8cBcVOR6ZIQOB
	ARTG18Zsn1B9ZZDBu7dQPzK87Vi7+P2eTfO4GMM/eiC9aB1qpk4XT4ibzh4X2FzDOXvps4KtbCUA3
	esjkVOLq7OrnTzxeTGiDEPO4RVeBfgTfUklmpB1CtC+RTznX6J4hMRtAWTgd6zuafZmKoWOWfa0kF
	tU2YXVaYvrOrQ/4qliFbUpsq5DZrYoCUTv84n2IhMM5iG7xdC6N+p3i4Sch/dbzwLNf8JcExVwpWF
	r7SiDMmQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vek-00000008rpq-1r1e;
	Sat, 11 May 2024 22:57:30 +0000
Date: Sat, 11 May 2024 15:57:30 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: hare@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/5] block/bdev: lift restrictions on supported blocksize
Message-ID: <Zj_32mOcrHblLJFn@bombadil.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-4-hare@kernel.org>
 <Zj6e95dncIn-Zrlh@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj6e95dncIn-Zrlh@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, May 10, 2024 at 11:25:59PM +0100, Matthew Wilcox wrote:
> Not all architectures support THP yet

I noted to Hannes the existing page cache limit, should we have a helper
which also then uses CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE to fallback
to PAGE_SIZE otherwise ?

 Luis
