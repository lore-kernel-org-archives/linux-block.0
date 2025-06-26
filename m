Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02EE1CFBA
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939781; cv=none; b=gcz/Fwwyr6Dz+TLJATHHfieLJD+taIzkQxS0ireLnra98VsNA1eTa4m7Cx4bFEejP+dlnN36gZwaBZ6e9859hxy9dsEq+CV/oi1c7N7ZNMKbiWj414hAE9suW5TYQaA5Gp24F80cHEClWjQ3zVlAY1Xiihfj9NiBXfIaXasc3/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939781; c=relaxed/simple;
	bh=wDu6DK6om89UHsDxdNM4D1owhSt5H2XUW7SJi6WFSHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkfW9hcV/z6zY/KpuSZ/1zhvrAikSx4XFzysj77vmDB5Qgz2HBhElpen5b3k2gg5K8vdd2AX/0dy6DH2oVZ0DXkXRZYNUJ9DnX5dFjnSY05uvS26WdTqL5hPwDEzob/w7tnkyrfWvqbSkgcX9Ka7P+YWSWSdvipLOwox6BIbe/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ed2tJ64H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ed2tJ64H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3849C4CEEB;
	Thu, 26 Jun 2025 12:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750939781;
	bh=wDu6DK6om89UHsDxdNM4D1owhSt5H2XUW7SJi6WFSHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ed2tJ64HyLjyqBtfWX46LN6YmqdzKpAhYnfsOdUnqAJzVMfuL8Ao+TKzA1e4kQUlg
	 NdXBzS2VLs43bhONw8sg78vNSB4feOelHyIPXbS8r2Yi9AdT6cXJHWvYshkqba/Wm1
	 O0ik3td3284y3aytXMzTE3VCD1Z7fh8ZWCB7RW70RFe8AvplkMzaMjmD6RiUwZLLte
	 KwC4rDFwIWxBHHlGkXDZRBTtoAswdhedRCkj0elfOy7ngRejiDyD3W+s+2lpw4VDt1
	 i+b6CcZWqQzFVP1o/MPHOqQwGuTtSnJ2bW9pUSiQY9husffB2xrK/R6nHlL1D563Qa
	 l1ufoCXJUSzHQ==
Date: Thu, 26 Jun 2025 06:09:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme updates for Linux 6.16
Message-ID: <aF04g6_dk0uWq4jy@kbusch-mbp>
References: <aF0p8PlTkmFvfDeW@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF0p8PlTkmFvfDeW@infradead.org>

On Thu, Jun 26, 2025 at 01:07:28PM +0200, Christoph Hellwig wrote:
> [note that the commit dates are very recent.  That is because somehow the
> tree the ran through the build bot had me as the author for the commit
> from Keith, so I did a metadata only rebase just now to fix that]
> 
> The following changes since commit dd2c18548964ae7ad48d208a765d909cd35448a1:
> 
>   nvme: reset delayed remove_work after reconnect (2025-06-26 13:04:35 +0200)

Your 'request-pull' used the wrong starting point. It should be the one
before this commit.
