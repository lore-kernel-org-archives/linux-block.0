Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB56728DA5;
	Fri, 31 May 2024 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717136233; cv=none; b=rxo3VCdfsELlHlwaCW1/FcZRrG370GeY8gFwSy79AnQQYGXoH2CvAI4zQAvPoBLGMgbG75gBpBfkLoiXVomq1GBOI/lu1aVMlz8QB+2s2ugcq594DKOkwaD/Xva3oVx0Jzan4pW9X2T+BtwAAkBgiwk+EbtdefYIwXEWXYFHXXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717136233; c=relaxed/simple;
	bh=iueQtP9Gslcg5KRKNhCalSsLgvkR0FSUv1bpe6Pdegg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYbnmKez8ayRlQYeae4xdWSl19GNLrOXmBtZ6gQjFQz3wOosDSJ+nYah0uHsAz91ql4IAQK2I3ALA+EuDsbn2Tez37qqfoXiJpukuXQQFm/sZg5pWgX/2uOcU/8htgcjWd91z9E++30JCeMfUbNNxCLCmK9KhmO0wic0k58h2Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 57F7668BEB; Fri, 31 May 2024 08:17:08 +0200 (CEST)
Date: Fri, 31 May 2024 08:17:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Friedrich Weber <f.weber@proxmox.com>, axboe@kernel.dk,
	ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhouchengming@bytedance.com
Subject: Re: [PATCH v4 4/4] blk-flush: reuse rq queuelist in flush state
 machine
Message-ID: <20240531061708.GB18075@lst.de>
References: <14b89dfb-505c-49f7-aebb-01c54451db40@proxmox.com> <984f1f77-288c-441a-a649-5f320249b576@linux.dev> <4d799672-378b-42b1-896b-38df2c5e9c84@proxmox.com> <0783d367-4608-4b16-9b88-6eaf5d5706eb@linux.dev> <8b1400e6-b35e-486b-8ea0-de76270267c0@linux.dev> <87f495c2-7504-4d22-b355-608b13c456cd@linux.dev> <cb0fab18-ba27-420f-ace3-b099c74398c6@proxmox.com> <09be2bc6-d16a-4740-908a-f157dcd97ca8@linux.dev> <acc28f2c-0e72-409d-bb61-791ef62ddfd4@proxmox.com> <b73d3891-9a52-4f0c-b154-5a6d6117c697@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b73d3891-9a52-4f0c-b154-5a6d6117c697@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 29, 2024 at 04:50:02PM +0800, Chengming Zhou wrote:
> Yes, because we use list_move_tail() in the flush sequences. Maybe we can
> just use list_add_tail() so we don't need the queuelist initialized. It
> should be ok since rq can't be on any list when PREFLUSH or POSTFLUSH,
> so there isn't any move actually.

Sounds good.

> But now I'm concerned that rq->queuelist maybe changed by driver after
> request end?

How could the driver change it?

> > Also, just out of interest: Can you estimate whether this issue is
> > specific to software RAID setups, or could similar NULL pointer
> > dereferences also happen in setups without software RAID?
> 
> I think it can also happen without software RAID.

Seems to be about batch allocation.  So you either need a plug in
the stacking device, or io_uring.  I guess people aren't using the
io_uring high performance options on devices with a write cache
all that much, as that should immediately reproduce the problem.

