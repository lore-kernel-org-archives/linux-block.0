Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F1440BF5;
	Mon, 21 Apr 2025 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745248963; cv=none; b=EvhQBXjtTb1OyKWoR9IfOcip00KUZ20CRx1RBr0mGlvwgg30RTxyDDingg/ym86HNqM3O/XeYrECmQRzFFdibj1glZ93ZvtoDYz2RDooT0IQC5HSPLEJ1P52/PgZDZYn7anMYFRLXH+xgpbuK+4Cylfz8krSfRfupIlhncCUaC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745248963; c=relaxed/simple;
	bh=YY9gTG9ZBW4E08buukcEYYHP7HWbwATtN3Kqgx1StfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQQR2oCrblQ/0E9GLzd9J+NH2EItg3MydATQ3We5FMZcoP8P1iuqzTNPGCgELEPGWK7h9Us1q5EjnwXctPX8KhysvmDZlzz9keG+7lt/SsYLSxIYiBtWTSonQv45qF2IcYQ/NvbX8en7lbbwjMpOpx1DBk3oZY2fS+1nWMFGWtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=po1kUUUP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="po1kUUUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E57C4CEE4;
	Mon, 21 Apr 2025 15:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745248962;
	bh=YY9gTG9ZBW4E08buukcEYYHP7HWbwATtN3Kqgx1StfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=po1kUUUPnrue8nQqTrVk04k3i9LGMZ2KOf9Czrgz50hvGrpLUOWSqUpFFZXFPz0tL
	 6L95GsISSfNIZe4IJPHVPByMrKsMXOVG8tLru+XYNQLt2mcvz0Jsc5JV4pUbzErmWm
	 nLiW1GiIMh+w/blZlyfGArERrfH9UNv3JBtW5sOSEK7JlN2Jju5mTnnC9hQnUs3hYL
	 ctwGxl/EPflrlFv5WW7huRiot4jme9zqgu6fZpe+xmgXJhe44uTIhig0eMHRfqorXh
	 OrN1oRmmUkBQNevpyXK9012ixaHx595JKr0nd2kVGnyOTXb5g8D65AR6R7Ev1JMzrs
	 xO9B6d0cErMMg==
Date: Mon, 21 Apr 2025 09:22:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Matt Fleming <mfleming@cloudflare.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: 10x I/O await times in 6.12
Message-ID: <aAZiwGy1A7J4spDk@kbusch-mbp.dhcp.thefacebook.com>
References: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>

On Mon, Apr 21, 2025 at 09:53:10AM +0100, Matt Fleming wrote:
> Hey there,
> 
> We're moving to 6.12 at Cloudflare and noticed that write await times
> in iostat are 10x what they were in 6.6. After a bit of bpftracing
> (script to find all plug times above 10ms below), it seems like this
> is an accounting error caused by the plug->cur_ktime optimisation
> rather than anything more material.
> 
> It appears as though a task can enter __submit_bio() with ->plug set
> and a very stale cur_ktime value on the order of milliseconds. Is this
> expected behaviour? It looks like it leads to inaccurate I/O times.

There are places with a block plug that call cond_resched(), which
doesn't invalidate the plug's cached ktime. You could end up with a
stale ktime if your process is scheduled out.
