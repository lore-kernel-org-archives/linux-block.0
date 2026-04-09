Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB162F99BD;
	Thu,  9 Apr 2026 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775716843; cv=none; b=aX7Ag8MPGZY7jTqYOtCLI26mjlxBWJocLe115cHZhqvdIioECplpfnkcN0YfGVtLpGTYpi2XqKJzSNvB9S6G0Ic8AxhC96T9ISpaZ5OOHUGutHI7NNVQToyjg+4bODKUmJrN/x3r1qsz9O1BVOho+mnzpH8Hm1yjcHWf4k2G0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775716843; c=relaxed/simple;
	bh=bUrD7CvlyUNPy7W+n0eAkkmfVEgw0M7Q1Lqcg2mrkmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1/qkHageDPow3tm4z4RZKBK0Xvz3LtReJul8tZ/d1yB3/zhC20jfSYGGausDsVVfKh+V5bsNeiDV4sD4+Nx1o0JYjA0TShxjM0zH1VPhXF1njDvIM5DjsrXaAs5cshkWBKit6e2x7LvWnEFm/LA/kbgHdn10FtJ9604qp6IApY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uS2D+CKI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uS2D+CKI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9XvyWJUSOM5eV4ieBRtSFsN4pGEcp8pm1zhh04ZFATw=; b=uS2D+CKIPopKb6rIgjfm4tVtzG
	QeMBW3Fp8fk+PVjZ5wR1CuFkHSircRVfSkqC98oiDwIaZW3JhGLVKg1kcKRSLMAjfTdG+ZjrdlIUc
	smn4R7HTNUMFwqr/BPUEox0cK67EgrHn2U/TDvGZBCvUyLGDanQvcmQOOM9xoWWIuIPkEdLCDlIOj
	dEWXH2wnIuwKyP6JTg0e8vpF9DH5RSfho/Grs0TzVxsJyBRlEFy2ZS5A9f66ljyWYM4tkiEqC/903
	TouMg4cJSvkCNXCaWTEVS2z1JlFPxocmA390s5zpckRdujmzl3wnDUqKWlyqnxTxwZG1xnK2OY/zg
	f9N1BvOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAj4E-00000009mpj-1sUz;
	Thu, 09 Apr 2026 06:40:42 +0000
Date: Wed, 8 Apr 2026 23:40:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 00/20] DRBD 9 rework
Message-ID: <addJ6uTc8Zo4GKpW@infradead.org>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
 <ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
 <adXk_m3SbRcWTOIC@infradead.org>
 <c92d5318-8c8e-434f-835e-61cf1fae4edf@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c92d5318-8c8e-434f-835e-61cf1fae4edf@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

First an apology, I thought it was in your tree, but it looks like
the drbd branch just has minor fixes.  So a lot less urgency.

On Wed, Apr 08, 2026 at 06:58:58AM -0600, Jens Axboe wrote:
> See the previous discussion,

Do you have a pointer to that discussion?  I can't remember one.

> the goal is to sync the two drbd code
> bases. It's followed the "usual" pattern of the in-kernel driver being
> neglected and development and users pushed to the out-of-tree one,
> which is highly annoying.

I don't think that's a a usual pattern.  Also the new version looks
like a complete rewrite and not something incremental:

 45 files changed, 45891 insertions(+), 16264 deletions(-)

For a code base that is "29482 total".

I think reviewing it would be easier by just adding an new drbd9 driver
and then steering people toward it carefully, as that is actually
reviewable compared to non-bisectable patches changing large chunks
of code in a non-atomic way.

