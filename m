Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEE579DA6
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244338; cv=none; b=E42+NMfPD/xDPXb2jtOP48g9bffLqrvA2x1D73c2fJ3dKS0hSY16NFnWp0bAHb6BdyEvPLY0BfDf3L3RwjxpEtJicrKQfpAOIpzgzYfwrzgAti+r+N+9Se6+xsOowpE26oJWI8mBDBtQkpQvcelf0MQqmB4o5TEnXZpQszZ910k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244338; c=relaxed/simple;
	bh=8G+NqU8TAar8dDCyN0Z614DwQ2fQ+To+UP5LTwEXdqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXCgJlafiDnog1o3JRV1ZLQaIEJjkgcxGImgT7LR6XpbgXuborHzeN2w4M6u0zwktT8mEhs8jD5U0QMfCI6xkpvn+LHRKfkIG/pSzSukeYSqvDhEJJ6q33FGJuYxJCbcr/i2A3zZHgG9s9oxceE0MMxuoOCZzgbbtHxgqTzzXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VdLnD0XY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VdLnD0XY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zJvsSA+JegeOGi0/Y4HrxMU/U+zv4tqEkaq1whY5MAA=; b=VdLnD0XYjoAgrsemtMUopGfA4V
	531dczOCYpPUgMi/yFe5hr64AjVrP8658xGUacXcPEQCutY1YwpzBSA8ibHxym7FbSoMFPJAGDlm4
	Ig9XiYAJH4MEwu4lUgf0175ZhX1Zy/itwHl+j3GZKbbEyEmMcLJdAzjjRpy5sL2Nk+eQ2aMEkfD+c
	u0kZcvcNslSsQhMGe1Re+KEukVQq93pG0j3QbINHqbwY4X2DI8Lob3eJdahgAsypZhqqWceI+3jF6
	7be/mAZGczY37pKOoxtRgfquSazSNu7mysgz/PbrDN9L7OorvwELMzy+4iYwF8n4VmpdENkukxxdf
	5fN9BICg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk0g2-00000005aMx-2Df5;
	Tue, 12 Mar 2024 11:52:14 +0000
Date: Tue, 12 Mar 2024 04:52:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
Message-ID: <ZfBB7reT7Di-DHDm@infradead.org>
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org>
 <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
 <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
 <Ze-hwnd3ocfJc9xU@redhat.com>
 <Ze-rRvKpux44ueao@infradead.org>
 <07ab62c9-06af-4a4f-bae8-297b3e254ef5@kernel.dk>
 <CAHk-=wjtVMQQbez4ZhXBeu4gbrC+BxUf3gd8ypyR5BzV5ekfnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjtVMQQbez4ZhXBeu4gbrC+BxUf3gd8ypyR5BzV5ekfnA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 11, 2024 at 06:20:01PM -0700, Linus Torvalds wrote:
> On Mon, 11 Mar 2024 at 18:17, Jens Axboe <axboe@kernel.dk> wrote:
> >
> > That does seem like the most plausible explanation, I'm just puzzled why
> > nobody hit it before it landed in Linus's tree.
> 
> Yeah, who _doesn't_ have nvme drives in their system today?
> 
> What odd hardware are people running?

Whatever shows up in the test VMs, or what is set up by the automated
tests.
