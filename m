Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3E36C9E4
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490526; cv=none; b=YJPlSKl/FD265fv/qPmijBywDVg2F25paFUANuHAlpRZxj9WkrW+qSuFhD+jo8DC61GZ0C7zG3aAs6wEvGsCaZc/qbQufI/bHXVldUNRIirda6DkpIvYlHagfT8sdHJTuayoZ2lb0aOXVSbFFWi8rkSOcoQUEtt0VQpFUCBXNc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490526; c=relaxed/simple;
	bh=NC0vphUw9hV61U5gsKRyy5yA8yPMH4UjHJmd8t+EdP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjHT+PzmdxxPxOZkGVXW6A8E9moWVLj9OuDvy29KEH38Zb+aReopE7ItddCqFksoMAzjb7psBVUVJA0QgH9Kdt163CaFDxvTvXUrDvC7XHGHIcWi6P/j98jHOyasaPucLk0JAHzlDLVkwqVvb2SES868R4KMTnKvaGBZODJ9vwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5oerC0x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5oerC0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317661F000E9;
	Fri, 22 May 2026 22:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779490525;
	bh=RYxxlbc90wQk2srJHrLU+bzvWk9cf2n6UL5BN0RDA5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V5oerC0xjnqTlDWwhaw6z48caEoUmkVyHcEaxwo5lQV5CzHuZpBjjRgbfPDh8QLwF
	 RfJZxKGROvqjKynQv7/kRiCyE6qzkcOkMUWIpGBrtr2EbpLpl9Q6UonNgFuItJfmnf
	 eT2JsJ+d+kzdS9Ll6h+FmupsoKTbnFeIPCaHYRp1VVSY0eU1rYYDsC4JiYm5iIkMKf
	 u3Hne5CjdNZ+p7AURLNbp5IGdA1F1cazIaqPOlnmJCwPON7aXu60RKmxed3yhItpUU
	 6yZnt2lZILrv8GYiwlurAe/zl31MsLenAdzTZ22Gb+/ew8xPA/vo0+1UB4QvqLPPPO
	 t5AcCi0nTNp1w==
Date: Fri, 22 May 2026 16:55:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv3] blk-mq: pop cached request if it is usable
Message-ID: <ahDe25f1Dw0YBsOL@kbusch-mbp>
References: <20260521190253.242065-1-kbusch@meta.com>
 <ag-WUymW2vwVyMJB@fedora>
 <ag-1EoopSdp0JZR5@kbusch-mbp>
 <ag_XoloTHEgt3Y8s@fedora>
 <ahDT-JZZGyyTXyii@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahDT-JZZGyyTXyii@kbusch-mbp>

On Fri, May 22, 2026 at 04:08:56PM -0600, Keith Busch wrote:
> On Fri, May 22, 2026 at 12:12:18PM +0800, Ming Lei wrote:
> > On Thu, May 21, 2026 at 07:44:50PM -0600, Keith Busch wrote:
> > > On Fri, May 22, 2026 at 07:33:39AM +0800, Ming Lei wrote:
> > > > 
> > > > BTW, as mentioned in v2, the request may be added back in case of merge,
> > > > but seems not a big deal given blk_mq_free_plug_rqs() doesn't free requests
> > > > in batch.
> > > 
> > > We could introduce a special goto label for the merge case to push it
> > 
> > It can be done simply by replacing the added `blk_mq_free_request` with moving
> > it back to plug list.
> 
> What I'm worried about is hitting a blocking allocation, then the
> cached_rqs list is freed, leaving the current request from it the only
> one still holding a queue reference. I think we ought to re-enter the
> queue in that case.

Hmm, I may be mistaken here. The block allocation doesn't call
blk_finish_plug(), so the current plug is left intact; the other
queue_exit goto's are either from non-blocking contexts or a successful
merge that holds queue references in other ways. I guess there is no
queue_exit goto where unconditionally pushing back might be a problem.
So yeah, sorry, maybe restoring it to the cached_rqs is a worthy
optimization to make.
