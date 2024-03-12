Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F79D7A126
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244407; cv=none; b=YIL2rfEwuvNJfRw9q32pEBTW3wczf2oMb9zmCyZs8WFoYFZ87b27RvbgXfF60LjElxOsiX7UcoRGd1GzHt3aaoyenTA9evYDudRDMUkc+/KkaS76qAtxB5S5YLi8Z01Flus8U0bvj6swSoGddRVc3LsHd4MexKU2Sx8dOyjPviU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244407; c=relaxed/simple;
	bh=B1cX7vPEUdJUR6ISffq06N70YvLEKpjuWUK2JDKB65k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOonX16UGWGdkRue7hSUyQMxoCV8nKbpkUnOG7IaDS9oToXe1yvDfp1OxQBvPhBuBRqTpRB/CIAoycYK87C8BwSaHv/2eapHX8JAqkpkd0sWmZVXMgR5JDuHczgcYlgqNipAgQOVimlJGwPVsyFBx3X1t3E/QakV9weF6WLp3OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vZVVcpJq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vZVVcpJq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B1cX7vPEUdJUR6ISffq06N70YvLEKpjuWUK2JDKB65k=; b=vZVVcpJqnMF+vewGa+p8t8GWFN
	7svGR9x4Gu0sRJAk8gp9fevFVC6XbmUFCEWAxOI8BqYODsw1xCnfNkXRc8/gjlxgK0yxoz1ML6Bgn
	aN0dHN/lqBdzV0AUcAQ8Cg/qf6aPiisDj0lCOhpkgabamARifSAEZWt94yD+UK3nslYK4q8zOflY1
	KkY6P7PFufM77qpUJnmmX+WDDUkjz4aA9KwrauReR451r568oGDS0TadYpnCHOAlnXGWRFSepjLtg
	4G1Nzet0e4qs+Zy2eulImcyAnTsnROS8qwbHkbXbpSxgmYGRGvfLupuJZ+bc1paRw8mmt+covvkN2
	ghWmF0uQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk0h9-00000005aeD-2abu;
	Tue, 12 Mar 2024 11:53:23 +0000
Date: Tue, 12 Mar 2024 04:53:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
Message-ID: <ZfBCM0YWewr_KYyn@infradead.org>
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org>
 <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
 <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
 <Ze-hwnd3ocfJc9xU@redhat.com>
 <Ze-rRvKpux44ueao@infradead.org>
 <07ab62c9-06af-4a4f-bae8-297b3e254ef5@kernel.dk>
 <CAHk-=wjtVMQQbez4ZhXBeu4gbrC+BxUf3gd8ypyR5BzV5ekfnA@mail.gmail.com>
 <01bc0f0d-c754-45af-b5a4-94e92f905f6e@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01bc0f0d-c754-45af-b5a4-94e92f905f6e@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 11, 2024 at 07:23:41PM -0600, Jens Axboe wrote:
> Various NVMe devices do have different limits for things like max
> transfer size etc, so if it's related to that, then it is possible that
> nvme was used but just didn't trigger on that test case. Out of
> curiosity, on your box where it broken, what does:

All nvme-pci setups with dm-crypt would trigger this.
