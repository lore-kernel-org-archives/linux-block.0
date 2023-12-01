Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A225A103
	for <linux-block@vger.kernel.org>; Fri,  1 Dec 2023 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHekc8dB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 639BAC433C9;
	Fri,  1 Dec 2023 21:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701467393;
	bh=uUom9WupDl+O5AjG2gkMIyA0WZRM7Vw5hD1AHc+5Kus=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tHekc8dBVFRvCSVdcO+PJkYqdBH4j8ENzuUs61yjk1LWBSmlR1Zb3Vz73etgU3thr
	 691NQJPpYFlkS+ns8dfxyzQKyyGRNW3X56DmoIjc49oL7QNiGgXMnNfCDLe+wqCgCG
	 wcuc3CYXKMQ82SGosSIOSCewELniWpVbe9y6p5rwkKgoRCZkNfaqQJr3OHW5z+UKCX
	 uME4XHE7Gg6suE9BRWk55h56oPpG4FntnfmSMcNKwq2weAF7HO7F0kP9yU93YZPts2
	 +nE0mijbzbMR0DAauJ6Q5LSwdqhdoXQ1iSWqwbfQ7AJbmNXFuecCQGqF7Gt9gMQGJc
	 PGVZHtD0lKWbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 519BDDFAA94;
	Fri,  1 Dec 2023 21:49:53 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.7-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <201079c4-7084-4d94-bbde-7e3c536b801c@kernel.dk>
References: <201079c4-7084-4d94-bbde-7e3c536b801c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <201079c4-7084-4d94-bbde-7e3c536b801c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.7-2023-12-01
X-PR-Tracked-Commit-Id: 8ad3ac92f0760fdd8537857ee1adfde849ab0268
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee0c8a9b349ecdc97f81f0000a94ac9be8d8006c
Message-Id: <170146739332.2332.17051910201746388662.pr-tracker-bot@kernel.org>
Date: Fri, 01 Dec 2023 21:49:53 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Dec 2023 11:56:46 -0700:

> git://git.kernel.dk/linux.git tags/block-6.7-2023-12-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee0c8a9b349ecdc97f81f0000a94ac9be8d8006c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
