Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF1213C9C8
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468031; cv=none; b=XxCX09suNwgSrgjdS0n2iCCjrqbhhaVIDKXfWgUEQzXjbINNvI8rttEzmnkEA0N16oiUDFsbRwFv9ZWUnrqexfog6u+NePPdJOtM5ky/QdZwow3rwtybthAx4GdXtei6TZVCSQWGqhsux0v9NOTHENwK4br6mVcsEefBoTjsK9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468031; c=relaxed/simple;
	bh=ml262YuBryeikooYLLhnj5Q4jMLb6ulf2IcDiifuBo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7+QodLvfSZUFGS41OwfkCA8iDSiUyNMw72Popv8IC3Y7z/BnmspSCLTFIKpU69P0NxzZpEOlRalgnCfltMJueijJWAX/QhFbD1irqXk4Dqjhgmu6ESbgiqf2QfH8JUAfjY+zllCbb2kYReuDpTy9YkvFe1Sa/4On4lqQxvL014=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCWfGNGD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCWfGNGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E14C43399;
	Tue, 26 Mar 2024 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711468031;
	bh=ml262YuBryeikooYLLhnj5Q4jMLb6ulf2IcDiifuBo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCWfGNGDR3DrxpDMXP0lY52PqycTzru4JpKCYSbssSlZVC4HcpAziavSUJzhPR8vY
	 LEZ3OTlDOm1Ts5k7Jmyq925h/9bjagdnf4/JlXwV3gbmROTI7/gk562xCoDgsj6p/L
	 uKnucHZt+RzGUPvAKk4dkB8kHv3Fw4Mnxx3wUS2ZtsIhuLRAqXOG6dwQRBBTuSbcGv
	 V5Tg1mbV+JubWek+tBDIaR+U4lVas3nId7SIs39to4AqckZ9NpJ9ILU8yFCKcxaZtS
	 QeH0XrhZbvQChB6TVh7COgi+c5mIB4SPCkpyQ4AvrM/KUgOokZa9tZcWcXhoG+D5W+
	 4/W2S7wPi9P9g==
Date: Tue, 26 Mar 2024 16:47:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Message-ID: <20240326-langanhaltend-anbot-1c1e74cc198f@brauner>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner>
 <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
 <20240326125715.i23eo6sh5223tdmc@quack3>
 <20240326-eidesstattlich-abwahl-ddfb1c75c05e@brauner>
 <20240326133107.bnjx2rjf5l6yijgz@quack3>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240326133107.bnjx2rjf5l6yijgz@quack3>

On Tue, Mar 26, 2024 at 02:31:07PM +0100, Jan Kara wrote:
> On Tue 26-03-24 14:17:20, Christian Brauner wrote:
> > On Tue, Mar 26, 2024 at 01:57:15PM +0100, Jan Kara wrote:
> > > On Sat 23-03-24 17:11:19, Christian Brauner wrote:
> > > > Last kernel release we introduce CONFIG_BLK_DEV_WRITE_MOUNTED. By
> > > > default this option is set. When it is set the long-standing behavior
> > > > of being able to write to mounted block devices is enabled.
> > > > 
> > > > But in order to guard against unintended corruption by writing to the
> > > > block device buffer cache CONFIG_BLK_DEV_WRITE_MOUNTED can be turned
> > > > off. In that case it isn't possible to write to mounted block devices
> > > > anymore.
> > > > 
> > > > A filesystem may open its block devices with BLK_OPEN_RESTRICT_WRITES
> > > > which disallows concurrent BLK_OPEN_WRITE access. When we still had the
> > > > bdev handle around we could recognize BLK_OPEN_RESTRICT_WRITES because
> > > > the mode was passed around. Since we managed to get rid of the bdev
> > > > handle we changed that logic to recognize BLK_OPEN_RESTRICT_WRITES based
> > > > on whether the file was opened writable and writes to that block device
> > > > are blocked. That logic doesn't work because we do allow
> > > > BLK_OPEN_RESTRICT_WRITES to be specified without BLK_OPEN_WRITE.
> > > > 
> > > > So fix the detection logic. Use O_EXCL as an indicator that
> > > > BLK_OPEN_RESTRICT_WRITES has been requested. We do the exact same thing
> > > > for pidfds where O_EXCL means that this is a pidfd that refers to a
> > > > thread. For userspace open paths O_EXCL will never be retained but for
> > > > internal opens where we open files that are never installed into a file
> > > > descriptor table this is fine.
> > > > 
> > > > Note that BLK_OPEN_RESTRICT_WRITES is an internal only flag that cannot
> > > > directly be raised by userspace. It is implicitly raised during
> > > > mounting.
> > > > 
> > > > Passes xftests and blktests with CONFIG_BLK_DEV_WRITE_MOUNTED set and
> > > > unset.
> > > > 
> > > > Fixes: 321de651fa56 ("block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding write access")
> > > > Reported-by: Matthew Wilcox <willy@infradead.org>
> > > > Link: https://lore.kernel.org/r/ZfyyEwu9Uq5Pgb94@casper.infradead.org
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > 
> > > The fix looks correct but admittedly it looks a bit hacky. I'd prefer
> > > storing the needed information in some other flag, preferably one that does
> > > not already have a special meaning with block devices. But FMODE_ space is
> > > exhausted and don't see another easy solution. So I guess:
> > 
> > Admittedly, it's not pretty but we're abusing O_EXCL already for block
> > devices. We do have FMODE_* available. We could add
> > FMODE_WRITE_RESTRICTED because we have two bits left.
> 
> Yeah, I'm mostly afraid that a few years down the road someone comes and
> adds code thinking that file->f_flags & O_EXCL means this is exclusive bdev
> open. Which will be kind of natural assumption but subtly wrong... So to
> make the code more robust, I'd prefer burning a fmode flag for this rather
> than abusing O_EXCL.

Ok, done and resend. Thanks for the feedback! I was rather focussed on
not using a bit but I agree it's likely the right thing to do!
