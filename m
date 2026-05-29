Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB7348C4A
	for <linux-block@vger.kernel.org>; Fri, 29 May 2026 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085615; cv=none; b=Ve5NL91oO+ok0Sy47RtWymP6lrqL8aqC68RECEKP2jqJ03CsanYqrTjwc/zj967dpgX11uEBh3xDMkVCWlbs8rDI/Ukn1R3t3liJqaUlbnoWYtE3ROC9bxEpX3CSX6N6th2DjQIUSPXD5DOwUCXxH+bACPAxhkmvsda+W9WDiMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085615; c=relaxed/simple;
	bh=43GwVi+ZyNL8+wT2jSmbD+UB3vq5XdQyAz55Evfs7Pw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=F25n1CLKiXS2AoVtFNCz10bOtHNDNFcWnPBJSZP6QCW55LZRt7oXqYl8atyTly0gO8CZUchPKdqJbotpjf73yczbApwS3mjjRcFEmE1DvSFKvE8bcX0N6QTBzai7MeTySVR7VG9xxTPMUu93MGGrL/J9mreS/QE3f9JSLPvimaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzLPkVI1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzLPkVI1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E588E1F00898;
	Fri, 29 May 2026 20:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780085614;
	bh=dvqTVHBnQhiXm4Bkh82NNdEmPQrYUBcg7ivnGdF4zPA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=mzLPkVI1uU1Ilqy9edeS4hBhvVgUd4zHw2PapWeTVJxGnPJKZs8fFrqC119AmjyVA
	 7dPGGqEhcoQEUbKKv/rC4EsQgpTiAbV+95/REuKerfFlXBnUcntAsL8Jd9m6VXUTRb
	 5oJkwg9JHgpxOKJ2UFMxtF8cjFx15a8e1dGtYJL+ntLMWGAzp1nsr9sr5XNBFuC68t
	 +w3Kxg5GcalBQ4JQp3KX3vc6CeQ8u8hh1zhCmQwBn+eFTkfF16Bx3/t6NZE8ojhptJ
	 VIEy81/N5OfNm0nG67fW8Y0gKF4J6BVWS77jUCd92eePAkaz39500Q0xOqqSWv91TK
	 5aSnj2+6ztcuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C9039301A0;
	Fri, 29 May 2026 20:13:39 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 7.1-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <d12b120e-0628-4d5c-a36a-7618f752250d@kernel.dk>
References: <d12b120e-0628-4d5c-a36a-7618f752250d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d12b120e-0628-4d5c-a36a-7618f752250d@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git block-7.1-20260529
X-PR-Tracked-Commit-Id: b051bb6bf0a231117036aa607cadf55be8e63910
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9215e74f228f2b239f41271da9e5076ee3439d1b
Message-Id: <178008561841.1949175.3759745061562899932.pr-tracker-bot@kernel.org>
Date: Fri, 29 May 2026 20:13:38 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 May 2026 11:03:35 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git block-7.1-20260529

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9215e74f228f2b239f41271da9e5076ee3439d1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
