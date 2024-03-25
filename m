Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DCD54917
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374861; cv=none; b=U3cPYBYxMVsQoSyKNSQh1/83HfqfvJU45wKAxcCYsQPDUbwhEkc3FqYPW+XQ/YJsp+YhBe2EM+nUXvyvzePnMpAg3GgyaJu89J06hUwk4yJukP99Snh02XH4lQY27Wp6Hi5+1mkulUfZmkUVtHYLv6j7A1/roec38PpnbkWULOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374861; c=relaxed/simple;
	bh=DFTfl5tkIsDcJwJrvgPEwpjNvKiXx2TUe37YzwNItrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NK0gOt+dSRKkuX1G6WXU3Os2w8AX1WLYdNwmWRA6idkE9AAxHx5ge7hcVNziQTyJA7UIeX8vIFVDGDIqC0yR0KJ6n6Yt17VufcWafWG4eT09gp87xXSchFdgJ6t2IvMZ8Yox0/c2TCiXV3hBOfw9ps8O3g6XvXvdj1D1BuHp4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiygy+yl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiygy+yl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31844C433C7;
	Mon, 25 Mar 2024 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711374861;
	bh=DFTfl5tkIsDcJwJrvgPEwpjNvKiXx2TUe37YzwNItrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aiygy+ylnx3of+L6m8b7Ik5TNTkaIN5TXAS4zk3PTcV2SrUBx/lVsYlVwALDFgyhf
	 6iQKH6uv1iJYBeQltdNyCRPl7UjKHn05va1Q05oo0G7n+P6jFOQSk/4Dzxw4MwYBjY
	 /AbKnLcwTmXsJP2pwvDVfZ7ZUo3GyJ0LmcCqEIzaJJbYhw7biBdKP8KFrGS68zkBLG
	 5A0uFicJ9ypBGjFp369VNSwPDgZ8tIw9sZDHAdPTWctaG9XKtjL7Q9tvJVyTtFqoUg
	 0RxBV9dZksELD+xdHtwaKthv6Vph26OvI+UHdlq3cbpbbvz/lqGYP6nycLycDrvCxM
	 4NjH3JRfIbqpA==
Date: Mon, 25 Mar 2024 14:54:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, 
	linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 1/2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Message-ID: <20240325-entsolidarisierung-kapital-5897091cdd25@brauner>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner>
 <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
 <3594bd44-4c6b-d079-1209-f069353ccd58@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3594bd44-4c6b-d079-1209-f069353ccd58@huaweicloud.com>

On Mon, Mar 25, 2024 at 07:51:27PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2024/03/24 0:11, Christian Brauner 写道:
> > Last kernel release we introduce CONFIG_BLK_DEV_WRITE_MOUNTED. By
> > default this option is set. When it is set the long-standing behavior
> > of being able to write to mounted block devices is enabled.
> > 
> > But in order to guard against unintended corruption by writing to the
> > block device buffer cache CONFIG_BLK_DEV_WRITE_MOUNTED can be turned
> > off. In that case it isn't possible to write to mounted block devices
> > anymore.
> > 
> > A filesystem may open its block devices with BLK_OPEN_RESTRICT_WRITES
> > which disallows concurrent BLK_OPEN_WRITE access. When we still had the
> > bdev handle around we could recognize BLK_OPEN_RESTRICT_WRITES because
> > the mode was passed around. Since we managed to get rid of the bdev
> > handle we changed that logic to recognize BLK_OPEN_RESTRICT_WRITES based
> > on whether the file was opened writable and writes to that block device
> > are blocked. That logic doesn't work because we do allow
> > BLK_OPEN_RESTRICT_WRITES to be specified without BLK_OPEN_WRITE.
> 
> I don't get it here, looks like there are no such use case. All users
> passed in BLK_OPEN_RESTRICT_WRITES together with BLK_OPEN_WRITE.
> 
> Is the following root cause here?
> 
> 1) t1 open with BLK_OPEN_WRITE
> 2) t2 open with BLK_OPEN_RESTRICT_WRITES, with bdev_block_writes(), yes
> we don't wait for t1 to close;
> 3) t1 close, after the commit, bdev_unblock_writes() is called
> unexpected.
> 
> Following openers will succeed although t2 doesn't close;
> > 
> > So fix the detection logic. Use O_EXCL as an indicator that
> > BLK_OPEN_RESTRICT_WRITES has been requested. We do the exact same thing
> > for pidfds where O_EXCL means that this is a pidfd that refers to a
> > thread. For userspace open paths O_EXCL will never be retained but for
> > internal opens where we open files that are never installed into a file
> > descriptor table this is fine.
> 
> From the path blkdev_open(), the file is from devtmpfs, and user can
> pass in O_EXCL for that file, and that file will be used later in
> blkdev_release() -> bdev_release() -> bdev_yield_write_access().

It can't because the VFS strips O_EXCL after the file has been opened.
Only internal opens can retain this flag. See do_dentry_open(). Or do
you mean something else?
