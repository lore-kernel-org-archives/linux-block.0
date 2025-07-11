Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DDC2F1FE2
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255872; cv=none; b=H5IMevsl0vWJcoxvWef9tLoYMX+sY5Ae6Ecs844UBGG79X9+4OWWsORc/wQMYK9lEFpEUwgEHP+6MQFHwu2kJx8eciYlEcGnUZjAhYa/rExHk3d5EAmuom+OKV+vPhKVds6OcCYVUhQ8E/pmNiwaA2dLLbE5tGh9Z4tEBw+3bcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255872; c=relaxed/simple;
	bh=1NwjKJa+TRo4OmRmF6Ch6gbKcRdVbapmpyqxTB+PN6c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zg7cY5j7iuR7lO0742RwUOrMvCGqqKovPecbKuO38ISzmGLRt53kigFzFdDNetVHoS/7RNsOwcYt9me9GmL8edMyeHMh6641sf7VsyJqh5pIgSdgU248LhQS6z5pCGAQwRYfxEwJfFcczPktE6hhyeiTYcqKD34SV4TDOTraEFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNMfxs/B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNMfxs/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FE3C4CEED;
	Fri, 11 Jul 2025 17:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752255872;
	bh=1NwjKJa+TRo4OmRmF6Ch6gbKcRdVbapmpyqxTB+PN6c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LNMfxs/Bsno4LRQRzmI3yhJ3T3GmE00EvfegXtAfZj5W3Mh/0xbUPnefhra9FjMrr
	 47PpcpRoNCeQt671CHHDRTI6N6o05c1iHYQzJ9WmD350vWGQw8HASkv1/YXCYlLASD
	 5QKF3levzdAEBY56ippOSUEHdDc1u/xWQX5ykfVVO50oVtikXrh/Wi//TcgEkM3Ykv
	 wzAyA85CBF0C7MuT3OoVc8iShfiLPpoIaBBk/DH0SBK7lzb8v4U70IMEwxD8lW6d7v
	 kDKn5NFDOyaMHsspH5ajGy9RdjX/aFJZBHKCd59T+FfmkU3Fv3rQ/2M4iOS91bu9LC
	 FpqKenbjtUXyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BCD383B275;
	Fri, 11 Jul 2025 17:44:55 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <623d3918-3595-42ce-8d47-6d232a94a277@kernel.dk>
References: <623d3918-3595-42ce-8d47-6d232a94a277@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <623d3918-3595-42ce-8d47-6d232a94a277@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.16-20250710
X-PR-Tracked-Commit-Id: 4cdf1bdd45ac78a088773722f009883af30ad318
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40f92e79b0aabbf3575e371f9054657a421a3e79
Message-Id: <175225589418.2350666.11043145796133678587.pr-tracker-bot@kernel.org>
Date: Fri, 11 Jul 2025 17:44:54 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Jul 2025 07:47:55 -0600:

> git://git.kernel.dk/linux.git tags/block-6.16-20250710

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40f92e79b0aabbf3575e371f9054657a421a3e79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
