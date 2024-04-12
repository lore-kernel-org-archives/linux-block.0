Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FC1446BD
	for <linux-block@vger.kernel.org>; Fri, 12 Apr 2024 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943921; cv=none; b=jKr+L1LcpJTWg0WnaXB8Be0J99k4xmfTx9+fXrKJmDe0wT2BoHD082Dsvw46tjD+nXYin+a5vkuOYtV2jPfN4aJQShiP+ctgm2lUozVs/1RxgF/FEZaEUnG/wstbFS5cbb8Sybh5mVHpv0H3VpX5D3u9MHSzSCssmsitF4+vVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943921; c=relaxed/simple;
	bh=L/l7BmkPhINJ5X1eK8VWMPIpJRr5euRySSxDRWHB+DM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=exx9aGuWj/6E3alfWURs27PyEgMXvmr2jXgVbW17c95y2NHyOKiJaTW9l8alzeRSsF3shUSHQ+ENZFS1PiooHZz23V28R5Bhfp70lSy3KESh5k+TupjPj8RDjAfQQ/9x17Pg9ThLoPy4JoSTMphXGcmFKDvrFJsYwypo5O2hCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1NnonY3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1NnonY3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8580C113CC;
	Fri, 12 Apr 2024 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712943921;
	bh=L/l7BmkPhINJ5X1eK8VWMPIpJRr5euRySSxDRWHB+DM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t1NnonY3t/sqW5FidAw2zTIrP5yY1Fx/FT148Ei5VXpTuKlbFkuRNAEy0DkJFnnq2
	 zsLRIjkgF2TOabJkoH4EiYswwT7jl6/FlQx2yjrQ41G5aUB0ZNJqfQ+V5DnIlqL4sH
	 AN3/Z7dX5Jilr9v86FlUpV702fgSGGcRQMnhQVaA2OJLhSZo1XQMNGhhtOkiYvjsPU
	 x5o3PZEnwGfX+4rgVX3BVdFgwbvjdaoWqzBKxCUquEDZ50oCnt0guJGlf+e1AVvhGr
	 PgooekfFz7+zvK+E9kybFQWaXgTWVJHm5xFnBovU8QZSbi4Yq04idKwyLO4QEZ0e2H
	 i6XmfnoT3ukGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEB83DF7857;
	Fri, 12 Apr 2024 17:45:21 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <6c52c906-677d-43de-b5bd-a0a213097de2@kernel.dk>
References: <6c52c906-677d-43de-b5bd-a0a213097de2@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <6c52c906-677d-43de-b5bd-a0a213097de2@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.9-20240412
X-PR-Tracked-Commit-Id: 3ec4848913d695245716ea45ca4872d9dff097a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7ad0581567927c433918bb5f06f3d29f89807d3
Message-Id: <171294392170.29341.13334372802964910923.pr-tracker-bot@kernel.org>
Date: Fri, 12 Apr 2024 17:45:21 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Apr 2024 10:48:20 -0600:

> git://git.kernel.dk/linux.git tags/block-6.9-20240412

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7ad0581567927c433918bb5f06f3d29f89807d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
