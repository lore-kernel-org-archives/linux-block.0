Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443D0612FA
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032511; cv=none; b=Nl38Hmobzo3cXLsi1XtmVO111asIrCtgHZkod2OixlafaXHGAy7qUEHGQ6vDAAHKCBzYrzqXPryjFPPwcHheCqeFd3XVMOdsxVvA0cfWHTyS3gK+mDnxIwE2XPT8nQ2HPE2G40c8BAJbZKGB4XQnG+dkoYHwKg41nSrwqWioKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032511; c=relaxed/simple;
	bh=PY0z41GnawBAgLYFMDX3kYH902XBlka5SOYeYRuRctI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9DDVUQhTGBV5DJ7ogCXOeM3NsBZkLYntjPMJGx50GNnNS+CEvORGZKAKHaevir1WZo/G5QV0GTDAXW2We7TCfKvbONcDePgHmGl5Nz15H1NCLz5WTTV/FxQQyR6vQNs2WT+dbjWCs5Xjk7RBh/l2iiBTbMKKuC0sGdwgwG5soo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyAbLbaJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyAbLbaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838EFC433C7;
	Tue, 23 Jan 2024 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706032510;
	bh=PY0z41GnawBAgLYFMDX3kYH902XBlka5SOYeYRuRctI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyAbLbaJy5y74oRw3B3GnDrEoG+UmII8gvkJWwoMLJhIrJo9n9kAxoqKhugfnTlFj
	 ThYoHMhDF+HMhzA5Zub9BrqHiF6mhji4tEbDEwdKn/kST8J+cSXiRbkk6jghlB32f8
	 yzLTypKIECdMceZ4V5uxDXhinRlWUlHuqIa8tOGsk4XmvAxNKvKx9dylPTMrovmfra
	 Ioo9Se+EoBonAMAK9DjLgvinszAjhPmdnPlEysXmg1h0QCS/+N0v7bqAiNJWUG9z6P
	 eoccVgS+9VfOwyipbsxdA3foq94kGlz4hGRtfCuyBZ97g3p5E+M28p8OZa0K5z5XBJ
	 JLxMa5qI0+Pdg==
Date: Tue, 23 Jan 2024 10:55:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 4/6] block: update cached timestamp post
 schedule/preemption
Message-ID: <Za_9e8zEw94UpkBE@kbusch-mbp.dhcp.thefacebook.com>
References: <20240123173310.1966157-1-axboe@kernel.dk>
 <20240123173310.1966157-5-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123173310.1966157-5-axboe@kernel.dk>

On Tue, Jan 23, 2024 at 10:30:36AM -0700, Jens Axboe wrote:
>  static void sched_update_worker(struct task_struct *tsk)
>  {
> -	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
> +	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_BLOCK_TS)) {
> +		if (tsk->flags & PF_BLOCK_TS)
> +			blk_plug_invalidate_ts(tsk);
>  		if (tsk->flags & PF_WQ_WORKER)
>  			wq_worker_running(tsk);
>  		else

I don't even know what is in the 'else' case, but it doesn't look right
now that you added another flag to enter into this block. Before this
patch, it looks like we could assume PF_IO_WORKER was set in the 'else'
condition, but that's not necessarily the case with this change.
