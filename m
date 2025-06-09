Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E514221B9D8
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481492; cv=none; b=ubZjf3KrJldakEw9dZk/pzv8h4NYH6ad74lAVk5DrHZp8DXFZpjPAaVztpFAmR7QSuHE1tlxz0cvuWKBMdxW4tAmauZT8WbOl42aq6rp14MNgz8VCbuvy4eu6S2687egwYQf/VGfn5xxWkNfauKcNQw+pV4WOf9UNdQaVTTCzpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481492; c=relaxed/simple;
	bh=V9R/MlXkDxF8BcfPqNzbvEqrs6zAbVcZgELa1g9IE3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbnWVUfBYbBociphflJGMu7+J3RWaBc+jpd4WQal1inXrvsLmiHQnHV0+yFWA8UhUFIko/5Y8ShgkyUAkrHd7nB/GR8TLkXeZ2w3cVNO19aM6pMCK4Xvy+WPdPZgv2u5e86TEBjiOVkMUCy7Sv5+pJYPzdtUQlU9/ugyqUM4Cz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSL/Vd3w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSL/Vd3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446D8C4CEEB;
	Mon,  9 Jun 2025 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749481491;
	bh=V9R/MlXkDxF8BcfPqNzbvEqrs6zAbVcZgELa1g9IE3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JSL/Vd3wCBE2pYIJY1CXXvjGJLBptYttI7nc36++QiqsFY+326Whyb0jHu5+h/b8k
	 B/8XM6nroSV7iG6l1PpmKBqyyqA5Zwy1P3n/+z/jI4w5ZUUtjHk5WrKpRZyoH15Mz/
	 dRyoVQ56uokfoNO8OADQharWJpnnzXLBnBPuYwPoWGimk7t5TqBU5B4+CrJdhplMP2
	 TCJcmcxlFbhuDQzKbZg9usDlk1A4IamPhRC9ynNOgTKRtleKOcyfJWE/nAktt5GRL/
	 vsLMzGSwXikIKppTyAl1dzxm5QMud30CAJpNBV5CG47LzrYk6Ds0kzzOirVFXV6CLG
	 tRd32RnIGTDMQ==
Date: Mon, 9 Jun 2025 09:04:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH blktests] block tests: nvme metadata passthrough
Message-ID: <aEb4Ef7ODvAX528j@kbusch-mbp>
References: <20250606003015.3203624-1-kbusch@meta.com>
 <brqphgz27tsruoz4jyvvc4x6kwmqv2lkotdwwox2njqfku3kb4@2hpbwsti3rcn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <brqphgz27tsruoz4jyvvc4x6kwmqv2lkotdwwox2njqfku3kb4@2hpbwsti3rcn>

On Sat, Jun 07, 2025 at 12:54:50PM +0000, Shinichiro Kawasaki wrote:
> On Jun 05, 2025 / 17:30, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Get more coverage on nvme metadata passthrough. Specifically in this
> > test, read-only metadata is targeted as this had been a gap in previous
> > test coveraged.
> 
> Thanks for the patch. I ran the test case on the kernel v6.15, and it passed.
> Is this pass result expected? I guess this test case intends to extend test
> coverage, and does not intend to recreate the failure reported in the Link.
> So, I'm guessing the test case should pass with v6.15 kernel.

Oh, I thought it would fail in 6.15, or at least part of this test would
have. I changed a lot at the last second before posting, so maybe I
messed something up. I'll do another version after making sense of
what's going on.
