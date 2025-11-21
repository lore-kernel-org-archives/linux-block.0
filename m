Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2622FAC16
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752852; cv=none; b=i1uJnbrRb0/PJBMxZES4vXCresHAtEYOb+LWN+2bHSJiK8ARowdajZTWODHn50Z9pCVb3fJMmqdGWO/9Nk7UcZ++fq1PKUIOaLMGoR3gnwaQc/61IkR2QLCYIjTO53Wncz1U0cs9edj5ZrvMcNgeuiwEW4sk9P3EqdNJSthYjLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752852; c=relaxed/simple;
	bh=gxd97ClACcuPLOeTeMh/j6vRt/qArl0BLClORPvJusA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ElN9UPMAMxGQUv4rciH5vgoxztyYcGGJ7vGaa7B8JfCafoJq7BGgDjpt1aEPyPL8zCzFqquWWjeAZmQPEEzp6TWeP70Rg5ieNuJwTxuxZqTfaa42cz9XcaaM+MMlkp8HnHMvnz8P3fergUg+Kfp/YzIPA9RmwLjBlXkWeOq4wvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2dw2Bpw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2dw2Bpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61046C4CEF1;
	Fri, 21 Nov 2025 19:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763752852;
	bh=gxd97ClACcuPLOeTeMh/j6vRt/qArl0BLClORPvJusA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S2dw2BpwLNNDE8CSh5rYXaai/RzPDE5j7qtbXRGcPFCZM0VpS9p3+2//3f7P+lwle
	 bLA1KEtoEvnpy1aiGf5N6tGil6NOeY600qvyB7vwxiPza9EXsQB4QrN+/AW7/1nanu
	 JHHdPs+QClTzfmfGa5w4liyB2z8dwhZdxTgICXtwRFrEvLVpFSxA6QQRQnSn8RhIiV
	 J6ZuF6gOyyJg8dBN521nykpGadhYTDk75NSznexmRdu4qZPn4pO57Se9yY9796W/uh
	 GxtdGbOzv0RF3pZLY5TEjW0aleldHxpJ0gzrDAPTs1PrHVO1wD35w1X1AaJ71P0owA
	 orx02qMfOkiPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CCC3A78A5F;
	Fri, 21 Nov 2025 19:20:18 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.18-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <fd17309a-fe4d-4862-aa93-e84bf455f639@kernel.dk>
References: <fd17309a-fe4d-4862-aa93-e84bf455f639@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <fd17309a-fe4d-4862-aa93-e84bf455f639@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251120
X-PR-Tracked-Commit-Id: 49c2d5941c89060342c65997de91859e5830dee5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4165ffc835fcf738c2ff41ce8305b04454c07d0
Message-Id: <176375281669.2554018.7917059300981534066.pr-tracker-bot@kernel.org>
Date: Fri, 21 Nov 2025 19:20:16 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Nov 2025 10:37:47 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251120

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4165ffc835fcf738c2ff41ce8305b04454c07d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
