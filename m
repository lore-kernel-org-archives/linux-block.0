Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13DA281358
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456327; cv=none; b=ZINbUtJ/yP617MmFy4NVOAsIzJeEPKZfWWUyHazNuZyxpBFrtXZXSEPdtBZ4OhblwssazL/KH2lxD3bwacFhBDMfWDus5XNAjHkJb0FZdUOKrif4jSzWVNtJcNwqlJBs8If3WQzryVEgkAMVMcobi8+anGr7wCyoStPgij/OynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456327; c=relaxed/simple;
	bh=7GhCq0iWszfiJSYQtVIZWHEO/m2l7MjDTYqD56ItfnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jM3QY4Dt9d2f9sKnmC1A7juTcBVS9NRlCrX5BunJTMFFkWf97Vm/ntxANok//dS9Q8AOcho6oA+JOq/3abCp53LIdqn8EV/yKJ7wCDE8gUsV8BIj/7yMGjIUrXhv/JchBIljWZYFbQvYClAnB5wAgTN5Qjh4k3D+D9z6V+Hw7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOsWf9eF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOsWf9eF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC8CC4CED1;
	Thu, 13 Feb 2025 14:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739456326;
	bh=7GhCq0iWszfiJSYQtVIZWHEO/m2l7MjDTYqD56ItfnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOsWf9eF0tIq0dnCjrReTuv8tlu3t2FXEnZCqKwDtuLIt8tSEqfJBK9RiOtoEBVWA
	 vBGT8nW/VRxDhOzZtvW1ASmtqU5BbAl+7fthh5a2lDBNTe1Gg+PNCfwsBgQ4HiAQEQ
	 3Kecj26BRdeSDhdWo3dIzKY7EGhoeTG+qSiVlw3JFegc0nea/HyXUB+nse+5t+Xftf
	 FxrMxuRnTqgCnR/K4uqklmz9Rj1EHUO+Q4Y1pun0kvWExnBGmYSilkwB8S1ZAXu0hR
	 yjbp4N5HwUEjhvUCdUlBsLFe9iUapKVVgCekVYQ1ylGsC+1zi/vU9SDwDcDHaZR38N
	 sd4ishmRS7emw==
Date: Thu, 13 Feb 2025 15:18:43 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Yi Zhang <yi.zhang@redhat.com>, John Garry <john.g.garry@oracle.com>, 
	Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>, 
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <csvt2osvntbtvqveufnsiv2dhinz46z744fx4mgjarbd3twg45@k7zm3jv4k2xb>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
 <Z6peww6d3EP5-B8n@bombadil.infradead.org>
 <Z6qxnAEMeTVW-wK-@fedora>
 <t2o3dadb744eyzy7v6jta3gdjgscpttf4s3abqm2mndk5mvwjl@hbvl7vzv6foj>
 <Z62nJqXu_et99D02@fedora>
 <Z62tpanLQgFK8j0i@infradead.org>
 <Z62yq9bbxWwPvJot@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z62yq9bbxWwPvJot@fedora>

On Thu, Feb 13, 2025 at 04:51:55PM +0100, Ming Lei wrote:
> On Thu, Feb 13, 2025 at 12:30:29AM -0800, Christoph Hellwig wrote:
> > On Thu, Feb 13, 2025 at 04:02:46PM +0800, Ming Lei wrote:
> > > The problem[1] is that this kind of mmc card fails to be recognized as
> > > block disk. Block layer io split code can handle this case actually.
> > 
> > When we still had bio_add_pc_page it would break the assumption that
> > you could always add a full page.  With that gone and everything going
> > through the split machinery we might be fine now, but backporting it
> > to 6.13 and earlier will cause breakage.
>  
> Yes, I will mention the following two are depended for backporting in
> commit log:
> 
> 02ee5d69e3ba block: remove blk_rq_bio_prep
> 6aeb4f836480 block: remove bio_add_pc_page

Ming, is that sufficient for your use case? Or do you still need to remove the
assumption that the "minimum" segment size is not PAGE_SIZE?

> 
> Thanks, 
> Ming
> 
