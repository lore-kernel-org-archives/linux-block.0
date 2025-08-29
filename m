Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18030334388
	for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485585; cv=none; b=NeWEGV/Ye/fiAnLYy8Lq+V6JQd5jqkUsA1b1Y7Lw7xcvaEEibNLKoqXcZKyYA/WtM/9Ziz8tXqoZJV/mym4J/gedWR6OJh2iArFYvCQny9HstKrt+u8QMI0HyoglRufyMtZU8uicfOpEiBNpoz+VFjf7+cw7eftUtPjqsfRq5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485585; c=relaxed/simple;
	bh=lNe1kBFUX9AIcyQFrc1QEWqNZish7dXC8+8SQkdgB1A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZyWsEDOUHOxoQcs+tEq+dzmmoF3Yjma+0kTe+64ngQtd9gPozKgBPcFIItYvDQn9NzRtKM2BwfTuRrYqmHFUPa1+HRp6kASusblYykk2Zy9lfAMKiypiI2AWskEJ3pFog8MBWeUrLgZLYud1QBffp8d9oqnu12JHPZ08ASgvw68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOtOcniM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOtOcniM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2D8C4CEF0;
	Fri, 29 Aug 2025 16:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485585;
	bh=lNe1kBFUX9AIcyQFrc1QEWqNZish7dXC8+8SQkdgB1A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kOtOcniMDwXu3+WjVlTKBoM/W1jk5Re/+54lyawmdtByl/fn26Ge0nNJXeiCuz0AI
	 J+cW/TVMzmZlkwqT4KuaZ2pfiG6F8Rl/nkFifd47GyxSKC1QzWsC2Ee5jVDY8dJyWP
	 d0/obbSmHexvFO88OTlLY0voEGP+S6AsDLDhCjhb3bzA+1Rj8kRRWXF/UzWsiA2GCY
	 VSy5Wpx0M9g/mqW1pxbv0m0LrwgKbtvHarVmh1o12WuISrZqPApz5LckjG95JmMgYv
	 vpB1oD0gq4m1A5dW0KMufNFdyUVXONz9MF+o8S+/G9zSvdzWNjTqafvIwixeCJLp2u
	 Gqpgh82TdPXvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB24B383BF75;
	Fri, 29 Aug 2025 16:39:52 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.17-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <42115c00-7422-4c51-9d2b-5296bd462c27@kernel.dk>
References: <42115c00-7422-4c51-9d2b-5296bd462c27@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <42115c00-7422-4c51-9d2b-5296bd462c27@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.17-20250828
X-PR-Tracked-Commit-Id: 95a7c5000956f939b86d8b00b8e6b8345f4a9b65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1cf752d58d59f9222389c14d67951da8e7fbd2b
Message-Id: <175648559162.2275621.10847076043749500335.pr-tracker-bot@kernel.org>
Date: Fri, 29 Aug 2025 16:39:51 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Aug 2025 19:27:53 -0600:

> git://git.kernel.dk/linux.git tags/block-6.17-20250828

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1cf752d58d59f9222389c14d67951da8e7fbd2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
