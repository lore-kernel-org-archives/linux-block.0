Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDB52356A7
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570714; cv=none; b=kEcbP2IDuagHMKnRCeCPtZIZyt/Dv4eJLUh4kbeXAX+IDAZOzPj1HipyLm4uI/J2Dtdj+5bkRmlqOJaH/EITTGjnt6Y2cudEvVte2toZ8QTYMVJHzkwVJ7WqSo5P02OGs4qipfZZxkxG+jSzAem9t2zMJgG7AmCew8Cz4JTGJU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570714; c=relaxed/simple;
	bh=JQ0QQNCQ2xeKuiosGsHSQtXrqmR8dk9QsZKLN5vpNjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVKKK2aizOJGuPH1cYSM9YcAM0toZkA+ssJbet+8kHI8Vs/NdAUgPqMThENuF+JibhHEqI/TwNypz4p0Dw6QHYCJayeqVjCHyxAcroBViDcJiiJPjU5QJ5KLcnwtkdjBGfuSqBpMg3FO5ewn/tb57QpU2NPo/NSR65ROOagrTIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnXTAOgW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnXTAOgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8356FC4CEED;
	Tue, 10 Jun 2025 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749570713;
	bh=JQ0QQNCQ2xeKuiosGsHSQtXrqmR8dk9QsZKLN5vpNjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnXTAOgWAfWMUGwgZ3hA0GiMZPvvwyg5Yzo8ysOh4d1ryyUmmTQojadcm5j0XbQHI
	 j4giiNPDfYZzGG3Rqj1I9Zo9U/MOz4EHPZnU+Zh0qfcoMKjCt9CfSWHzthE3lVH3RR
	 Q6HILFxkd8kCsSY37cQbAUQyu/lhvtPt77qhDS91zV4F7A6oqkxJR+68JeQ53lLdgD
	 sriMYBEaegPzhK3cK3KeFodsBEDwm2qE99gsL92Ox76m6zaLD03VQk7LDeWTawzsM5
	 EeojJZx0S9Ew6h/3EKCc3m492CPqt0x4t7QhvpgmipZa8+YzudcBtbsuEw3hV4fw+9
	 MgR9WyePNeE8Q==
Date: Tue, 10 Jun 2025 09:51:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCHv2] block tests: nvme metadata passthrough
Message-ID: <aEhUlw8H2ZD98SpY@kbusch-mbp>
References: <20250609154122.2119007-1-kbusch@meta.com>
 <pgyqdqi76m7skiyirtjb3d7wtbb5223sk64eoqtafg7r763biw@7f4pdqtoptiv>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pgyqdqi76m7skiyirtjb3d7wtbb5223sk64eoqtafg7r763biw@7f4pdqtoptiv>

On Tue, Jun 10, 2025 at 07:31:10AM +0000, Shinichiro Kawasaki wrote:
> Thanks for this v2. With the fix above, I was able to confirme that the test
> case passes with v6.16-rc1 kernel. When I reverted the kernel commit below,
> it failed. It looks working good as the fix confirmation.
> 
>  43a67dd812c5 ("block: flip iter directions in blk_rq_integrity_map_user()")

We should probably put a "Link:" tag in the commit message for this:

https://lore.kernel.org/linux-block/20250603184752.1185676-1-csander@purestorage.com/
 
> To run the test case, I tried QEMU nvme emulation devices with some different
> options. I found that the namespace should have format with metadata, and
> extended LBA should be disabled. IOW, QEMU -drive option should have value
> "pi=1,pil=1,ms=8" for the namespace.

That's fine, though you don't need to set protection information
capabilities for this. The test will still run if you enable it, but
it's probably better if you just let it be opaque metadata. You can also
test with ms=16 or ms=64 as both are supported by qemu's nvme device.

> I suggest to describe the device requirements in the test case comment. Also, I
> suggest to check the requirements for the test case, and skip if the
> requirements are not fulfilled. FYI, I prototyped such change as the patch
> below. Please let me know what your think. If you are okay with it, I will
> repost your patch together with my patch for common/rc and tests/nvme/rc as the
> v3 series.

Your changes look good. Thank you for the suggestions!
