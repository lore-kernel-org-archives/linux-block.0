Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A81482E8
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770334481; cv=none; b=ECq8AlJW+ZJp9vhOxiWpe8J9xrZQE0OCiEaFsRObM23UKUP/YWZ8qB3UgQ8VGhhDrLgcqLc9qGntVRR6nsNSZBX0QJaX7cNhF0alozhiZPfJULBeBTiCsmqfZ2U8+O/yZPkcU+HzIyVPNfhv0Ax00qv7zYuYNuq5A8Y2UA+EKKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770334481; c=relaxed/simple;
	bh=DknomvMWuVfxZYm0f5nm/DQ5EKTqoNY4eFNW1ZTche4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LrpJvzJmy68fqzSv/nWqcdUUmvS8xd2v4+xOcPTM9r+6ekhazLgHsnSFD/hzPNlgHJ1xM8jRF3Mt+kEDcb3mhu+z0XCZk7zqMNE1cxEgHjWDxrbUjk7g5Shk7MCTSgy5ejjmyAs/3488wsEfmIsjxKFSXtD1MVWicHSRYuviZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTHWrJDS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTHWrJDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376BAC4CEF7;
	Thu,  5 Feb 2026 23:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770334481;
	bh=DknomvMWuVfxZYm0f5nm/DQ5EKTqoNY4eFNW1ZTche4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YTHWrJDSEHjo4TMDg75vFvA7a/y9pUAew5N2EkD6DL9/hLtibUBZnBey5X0zyqT4I
	 HqeyZy1g/u6CgLAczO0K/vjd2WEAdLHL55Nvnl0ry1UBEAiK6NK4a5XAzQUzTRtskB
	 v0626Vs25lCbO3lOqmWa7j9GoSpt6y+dP9NdKHdHWj83LuIXamaLS2ptnctWWTbxmk
	 gNaJwaCGRLnSRGdlG7zsGV1IAS2ySnLVFt9shGq3Zw/5Jy6mSOsUDLIAgrtBd+3UnD
	 WKYs5rl8+xQmdaWu5f1hLGcxC/elJl5MvPC2QEQ1YNnKYcNcNr/8ZqftN7srkLbXZ7
	 C5Kr7AVw7j6mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B1163808200;
	Thu,  5 Feb 2026 23:34:40 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.19-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <88a6cbc7-19ed-40dd-a382-3efef7d24ba9@kernel.dk>
References: <88a6cbc7-19ed-40dd-a382-3efef7d24ba9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <88a6cbc7-19ed-40dd-a382-3efef7d24ba9@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260205
X-PR-Tracked-Commit-Id: a6abd64e145ca3084b6a567e06517a7c2dbfd38d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06bc4e26310f9f2c0dd2fbf4885483306c5235cb
Message-Id: <177033447856.607944.11309452287509993607.pr-tracker-bot@kernel.org>
Date: Thu, 05 Feb 2026 23:34:38 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 5 Feb 2026 15:24:39 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260205

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06bc4e26310f9f2c0dd2fbf4885483306c5235cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
