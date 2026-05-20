Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0464E3F0A98
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290821; cv=none; b=BhvKK4QA3LpEQXtQ1+c48Wz2uQCo9ijPzDyc9Xo27l5M9ect+lTstW/MUmfER4ab31mSNNkr2y7J5JrjlVihU6YRMp7EnMb1fulRxCnbcWWEx2j4I7H4Wo2XmbKMGUfsvZl6keCxpU3o8CLug5psnhxU0ISK5l+7NWQOgd4/X3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290821; c=relaxed/simple;
	bh=jt4kP5QYBHh5TBL2IJdTGMNdOo/DBRCvw4Jk0ALZllk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/rRpWLDf2Ko/BNu01Cj+lwhuAzPSY37/1KCYMm1mvaorEnJXxxu12i/oI9ZLDA/x6aBELTijkU5tQVVBwSXF8Jivwnc46kt4FVDSU0dD1Pn8IgJjW6bywjegWh2LfMo3YQZcn8Jz3GUeLe0vDOiRNB7RZdj9nirSMT4QqnyCBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu0NOiqB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu0NOiqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFB71F000E9;
	Wed, 20 May 2026 15:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779290819;
	bh=aZMpsSMzyFe7vhXQUFxUc/6nYjHW4Wyu8MVYsvKO6X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bu0NOiqB43LG/qOGM0no+trU9dTDk2rb7jnb3Uj73WKkOl9m9NziliGpFvx+8+wKi
	 4w40k3xOyFK9p8jlPFvcfbQrq6WFkWcJw7iHe45rV0MEdXZQKM+6YUHAO38tM2cbMv
	 XhFiHj6i4NTGnZMKMYfnVNGzsfNtv9Qq/admLR+1ZRsKG7Dh6Cdky6kTxlfX7Nq+Rt
	 9ZHvFfl7JYcwzyZZpr91h6ALOlTKS1aQv+WwJCz16EvIadbQSNqK4mmEXTxMk/kIVr
	 hsNQspwqXeNQ8xpi9RacghS7AdaRMVRQudHmXRFIzsBxLyegZvGICx4cWxmOEmSv1d
	 ilbp3lVJvfK1w==
Date: Wed, 20 May 2026 09:26:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	tom.leiming@gmail.com, coshi036@gmail.com, Igor.Achkinazi@dell.com,
	dlemoal@kernel.org
Subject: Re: [PATCH RFC 5/5] block, nvme: add failed_bio callback for
 multipath bio failover
Message-ID: <ag3Sweie8nWMpmqq@kbusch-mbp>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-6-kbusch@meta.com>
 <20260520072746.GD14937@lst.de>
 <ag3ORafKCTyn7TBA@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag3ORafKCTyn7TBA@kbusch-mbp>

On Wed, May 20, 2026 at 09:07:49AM -0600, Keith Busch wrote:
> On Wed, May 20, 2026 at 09:27:46AM +0200, Christoph Hellwig wrote:
> > On Tue, May 19, 2026 at 10:23:26AM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > >
> > > The nvme driver has long utilized a zero capacity to indicate the path
> > > isn't reachable, which creates a race condition with IO dispatch when
> > > paths are being detached on a live system: when the block layer rejects
> > > a bio early due to a capacity check failure, drivers with multipath
> > > support using the original bio have no interception point to redirect
> > > the bio to another path.
> >
> > Trying to reverse-engineer - the problem is that the block-layer
> > code catches being beyond the capacity and directly completes the bio,
> > right?
> 
> Yes, and in the case being addressed here, the "zero capacity" setting
> is path specific, hence the driver wants to attempt a failover. I
> imagine general capacity violations are not path specific though, so
> this is kind of a weird case.

Oh, and it's not just the zero capacity IO error that multipath wants to
hanlde. It's also that we've marked the path's disk dead, so there's a
race if bio_queue_enter() will call bio_io_error() that this patch
handles. I should have mentioned that case too, which wasn't handled
with the BIO_REMAPPED flag suggestion.
