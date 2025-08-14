Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA932BE020;
	Thu, 14 Aug 2025 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171381; cv=none; b=Xsze1Iq+oyedA7J7lwLbdsaG2LJDF6LQQOaWP7ohIkJGvZpy4oM6B8vFCEqOOSH5LIJmKUeivZKTMhhdWwlOTqyTYDZCeFdkFgOZv3iyMqN4o85ELPh8fhzrIXIKKA2rL4lqkAcXKvw1VPIFZ+N0sPB0wJA9pGJ8RqbOZlbNZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171381; c=relaxed/simple;
	bh=/Zk/Q+fBOufaFyz6kG2JSiBnxwxA5G35PaAtrGD5eQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da2Y+0JBZe3D7m0x3OJbMvwpi5UwvT3UfaQ5+upOlX9UJmrAbs8WrIX+0PkmDfH8v3SjuhJV1FZHUBYfHI4vp6SQzqiquboWwLWFvdi+oIFDMSH8PHuD3iBo//lxtcYxDJ1YJXJh1jh5YGSm8DaY5gs5pIwF//LRpWnEe2wE4iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZEv/zTU1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZEv/zTU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DD8C4CEED;
	Thu, 14 Aug 2025 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755171380;
	bh=/Zk/Q+fBOufaFyz6kG2JSiBnxwxA5G35PaAtrGD5eQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZEv/zTU1BMXZ7iDV8Jv6jNx/RyyJ1DZGThrIlPRo36HFkhnM7zg9dzn48x4aHYJNE
	 UcS/2qeXLqS1m1gCiPRz4iy6m22/LZG8fdnXyAWtp+gXlk9NgXEPEegBtiOGoyt5TK
	 8hWjRCQRsPlOimWXpKChxyooCc6kVC95uKOxEsFI=
Date: Thu, 14 Aug 2025 13:36:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardeep Sharma <quic_hardshar@quicinc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y v2 1/1] block: Fix bounce check logic in
 blk_queue_may_bounce()
Message-ID: <2025081449-dangling-citation-90d7@gregkh>
References: <20250814063655.1902688-1-quic_hardshar@quicinc.com>
 <2025081450-pacifist-laxative-bb4c@gregkh>
 <21bf1ed6-9343-40e1-9532-c353718aee92@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21bf1ed6-9343-40e1-9532-c353718aee92@quicinc.com>

On Thu, Aug 14, 2025 at 04:24:25PM +0530, Hardeep Sharma wrote:
> 
> 
> On 8/14/2025 2:33 PM, Greg KH wrote:
> > On Thu, Aug 14, 2025 at 12:06:55PM +0530, Hardeep Sharma wrote:
> > > Buffer bouncing is needed only when memory exists above the lowmem region,
> > > i.e., when max_low_pfn < max_pfn. The previous check (max_low_pfn >=
> > > max_pfn) was inverted and prevented bouncing when it could actually be
> > > required.
> > > 
> > > Note that bouncing depends on CONFIG_HIGHMEM, which is typically enabled
> > > on 32-bit ARM where not all memory is permanently mapped into the kernel’s
> > > lowmem region.
> > > 
> > > Branch-Specific Note:
> > > 
> > > This fix is specific to this branch (6.6.y) only.
> > > In the upstream “tip” kernel, bounce buffer support for highmem pages
> > > was completely removed after kernel version 6.12. Therefore, this
> > > modification is not possible or relevant in the tip branch.
> > > 
> > > Fixes: 9bb33f24abbd0 ("block: refactor the bounce buffering code")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Hardeep Sharma <quic_hardshar@quicinc.com>
> > 
> > Why do you say this is only for 6.6.y, yet your Fixes: line is older
> > than that?
> [Hardeep Sharma]::
> 
> Yes, the original commit was merged in kernel 5.13-rc1, as indicated by the
> Fixes: line. However, we are currently working with kernel 6.6, where we
> encountered the issue. While it could be merged into 6.12 and then
> backported to earlier versions, our focus is on addressing it in 6.6.y,
> where the problem was observed.

For obvious reasons, we can not take a patch only for one older kernel
and not a newer (or the older ones if possible), otherwise you will have
a regression when you move forward to the new version as you will be
doing eventually.

So for that reason alone, we can not take this patch, NOR should you
want us to.

> > And why wasn't this ever found or noticed before?
> [Hardeep Sharma] ::

Odd quoting, please fix your email client :)

> This issue remained unnoticed likely because the bounce buffering logic is
> only triggered under specific hardware and configuration
> conditions—primarily on 32-bit ARM systems with CONFIG_HIGHMEM enabled and
> devices requiring DMA from lowmem. Many platforms either do not use highmem
> or have hardware that does not require bounce buffering, so the bug did not
> manifest widely.

So no one has hit this on any 5.15 or newer devices?  I find that really
hard to believe given the number of those devices in the world.  So what
is unique about your platform that you are hitting this and no one else
is?

> > Also, why can't we just remove all of the bounce buffering code in this
> > older kernel tree?  What is wrong with doing that instead?
> 
> [Hardeep Sharma]::
> 
> it's too intrusive — I'd need to backport 40+ dependency patches, and I'm
> unsure about the instability this might introduce in block layer on kernel
> 6.6. Plus, we don't know if it'll work reliably on 32-bit with 1GB+ DDR and
> highmem enabled. So I'd prefer to push just this single tested patch on
> kernel 6.6 and older affected versions.

Whenever we take one-off patches, 90% of the time it causes problems,
both with the fact that the patch is usually buggy, AND the fact that it
now will cause merge conflicts going forward.  40+ patches is nothing in
stable patch acceptance, please try that first as you want us to be able
to maintain these kernels well for your devices over time, right?

So please do that first.  Only after proof that that would not work
should you even consider a one-off patch.

> Removing bounce buffering code from older kernel trees is not feasible for
> all use cases. Some legacy platforms and drivers still rely on bounce
> buffering to support DMA operations with highmem pages, especially on 32-bit
> systems.

Then how was it removed in newer kernels at all?  Did we just drop
support for that hardware?  What happens when you move to a newer kernel
on your hardware, does it stop working?  Based on what I have seen with
some Android devices, they seem to work just fine on Linus's tree today,
so what is unique about your platform that is going to break and not
work anymore?

> > And finally, how was this tested?
> 
> [Hardeep Sharma]:
> 
> The patch was tested on a 32-bit ARM platform with CONFIG_HIGHMEM enabled
> and a storage device requiring DMA from lowmem.>

So this is for a 32bit ARM system only?  Not 64bit?  If so, why is this
also being submitted to the Android kernel tree which does not support
32bit ARM at all?

And again, does your system not work properly on 6.16?  If not, why not
fix that first?

thanks,

greg k-h
