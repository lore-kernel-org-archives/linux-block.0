Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7296A17C68
	for <linux-block@vger.kernel.org>; Sat, 11 Jan 2025 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736625658; cv=none; b=DeTbN0ynBr4jXj6ZLbi09E6G6q8PmfXm9IwzKcMtgsc8+hSE2fzpWU8i3qjgqWkWVAL6y9XepW9IVFPonqGvqv9t72nyLFXZgbBSLTnOOHAnv/76Rcaxb4uaAgGGlzggtCgznAnaGo2XBGUOheC4GUwNvHFhyaDzdQDVIk4i3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736625658; c=relaxed/simple;
	bh=j6VGNivdrabXxBP2b3pV+7kN+vCL2f9SYw+lo+7pzE0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qBuLznfaVVWxUx9sXEAEFKRVw6PFHzlJ5bbiVqnD0rMQhZXRIKnLV73qnSSBW1AjQ7U2bGG/NEolnchYIC97htGd/mK/7601yFh5pnrQTay3MM09NENqGHAohGKPWV3imBBRfdUvSmlt7KIOCR3nwEN1HoCdrcePG/CTP/tw8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rt9tgnD5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt9tgnD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5150FC4CED2;
	Sat, 11 Jan 2025 20:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736625658;
	bh=j6VGNivdrabXxBP2b3pV+7kN+vCL2f9SYw+lo+7pzE0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rt9tgnD5FBvBLSsBE8Jiy3Z7DlTrrp9tkWKnaJY1jlaAnp0cLnWVCFCOIGJG9d2Vy
	 RwqEfJZSjInMpDvi2RMrk3TFjb9GeYyR9gt3C0rOl4IUg/5ETVEeg3Ttd708On35Vt
	 cNpwk3mUlSh4GCG+MdBGVNZK5li6yfQBXz8sxpJXTleEeE5G6XcpsMkn7Fp7DEJQL8
	 he16Yw3OegYPYZ5rJO201r+qF4r58s95H5tgEfFXTq/evg4/GJDOO4ciUwh4OD6fkP
	 ZovCEIKY3GPU9CsQhjTq0w40q+gUXKESqOw3s+jiYkC3WlojyE0OFhXCbi7uSvrGHX
	 B1uYW3mFLE9Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD47380AA54;
	Sat, 11 Jan 2025 20:01:21 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.13-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <7f932dbd-f009-4df8-8d8e-618ec036a004@kernel.dk>
References: <7f932dbd-f009-4df8-8d8e-618ec036a004@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <7f932dbd-f009-4df8-8d8e-618ec036a004@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.13-20250111
X-PR-Tracked-Commit-Id: fcede1f0a043ccefe9bc6ad57f12718e42f63f1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05c2d1f2728240f7cd750ea389d4ad87fba0ad03
Message-Id: <173662568035.2439897.11950180859702410094.pr-tracker-bot@kernel.org>
Date: Sat, 11 Jan 2025 20:01:20 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 Jan 2025 09:19:41 -0700:

> git://git.kernel.dk/linux.git tags/block-6.13-20250111

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05c2d1f2728240f7cd750ea389d4ad87fba0ad03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
