Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D0182B4
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 05:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744089844; cv=none; b=JxO6DBvizSOQmQFRfqTAHkXdl1fnZGaUzjKCT5Uqrq9CF+QaJBhzvdmd9tt+ba78xbIWQCK8OnoYWVQuX3sWB7L4nZLq2tqrxZoC+H3PSDocbyGbxUVSYlY/mRt8aHqAJ58m15st1RiwogIVrLkdlG+MZbT6tNpsGbAiY8Ml6OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744089844; c=relaxed/simple;
	bh=nQe2aLNM/BB4VdEXa8vl9eA2kNni/JrG9tEbFvqVUuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZ23JOZ31LIbf7E0NACAaoPt8LZwRZTxhXkCYhoWLFNkhJKEKuQvElRdkwXDpyQvFnEm3KeC38x5GtFPK3AaI1o5eII4yf0qPpoT0ZPPgBrNu8SYIdij8iorjaZgaa+9ooD41YsI+PNSt6zwE5MvCX/IbC6X/QXT1gpB3hyBYKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8B14267373; Tue,  8 Apr 2025 07:23:57 +0200 (CEST)
Date: Tue, 8 Apr 2025 07:23:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
	syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com
Subject: Re: [PATCH] loop: replace freezing queue with quiesce when
 changing loop specific setting
Message-ID: <20250408052357.GA32561@lst.de>
References: <20250403105414.1334254-1-ming.lei@redhat.com> <20250404091149.GC12163@lst.de> <Z-_LLTtusK8g0rlM@fedora> <20250407064806.GA18766@lst.de> <Z_PnCUw0eeVdwxxy@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_PnCUw0eeVdwxxy@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Apr 07, 2025 at 10:54:01PM +0800, Ming Lei wrote:
> > What are "internal settings" please?  If you change the loop backing
> > file outstanding I/O is relevant.  If you change NVMe ANA or retry
> > policies are relevant as they are checked in the I/O completion handler.
> 
> internal setting means the driver internal setting, which is only visible
> for driver.
> 
> Here this setting(lo_offset, backing file, dio, ...) won't be used in
> completion handler, so it is fine to use quiesce here for updating
> these loop specific setting.

The backing file is used during I/O.  So you certainly can't change
it while I/O is in flight.

But the important point is that there is nothing inherent about
"internal" attributes needing different synchronization.  Maybe some
field don't need a full I/O quiesce, but you need to explain that
for each and every single one of them.

> 
> > 
> > > > This also misses an explanation of what setting this protects and why
> > > > you think this is safe and the sound fix.
> > > 
> > > 1) it is typical queue quiesce use case
> > 
> > What is the typical queue quiesce use case?  Why is it "typical" and
> > why is it safe.
> 
> typical quiesce provides sync with driver's ->queue_rq(), and it is typical
> that these driver settings are only used in driver submission code path.

"typical" does not matter.  The required synchronization needs to be
provided even for non-typical use cases.

> > > 3) for driver, quiesce is always preferred over freeze, and freeze is
> > > easily mis-used by driver, you know we have bad driver uses for freeze.
> > 
> > I am actually much more worried about quiesce.  It is much less well
> > defined.
> 
> It is widely used, and please see document of blk_mq_quiesce_queue().

I did not say it isn't widely used.  Which is part of the problem.

