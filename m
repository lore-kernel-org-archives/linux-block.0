Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29279F2
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 06:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008860; cv=none; b=KvIEYDXZENDJDBmjCK3lNiwDs6xqVc0rQygmWXzRs5rGcuxWXUfrmZtG6zNLLijJdqYkOXvP0i38YtfLJHXDytWqQRomd9vBbw76e2jdhcrENC9TJebMKyydAib/RzAuem3InndAifQSQvLFL7CJs52WRHkqiEnma8d5Y2sJy3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008860; c=relaxed/simple;
	bh=Zq9IJUGurKGqEMYEq4hns9JhyaXFEjT89kLDNmsXlyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcR02ZlBolGOv74L8kTRpZYFmRa2Em30+ew9Ouh2JU4XuDkwV+kjzzreJmNZgrI2fOEIoF/yZwEWjDpLJQ9AeNhqHw76qxvkDGTZXVYo3lhcY/8WCsQRgJmdhzXh/VgDzUabogfZUWFUwWYGdg3Hfqdht2dJ3EqqDicURWicCPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8625668B05; Mon,  7 Apr 2025 08:48:06 +0200 (CEST)
Date: Mon, 7 Apr 2025 08:48:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
	syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com
Subject: Re: [PATCH] loop: replace freezing queue with quiesce when
 changing loop specific setting
Message-ID: <20250407064806.GA18766@lst.de>
References: <20250403105414.1334254-1-ming.lei@redhat.com> <20250404091149.GC12163@lst.de> <Z-_LLTtusK8g0rlM@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-_LLTtusK8g0rlM@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 04, 2025 at 08:06:05PM +0800, Ming Lei wrote:
> On Fri, Apr 04, 2025 at 11:11:49AM +0200, Christoph Hellwig wrote:
> > On Thu, Apr 03, 2025 at 06:54:14PM +0800, Ming Lei wrote:
> > > freeze queue should be used for changing block layer generic setting, such
> > > as logical block size, PI, ..., and it is enough to quiesce queue for
> > > changing loop specific setting.
> > 
> > Why?  A queue should generally be frozen for any setting affecting the
> > I/O path.  Nothing about generic or internal.
> 
> For any driver specific setting, quiesce is enough, because these settings
> are only visible in driver IO code path, quiesce does provide the
> required protection exactly.

What are "internal settings" please?  If you change the loop backing
file outstanding I/O is relevant.  If you change NVMe ANA or retry
policies are relevant as they are checked in the I/O completion handler.

> > This also misses an explanation of what setting this protects and why
> > you think this is safe and the sound fix.
> 
> 1) it is typical queue quiesce use case

What is the typical queue quiesce use case?  Why is it "typical" and
why is it safe.

> 
> 2) loop specific setting is only visible in loop queue_rq() & workfn, and
> quiesce does provide the sync for queue_rq()

_What_ loop specific setting.

> 3) for driver, quiesce is always preferred over freeze, and freeze is
> easily mis-used by driver, you know we have bad driver uses for freeze.

I am actually much more worried about quiesce.  It is much less well
defined.

