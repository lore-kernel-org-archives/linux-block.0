Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061041DF246
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 05:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745212372; cv=none; b=G7WLAFj/W1WVvJ0UqNDzdAX1qwFyY6yurC62reMdhKyw29MptlsGGonosZyRgGlNU1kqObymTJH1NvUR9fgVHJfIF/w9ktgvVLikQ232OPk84/4kvgVsVc+htKvX544VNWeXDC7UiuLvl9fFpenKRNVr3iwngkpdeVgJDASiJYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745212372; c=relaxed/simple;
	bh=Akg5iidF+wL4qorlRSaF7PL2uHiLnRkZRVri+dsDXHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaRWPOAAd5BF/pqeFCKrbLf1hyrJFYJOWOWZLtTjet8W1wVRY7oVpieiV6QEHRR6FVXafr5p/9uSm3jCv1Tm56VFJp2LW6Q5ErZ6pBMGaZ2fR0rqOB2OVX9mqjCgR160GtB1jBOrpKqpDDo1Xx3yiETAC0wkSGH/ftOMFvCe05M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kyi7H6eV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kyi7H6eV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WwflBDclrTcfJKzOOaRK/2x5iICVmL5huFseuTc3TVY=; b=kyi7H6eVVeDc8sZvmcqTgdTszW
	mP3SEwIwGBlBJAMks6ADdTN2IJOsw6sa7avEsFLZ82bRS+o9wC2qRCQCB4/c2r0J/nMWWT5YIky3o
	UN+Yw6huhd1heBOsokf8wm9iXrafQKipdy39M36qc8AG5lcRjHTf5qQIIwsj4YA0/Y11u3W3mpYuU
	apo4SOJfEPhWetKcO1nvDVxXu7KBtOzA3dhNRxDAkB5DPFfSIF2pHl/UcOxtJuhZDRYqY1SzSeCpL
	CrMq/BVz9XkChrcX1GWNlFnITW7aJUO8XpOS+1FB6oNCe5ZgGPq5MBZN6Cm+RWaUhVl8/0GwuNZ2X
	FSQ3dCBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6jSZ-00000003cJO-06d8;
	Mon, 21 Apr 2025 05:12:47 +0000
Date: Sun, 20 Apr 2025 22:12:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, axboe@kernel.dk,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] block: integrity: Do not call set_page_dirty_lock()
Message-ID: <aAXTz3e8-X1SlGvX@infradead.org>
References: <yq1v7r3ev9g.fsf@ca-mkp.ca.oracle.com>
 <aACcuGpErEsBcxop@infradead.org>
 <yq1jz7idh39.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1jz7idh39.fsf@ca-mkp.ca.oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 17, 2025 at 10:05:11AM -0400, Martin K. Petersen wrote:
> 
> Hi Christoph!
> 
> > Who sais it it not backed by a file? Which that would be a very
> > unusual use case, there is nothing limiting us from using integity or
> > metadata from a file mapping. Instead we'll need to do the same thing
> > for the data path and defer the unmapping to a user context when
> > needed.
> 
> If you have a use case for file-backed then supporting deferred dirtying
> is perfectly fine with me.

I do not personally have a use case.  But we support using file backed
memory right now and have since adding these user interfaces.  Suddenly
removing the dirtying will cause silent data corruptions for these use
cases if they exist, which is not a good change.

