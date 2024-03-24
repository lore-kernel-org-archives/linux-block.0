Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE3D178CF1
	for <linux-block@vger.kernel.org>; Sun, 24 Mar 2024 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323596; cv=none; b=T/94MxMSMHu0q5Gy3u/qdTmyzxjGdF0vqsZRlbWAQCOWma9vYgNmRQw8mWDtC/2xNzpXUCmaUctnbNWPfoRuluMIvk8KDqMWZxc1Fxb4T/VwG3FCum/kugHqqfkR/fMacFMDR/e8ai45imp2Jkril8OOtLNL5UinbBhgK3h2k5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323596; c=relaxed/simple;
	bh=POgH/L5/8sKhERoaHdSUsravzApcjrzfC6U0gswpZBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7WG1WhsRKWBeKk+QDDUdYEgvV6frTX2Q5qA3kDLo9lgfwD3rdKW0MGmksZFdsghCgRwXo5mTKL0pMHyZ6M4IuKYNYS81CGcoVbGKInb1hDyIbNgorL9Mb84RTNARR5/prUc518mZyOrxUNW3M+MuOOAV9D5sA32Os0zcMrU63I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4+w9wpLr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4+w9wpLr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=POgH/L5/8sKhERoaHdSUsravzApcjrzfC6U0gswpZBY=; b=4+w9wpLrZoPglCkTD/AUIpHqRH
	JE/qgb9XS+7egP0J+xt9evnRg0zgi/oMwcXLzG6X8u6za0PgDcHsJn3FtzunhITXPV70/qCam6KMo
	2h49qXsfQjUfURS/46pnLCx6qsWBsLhrxcaL59FSsIi1kbl+hwcLyZEPlwUtTr3mpZXXnHl0t7Hww
	tul+PQPQTAB48KUl7bRv9/Bh6Y1kLJqTBEXqCcAKeciJWIMkY1NOprWbmjOC/Y+JsNTHVp75uIzcw
	No9vpqDpK/vn8I81+09Ect7TWKHM15OTRXVnHTCFuSLbTQbKxoP4d1rIzLCBwn+GvSrJ5zpsblHrh
	cQTNVheA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roXRR-0000000DvIF-3d8Z;
	Sun, 24 Mar 2024 23:39:53 +0000
Date: Sun, 24 Mar 2024 16:39:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-block@vger.kernel.org
Subject: Re: pktcdvd ->open_mutex lockdep splat
Message-ID: <ZgC5ydajy7i0f8e8@infradead.org>
References: <Zf20dfwIdayItxsO@bfoster>
 <Zf27X6ZNOwkXjc6A@bfoster>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf27X6ZNOwkXjc6A@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Mar 22, 2024 at 01:09:51PM -0400, Brian Foster wrote:
> Ok, I guess the reason I was only seeing this in one particular VM is
> that for whatever reason, something happens to invoke pktsetup during
> boot on that guest. If I boot up a separate VM/distro and run 'pktsetup
> 0 /dev/sr0,' I see the same splat..

pktcdvd is completely unmaintained and in horrible shape unfortunately,
and no one is interested in caring for it.

I can only recommend to not build it into any kernel you can care about.

