Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1023769E5
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786396997; cv=none; b=ZmjexqWTmww6WjMznHg1B4eBGVTrPz2xOwcc1y5Do9F/lnBln0wUcZIbWAsuxjO8EIiafO1j3DRrEg27pGsRmLZL5XVc0fjMCbeVKSWBQe/Xs+gif/NqSHJILycQzZXA0hgQcRP2BXxfY9csYMBad2P6EIRVdjkMOHFqqxJdQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786396997; c=relaxed/simple;
	bh=8OIF6g5/7ciSQduvjcQE2j46eZxB4C79nAyyS4idY+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I58ioDlVFc+GyB/CdIoKLNJ/TbBNkjHBsjce3ZKND/LnLVvLPHdZWmbZnJ1FlGdiNqW/R2erC2XOjzO1yJvMOG/NovBm2K0gP+x7iGbBm3tYzI8yBRLjzyTB72sdd/lDFW5vwzYhWvY1IXIQCJAaUpJxYjHkgsciUzDEhN8EPjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxpR9Ytj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxpR9Ytj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6441F000E9;
	Mon, 10 Aug 2026 21:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786396995;
	bh=2kgdte3d/F5SbB7TlyLxgnUaJPtVrt40lEUouBS2b7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gxpR9Ytj7c3rannud1kYocXuJPUPzR24edw3YEB782bt2r4e1EWbVj1p1uGImBaa3
	 WauI0ZkztesLQBtt3KCeNdKS0PiIkD17cTKwyNLb0AwJStgv4Q3T5V7BU9kOUGKSgs
	 WwGyBrBWmOvXgJo9cj3hemeLgHvld63zyYyQqwuQslTSZ5YROqzC4TDylmrjTc3Dae
	 ltcitqfnOhVucNFwweG2y56t7ONT6rDpckqOhAEmEE9arB+IKKXq5hp6Pu3TYgAOh9
	 mmqh5Uk7Cf0iFZvpW9BuEodswHK8N5gfyhy04y+rzrz8C8nfuX41PHG6PxmiAlF7/K
	 w6ACu7kRT0a5Q==
Date: Mon, 10 Aug 2026 15:23:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chris S <coshi036@gmail.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	tom.leiming@gmail.com, Igor.Achkinazi@dell.com, dlemoal@kernel.org,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 3/5] block: validate bio bounds in the queue entered
 context
Message-ID: <anpBQXfo7eGNU2-v@kbusch-mbp>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-4-kbusch@meta.com>
 <CACd_6n2jNS9Msd_N-idPx3ijgN8NUxT1U1m2OrJu=e+GToB+ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_6n2jNS9Msd_N-idPx3ijgN8NUxT1U1m2OrJu=e+GToB+ZA@mail.gmail.com>

On Mon, Aug 10, 2026 at 05:12:45PM -0400, Chris S wrote:
> Keith, I checked this patch against the nvme_setup_rw() WARN I reported
> (the second link in your cover letter).  __bio_split_to_limits() is
> called from blk_mq_submit_bio() after bio_queue_enter(), on both the
> cached-request path and the newly-allocated-request path, so the bounds
> check is now serialized against the freeze window in
> nvme_update_ns_info_block().  With the capacity forced to 0, the bio is
> failed here and can no longer reach nvme_queue_rq(), which is exactly
> the race I hit.  Thanks for picking it up, and sorry for the slow reply.
> 
> I'll drop my own "nvme: don't WARN on I/O to a namespace revalidated to
> unusable metadata" patch in favour of this.

I'll need to revisit this approach as it is dependent on something in
the stack calling the split to limits functions, as well as the upper
layers error handling for a catching the end-of-device condition later
than before.
