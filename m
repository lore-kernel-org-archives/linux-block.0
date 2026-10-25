Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792887611;
	b=cEnFs1OSQMaH5rWihWfRduMhouAN+Zvbq14KgFuGC0re9kE7L77daIJjJxPYQl9f7Vql
	 R5HyMTAzhPwxcS6MxMDS5WcLwuZHsgx3oX+bQPfqFyipundrYh/NwTNvyOMoR4MLijcTd
	 z5F2/PUBQzu3bIJX4kPiLCHqFD/xZCiLsFmzGKrc9XFgjkA1OEwH+63IoLN9wcC98WfCi
	 qcCIynLDyFTa6R3YVNoBm8qR4E8IeDAF//oG5PeoWCZJOmJTpoX1q0UHU5EwEhnvq6ZOS
	 QLH36FifmhutMVbyxqm22bUs7YytD8vAL78KedMLDFXVTR2r549psfktu25qNuBLONQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792887611;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=t1YQFn0x8nP9hc6SNzB8o8M4BvjBUjche5ZWklFu+uM=;
	b=nLTvBfnlPfMWXn/4mI155Vk6BtBV3SmnFrjRuf28bkl0FZdlUC0ZhBndshehCIRv+jE5
	 rmkvGByqGlH7UylvV8cYW+cJG2t+68TJmCdD2x+AXeL3MkYHPe0f2AtO5JEWqFWVVetyU
	 wP5Z8eE8LGZUPXfOxXabRo0CdOWtS52VJUHbHNhE++1ddWNeJts2YmXlI7U5ul3tugsi7
	 mxAO2fNVZtcwn1v9RWXT7Q3YHHVakkjPUjFUnxgh5Bl5mh/vONxumix1MgIuGmu3ycie/
	 erwbqc9cVKyFFy8DrPdLsGUSgXMFnpFhLuAlb7K++pZ9GxwGvtfApYvTXLykwhg4ilw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmjKMMEr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379A6606A31A
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmjKMMEr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126D31F01825;
	Sun, 25 Oct 2026 00:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792887611;
	bh=t1YQFn0x8nP9hc6SNzB8o8M4BvjBUjche5ZWklFu+uM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=VmjKMMErGecErxxFlq1sZPlOZsq1JmXuyv+I3ZLRTFu9NMFad3OZ3i28YSEp/rtDz
	 yKj4U/fvO41LlHg+U859iREE8w1l/cudrd2ashOYBgp7UxgmJCrLyNvGP6/JfWjQXJ
	 fHqZHcozO+AL0D5pdpD6l9GiY1+2B/o9YXodcDnz4H3WyxM2K2ZvhIKv+cvTM2b9ZC
	 UBWbDmP6Tw588e31YmMbuHCf8XtgtKSc5ZBx5xMmGAhndS9vI+PlbpT3yPHQZRc4uu
	 j45VFXHbhztcsIyIFRVrZF5ebMhtA2IamGMB6A5CMNgLgriNA7toRH7uXBgzD0qvBX
	 hpoIzvP0HoyeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0792C391B1B3;
	Sun, 25 Oct 2026 00:20:11 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 7.4-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <3b7e92f1-77a7-4bf7-a942-83de345bfd1a@kernel.dk>
References: <3b7e92f1-77a7-4bf7-a942-83de345bfd1a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <3b7e92f1-77a7-4bf7-a942-83de345bfd1a@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.4/block-20261021
X-PR-Tracked-Commit-Id: 40d070cbb1906896d6fd65c39722d2411830ed9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b23545529c21737dd7939e86b6f649f06480796d
Message-Id: <179288760967.1837883.10019790159910042896.pr-tracker-bot@kernel.org>
Date: Sun, 25 Oct 2026 00:20:09 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Wed, 21 Oct 2026 08:43:33 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.4/block-20261021

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b23545529c21737dd7939e86b6f649f06480796d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
