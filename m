Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638FC1CF5E2
	for <linux-block@vger.kernel.org>; Fri,  7 Feb 2025 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738967150; cv=none; b=em/SNNSncaZJyUF9LCkXPVIb2CYFD1VwIQBp7qCN5uNSy0vyKjXApIMgZdhZohCslGNgnJsMPbDorqUXtjMJaPMuHdBO2+jN3IWUJ+iKkvqnFA+24AisfTeG4sgqrRlU1wOuUfIwGFRYfN3HDLnBnAKx/E44wmsnGXV544ZApTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738967150; c=relaxed/simple;
	bh=EFcZXq4u+cxXBflN4YtUjgB5C1BnRkMdzfgX+ZlX7cY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lwIJ8CVwcB2cyweOmdRRM0+IGXau31f6yIY+rj4R9QnzT9izagDqoA1IRxLtsSRzhKi4imCZBTmGQH6ltl4wc5x7MS8IqS/LxFVKWjWxnu6rWlbhbaIMgdyT5QCklQ6WuSNgoIn5VHUWXTUASJZu147zvGaWG8eg+kP4DFOHgz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV1dvybt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV1dvybt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A64C4CED1;
	Fri,  7 Feb 2025 22:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738967150;
	bh=EFcZXq4u+cxXBflN4YtUjgB5C1BnRkMdzfgX+ZlX7cY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GV1dvybt6kEEFtoBhMIZbMbcXVivev+7nJpoxtNFCYytnL8dgddE6Eg1D0cBLSvki
	 z+nn9gXwcZox8AjbQj8vR8BlB4UV7bjizUw2SdEI0iISrcqHgqjT015EwXG/UmmZkc
	 4Jv53g4BYSaBgcZu985I59jCNsjvnJLcsmE2jTFfVLAi1VbSJqII9VtqF1V39WmWyF
	 Gc3U1CQkhuTTVj6ftW4i3eyhJqrcvMbq1m6QNtQkmfdskS6w5PrIbBLVLzBWPpEmlR
	 KwPfuQhQxwrZab/38fa6lSMLHOhUv/WE0qEunLYtHLR/MUZdO0MCjyR7RzF4e9dqbk
	 /7jJsFKQjdJHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71421380AAEB;
	Fri,  7 Feb 2025 22:26:19 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.14-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <1abded6e-1d80-4876-ae7d-7e575959ba25@kernel.dk>
References: <1abded6e-1d80-4876-ae7d-7e575959ba25@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1abded6e-1d80-4876-ae7d-7e575959ba25@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.14-20250207
X-PR-Tracked-Commit-Id: 96b531f9bb0da924299d1850bb9b2911f5c0c50a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a67d0a051349d89afe4d5ad4ef85a7d576d69e2a
Message-Id: <173896717800.2405435.8190535072388403783.pr-tracker-bot@kernel.org>
Date: Fri, 07 Feb 2025 22:26:18 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Feb 2025 09:50:25 -0700:

> git://git.kernel.dk/linux.git tags/block-6.14-20250207

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a67d0a051349d89afe4d5ad4ef85a7d576d69e2a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
