Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743AE53804
	for <linux-block@vger.kernel.org>; Sat, 14 Dec 2024 01:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734140135; cv=none; b=hziGKvX5/fDWTJm8OGHMfL+w4BQ43l2sGW+0mFMEu2UTh1YpZNhhdCgUXKJkjoaQyLMo3H2fUZeC5VXuoYfR5U27W+c2poUyJSLR3GDGLzpobMwI3JOzeoareHaTtjT5mv6q0DxaagE1eQsa6Ry+MO4tq/pwuM7sw3jAtkbrHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734140135; c=relaxed/simple;
	bh=bNiPAInGaG43TVxzVL4mpXvIgsSU+8Hs10gXSy5WstY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NI21n2joOw8oR7GGWh+COQqqmjHSqepqEDdXeToaJATUFBDoiUz4DnrwnLfSEbm/hEWjqc3ICIC3vuoHC4SeauD7lKdTZCNMBG7FjEbyYXEqZTsUZjl7/7M63yhiVp1WBNPA1tDDkO2SSiA8gdCsHd7kpfrZKHckSg+rC0dZFaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLNyTzfW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLNyTzfW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3821AC4CED6;
	Sat, 14 Dec 2024 01:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734140135;
	bh=bNiPAInGaG43TVxzVL4mpXvIgsSU+8Hs10gXSy5WstY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HLNyTzfWwMFmOAMAFmHnqIJlD+zXhSUtaCMBX8Z7daOmoRcMqFOJM7lCNR0RP3MIX
	 GjcuyEiEqY629lZDv60sadFs/t4GF1qxkEDvqPzvP2nSfwXvEMSVY8tKsIU8IlGB7x
	 Le2mBRoVtcQ3oakWXTyl0Z93c67nZ254vDbzlfx3XiSoFKmTl+/BLBiPcTiUB8v/P/
	 Ql+h/sx8i8fvaPfiVlh+L/8w0hXDQYHbNMA794g2OsNtcVZs3YB5qQe+e7ksH4D9DS
	 tCezrkPQeRy3JdHrJ2hDH+bjoAl7FcQ8x/xcXwCfi6cFsToqIC8lfVR3w8+tVpIs7y
	 MajrqWBhrSyXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE01380A959;
	Sat, 14 Dec 2024 01:35:52 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <d2acd3cb-188c-4ad5-91db-efbc6e50a1c1@kernel.dk>
References: <d2acd3cb-188c-4ad5-91db-efbc6e50a1c1@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d2acd3cb-188c-4ad5-91db-efbc6e50a1c1@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.13-20241213
X-PR-Tracked-Commit-Id: be26ba96421ab0a8fa2055ccf7db7832a13c44d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c30c65f3fe3506e8838c3eb64b4b5f48b667a131
Message-Id: <173414015154.3218065.1285464758471824697.pr-tracker-bot@kernel.org>
Date: Sat, 14 Dec 2024 01:35:51 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Dec 2024 13:48:38 -0700:

> git://git.kernel.dk/linux.git tags/block-6.13-20241213

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c30c65f3fe3506e8838c3eb64b4b5f48b667a131

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
