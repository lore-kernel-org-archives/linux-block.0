Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381B14A8F
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 04:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708575518; cv=none; b=MAAUC6BsyegYtqLjRlwJa2nu8zJch3zDbGo1AwwL2BCUU9Z9tUVK1pqkSRwHAOlxdqN9e8k8WCsRWgx1p+z5vn4I1Rd6T1iJDI8f52FNR2ihBTOVy2mTStuYMW9uN/95AyAlF0a65IwlQTvT/a9ELH1T2RNzJTwLgRTzcqXT+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708575518; c=relaxed/simple;
	bh=+wpViVQf2rs4556+SVJJvlOMfQq8OsVWmw0Nxl9DI3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYd6B2tlqnI6287U3FnqUSjgeNGS6qDqxy+R4lgfFwCVrmylW6cpSz3y8VogIkdGaTZFZsDMQvdpRyuK+ZPrdX+AVWHA9LuQssw3CuU0JK29XORp69gxBpAf7QBY/3eH1o5zAlsA0TVSLRA8UvRyNre1rlMOtUQbB2vrO6VHbn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7gIJodb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7gIJodb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31306C433F1;
	Thu, 22 Feb 2024 04:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708575517;
	bh=+wpViVQf2rs4556+SVJJvlOMfQq8OsVWmw0Nxl9DI3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7gIJodbi4Jc4eCV1bQL6NFUaw3ELjk4wQkcDBbNdTm7tsrMUQW/NycvVCC/LJIc3
	 MHJwtwaISo9lyJ6iDdKDOgv/ql8PtgqAtB0Qmihi0ETTxY2fR1UcX2zCwH18vQzNwE
	 5+/K7u45/k+iZK0L6uK2RwAZvgyDhvWfJ+/+KliUz7IymsrbicTjDSpNA7VJKQDI8a
	 3bFwYQ83dUPWyqqtzF/70NugD5KG/KePAh6iAzbhYX6F5kgLx4ABeyIecz2Xy1JNPK
	 MbjuI8tHR/5LmaVQPb488WRLlpC6c4yiq7i2jxvUxz8wAVbuSjSDBLsfDxIYXJKGkn
	 V5XFJsDIeNx6Q==
Date: Wed, 21 Feb 2024 21:18:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Conrad Meyer <conradmeyer@meta.com>
Subject: Re: [PATCHv2] blk-lib: check for kill signal
Message-ID: <ZdbLGqP8o0q9v1g5@kbusch-mbp>
References: <20240221222013.582613-1-kbusch@meta.com>
 <ZdbHXDCquO23rbJk@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdbHXDCquO23rbJk@fedora>

On Thu, Feb 22, 2024 at 12:02:36PM +0800, Ming Lei wrote:
> On Wed, Feb 21, 2024 at 02:20:13PM -0800, Keith Busch wrote:
> >   After the kill signal is observered, instead of submitting and waiting
> >   for the current parent bio in the chain, abort it by ending it
> >   immediately and do the final bio_put() after every previously submitted
> >   chained bio completes.
> 
> I feel this way is fragile:
> 
> 1) user sends KILL signal
> 
> 2) discard API returns
> 
> 3) submitted discard requests are still run in background, and there
> can be thousands of such bios
> 
> 4) what if application or FS code(such as meta) starts to write data to
> the discard range?

Right, there's no IO order guarantee there, and sounds reasonable to
expect no potential conflicts after the function returns. We could add a
similiar completion that submit_bio_wait() uses to ensure the previous
bio's are all done before returning. At least that looks safe to do for
any case where fatal signal would apply.
 
> > +		if (fatal_signal_pending(current)) {
> > +			abort_bio(bio);
> > +			ret = -EINTR;
> > +			bio = NULL;
> > +		}
> 
> The handling for blkdev_issue_secure_erase is different with others, and
> actually it doesn't return immediately, care to add comment?

Ha, I actually prepared a patch to make secure_erase look like everyone
else. I chose the smaller diff, but it does look weird. I'll reconsider
that for the next version.
