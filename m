Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8358ADB
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw+6vryX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DDB8C433C7;
	Thu, 11 Jan 2024 22:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705013879;
	bh=5JntnIGHqXDR4IpvDuLSBaCL/Rm1+pOc1A7tV389yuE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xw+6vryXZIGugSeE6xvGU9JgMOBOki0VTLpEWlisEGKlxstX2GL2VITYcwqBWlLUr
	 JBOQZ0uAf9r06hTML44wvwcLBPYG55uOmNNLA0M/33SfgnyMURsRP4bS7yBGwI3YtB
	 t+yr8atvlmgwtoaNj7dj+zQ+O1G4t9cDWBaOATajt+LHNFl0hSEPshQat/RJws1sje
	 yIB2/Q+fOmrpF1cCJ91BMhB5TlBypPCjs/hgK6/SRSqpjyq8YG8clLrVBURKsH84zZ
	 al54NG4Y65Nl1/l3+VNmMpfERQeJW4UAkKTPSLBVGdluKXz0aYZS/8tg2BDSHJMT02
	 U3+P4rzB1o4HA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F08DCDFC698;
	Thu, 11 Jan 2024 22:57:58 +0000 (UTC)
Subject: Re: [GIT PULL] Block changes for 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <2bc9c8de-b2a1-43f7-9aa0-a6ec425a1ce6@kernel.dk>
References: <2bc9c8de-b2a1-43f7-9aa0-a6ec425a1ce6@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2bc9c8de-b2a1-43f7-9aa0-a6ec425a1ce6@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.8/block-2024-01-08
X-PR-Tracked-Commit-Id: 587371ed783b046f22ba7a5e1cc9a19ae35123b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01d550f0fcc06c7292f79a6f1453aac122d1d2c8
Message-Id: <170501387898.24643.16484960039408938031.pr-tracker-bot@kernel.org>
Date: Thu, 11 Jan 2024 22:57:58 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 10:02:28 -0700:

> git://git.kernel.dk/linux.git tags/for-6.8/block-2024-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01d550f0fcc06c7292f79a6f1453aac122d1d2c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
