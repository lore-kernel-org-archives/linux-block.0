Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82848258CD8
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741386580; cv=none; b=p1sX5uJKDXU3eAntbB1DcZwxsjFSMXx3c0QmYwPMF0zz0anRaOjL2zM+QYR2VCWztNv8F2atITsJ8rBdkLssFQUDBYHpfmvETYGQX9rb41V+mV+mftcpyz8/vPPIkwxsiQNvP9eoEKA3jMk8uUBD1sZCt6A55hstShQtqLfYNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741386580; c=relaxed/simple;
	bh=80z6Bvh7lHjuld7IJa7sRLnWbvWHCgadNYsxrlXAQjQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ul8nZnxDlQC4sOJAHE092b/WVIN8vexMal1PnRLVDWDe11gL4S9QLEVa3o0XjeYTjjmO+khsy2wpSLo8zb2Yq2ddmGPGEybd1mXxbo3ZiqjskSyygHrE71LgD49rGib2JBG986bZbp+cnWUOvJNJ1incuBkPLXt3DHlmSIEbnTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID61bMRl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID61bMRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65707C4CED1;
	Fri,  7 Mar 2025 22:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741386580;
	bh=80z6Bvh7lHjuld7IJa7sRLnWbvWHCgadNYsxrlXAQjQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ID61bMRlTWPckJcwPJLClsz1vH8NKwGyozaMZzTrhdJNvlN+u/Cz4j8k7m60Npt74
	 YeIKi7JexhLE1VAZlebp7Z9RZ13STKzrBExvWP1SFrSU4aSWeE8RpzO7pCwQ0vnyMS
	 JvwGhR7+e+YRiXZAWiMePvgNtqott+qCoAbOEkbC65z1ORvlBuL6R4FYI5y0UaI3HM
	 ZSoez16yeiJ/gAVMkrzel0gf2SXG9pyve+SOlPpTq0tnTsKa4q/zESlV3dwjxVF0HM
	 +zMvUVlrr3X8oakQcz+8rNkxRUvistpl38sd+K+mPgevlaGnGiwRUtqY5q/GaIeJPV
	 52GivRVmj3mQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B89380CFD7;
	Fri,  7 Mar 2025 22:30:15 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <d14d2623-6d7c-46fd-865b-c2334439eee8@kernel.dk>
References: <d14d2623-6d7c-46fd-865b-c2334439eee8@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d14d2623-6d7c-46fd-865b-c2334439eee8@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.14-20250306
X-PR-Tracked-Commit-Id: e7112524e5e885181cc5ae4d258f33b9dbe0b907
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 381af8d9f484c06d93e4a0b8459526e779b35a65
Message-Id: <174138661371.2506268.5199743679159636789.pr-tracker-bot@kernel.org>
Date: Fri, 07 Mar 2025 22:30:13 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Mar 2025 07:25:59 -0700:

> git://git.kernel.dk/linux.git tags/block-6.14-20250306

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/381af8d9f484c06d93e4a0b8459526e779b35a65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
