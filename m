Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26048389115
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534722; cv=none; b=j+hqB5YcSoaUNZbMCJnsdwSitrAk2bY/wHcrWIaAmFetWg8YLpzakHaSd58ZUYe6Qll7+hoKPXPQh913zgEDODce5M8gMagBQjcWytSYSzUbCJ/G69Lqt5OByK22irYT/vSv+fW24EZP7WjsbEC2Z4j3udrfs9POo3IsmpaEA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534722; c=relaxed/simple;
	bh=zgkQ66833H/6qhsTict3/zk2LErh837aIOBX2mH2wSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+2QTAUEDrRGG7DF6IlpJodS9GmveKZmqs6v+CqlUzT1L6ykFu55VRbZ2n3PdoiganRSUhqfAPLdXy2UlP4s3lXSYpmQA5Re2WEt+M+MEV4JlUEVKtNPFjDZDPbb/EvQPQx0dtwofmdyWrmKd+C2KGoI1KUrFwqccG2j7zHizRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5036E68AFE; Thu, 26 Mar 2026 15:18:34 +0100 (CET)
Date: Thu, 26 Mar 2026 15:18:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 17/26] loop: Add lock context annotations
Message-ID: <20260326141834.GD16166@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-18-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-18-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 25, 2026 at 02:44:58PM -0700, Bart Van Assche wrote:
> Add lock context annotations that are compatible with Clang and enable
> lock context analysis.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/loop.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 0000913f7efc..9c7ed9e8a442 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -107,6 +107,8 @@ static DEFINE_MUTEX(loop_validate_mutex);
>   * loop_configure()/loop_change_fd()/__loop_clr_fd() calls.
>   */
>  static int loop_global_lock_killable(struct loop_device *lo, bool global)
> +	__cond_acquires(0, &lo->lo_mutex)
> +	__no_context_analysis /* conditional locking */

There's not explanation here why this is needed.

