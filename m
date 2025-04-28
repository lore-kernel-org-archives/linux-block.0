Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB99256C64;
	Mon, 28 Apr 2025 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848181; cv=none; b=GamFH4ilfm9hxA03DEtp3eaU9VW+fv9wiwInH9RZKPfRbSCArX1QqiXijHIi86ajFdVR7jJgAfL2y3NBFgnWOHUEWkSktQCvZP+Ja3TIR52BBu/uRKDo/qn9lniCatmjoLyMK3jgZ8xcdHXcmy/4B5+cDniKguAnZV2xHl7Q0Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848181; c=relaxed/simple;
	bh=LT76VkU+lFukegnTMvC4JliKRH/Fi6SPsJ5TQpTHPC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhUv/8iBeu8YNMHXWZAVKpB/Pzm2NOpWfwDPE9spG5tQTaitJcXdH/0ziOD73xbkh/Js3+OC/ChoT+hWKdhycWYP/yYr4Sp+XrKIdwlkdgvAziv89pluqPC6nUhjOXnuLeNMjMlBCaRRhayDo2KdItIhiZUV6AePIHC9ysGWTDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j1EZ11zB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j1EZ11zB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pbGuZAKrq2M6ndsNnuI2WPrOZ34Dz7W83BsoQOyP4bg=; b=j1EZ11zBtFaXtgygx9ge6OVZf4
	/ssHMzy/EOVOR3vkPZVJoI6Dt2gVmLBxhYDFgNsAhLcFYgcc4qsqOmow06Eg+PDKfy+dtl74Tws6i
	6L8n0VUH9C6Pxduso1FrhESg49Gq9BCk0kJtRdeJYOa6SHOmzIPzVtXfG9V64qZcEzh+Vw/HzZ2nQ
	T//sUcCOyhUEcenm9LU43zNMDKcx4RX3GoMSMcmRTWKDF03uF3NpGNEMUFUMuHITW4KPnM+jC9dQo
	ICXLyVpR9e2e0p0CidHoPw4YYNV2oaTR1il8ULjF71kfPp/cISRTlH2a2+hyAMeRHrxrDW/xS1S0S
	XPFZfCUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Orb-00000006XZw-3oH7;
	Mon, 28 Apr 2025 13:49:39 +0000
Date: Mon, 28 Apr 2025 06:49:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: hch@infradead.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.lei@redhat.com,
	syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] loop: Add sanity check for read/write_iter
Message-ID: <aA-Hc5w4DwHHikyQ@infradead.org>
References: <aA94oQekLdgnjt67@infradead.org>
 <20250428134812.3225991-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428134812.3225991-1-lizhi.xu@windriver.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 28, 2025 at 09:48:12PM +0800, Lizhi Xu wrote:
> On Mon, 28 Apr 2025 05:46:25 -0700, Christoph Hellwig wrote:
> > > > and maybe add a blurb that vfs_iter_read/write had this check.
> > > It makes no sence. The current issue context does not involve vfs layer
> > > iter_read/write related routines.
> > 
> > Yes.  But explaining how a change caused a regression is good
> > information for a commit log.
> What changes?
> The check in vfs_iter_read/write is not relevant to this case.
> It is best to not write something irrelevant.

It is releavant in that vfs_iter_read/write have the check, and removal
of their used caused szybot to be able to hit this issue.
