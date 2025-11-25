Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD8C235045
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088974; cv=none; b=RqwYFE16g9OJsXjaLVnT4C+B/QRT+ZUNrEoVBd9kAYsp+gmXr4PEmT5opG2K+t7g+QwMPJ2RXbx+I9YE8Wtd78f/78G3pO1mURSW52tZOUlralUHOsCTYo2nn4awyiBGOPHhmgz34jU4IpF1EqcBCKs1TgD8/tZT0Rg9mRrM34U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088974; c=relaxed/simple;
	bh=dWvTqNwI7PZoHHcTET1FAV9AyIdB76+N00neVcHhFdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IC28I3lMmrYE4vTN8dZ6c28dMjM2JwQEBPNOjQpQeOrGHM0tmXFnq6gqWhpv+1lcbtDzbd8wrn5As2V7323BjoNvaSk1lCrAODUdEV81H2xBB5UuS2YCtc49uNzDjmg84+6zlDAZEuJrafCdXDdqAY7sg8WOtQFI6IyNYzqhP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsvukiPx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsvukiPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E29C4CEF1;
	Tue, 25 Nov 2025 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764088973;
	bh=dWvTqNwI7PZoHHcTET1FAV9AyIdB76+N00neVcHhFdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsvukiPxoXR69qNTemIbYd9rurWkWvOoTHxZbZP19kjlDFpz2h3cKDLP+HEzHJWLK
	 +IlA+uJCWD0Kwc9V9sr49epOTodsc3tqBywF9vL9hd8SVXyAb0m4d0cJm689a9fpSQ
	 DbcOKFE+Vc3dvbFiewUSwCtdisvzZpipshJOof7RrIhv4OqE14hyQ7g2pAtK5SGWBM
	 qUyyakiRazB/bOCcOyepgoq+t6aF66H9nw173Lxeu0pSE8Uh/vWhjzGYYqYJWKz9EQ
	 O9Xy8Buo9LwZ2CedmlckBgP9e9Bq2Zeifgideui4Sa+p35BaJ/hI36/aHQA8okzuGm
	 aC4rIf8b33Rxg==
Date: Tue, 25 Nov 2025 09:42:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>
Subject: Re: [PATCHv2 1/2] blktests: test direct io offsets
Message-ID: <aSXci0u7c9Ppnjbd@kbusch-mbp>
References: <20251119195449.2922332-1-kbusch@meta.com>
 <20251119195449.2922332-2-kbusch@meta.com>
 <y744um3exsnhtf5u4iabfipzwkexcz5t3xqe4vvspa7z7hfuws@y5mbl2oszpuy>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y744um3exsnhtf5u4iabfipzwkexcz5t3xqe4vvspa7z7hfuws@y5mbl2oszpuy>

On Tue, Nov 25, 2025 at 11:26:31AM +0000, Shinichiro Kawasaki wrote:
> On Nov 19, 2025 / 11:54, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Tests various direct IO memory and length alignments against the
> > device's queue limits reported from sysfs.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> [...]
> > diff --git a/src/dio-offsets.c b/src/dio-offsets.c
> > new file mode 100644
> > index 0000000..8e46091
> > --- /dev/null
> > +++ b/src/dio-offsets.c
> [...]
> > +static void init_buffers()
> > +{
> > +	unsigned long lb_mask = logical_block_size - 1;
> > +	int fd, ret;
> > +
> > +	buf_size = max_bytes * max_segments / 2;
> > +	if (buf_size < logical_block_size * max_segments)
> > +		err(EINVAL, "%s: logical block size is too big", __func__);
> > +
> > +	if (buf_size < logical_block_size * 1024 * 4)
> > +		buf_size = logical_block_size * 1024 * 4;
> > +
> > +	if (buf_size & lb_mask)
> > +		buf_size = (buf_size + lb_mask) & ~(lb_mask);
> 
> I investigated why this new test case fails with my QEMU SATA device and noticed
> that the device has 128MiB size. The calculation above sets buf_size = 192MiB.
> Then pwrite() in test_full_size_aligned() is called with 192MiB size and it was
> truncated to 128MiB. Then the following compare() check failed.
> 
> Is it okay to cap the buf_size with the device size? If so, I suggest the change
> below. With this change, the test case passes with the device. If you are okay
> with the change, I can fold it in when I apply the patch.

Yeah, totally fine. Much of the sizes were just made up as I went along,
but it should probably be programatically calculated based on the device
under test.

> > +#!/bin/bash
> 
> Is it okay to add any GPL SPDX license and your copyright here? It is not ideal
> that I add your copyright and license, but if you specify them in this thread, I
> will add the Link to this thread in the commit message and fold-in the specifed
> SPDX license and your copyright.

Yes, sorry, it should have been there. I added those to some files, but
missed this one.
