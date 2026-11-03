Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692982;
	b=fJtABIpGNqw34MVkJFjySqtijE51so3op+PYmWGFU3U9ibZLqZ8Zs9wtYwJL3KVrGfDd
	 XrEKWd3CgrUsufZarxsdCkpjMI1yIB/tXVKv0H18v/Zq+abNp1cqe+Tgq2JBhEqGnx1wk
	 tcOs85v22Ys8VFKgn5XQqT/uKmZqV1WEHUbEVc+zBcvDfO7J6YO91SL4rQljPF/qLRiv2
	 IlpL8wZR7Jc4/Z+Neg/Mn02jwRYN28dlyVFrpzvSpGkagFQrcKCncGd3Ddhuh2d3HkaoH
	 rVtxvQYvhP/FJdRcRp2lrV9vzbYrxawXSlBiMA5GtB7OqR69lzXGxT8NMx/WYSjT5GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692982;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=PuljJfcv+RdZBrk5XmMGwxXwFbISWSi3wxA6FJ4S96Q=;
	b=HF0WjUX59MkV7eov54oV0pfNRYgP0EGlXIjs/ER7dEGDgSy+sSvSbVX63KJeBnPDPZOB
	 O3fWekC1MjXx471jPsZMcBwkTFOINHIvdLJ0kEDPXGpD5EVG5MODxvM2hk+rfZEVR2YuP
	 UlCUxf9zeDPaxN7wMtt63GEtFmukKFLhurgRVGAYAiP/8vCkYc1nJQ2wKVoV90mzj5scx
	 aehQbFVAt1hIipj9oyAQBERCwzvcYQPJmeDxsYwB/p7JPFnArb2u6PfXTIfMDVt2K2X25
	 8Pkl2Tz4+tafCqbKnxzjyMIarYp66+Iz/IOhQg74gg0DHpugye/UwzH9pWwD+HF3uMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811B606A329;
	Tue,  3 Nov 2026 08:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6811B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 29E2E68B05; Tue,  3 Nov 2026 09:02:58 +0100 (CET)
Date: Tue, 3 Nov 2026 09:02:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: hch@lst.de, mst@redhat.com, jasowangio@gmail.com,
	virtualization@lists.linux.dev, pbonzini@redhat.com,
	stefanha@redhat.com, eperezma@redhat.com, dlemoal@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: Fix zone append sector reporting in
 batched completion
Message-ID: <20261103080257.GB3975@lst.de>
References: <20261027150654.GA14436@lst.de> <2026102810270846959TfFOThssBqrSo1PlP9X@zte.com.cn> <20261103080223.GA3975@lst.de>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103080223.GA3975@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 03, 2026 at 09:02:23AM +0100, Christoph Hellwig wrote:
> On Wed, Oct 28, 2026 at 10:27:08AM +0800, shao.mingyin@zte.com.cn wrote:
> > I looked into adding blktests coverage, and there is a structural
> > problem. blktests cannot issue REQ_OP_ZONE_APPEND from userspace: fio's
> > --zone_append goes through the io_uring_cmd NVMe passthrough path, so it
> > never reaches the driver's zone-append completion, and zbdioctl has no
> > append operation. blktests has no zone-append test today for the same
> > reason.
> 
> Right.
> 
> > That does not fit blktests, which is a block-layer test suite driven
> > from userspace. Two options as I see it:
> > 
> >   1. an XFS reproducer (e.g. xfstests) - the one that actually
> >      exercises the append completion path, or
> >   2. a blktests zbd test that covers a zoned virtio-blk with poll
> >      queues, which would not reach the append part itself.
> > 
> > I am happy to write either, or to leave it if you think the coverage
> > is not worth the churn. Which do you prefer?
> 
> We do have some blktests test that use a file system in the zbd
> category (zbd/009, zbd/010, zbd/014) so I think we could do this in
> blktests.  I.e. do a blktest that tests zoned polled I/O if we're
> on a zoned device that support polling.

OTOH xfstests might actually still fit better for this.  I guess
eiter way will work..
