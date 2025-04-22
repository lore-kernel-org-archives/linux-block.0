Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3092C78C91
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 06:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302389; cv=none; b=FyApgwPO48IshFNbTiC2AWNjNXYTrGdgkttkvJQ5Pe7+EuW6X8C8eaLnCGVI0+RNqzPBC1+z6otUQR+eIBwg9IepBmBNc+GWYqZZImLfSEmT4/a7DNkJsrB1GrTMemy39vT+cWJvL347Vh7Uf0dc98dJEMJrPxfAPc55SdXBm9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302389; c=relaxed/simple;
	bh=kRbhIwWWUsJB195/toGbzC6O/f350hCQHWhvsZNmzXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUxWdX1Wgsvvz/3O5vB894htIz6sccZt8v7mrvirp02SghI8ywFz7uxRy4Ls9IudAdKErhPQYuG7nAeRCNIJIn2KfIGERFvIARcVvhreQAs4G+BtJs6or00emFfL5iyIHXsMJjScb5iw/FW/6Xu8iP6FJDg0i19qWMxztv0xEAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vrMgQ9cM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vrMgQ9cM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yXl/h38b4Qmh3WpWz+JYMYZT8mmdPHwI2Y1SwU1cyUU=; b=vrMgQ9cMfkagXslRE8q3uZaxmo
	g4XfY7qsTl3z/zEGevCrN1qJdf40bgaLcENEcCz0DGkIbKQFH60UQIanKOuTAPoGXL7zdNsbCR7Q5
	RS2IF2suNesUSjhcL169LAuHw2hGVsJqSk4qyzkjXzbhZ5yF1fC9A1gamfKWrMfpWWA53BAltyAvr
	Rq+bF7fCSGvVqle2TanwwweSYOK66LAUXWxCR0gld9R1gwULSd383rfEUVOcpMZx5oygP/Iz81rwX
	+9U0rELmDhL8TXfDwAyyPGQUR/3xESeXHw9Tu/OvlPqMDk27YuDz5fI00tX9Nunjqfw4qXnQtrn7b
	gG9NKlAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u76sV-00000005vJr-08mq;
	Tue, 22 Apr 2025 06:13:07 +0000
Date: Mon, 21 Apr 2025 23:13:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, axboe@kernel.dk,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] block: integrity: Do not call set_page_dirty_lock()
Message-ID: <aAczcwHDWmlDgtdy@infradead.org>
References: <yq1v7r3ev9g.fsf@ca-mkp.ca.oracle.com>
 <aACcuGpErEsBcxop@infradead.org>
 <yq1jz7idh39.fsf@ca-mkp.ca.oracle.com>
 <aAXTz3e8-X1SlGvX@infradead.org>
 <yq1a5899caj.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1a5899caj.fsf@ca-mkp.ca.oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 21, 2025 at 10:14:27PM -0400, Martin K. Petersen wrote:
> > I do not personally have a use case. But we support using file backed
> > memory right now and have since adding these user interfaces. Suddenly
> > removing the dirtying will cause silent data corruptions for these use
> > cases if they exist, which is not a good change.
> 
> Oopsing in the common use case isn't desirable either, though :(

Agreed.

> In any case I'll work some more on this tomorrow unless you beat me to
> it.

I'm not going to get to this today, I'm still in holiday catchup mode
with a huge unread inbox.

