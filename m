Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9233FBEC7
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804151; cv=none; b=qGH2a/XGPPIHFk1Cj3+BoD3kNGnJadaphzOk8/rJieZLjDaux3e9DgMofCm2piS8QyRvCGjudASsyw/vtgG60nc7q7DHrqdWPtVovCvYegeLGCihRSUJWir++tfgaxR8w5CT8xY4tB6M4nlQy2QuJI8sphCQsBnvx6risM5gI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804151; c=relaxed/simple;
	bh=X0GxWYTGw4jTFtj0zn5H7JoqshmKIbNaRI+Lod8XIGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb9ee7j5BTnx5PV5UZG1SSd7TS7ATpRxMROCrbUTzNpYkYJcfy5mZD6isOKn/xiVsS6pR+Yslybvjlpr12ZMyrh5NLuWn0h2xo6qmF7UM/evxsFwuadE1nfHBNOe+NWJG9ume6F9nXgJ9EI6P35K8JpqZMA/WR5HG2fDOx14KGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO7n2yh9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO7n2yh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D281F000E9;
	Tue, 26 May 2026 14:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779804150;
	bh=Q0tOLb2ufYPC1G9O02nlHp6C846al/OH4FmQiF+dmAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nO7n2yh9lx6Xnjs+1IfqiWmOOy3W8QT6gOlNCbFmCznHsFo2TDZdkQUR80Mpxmu+a
	 rxtlUgF/3V8/h8TM0RTQzGhnudPbWiqu/6FhKT8enQ+dsrCQm9EwnvGE/sOkm5+Jm9
	 Wbw1Brop640DZHjnQo/saTculfPbdcqckLNn99oaBJqqSEUmWpqKgi0Miv2nwWhWDC
	 bAkB21v9m0xL4JzNhQb26YxdDBpBpF05Hho0BW8xJXF2Rsw1BlVZs2RoxkLysyegzN
	 biNi1YUWPvyvd0r+LNi8hrHv/cyCgqkl+3jZwJNnmoUP6wPGn3o47Mob3pvazXhhKt
	 JDbz8IiuQGIfQ==
Date: Tue, 26 May 2026 08:02:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: reinsert cached request to the list
Message-ID: <ahWn9JhsPhhTQkGL@kbusch-mbp>
References: <20260525160744.896047-1-kbusch@meta.com>
 <ahT656Dazfz5oc8r@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahT656Dazfz5oc8r@fedora>

On Mon, May 25, 2026 at 08:44:07PM -0500, Ming Lei wrote:
> On Mon, May 25, 2026 at 09:07:44AM -0700, Keith Busch wrote:
> > +		rq_list_push(&plug->cached_rqs, rq);
> 
> rq_list_add_head()?

Yes indeed. Serves me right for trying to squeeze this in over a
holiday. Thanks.
