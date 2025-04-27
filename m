Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9770979C4
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 04:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745726689; cv=none; b=gsNRX6Rb7r4tH/dthqRfQ28s5M+3xDfDgK8iVF+N8H8X9xwfTswM2a/5VEIdrpiMoR9Zrxmyo8MScdMtsFCNfgA/KoBfwOhswXtRZhM6XdEIowYWROCwIHPohD1KBGgDXX8hBShWGg/7WPLPxs28K57IY+nt6Pv326He0T586OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745726689; c=relaxed/simple;
	bh=rJMCC+V4FvScaxiFmF/rYhupUAOpp72DqYenxJuTPlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWuqLx7sP4NBYNYFh7y1igZNW8qGnxdbYUI55tYuJtaZCb3Bdr4qZJPzrtoxi8AE+q+wDk9SnJV7L4wEfvBi3qf8tJFovbmQXyw0rb0/dq0OeyfU5G0sBoJCtR/opCx67JUOB6ocZqNOYNu0mR7ulPB1pBHkHCXvuH0qs1Df8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgvotdSg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgvotdSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7424C4CEE3;
	Sun, 27 Apr 2025 04:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745726689;
	bh=rJMCC+V4FvScaxiFmF/rYhupUAOpp72DqYenxJuTPlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgvotdSgGCfxj3WmA1VL9DX2GuEHEdzrWkAkeeDCp295kYd/pyPTWescIZTTXZNtq
	 7Gi7wGbTduTylbx6ztwV66eP6NHCls1tJXvxgAnGt18UcjEmDg/eYsGdHE15+POoye
	 dkpnMsV06Fl3nro6MWWuy2i9GJvD6XA1L0mQ/bRdHqpGpUzz4OI3m3PQgsnkVSI6Cb
	 P1o01YM3iT6d3gVcNtDdxIA7pBRWDgNyW7mKy8H21jg+Fam9djFz0tlWM6vxv/gnIL
	 fjjMV4uFgFE9AY/ZINDcEkNcfEGnJ2Fac6dEOxAUXp3bnf7gbfPuxegbzqoaZF39MI
	 i5GQqAqBAh1VA==
Date: Sat, 26 Apr 2025 22:04:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 3/4] ublk: add feature UBLK_F_AUTO_ZERO_COPY
Message-ID: <aA2s3oVFfOF1X485@kbusch-mbp.dhcp.thefacebook.com>
References: <20250426094111.1292637-1-ming.lei@redhat.com>
 <20250426094111.1292637-4-ming.lei@redhat.com>
 <CADUfDZqQ_xvFMP=yjUYvvnn6u36iNBmcgoONBoBVhDjyiZQfjA@mail.gmail.com>
 <aA2XwIcOPysPTra9@kbusch-mbp.dhcp.thefacebook.com>
 <aA2gJqKs31-_diER@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA2gJqKs31-_diER@fedora>

On Sun, Apr 27, 2025 at 11:10:30AM +0800, Ming Lei wrote:
> On Sat, Apr 26, 2025 at 08:34:40PM -0600, Keith Busch wrote:
> > 
> > This is very similiar to something I proposed off-list, and the feedback
> 
> Looks we both think of it, :-)

Yeah, for real. I was a bit dismayed when I learned of such use cases.
So much simplicity and elegance went away...
 
> > back then was this won't work because the back-end ring that wants to
> > use the zero-copy buffer isn't the same as the ublk server ring
> > recieving notification of a new command; the ublk driver has no idea
> > which uring to register the bvec with. Also, this is using the request
> > "tag" as the io_uring buf index, which wouldn't work when the ublk
> > server ring handles multiple ublk devices due to the tag collisions.
> > 
> > If you're can make those trade-offs, then this is a great simplification
> > to the whole thing.
> 
> The io_uring fd & buffer index can be provided from 'ublksrv_io_cmd'.
> 
> https://lore.kernel.org/linux-block/aA2RNG3-WzuQqEN6@fedora/
> 
> If we only support IORING_ENTER_REGISTERED_RING, 32bit is enough for
> io_uring fd & buffer index, and there is still 64bits available if not
> taking UBLK_F_ZONED into account.

We still need a registered sparse table for the backend ring. I think
maybe a simple ida from the ublk driver to select an index may let the
daemon register something reasonably small.
