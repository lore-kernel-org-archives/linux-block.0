Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DD3548FD
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632217; cv=none; b=LCRo0VjqK1vX1h1nrgpFCu+jkYZUquaWgqh3woXKRIgrLXZWCShn/ZACBQHMquYyDinys/BI99tUxFQTLVrljLN+MEKe6Pj4Ay2VosOdJ73PvgJHDZBbnkaIcqfFCuOBvjyGTSo1nAfjRuF7nC8LPBH1adkop5U7CmPxroT+r3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632217; c=relaxed/simple;
	bh=Hxd9mm2h1IQHah8v0Fw0MTHm2RdgDRxOycRWSJpBQSE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TZm5qa/OxCLixTLr0XCth4ShxUZ0Zfoa72pu61yFUl3e3flXSKB25EvKerEfcq097sybuqaYauJdj99nz+W9v65p12ZxVRH9OGMX6RIB8tTkNzWamd/RYSEFqXVWrobZwEaTeQYDhcl4+lAPqr/cn9BJUq2+lWN5URnJlEBQjFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbBFri6v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbBFri6v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D99E8C433C7;
	Thu, 22 Feb 2024 20:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708632216;
	bh=Hxd9mm2h1IQHah8v0Fw0MTHm2RdgDRxOycRWSJpBQSE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NbBFri6vUHEsMphaBBSpKUieDpcrv2ceqUPBX3aDkBvtvFfwEyevb5FLWgNg7VNk4
	 fPdyW4VARnjbOt3RDxUCFuQmCQsHJa68ZtDFcUUzOfgmmnGUg/MaCNmnQBzviJpdAp
	 vSx40NyGUichoMcDVh/lOL6hHF3WDgxR3d0CVTQy7GBhbpuocRlq13kblMeGNBPFsq
	 8wOBLkiLeIJebmD3nDiMybcuva0gudkp4vEdFh9SWAPLsgO/+cLmow3H8z64nPiofC
	 H9krxS/prQGcJjd4dPbsQCsjedyqEU+0+eq6Q3m5yvXuVShXN4Vsjjn6B6iwobKwDr
	 WPWn56OAxa5tQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C840DC04E32;
	Thu, 22 Feb 2024 20:03:36 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.8-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <a9ffa3a2-2b49-409a-a256-a70f8f38b8e5@kernel.dk>
References: <a9ffa3a2-2b49-409a-a256-a70f8f38b8e5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <a9ffa3a2-2b49-409a-a256-a70f8f38b8e5@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.8-2024-02-22
X-PR-Tracked-Commit-Id: 5429c8de56f6b2bd8f537df3a1e04e67b9c04282
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffd2cb6b718e189e7e2d5d0c19c25611f92e061a
Message-Id: <170863221681.18444.5264527444355130334.pr-tracker-bot@kernel.org>
Date: Thu, 22 Feb 2024 20:03:36 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 22 Feb 2024 10:46:14 -0700:

> git://git.kernel.dk/linux.git tags/block-6.8-2024-02-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffd2cb6b718e189e7e2d5d0c19c25611f92e061a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
