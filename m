Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1CC3ED5C6
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937022; cv=none; b=Bn/KIMXJCV50d0n9OVLWSne3nzkWdSIYmqaTWU5VovRursEXugPY9r0S0/AYYV0AFeJORKzclimzOSpBdLzq7ADiq2/H7IuBnLoU5ECij4td+76GRBYJS13DztVD5Pf1yUxKBRZlpHsAuOLwUH+XQ0TbZGrhoIdeT+CkkyuF3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937022; c=relaxed/simple;
	bh=NFunWSO+VSZTwYNfXCiNilKXFoeZ+uy/5BIhyaLkaW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOmNZU/kbFiKnfujIWJ0HN+eN/Ju7JEN3TP0gUVS5SVHPLcJYk7haER4SNb6aikS8MuN+9kH2Xc6X28ZCjC8d6Mdc8l4wczrDc9jfOJTeQzfitx0qcE7z3zPWdLPyo5mt4VScjOsUJx/TYnJoXGsYKZwBd14oaHKi96X4CH9ZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tF6/iWos; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tF6/iWos"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=KFJ0oFu6V09nh/SllpDZ2DjkxhLxKMr+gGZSzCnqtf4=; b=tF6/iWosJz+255slWZWWr4K0ey
	gmNH7YkAG9mqYxvcQvxZvdKHMnfPkWJaESgUrq/XL743SfxhX0zsxkRnm/N/Xk8LWaWN6/nnomfyI
	PkUEAIQ2jRb5OVIZp9FOpqw87NOu1kXNmcqCsErC0Z+3OP8Xzn0Zc/vKQlyMSVIOKS29thj4Y6uIH
	x/fBNJWL5lQTR42ufr+9xMcxhUqTVFxQXgXtYOcE6zOj3r/e0h6osxXMt2zbqj89FuMFgUiS8SYfj
	7TY+rDOlzSswqJvoyi25/V6JsnoVHtx9jdyVvPxO2WhDFz15N0lHPky2YbzciUqByItjdhV7xDiHb
	MnjNDVKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3G3I-0000000B3Bt-1xiX;
	Thu, 19 Mar 2026 16:16:52 +0000
Date: Thu, 19 Mar 2026 09:16:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Fabio Fantoni <fantonifabio@tiscali.it>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
	Christoph Hellwig <hch@infradead.org>,
	Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: Re: blksnap: no feedback received on latest patchset - any concerns?
Message-ID: <abwhdNB-j6GOQGRv@infradead.org>
References: <5459ee8c-075f-453f-8999-19219f9a6fdc@tiscali.it>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5459ee8c-075f-453f-8999-19219f9a6fdc@tiscali.it>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Fabio,

a 2 year old patchset has been paged out of everyones mind.  I still
think functionality like it would be useful, but it needs to be resend
to get fresh eyes.

On Thu, Mar 19, 2026 at 01:06:10PM +0100, Fabio Fantoni wrote:
> Hi Jens, hi all,
> 
> The blksnap v7 patchset was posted in February 2024 and has received no
> response so far. As someone who has followed this project closely, I wanted
> to ask directly: is there a reason this patchset is not being considered?
> 
> This is a module for non-persistent block device snapshots, useful for
> backup on filesystems like ext4 that don't have their own snapshot
> mechanism. It went through 7 revision cycles with review of some people and
> substantial contributions from Christoph Hellwig. The amount of work that
> Sergei Shtepa and Christoph put into this has been remarkable.
> 
> The silence after v7 seems to have led the developer to abandon the upstream
> effort entirely, which is unfortunate because seems to me there's still a
> need for a block-level snapshot capabilities module integrated upstream, or
> am I wrong?
> 
> I fully understand if there are technical objections, but could you please
> share what they are? Even a definitive rejection, accompanied by clear
> reasoning, would help the community understand whether it’s better to take a
> different approach or address specific concerns in similar cases.
> 
> Thank you for your time.
> 
---end quoted text---
