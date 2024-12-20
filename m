Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9350226554
	for <linux-block@vger.kernel.org>; Fri, 20 Dec 2024 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732702; cv=none; b=p+eaAdQG5sizLCaUWwQVcNZxVZMTcMwfNaEQBkYs9vnRHDPe4VFvnwLc4WMFgextN2c/0jxhyFcPq89HHHGmRc1I5xv5bM3FAd9miO+KJX7I67gMBfFBU7egRJU1C7izIVfob1hTccYTRtqVzVG3SfVUUxbEjY2/TGNp5yVjuPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732702; c=relaxed/simple;
	bh=YQnnCGGtucrT3Y7Rh1FrSb0cBM2D3wVhzKiykTf09Mw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IJf2ftpK71hIYv7tYljSslsULCuB5/93tw+XiO96sibYulGbBIduuruuGJmh3Mg5Vtb1pTPV+jiEksE+WccOgiEXaOTvhKmE0alel20sF3/yDHJ86lXETB7aSYo1pasMcq4JfEn5VN2zlo62iEK0xMLrMLyxchj7qp+ftHcI8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKp4b5qD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKp4b5qD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A92C4CECD;
	Fri, 20 Dec 2024 22:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734732702;
	bh=YQnnCGGtucrT3Y7Rh1FrSb0cBM2D3wVhzKiykTf09Mw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NKp4b5qDaQWJz7ai7StJ4Yrtrk9JcYTEbt1cnsGJLEKjgyDjuz/4DZzf7IyyJQVTM
	 Lo9csuha27bDAJ2mY8ePfYcB7EXrVRrMujPbRVp/rM/fB4ehPTjEeSTA7i0i4YwmFr
	 j9W7BtiwilE+BjRJKxKijXYgZXFfokygbm8WPQYlCO9zVdXZVySrmH7SwBOB86FJUe
	 Obz7U4s+Fh4ebEU8vkig2ryDAtiQA2nhWOwOQCGGTmdRkY0K8r464g18shF84V+8vD
	 zqn8IbL48/SmPP6VK26dVKLnc5PM2Mx4vh+WTmkQ8IS8Ls+9EGZ7XnKn4M5SLnCUXl
	 v/IOrkknAp/+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCA63806656;
	Fri, 20 Dec 2024 22:12:01 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.13-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <0369cf3f-fc02-46d0-b540-b021ce981f5c@kernel.dk>
References: <0369cf3f-fc02-46d0-b540-b021ce981f5c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <0369cf3f-fc02-46d0-b540-b021ce981f5c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.13-20241220
X-PR-Tracked-Commit-Id: 85672ca9ceeaa1dcf2777a7048af5f4aee3fd02b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11167b29e53b9a06635309445ead7edfd54e6616
Message-Id: <173473272030.3035596.17626799109641921287.pr-tracker-bot@kernel.org>
Date: Fri, 20 Dec 2024 22:12:00 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Dec 2024 09:25:37 -0700:

> git://git.kernel.dk/linux.git tags/block-6.13-20241220

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11167b29e53b9a06635309445ead7edfd54e6616

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
