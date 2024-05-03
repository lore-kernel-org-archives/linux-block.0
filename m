Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F89156860
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754463; cv=none; b=pD1mPLVxPesT9nviU6uss702leZSjEC0lcd99SHi6lpYCZ+Gqom/RRtPsOuiPmnXgoQgXgcbItVI5u/Wxb6kcQ+K79IJ3nAsQ1NLREToK2CX8m0IWXSp/SsjGErUYNG3XqhT3DnoTDpIlDCYkapU9R5CZbFDwP9u/DgjiLnZ5VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754463; c=relaxed/simple;
	bh=VYR1kCBG4rPyC3lb5xAvPApwQp7X0JAE0HBsShakQmw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=h63z4zm2cgA8KOBgSJKc4pR9C8GbYy1HNPtjVBT3iyQczLepxmVE444iY4EVpTK9dTzPSY8ka6NXUEbfvpsbHb1nqXUH/1kdTZCCRM8jAyTl1I3Lup6xinycyitDmg7vhpIhCg3fbkWaM1VERYvYdPwtCaDh8gYcWM92+X0XAgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AthFLO12; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AthFLO12"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4C6BC116B1;
	Fri,  3 May 2024 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714754462;
	bh=VYR1kCBG4rPyC3lb5xAvPApwQp7X0JAE0HBsShakQmw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AthFLO12SzVAczRjLgMdZUFwUbkNTFliSvGBKdkVQuPMHCS9H7+B/zguiJsy2zjRR
	 acklIhPFf2OVWcnE1tNVtTvcxnRBax9NR+elvxatOkwA6F7q6wvu2wTCYYqJYzDEDQ
	 4YrjbSw6wwHYv91j6xx8x/0Z1U85S2KrvHaDN5QrDsMMkTdhHxCa6Rfh8NTWtD6ytd
	 N8nUWdnbqsLuF4Dsesy2ycChOrUn8ZTcTxL0+AVKu7v+GXNsyVrmN6QINzhxxqDvmx
	 JDVsM/WmFrOxD5sa6mVAUL/orJeYAboL3QXZpWVG1K+nPtF9J0IntFcrb2j6jzooGk
	 ZrZbDWOb3Evnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC937C4339F;
	Fri,  3 May 2024 16:41:02 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <442223dc-d734-4c8e-abf8-1e89e92eb1ec@kernel.dk>
References: <442223dc-d734-4c8e-abf8-1e89e92eb1ec@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <442223dc-d734-4c8e-abf8-1e89e92eb1ec@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.9-20240503
X-PR-Tracked-Commit-Id: fb15ffd06115047689d05897510b423f9d144461
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d25a941ea5013b552b96330c83052ccace73a48
Message-Id: <171475446282.17709.4520862373498520018.pr-tracker-bot@kernel.org>
Date: Fri, 03 May 2024 16:41:02 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 May 2024 08:30:18 -0600:

> git://git.kernel.dk/linux.git tags/block-6.9-20240503

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d25a941ea5013b552b96330c83052ccace73a48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
