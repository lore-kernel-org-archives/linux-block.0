Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7AEEBA
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764459; cv=none; b=Y4WMkkycFi+seETDJ6mF5BvJheRq6POf7KCgMqwI5QW59gYpG2PyIXSZ/8cUVaXNWWhTQ9owhM4YdBAdH7axcZGti4fzq+o2zanIuCF6Athx4dPT+BYVODLOcouZWcBX+eCihKhbfUchmY70Qm1tJwfznW2b3RsJNBwCbrS3zNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764459; c=relaxed/simple;
	bh=DnijyW5JlqFyIDZJ73UKESOjI7JsNHismUMpJMOlCJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFtn90kMQCz/vbT2uNbHkRcvnLXDr3pF4YosjhS/+6Yh4XqfSm9eWQ4/1EKjlgB5xVCOtMq4zjAVqhxGSpxApOyJk9CEeW2PmGiNXBlSlwxQLzsNSTHNOsHJ6B99yAUNaUe2ZmXC/gZTbOoyr7O/5os65CBnLf52wDrM7vM/H20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsgnbBjt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsgnbBjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A0EC4CEE7;
	Wed, 16 Apr 2025 00:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744764458;
	bh=DnijyW5JlqFyIDZJ73UKESOjI7JsNHismUMpJMOlCJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FsgnbBjtQlZMjh/f1ltC5pK3959/KEwSX83fjA4sXQJGHApIOImOFyUMlE77uiKFC
	 O0dEfCU5JiCpXh6/Mn+OVjySE/5A+L5hoe0N3UrrmXzMUo9jyF5FBEbqt22DX44+Qm
	 gR411VQiJHep2fk959Eh3sgj7NQS5Z7h2jr5RiOzIVOSGmEVPqVpUNCdWBB5Vu224H
	 +lHvE+vrW8giQy8N8cfQQGMGTVL64nxaefpVFr+P/mRxOd3nqGQwzP6EB3yVqoNivC
	 NIvKcdU8VUCbtejPY10UL+d+1IHrK10SWIM/lZeBdWe899vdsX7dkfWJ4Ywmh1PDYf
	 f1icRQ+ARLNKg==
Date: Tue, 15 Apr 2025 17:47:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: stop using vfs_iter_{read,write} for buffered I/O
Message-ID: <20250416004737.GC25659@frogsfrogsfrogs>
References: <20250409130940.3685677-1-hch@lst.de>
 <Z_3VTGpuLQ1BcqvG@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_3VTGpuLQ1BcqvG@fedora>

On Tue, Apr 15, 2025 at 11:41:00AM +0800, Ming Lei wrote:
> On Wed, Apr 09, 2025 at 03:09:40PM +0200, Christoph Hellwig wrote:
> > vfs_iter_{read,write} always perform direct I/O when the file has the
> > O_DIRECT flag set, which breaks disabling direct I/O using the
> > LOOP_SET_STATUS / LOOP_SET_STATUS64 ioctls.
> > 
> > This was recenly reported as a regression, but as far as I can tell
> > was only uncovered by better checking for block sizes and has been
> > around since the direct I/O support was added.
> > 
> > Fix this by using the existing aio code that calls the raw read/write
> > iter methods instead.  Note that despite the comments there is no need
> > for block drivers to ever call flush_dcache_page themselves, and the
> > call is a left-over from prehistoric times.
> > 
> > Fixes: ab1cb278bc70 ("block: loop: introduce ioctl command of LOOP_SET_DIRECT_IO")
> > Reported-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks fine,
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

This seems to resolve the problem, thank you!
Tested-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> 
> Thanks,
> Ming
> 
