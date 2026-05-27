Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C477B39150A
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895263; cv=none; b=IMvCCFepIXm/vlk2mCASki78cJzhnxWzTnNj2JN9+M1WdPRG5/HXB9e/bIFQyj1BF3TI1U/jGFsdx0cWi+wjQRjLBIQ5EHL/Avx7DwNum8XekscnxhMUNC8tDdRZCzNTi0sCSRZIXsUtKYxG1i9BCoW5O66ixt3W7YArpRrnWWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895263; c=relaxed/simple;
	bh=G+9kNBEnQQiUQKQrn70RNh1jIXrgf6susxumBtOBe/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGCWS05rNKd+IYyEd5lM0f7JuHLOb5JMU9+hh7LHvKhnyAwNXAjQE1ZX727b2ksnZIZnBOdDUMrG6nuwuZC+3kjWmca6P7bpPXWRN/C6r4m7sFYF6FXyMihV7pyVWCO8hhrv6x/iW9LX1C3VcWGHZqwfNqpO5AI5v1k9YhD3phE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7ctsfOM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7ctsfOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1492F1F000E9;
	Wed, 27 May 2026 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779895262;
	bh=2kDOEHTAVXsJ8p+1XJC3siM1N1XJmdh0X1046Pwc3ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q7ctsfOMOJm7A45J6fWGrWpuJjRLzTlQW1CgUT32VVkgLo79uHsvZ8gC6wWVcYg1j
	 kbRhxueEE3D1nVJLSnZAn4lVgAN0fsOvrbcnWUcMqAsp1XfWSaVxzFCxQAUV0LO1T6
	 yyelRFRkg6ZKDu+8Y3jlY+S/z7yeo/QMUEkqj0AS07ERBLihDqf7b4fDo2iFACqsjI
	 nswJ9s+nMkU14lPgKVtbxqjn+15eYqDVGjjmA7Eq1PT/J8+6fAK+p7S2+2Jo8ArdLW
	 2IFMHq1cpw5lwLPswjLvba1i0qFsfuY4fxWxbm5Q3CpmNt7E9GkH7HE6vdo4ZurNr9
	 lre4BGLZu/rAw==
Date: Wed, 27 May 2026 09:21:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] bvec: make the bvec_iter helpers inline functions
Message-ID: <ahcL3GaCxRoPnPBT@kbusch-mbp>
References: <20260527151043.2349900-1-hch@lst.de>
 <20260527151043.2349900-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527151043.2349900-4-hch@lst.de>

On Wed, May 27, 2026 at 05:10:22PM +0200, Christoph Hellwig wrote:
> The macros are impossible to follow due to the lack of visual type
> information and all the braces.  Replace them with inline helpers to
> improve on that.  Because the calling conventions are a bit problematic
> with a lot of passing structures by value, all the helpers are marked
> as __always_inline so that they are force inlined.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
