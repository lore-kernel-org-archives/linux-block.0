Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327AC7482
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174039; cv=none; b=glN0r7aefkD68og9n9apoQZjpDXA4DQL081xMLvUSU6tzNzyEG5Rxxr0lybbvX4eMij9HtxvNPvkLveLIDs9PYSvcGVMyoGtpYd5mkVF8RrdBWUYxr/HxAWag9PMbGD3kOQCHJwNZfCZMkBeBZCqCnVVB5vCmWgG3M2ti5ZS9Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174039; c=relaxed/simple;
	bh=KI1Vppon/A1X2x5hRvYEvtEAgE39Mp0GLHHy+l/gv/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhxOvayZGm2hoPqtd3IbqhqcI2nmzoug/PQ44D/FtgrIeY7SythMQWpN2vptFDpo1kJGVxdtjo5pLOzw+l7BfIYtpcrTj9eKvZiW30mvY+J4un5aYtM+/x6bv5aRu4qAAnUvLx5wQ27qkd7Owsl21Mg0JMtsQYVsysHttByi46k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MMit6pcs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MMit6pcs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j92sYrtywE0aWe0OJeEvdxDMk85Z7GKLdrh8v6v4DR8=; b=MMit6pcsU9nVSHpNmooSGvxZ36
	ncmnG/2xALwjDy8U6GOG+Cd5aaHNoCVZMiHssIgJfjUSCbr/XusiO74Adb+vscvH3Qkuq/URFff3Z
	G4Qs1B4lnaZP0AAkVCF5mbAaIOdfBw2f0/Of731ls9Kgd0alymhEQODifrHal3Jj8WIB64D20KPbZ
	nGonCet41Tss3CMjIgOLZYvDKUownAAyuljaUbIGlvLlt7Wlx9LM/vE2+iSUQvsHFJkTjA/yf0tt1
	p/g73lRb075BAUOuq/cQ3+TcGd9ysH3W0xOgCuoIGg+eugkJTcvuVmisupN+BRoCr5/GBi0Li0yaB
	ZWuuk1dg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue8ea-00000001sXh-0Fr9;
	Tue, 22 Jul 2025 08:47:16 +0000
Date: Tue, 22 Jul 2025 01:47:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, anuj1072538@gmail.com, axboe@kernel.dk,
	hch@infradead.org, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [PATCH] block: fix lbmd_guard_tag_type assignment in
 FS_IOC_GETLBMD_CAP
Message-ID: <aH9QFHFjMG3fSEgL@infradead.org>
References: <CGME20250722081938epcas5p12a1ee45419754afa2f1c1c9040d519d6@epcas5p1.samsung.com>
 <20250722081911.78327-1-anuj20.g@samsung.com>
 <aH9PwbpvMhTMUNl4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH9PwbpvMhTMUNl4@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 22, 2025 at 01:45:53AM -0700, Christoph Hellwig wrote:
> On Tue, Jul 22, 2025 at 01:49:11PM +0530, Anuj Gupta wrote:
> > +	switch (bi->csum_type) {
> > +	case BLK_INTEGRITY_CSUM_NONE:
> > +		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_NONE;
> > +		break;
> > +	case BLK_INTEGRITY_CSUM_IP:
> > +		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_IP;
> > +		break;
> > +	case BLK_INTEGRITY_CSUM_CRC:
> > +		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_CRC16_T10DIF;
> > +		break;
> > +	case BLK_INTEGRITY_CSUM_CRC64:
> > +		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_CRC64_NVME;
> > +		break;
> > +	default:
> > +		break;
> 
> This should catch and reject invalid values.  Otherwise the patch looks
> fine.

I guess reject is wrong, as the kernel is the source, but I think
a bit of validation here still makes sense.  I think if you just leave
the default out, the compiler would complain if we added a new value
to the union without handling it here, which should be enough.

