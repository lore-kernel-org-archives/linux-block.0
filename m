Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F426110
	for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 02:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710382656; cv=none; b=LTHh/z8sZmThv5i1Mh2070EmL10BWMykF6KSu4E/uqBebCN0Qw9+SyW9Vte/yCvYgnBnlyTSOF0hE6EL9wud/CkUdRzUbQt11PKSjKdCsTU3QWZdJDL7Ar8o6PKsHqzn/Ywu14YFtGp8A2I3Hze1YmIHtPuuKlxMQpKBrpAK4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710382656; c=relaxed/simple;
	bh=+NqFgn8N9etYgMDhRfnatTVg6//GN8m52WKbRwEiBfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tS6FaV7PXVmCPjEaSGysZ8cl14PUm/AB0yUwp4eYQbkoI4otASZ3TIQkhEtwNxRhhP8xDJqRL+/Yq9UjL+SAkmFo3YY8eCttDyM9KMMBwEQSCdsyjNoOHyUxp0IWkMKfvdy+OPBzTl+55UHsbaFjPvO98bbCYaKOx3In7noU/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8jYXVKM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8jYXVKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AB6C433F1;
	Thu, 14 Mar 2024 02:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710382656;
	bh=+NqFgn8N9etYgMDhRfnatTVg6//GN8m52WKbRwEiBfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8jYXVKMea01i7OU4LYbPmimhiXsmn+z/DAK9f+RRPVVykQQGHeN0a3ARVRRsTu91
	 6bVxKbwKSAJUYrCPECqoEHyh/1QmGAySI2KrUx0ZXShwmPQJmjSfBHR+uOvcNiunKw
	 +CON3QctOscE/bay4yrLZJRJwFFdjnM9LDnpUI2gCVhhmzNc0h7OW+/dMb6HveS3d1
	 GdSssndB2ai9TJQMi/1r2A+YFuIq/fs6hvIoE+irKUlKPK+WJQ8eN8Z0N2ttsrmbeo
	 ukFh+ZJpbN2cRUrT5yrppdvLQJ3gaH2m/f6VJhqO/w8hEFiB2GVdjHGBRBeQNGh5Xa
	 ECQ9ptE0pee/Q==
Date: Wed, 13 Mar 2024 20:17:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>
Subject: Re: [PATCH] Revert "blk-lib: check for kill signal"
Message-ID: <ZfJePaJi8ZhYYCh0@kbusch-mbp>
References: <20240314021623.1908895-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314021623.1908895-1-hch@lst.de>

On Wed, Mar 13, 2024 at 07:16:23PM -0700, Christoph Hellwig wrote:
> This reverts commit 8a08c5fd89b447a7de7eb293a7a274c46b932ba2.
> 
> It turns out while this is a perfectly valid and long overdue thing to do
> for user initiated discards / zeroing from the ioctl handler, it actually
> breaks file system use of the discard helper by interrupting in places
> the file system doesn't expect, and by leaving the bio chain in a state
> that the file system callers of (at least) __blkdev_issue_discard do
> not expect.
> 
> Revert the change for now, we'll redo it for the next merge window
> after refactoring the code to better split the file system vs ioctl
> callers and cleaning up a few other loose ends.
> 
> Reported-by: Chandan Babu R <chandanbabu@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Keith Busch <kbusch@kernel.org>
