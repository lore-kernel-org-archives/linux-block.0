Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53F125B9
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752194226; cv=none; b=tZJkahKsZIg8LA6MRnenFxGtp7tCdJBPDwu6rS3ff7aVO+zQ3POy8w4UO4y9oJYHZVQUTE76DVVYP3HJ/1xkGupvh4Y3EJEgbnhck3J6gIPjFLafiwVjuCdUSc6IAjkYzZiEsBUWmBjZ14jMnk6W+uhcfK7W63h+GR4ycjfeH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752194226; c=relaxed/simple;
	bh=7u5+cf2nJZoDvmfkGRcyh5Fe4HAs8tplHaitTwUCHWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1WohzE4HpGl+OwNGpwKzddXAJvn2ezob37xdDoNfUV4uxlqzOFZKpnQDazHPbCkziJfkyQ13vWGILvEa7Z2bJpA2epp60cW4134NttNC82g6HMJmrdbClqIDuOmQc4X+agldDe3av4tpUzlfyElvNDwf5qzaOhoAh09A+625sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sqm12vd9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sqm12vd9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37622C4CEE3;
	Fri, 11 Jul 2025 00:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752194225;
	bh=7u5+cf2nJZoDvmfkGRcyh5Fe4HAs8tplHaitTwUCHWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sqm12vd9TY/Nk7pcL72xtGHsxJB2aGz4GX4/Iy7SCuXKfdNSIeMpjgT3p2SJAHMD7
	 jRJT1IWcHOYotojPgRMOhsQbiwVP33H7vUwcKMslz51Z3cLD8ylN4aA2pwq6cqzpZr
	 M4HeN/UPTISa4xw//cuSX1IENDvGQ8OY6c1RdOgZ+AWM0Y1r3+i78mXfQBr9yaQMTU
	 fw3PH0ByiCTkJZL6xvafI0/Zyl3fKDdoAbTSPctw4If+pFHGxiVbGee9KWaKlXo0e1
	 6VJ13eKdGROA34cUpAhBBt4Xb9B9arIUfdrGYEUHeN7vBg8FpZ16qSu90MW+jINSoE
	 2nK05e6x/oz2g==
Date: Thu, 10 Jul 2025 18:37:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
	ben.copeland@linaro.org, leon@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-ID: <aHBcr3Nw5UWrYy1B@kbusch-mbp>
References: <20250707125223.3022531-1-hch@lst.de>
 <m72dvfp7wmycwghaaa65zs5adkzylsdtnk4smp7rdfgrsdw443@ry2laobzym7d>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m72dvfp7wmycwghaaa65zs5adkzylsdtnk4smp7rdfgrsdw443@ry2laobzym7d>

On Fri, Jul 11, 2025 at 02:25:12AM +0200, Klara Modin wrote:
> This patch seems to introduce a memory leak, causing the slab to grow
> continuously. The easiest way I found to trigger it is along the lines
> of
> 
> # dd if=/dev/nvme0n1 of=/dev/null bs=8M

Doh! Thank you for the report, I appreciate notification for regressions
on the -next branches. I'll look into it tomorrow if hch doesn't beat me
to it.
