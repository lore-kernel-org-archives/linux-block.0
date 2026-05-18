Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9943F0760;
	Mon, 18 May 2026 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109039; cv=none; b=O6NPtjD2vExW0CvHisLhu/KX/ujOIjJ3hI+kgFTgel8xcJU7qed+fFs+9wIGZ5+GX3nCQvzJSbUkB0kPTSV+Pv0dfjXvvFnZNmuQj50IRo80iAxrY/YfH7nMvxP9Q4nTKZvCuXyb13mZWPIMsjC+7wfy94rxlgZ+R9l2VQ1r3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109039; c=relaxed/simple;
	bh=LsOiIUcaczQe/qsyYHUA46UAMy24CVa7oQJnUgawucE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My7Pq1JSTC2QzzifbtooUJJII4o47x/czesRy7xl8iddEFQs7diku1ys7MOnJnGDQOfuDjSzTtALVUsnS71h+qrNViBYtbJArimwx9WgaS7IjIiI7qBhzPE7qqQs4nzWNSGpCqtW+huSsAf6ksITHSMPwCWWLiHzEt83PbNLGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E839E68D05; Mon, 18 May 2026 14:57:13 +0200 (CEST)
Date: Mon, 18 May 2026 14:57:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
Message-ID: <20260518125713.GC5754@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com> <20260513081929.GD5477@lst.de> <24833f76-2289-4859-86d1-9215b11a1258@gmail.com> <df697a76-c700-4908-ac08-a47ad07e0796@amd.com> <4561c621-817c-46be-8ff0-0b557f6c819d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4561c621-817c-46be-8ff0-0b557f6c819d@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 18, 2026 at 01:40:18PM +0100, Pavel Begunkov wrote:
>> When that is really a performance critical path then you can use the likely() and unlikely() macros to give the compiler the hint which one to prefer.
>
> That might be more penalising than placing them in the right order,
> and it might be fine as it's new and all that, but it's not a clear
> cut as it's definitely not created to be a slow path.

Yes.  Whatever the caller is using at a given time is the fast path here,
and dynamic branch prediction in modern cpus handles this really well.

> TBH, not sure
> why we're bike shedding such things, is it somewhere in the code
> style?

It makes reading the code annoying, so it better have a good reason.
Now for a single conditional it's not much of an issue, but these
things tend to pile up and then start to get really annoying.
Always write your code the most straight forward way unless you
have a good reason not to.


>> What could be useful is to have the true path for the more common and the false path for the less common case for documentation purposes, but in that case I would expected some code comments as well.
> What kind of comment are you thinking about? A "this is not a likely
> path" type of comment before each mention of the flag is usually not
> very useful.

Indeed.  It's also not true here.  If the workload uses dmabufs, the
path obviously is very likely.

