Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF492E1EE5
	for <linux-block@vger.kernel.org>; Tue, 10 Feb 2026 02:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770691424; cv=none; b=EoMqh0tgN9YEi68DMT0IiqDeULGdAjQufMcztacokQ74GmYGl4hk9giov88aFKbWG8ebed909Ts80q1IFaFn5A7RxWMs/XxvPJq9YAV4WbKA1WnigYZLPHqrRfw55A/Y8jbLnv8gfQFQX5nYhnCuM8GfWzYhIRvrzD7ZVOJpU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770691424; c=relaxed/simple;
	bh=qg9r/dbaPmSSXY/7emPsj3ltsPLGrqhXYpj6bDkpEyo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VmRXhEc5B0lPxd4fddE5yi0SyoLLGSYLk8dL+GpqhxyXLIw2i1+o3WJdyy2agCej7jzB755Qxl66HzssMC/2Kd6fWRV9us3xJUqrODpSrFWZpiF5JBlmWoEg95pTiv79B64PD/96Pekaits6/fjlNuVceozYXEYWR0uK4zoWWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eH+jpDNa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eH+jpDNa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C736C116C6;
	Tue, 10 Feb 2026 02:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770691424;
	bh=qg9r/dbaPmSSXY/7emPsj3ltsPLGrqhXYpj6bDkpEyo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eH+jpDNa+NJdKB69H2cw9mu8FGEJ4/+AoEDErW2acHpyoENN3R8uDPn2Bj/poDI5I
	 BKWIhxTYpJzlTeLIHIaJs0O3uoA0SJH+mGJ7AiGc7pfHy1panm7GfjwZOmINc64XIt
	 ACUHiNyR3/xWnCMmLhRwfYTB2l9+HBsJ5uswCUimia7UNfxFcFGlbSeCUEBZJiNrb/
	 S4jctnzo+NmAxZEjcml1i0C0v+tVs3jMSuNebE6Tsuaoa2GaXVoCOu7k8idtBaJpLv
	 FHGycOiLmrq1Ge4konfJIdzEDEZwcn+CNMSXGFFg3xh4yRvPu5dwJVFI+wLRLSsk3E
	 XK+Pukm0mWbuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0AE7F380AA4F;
	Tue, 10 Feb 2026 02:43:41 +0000 (UTC)
Subject: Re: [GIT PULL] Bounce buffer dio for stable pages
From: pr-tracker-bot@kernel.org
In-Reply-To: <123a2a6f-7ab2-4ffa-82aa-7599d261da0a@kernel.dk>
References: <123a2a6f-7ab2-4ffa-82aa-7599d261da0a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <123a2a6f-7ab2-4ffa-82aa-7599d261da0a@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.0/block-stable-pages-20260206
X-PR-Tracked-Commit-Id: 3373503df025ab6c9a8ad2ce6b7febd2eb3c99dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4adc13ed7c281c16152a700e47b65d17de07321a
Message-Id: <177069141961.3309876.5932902681041926575.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 02:43:39 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Feb 2026 12:30:19 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.0/block-stable-pages-20260206

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4adc13ed7c281c16152a700e47b65d17de07321a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
