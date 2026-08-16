Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E7336885
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901364; cv=none; b=abk5cPnpc1uWfY2vRcVfwYNo9OrNXF6VW4O4mg/KV0JsZzLYIRkTBLHS19XI9C1MWvmKxvUCz4Rl5CP3wYTNRmZPtg0xIv6uP3YJRzYg1EBrW5kqbtk7wnOaKXV1LbrkpSqgYya+nITB7QoqComZWvA42EFTEkOhLnDxGvghx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901364; c=relaxed/simple;
	bh=fDx6ZQxZXkp++/S275qIb2TDDbvEb7LBE6gb/p+slpM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YwaRoyR1dBDlpjk3VAEcayLWhtEcgCoXM+EG+O400lQVXBbzpiWp6xIrjZjDYM1sProH7NQEm05KvgQbdSGsNwHFGK0XJRfeASOLa5Oa2ai33bd0c/ZSr6jGnidsd2E5qcvKlkSOupO9ZV0php/GjmKM3NO9b4W1uOHwkKHAN0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/ZYiH2J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/ZYiH2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AF91F000E9;
	Sun, 16 Aug 2026 17:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786901362;
	bh=N5fVu/WBXvwJeddxS6l+SDyexWHUqCTYW+8CeWwWRww=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=j/ZYiH2JGV+Bb3CE/rN929+uEFvaA9KhdpUpDBh0ZI0rOs5fhLet7WFdBvk400k2A
	 wlHzb95VKr1dQuKlEYUuw/mYhBc6GUZ9D+WrKrxfWBAj97w1hX61z881jKP0T/uIDU
	 upQaLCQTcuF7hSVt1FwSQSrKHpjkt0UaJ3Ja2QM4o+9HHfTzZgcvN03V9CuLmod1ZV
	 lSMf8WqvHIy/QPS9qb3tuz1LihJcBPfc9RvnBQQlIPbp+WtlOfSgLPDPvTjznJpzsV
	 rggbHeK7h6XLrdb/XEoCdGK2zhquuckx13P/lUDG6tpKWpZHN66E+ihW9j8WhG8/xO
	 kkPG2phkgN6/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09033924FCC;
	Sun, 16 Aug 2026 17:28:36 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 7.2-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <503e7149-b7d0-45db-b1cf-258c02898518@kernel.dk>
References: <503e7149-b7d0-45db-b1cf-258c02898518@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <503e7149-b7d0-45db-b1cf-258c02898518@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260815
X-PR-Tracked-Commit-Id: c71bf113dfdf426bdaf106636f573ef87b6613a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcb68831eac76dbfda1cf5930d3003d938890d34
Message-Id: <178690131542.334594.236862388254397988.pr-tracker-bot@kernel.org>
Date: Sun, 16 Aug 2026 17:28:35 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Aug 2026 21:03:29 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260815

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcb68831eac76dbfda1cf5930d3003d938890d34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
