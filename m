Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611E30FC0F
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765534287; cv=none; b=UDXEquz07AR2ERJDR3ZvLPHDFSjHepSpym4qjJa/U/vYVupwpajqpvHGLOKiqHKmoC9bqejMep1GsJTa6Kz0yJXc8KquO6XhErfYrjZc4f+G8TAOc77TEnX+JsKfTdCB3vED3Ot3AggyZwhEzDnLsTtApmo1Jrtby/DXqs/NaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765534287; c=relaxed/simple;
	bh=KfooV+l75JgHT2C1FJTPxziNy7F7hb1nf6Cvio3JLno=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tytRor8gfh7CXL6Plpo6ZT6Gf0EQls65h6R3zb1exrPAGWMkGQz1oN2OTmuFYz449EnajU6Mxz5CRpsH0WBRGEl3J6V52rabZ08zh4FVCHYMqCCK4nViata8aiFONYW6Dd03du1eMOh243MxdgAr33ld/q6tSQAQHEh/JwvlDTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khnQzmVG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khnQzmVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21494C4CEF1;
	Fri, 12 Dec 2025 10:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765534287;
	bh=KfooV+l75JgHT2C1FJTPxziNy7F7hb1nf6Cvio3JLno=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=khnQzmVGWX0zdeQhr4w1QpsiyjSyHJo7XpMt9TjsqYERXY2QXBWanmrEJUUJbG0QB
	 E+BfbpMYY6Ue9mXbnEK1tZeJwZCWLDHJYnLdgtN38iWcckYjN8ZKpVHQ58MuDw47Wm
	 queyNb1dV9mskaKgNjmJZC363gFb5/zbPhtlJaB7BNEdvSlv3j0KBwkRpakre1FWKM
	 9rkrVJBLC8smiBkcd8DwUTFugRCswUwaJPron+7/fv3qWI9YgIVT3izGQmgcZtg7od
	 6dYIVZeB1w4fzdG/tzvircWK3jSY6i7dRVltjUDDB7LIOoRvWn4FFnhDkhqndsosRY
	 ey04cQB57r6Lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5B883809A90;
	Fri, 12 Dec 2025 10:08:21 +0000 (UTC)
Subject: Re: [GIT PULL] Final block fixes for 6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <3d7381eb-9258-4743-86b3-5f4cfdab06d7@kernel.dk>
References: <3d7381eb-9258-4743-86b3-5f4cfdab06d7@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <3d7381eb-9258-4743-86b3-5f4cfdab06d7@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20251211
X-PR-Tracked-Commit-Id: a0750fae73c55112ea11a4867bee40f11e679405
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35ebee7e720944a66befb5899c72ce1e01dfa44e
Message-Id: <176553410023.2108206.767104062264951725.pr-tracker-bot@kernel.org>
Date: Fri, 12 Dec 2025 10:08:20 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Dec 2025 15:45:32 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20251211

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35ebee7e720944a66befb5899c72ce1e01dfa44e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
