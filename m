Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0D51D5ADA;
	Fri,  4 Oct 2024 05:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728021541; cv=none; b=Z/Q7dX1BgV8HUkQDi0bVu/HlaTB/O+BQme7Bdwd4ctGO+R8T8gXUCmcHJ8YlTYqPtXvYMG4IqtB/ZQ++W3L/TH8qLDbZh7vcEldH61+e/3d66svDrsTFI1+kCcdDONsCSELcGS9O4bFd8luILhypEFPD4ZGLntrCy2ocW4ytJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728021541; c=relaxed/simple;
	bh=NbtUIBzHS22v7ajwnahIepd3zYOHXeAK6WptKAyeutc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBx5KqgUn4U5OBWLIAm3jkgF5NxpycnHk/lCyyg5CORP9BTXB2/EUgsB+uvxnMFenBkNrHHAaxeqiKdHJkTkshMoKCxEXQbKbW8CwGAmPUsfcIZYFVqHSjWt4e3pbAGKH7JrWTTDEOoH+mUK5+Hc1FNLL3oE9tjCnkZiKPeLn9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8FA81227A87; Fri,  4 Oct 2024 07:58:54 +0200 (CEST)
Date: Fri, 4 Oct 2024 07:58:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: stable@vger.kernel.org, axboe@kernel.dk, Christoph Hellwig <hch@lst.de>,
	bvanassche@acm.org, linux-block@vger.kernel.org
Subject: Re: read regression for dm-snapshot with loopback
Message-ID: <20241004055854.GA14489@lst.de>
References: <CACzhbgTFesCa-tpyCqunUoTw-1P2EJ83zDzrcB4fbMi6nNNwng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACzhbgTFesCa-tpyCqunUoTw-1P2EJ83zDzrcB4fbMi6nNNwng@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Leah,

On Thu, Oct 03, 2024 at 02:13:52PM -0700, Leah Rumancik wrote:
> Hello,
> 
> I have been investigating a read performance regression of dm-snapshot
> on top of loopback in which the read time for a dd command increased
> from 2min to 40min. I bisected the issue to dc5fc361d89 ("block:
> attempt direct issue of plug list"). I blktraced before and after this
> commit and the main difference I saw was that before this commit, when
> the performance was good, there were a lot of IO unplugs on the loop
> dev. After this commit, I saw 0 IO unplugs.

/me makes a not that it might make sense to enhance the tracing to show
which of the trace_block_unplug call sites did a particular unplug because
that might be helpful here, but I suspect the ones you saw the ones
from blk_mq_dispatch_plug_list, which now gets bypassed.

I'm not really sure how that changed things, except that I know in
old kernels we had issues with reordering I/O in this path, and
maybe your workload hit that?  Did the issue order change in the
blktrace?

> On the mainline, I was also able to bisect to a commit which fixed
> this issue: 667ea36378cf ("loop: don't set QUEUE_FLAG_NOMERGES"). I
> also blktraced before and after this commit, and unsurprisingly, the
> main difference was that commit resulted in IO merges whereas
> previously there were none being.

With QUEUE_FLAG_NOMERGES even very basic merging is enabled, so that
would fix any smaller amount of reordering.  It is in fact a bit
stupid that this ever got set by default on the loop driver.

> 6.6.y and 6.1.y and were both experiencing the performance issue. I
> tried porting 667ea36378 to these branches; it applied cleanly and
> resolved the issue for both. So perhaps we should consider it for the
> stable trees, but it'd be great if someone from the block layer could
> chime in with a better idea of what's going on here.

I'm totally fine with backporting the patch.

