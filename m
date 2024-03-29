Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7F885C65;
	Fri, 29 Mar 2024 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718163; cv=none; b=Q0X35WlSBWwjt1BR1DxJ+C7+r3NxR6jFXIhFgqBg7o7PwaNiUAiZEf8v7zSHG7FpXMuFjE625cxYfSDOq1jH7WFkrxxVepqKaLOs5/dmoOT7hhd1AjZjtsJZVkGD6YDvDELPJPQo9a0L0nBBFq6en2dnvr6GrGEUEHtucXO+HA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718163; c=relaxed/simple;
	bh=Q8aiCQiDocO1TSosjADdGI3WzH++KgCgbUKBRybc3zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpbTp7Q46QPNl02yS1eG3zFbUUQBXXVDyBkbGVlfbO3qDj1ZVgwNb/JnYac9YIIeiufju8CacZxy4o0zpOCWGbCoC48ZEb1HM1Bz8fh5qKWcABRlgxIPU3gTKQ6VCrGPWnYR2gsni9Ew5DM1u84AnziZjtMVmsPfD1U00vKlbBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bAWNTgFN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bAWNTgFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033B5C433C7;
	Fri, 29 Mar 2024 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711718163;
	bh=Q8aiCQiDocO1TSosjADdGI3WzH++KgCgbUKBRybc3zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAWNTgFN+7+LR6ZouPr68Zdyby/lctHsRkN5y1ha+h9R1NOPgv8IvAHR80CtYh0tt
	 0oLaBZpgOVF6C0Gu8b4fKc3FWi0r2uKPPdFyesQFYuighSumwe6217WVJcL0OclJD7
	 Eq7aG/fqCQJCoFbm4Nz5cTu0CTz7uiYRSL6KgJMU=
Date: Fri, 29 Mar 2024 14:16:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>,
	kernel test robot <oliver.sang@intel.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] blk-mq: release scheduler resource when request completes
Message-ID: <2024032952-nearly-glorified-c0f8@gregkh>
References: <20240322174014.373323-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322174014.373323-1-bvanassche@acm.org>

On Fri, Mar 22, 2024 at 10:40:14AM -0700, Bart Van Assche wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> commit e5c0ca13659e9d18f53368d651ed7e6e433ec1cf upstream.
> 
> Chuck reported [1] an IO hang problem on NFS exports that reside on SATA
> devices and bisected to commit 615939a2ae73 ("blk-mq: defer to the normal
> submission path for post-flush requests").
> 
> We analysed the IO hang problem, found there are two postflush requests
> waiting for each other.
> 
> The first postflush request completed the REQ_FSEQ_DATA sequence, so go to
> the REQ_FSEQ_POSTFLUSH sequence and added in the flush pending list, but
> failed to blk_kick_flush() because of the second postflush request which
> is inflight waiting in scheduler queue.
> 
> The second postflush waiting in scheduler queue can't be dispatched because
> the first postflush hasn't released scheduler resource even though it has
> completed by itself.
> 
> Fix it by releasing scheduler resource when the first postflush request
> completed, so the second postflush can be dispatched and completed, then
> make blk_kick_flush() succeed.
> 
> While at it, remove the check for e->ops.finish_request, as all
> schedulers set that. Reaffirm this requirement by adding a WARN_ON_ONCE()
> at scheduler registration time, just like we do for insert_requests and
> dispatch_request.
> 
> [1] https://lore.kernel.org/all/7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com/
> 
> Link: https://lore.kernel.org/linux-block/20230819031206.2744005-1-chengming.zhou@linux.dev/
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202308172100.8ce4b853-oliver.sang@intel.com
> Fixes: 615939a2ae73 ("blk-mq: defer to the normal submission path for post-flush requests")
> Reported-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Tested-by: Chuck Lever <chuck.lever@oracle.com>
> Link: https://lore.kernel.org/r/20230813152325.3017343-1-chengming.zhou@linux.dev
> [axboe: folded in incremental fix and added tags]
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> [bvanassche: changed RQF_USE_SCHED into RQF_ELVPRIV; restored the
> finish_request pointer check before calling finish_request and removed
> the new warning from the elevator code. This patch fixes an I/O hang
> when submitting a REQ_FUA request to a request queue for a zoned block
> device for which FUA has been disabled (QUEUE_FLAG_FUA is not set).]
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)

Now queued up, thanks.

greg k-h
