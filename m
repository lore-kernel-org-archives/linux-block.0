Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB83A640C;
	Tue, 12 May 2026 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576875; cv=none; b=Ve2SzcutqcEQM6Pag4p/oZmMRHneEjDB7CC1ew0BaC1AVbFUcNar8DZk0s+XAkLgbigTQxWNlg2cO9zqtLfChYcmQJOe3MDy5vXicTx7fzRplbAFJ5qRgUMhOdfwkYjCIbvlkX1/mJZx6NilVlmg2BExsI/IoNLYDop/TwAkgA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576875; c=relaxed/simple;
	bh=6VMg+d7h+iFkN4JJf5Y/rSG0V7TmHtRoXREQY3JW/lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EryutLTnqwyAUYPyArd8eO3Oc/2y/eebFs7eMlJdO8mMXLOWXcNk5bmj8dgAhy3SrIGy8TRDIPduHjQcfyx0N5ndzzdIJyS7kKanwuUqlxNzQgTLXCMWB9jtEdsoHiS6gNgbDpDeGWcRHDxf6juzbVQz2n6OurwLOjRXiMb4Y18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=fbTdVoXk; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="fbTdVoXk"
Received: from localhost (unknown [95.24.31.83])
	by mail.ispras.ru (Postfix) with ESMTPSA id CCA3545F7991;
	Tue, 12 May 2026 09:07:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru CCA3545F7991
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1778576862;
	bh=IA9ltNCQx504z6TVL93600qZ/OaYMmMAp3/Bt/hG8as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbTdVoXkBo3LI+NJr9P01c/G0mS5JtjMJRp59fg0Ip6Yl5JiEXmerzMd/+weI9tqQ
	 vn0ChgyHdASFDjhxA4lUpFGbLAF3fGgasRv0l8Ek58OzYtpCkhNUtZRAvnIbQM1Oia
	 9jSFVPhl4Z3Rf8y9+SQ/1oanXXOpcXOpVRqdv05k=
Date: Tue, 12 May 2026 12:07:41 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>, 
	Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] lib: free pagelist on error in iov_iter_extract_pages()
Message-ID: <20260512111736-56f5db59d3c57c81d0d29f0a-pchelkin@ispras>
References: <20260508111329.329943-1-dmantipov@yandex.ru>
 <CADUfDZpC5WOBY4_xvAy6ORtgQsxwFYj3Px81RdN7NKQZBFdJSQ@mail.gmail.com>
 <89db3b52508cfb345317feec8fe066849abccc14.camel@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89db3b52508cfb345317feec8fe066849abccc14.camel@yandex.ru>

On Tue, 12. May 11:12, Dmitry Antipov wrote:
> On Fri, 2026-05-08 at 11:33 -0700, Caleb Sander Mateos wrote:
> 
> > Indeed, it looks like *all* callers of iov_iter_extract_pages()
> > pass a non-NULL struct page **.
> 
> This is not true for 6.12.x at least (where this issue was initially discovered)
> where bio_map_user_iov() do the following:

The current upstream has a caller of iov_iter_extract_pages() in
block/bio-integrity.c where NULL *@pages argument can be passed.

> 
> For 6.12.x and may be other stables, the simplest possible fix is
> https://lore.kernel.org/stable/20260505094529.406783-1-dmantipov@yandex.ru/T/#u.

Older kernels have this pattern inside block/blk-map.c as well which you
fix with the linked patch.  But there's still the same error left in
block/bio-integrity.c in 6.12.x, too.  All the places ideally should be
fixed and this can be done as a couple of patches for 6.12.x.  I'm not
against a step-by-step approach, but think this problem relates to the API
contract and all the cases should be considered as a whole if being
touched anyway.

> 
> For upstream, it may be better to tweak iov_iter_extract_pages() itself, but
> it may be required to adjust all of the callers.

Taken the point that callers seem to be inconsistent about whether they
treat ret < 0 or ret <= 0 as the error case, it's up to them to decide
depending on their own logic.  Not sure if we can suddenly convert all
'< 0' to '<= 0', this doesn't look correct.

And I see now that my initial suggestion to fix the problem in the callees
isn't so sweet and simple as it seemed, and agree with Caleb's and your
initial proposal to adjust the callers' side then.

In that case it'd be good to add some comment to iov_iter_extract_pages()
explaining that the caller is responsible for freeing the allocated memory
if it passes NULL *@pages argument - _even_ if iov_iter_extract_pages()
fails.
