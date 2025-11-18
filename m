Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BF9191F91
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 05:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763443291; cv=none; b=Fg+PS/KlJoQUuYuHew385fSOooYLxBuGNnx+9hIt6EGScytfjqvJc5SrrGnr0h8VpqQMOwkBEmkNZjtwjp5rXp+CVsVHHDaTOUanPrV+KWXfTzlSk3vq6GHnUn7HAcC7f8QVeVF1J1v8APoAAPB50rCkeIWuZzdUviTtTQi6kcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763443291; c=relaxed/simple;
	bh=yVrA1zd6HywQ6+5O/b+LefqxVFdpnhEXf2TfScmNAVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYgT9atJW0E/5djXJ+vLWcopzMIZuMIM5zWqfXywafOPx9UPOZOM9gsDVf45SaGF3AvpnqfCqr7ytnFisRO9Jtewa6bSKb6NnodIuL2NYPCWwgzylxJu+TsJyzQ2Iy6XSMfKbauLGxIZYvB9Ud8U3eGzWkt1xEN21g9pMVEVfYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B53D7227A88; Tue, 18 Nov 2025 06:21:24 +0100 (CET)
Date: Tue, 18 Nov 2025 06:21:24 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/2] loop: respect REQ_NOWAIT for memory allocation
Message-ID: <20251118052124.GA22100@lst.de>
References: <20251116025229.29136-1-ckulkarnilinux@gmail.com> <6f76d0ec-a746-4eaf-abe9-86b51d2ff9db@kernel.org> <67472833-fd71-42a7-ac32-26e1da30f3ad@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67472833-fd71-42a7-ac32-26e1da30f3ad@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Nov 16, 2025 at 05:43:53AM +0000, Chaitanya Kulkarni wrote:
> On 11/15/25 19:50, Damien Le Moal wrote:
> > On 11/16/25 11:52, Chaitanya Kulkarni wrote:
> >>    6. Loop driver:
> >>     loop_queue_rq()
> >>      lo_rw_aio()
> >>       kmalloc_array(..., GFP_NOIO) <-- BLOCKS (REQ_NOWAIT violation)
> >>        -> Should use GFP_NOWAIT when rq->cmd_flags & REQ_NOWAIT
> > Same comment as for zloop. Re-read the code and see that loop_queue_rq() calls
> > loop_queue_work(). That function has a memory allocation that is already marked
> > with GFP_NOWAIT, and that this function does not directly execute lo_rw_aio() as
> > that is done from loop_workfn(), in the work item context.
> > So again, no blocking violation that I can see here.
> > As far as I can tell, this patch is not needed.
> >
> Thanks for pointing that out. Since REQ_NOWAIT is not valid in the
> workqueue, then REQ_NOWAIT flag needs to be cleared before
> handing it over to workqueue ? is that the right interpretation?

Having it cleared does seem useful as there is no need to skip blocking
operations.  I don't think it actually is required, just a lot more
efficient.

