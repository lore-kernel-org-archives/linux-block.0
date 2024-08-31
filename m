Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12CE2E630
	for <linux-block@vger.kernel.org>; Sat, 31 Aug 2024 04:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725077510; cv=none; b=XAwHiFFB2lDn5z6YplBmywVR3EM3URHU8PQ+bsLqzKahR32c4menKA1DKF03dRscYEKgkEBQ7XSqUMuTxUhAtgRAD52p61EBWfdt5S6Zvoua0FY9QiPqG7lGrvSPRl63DPcjT7MUHVosOtIQsMUPL+El9KZfREHmMMMgq5IGXlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725077510; c=relaxed/simple;
	bh=i0DkENfCUD8O/aTlhCIMwQl1h1XxgWqsixMTi2S1Dw4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mCt7Cf6EjmbtPuDlk2dTBpsHz/6n+Eog29YDLsWKAYUckXvo7+vwc1tcRAcmR2widJY3PL2gqrGvsDgqZW7D60iU0DHAXlxCjZ3eggXODyy+Tv2HHDBxJ2PGqCQWe5IbGhGb18mQNj9urDSHfXXzfYDDJ5ceoegoat70860fBFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFx+zeD+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFx+zeD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF97C4CEC0;
	Sat, 31 Aug 2024 04:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725077509;
	bh=i0DkENfCUD8O/aTlhCIMwQl1h1XxgWqsixMTi2S1Dw4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tFx+zeD+vT3kityYxPSYMmXt9ZHInZxIYg9OUbaCdkBaY2pitrR7E3Y7kMk4xm14z
	 i+MDNbXtQqFEFt3iV5PiEnSQADkMnQWCyBKHZ5jcm92jg6YKH+BQKb6rDwUtJJ0QOF
	 sMV9D+hOLetESe2SYw4y+kmAiOKiTv72Xk/eVprpTRlR0bFyUswYq30Vw4Vat/bl+u
	 D0si3IJuHcQwBIsZup/p3rfcddJlK0ci7+jg/Rm2VNzqV+vaLuI6dIXjKGEI7O7zZM
	 t7HWo/NA1WZRKXUM2g8BK3noPG/Xb3/IXBU4bnR3oSWFYhAM9hG92ZnBXUYYWI5mNJ
	 5xpZfG/rceAbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71AE83809A80;
	Sat, 31 Aug 2024 04:11:51 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <8b25d5f6-6235-44d0-843e-e954729a105b@kernel.dk>
References: <8b25d5f6-6235-44d0-843e-e954729a105b@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8b25d5f6-6235-44d0-843e-e954729a105b@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.11-20240830
X-PR-Tracked-Commit-Id: e33a97a830b230b79a98dbbb4121d4741a2be619
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 216d163165a937ee9c1d0e9c26fe7a6f7d27ac4c
Message-Id: <172507751002.2790816.3639216203064050834.pr-tracker-bot@kernel.org>
Date: Sat, 31 Aug 2024 04:11:50 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 Aug 2024 14:33:11 -0600:

> git://git.kernel.dk/linux.git tags/block-6.11-20240830

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/216d163165a937ee9c1d0e9c26fe7a6f7d27ac4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
