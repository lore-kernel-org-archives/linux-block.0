Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37646110
	for <linux-block@vger.kernel.org>; Sat, 23 Dec 2023 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAiY2dBj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A74FCC433C7;
	Sat, 23 Dec 2023 03:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703303170;
	bh=Y+at13BL+/xYbQPH12QbGdipF6DP3KRJa+LEuIaU4MM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lAiY2dBjpnvOWTZtNLQUa4IyW0pXo5XE4oMa/Wddc7vXN4mPcmRbjgiLVMwaX0NWg
	 UNxrWuXYpvBe6uRFGMTJSqo7c1F01jQnUDyWiP/oCgKGxKmEsxXvcpEPLIFd0Na4Ek
	 VVrFbvGhFUtXYVdRhaPLef0hkrPLXMj9u4R2IRTtxXv48hBby0joCKxecQxxcE57PS
	 4AZwZMHlyEMH+LR/hjNZFaJemGMIAXFBPhhaqtDJ1O0p5x7jKfErNMP6ucnFGAyBAH
	 GBnTlR7/RGHS7oHSWLaBvxFyNiTWkHQyK3WwUEDmtdrtWdRhmXsedPCLgU4DAxNF1C
	 nZKT+iBEZCU5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 944B7DD4EE0;
	Sat, 23 Dec 2023 03:46:10 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.7-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <075bc8fd-e296-4b0e-bb4a-d69bcf7d4ba0@kernel.dk>
References: <075bc8fd-e296-4b0e-bb4a-d69bcf7d4ba0@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <075bc8fd-e296-4b0e-bb4a-d69bcf7d4ba0@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.7-2023-12-22
X-PR-Tracked-Commit-Id: 13d822bf1cba78612b22a65b91cd6d4d443b6254
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5254c0cbc92d2a08e75443bdb914f1c4839cdf5a
Message-Id: <170330317060.32157.15829737919095740951.pr-tracker-bot@kernel.org>
Date: Sat, 23 Dec 2023 03:46:10 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Dec 2023 16:20:05 -0700:

> git://git.kernel.dk/linux.git tags/block-6.7-2023-12-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5254c0cbc92d2a08e75443bdb914f1c4839cdf5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
