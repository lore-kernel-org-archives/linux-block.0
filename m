Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C6350A16;
	Thu,  4 Dec 2025 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870943; cv=none; b=t+QkfxVqmsNjQjO1udkkhHnbGT8krxe/BzjtPGy9cxGo47hmL6FflKzLrEIoIMVAXX/kjxW2qIUaUZCSEjUbO2yIdt5kdVVdLnEuIPr+jINsgHMkJNqg9IRbPi/50agjqAwq/SfyM+Xww+HS9rC2iHb3rMVMvkGyegky0DYH3tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870943; c=relaxed/simple;
	bh=cWH4lfdD74O2lLdgOIp1vzZuReu/JSCmyStEbDHm3jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di1z59pF7ZQPsKg5ieOiTArWuiLG3YkRIFyQqoZ+7ilmhDolwmhPMzCa8QHQtMHtordCBQCIy2KIyvyiGL8GMDQg4+cejwyOvvkAVjG2dEHy69uP67CK9RmWeBtzLb/wZHsG1icP/CyA4ERTzNNczR4aCcU1GNFJgBTmxym3bqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpVnvSsp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpVnvSsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9AFC4CEFB;
	Thu,  4 Dec 2025 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764870943;
	bh=cWH4lfdD74O2lLdgOIp1vzZuReu/JSCmyStEbDHm3jI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpVnvSsppX0MSlbAJytC0vo+vslia2qfybseG9ks5XSlanVrfRdZuXYfyIZq9Kpnz
	 ppce43qD7zX8Ocxw6z04hSN+GgLj3e+q1NrXidqWnhRW+lR+Mbhk9g0DgWDN3StIVu
	 b0f6m21YcJK378JUez9Y76zkWaPeK61E1O/rCLy7Yr5TtIDhYLcSyh6c9JGWmBnk7h
	 sBDCmjWakvha6AewcxJH2QEzGimC8IixydSkEV9nnEynL1m35FMokjYwOf9iv17IWX
	 Vh+8+QY9UcLpJ3BGYFzow60WmIGnfyGZY0aDT/z+kbRswMx86A0gMaUDh5a8PjWtka
	 U3NP+IoTgDj2Q==
Date: Thu, 4 Dec 2025 10:55:40 -0700
From: Keith Busch <kbusch@kernel.org>
To: shaurya <ssranevjti@gmail.com>
Cc: syzbot+527a7e48a3d3d315d862@syzkaller.appspotmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [udf?] memory leak in __blkdev_issue_zero_pages
Message-ID: <aTHLHGtXXrtDumEy@kbusch-mbp>
References: <6931abe7.a70a0220.2ea503.00e0.GAE@google.com>
 <23fde58b-ef8f-4420-b0a8-5ae87dfe0bc4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23fde58b-ef8f-4420-b0a8-5ae87dfe0bc4@gmail.com>

On Thu, Dec 04, 2025 at 09:42:38PM +0530, shaurya wrote:
> Move the fatal signal check before bio_alloc() to prevent a memory
> leak when BLKDEV_ZERO_KILLABLE is set and a fatal signal is pending.
> 
> Previously, the bio was allocated before checking for a fatal signal.
> If a signal was pending, the code would break out of the loop without
> freeing or chaining the just-allocated bio, causing a memory leak.
> 
> This matches the pattern already used in __blkdev_issue_write_zeroes()
> where the signal check precedes the allocation.
> 
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

> ---
>  block/blk-lib.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 3030a772d3aa..352e3c0f8a7d 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -202,13 +202,13 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
>  		unsigned int nr_vecs = __blkdev_sectors_to_bio_pages(nr_sects);
>  		struct bio *bio;
>  
> -		bio = bio_alloc(bdev, nr_vecs, REQ_OP_WRITE, gfp_mask);
> -		bio->bi_iter.bi_sector = sector;
> -
>  		if ((flags & BLKDEV_ZERO_KILLABLE) &&
>  		    fatal_signal_pending(current))
>  			break;
>  
> +		bio = bio_alloc(bdev, nr_vecs, REQ_OP_WRITE, gfp_mask);
> +		bio->bi_iter.bi_sector = sector;
> +
>  		do {
>  			unsigned int len;
>  
> -- 
