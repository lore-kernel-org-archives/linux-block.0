Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2994B13AEB
	for <linux-block@vger.kernel.org>; Fri, 29 Dec 2023 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HicVA8qu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3E57C433C7;
	Fri, 29 Dec 2023 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703880029;
	bh=xHXuMRscsxZYHBpu5fjOwSTKCmrQQlLxGdXIMY5cyIc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HicVA8qu1OcvZno40mhJmZ6szpxpzU/RRlt3+ErGjAJwslweR7h6BpoO0NFRlyUhc
	 Z/AjDqdLbmcZ9LuI6aNkT0UsymLDFtixXpzRkmsDUEHCB0x5IChBUfxfhVFib3zANe
	 XpI5VaRxdnAOtmohBvu8rTK1482hVQ1TQ+iICVJXetUzzrTyM9aOudlVDgjxm+sht8
	 ftWVrSQ2W0yaz6qx9jUcKK6PhErKq7sS8eb2fVK5YrmvL6ZQS4N0rGjqbKx9kJaUN7
	 XlB9ld8VTiaUAkSfW3+YPHEeVazwMw3vXVijgbPCPxA+PREVWo11L60MAqfljBU7dm
	 bY2cXHZcmVzBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91A9FE333D4;
	Fri, 29 Dec 2023 20:00:29 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.7-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <7ecffd8c-8fc0-424d-9936-b02a5957e0a3@kernel.dk>
References: <7ecffd8c-8fc0-424d-9936-b02a5957e0a3@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <7ecffd8c-8fc0-424d-9936-b02a5957e0a3@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.7-2023-12-29
X-PR-Tracked-Commit-Id: 02d374f3418df577c850f0cd45c3da9245ead547
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09c57a762e797a55f6336c9798f576c889658ba5
Message-Id: <170388002958.30633.4711512540364534648.pr-tracker-bot@kernel.org>
Date: Fri, 29 Dec 2023 20:00:29 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Dec 2023 08:57:17 -0700:

> git://git.kernel.dk/linux.git tags/block-6.7-2023-12-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09c57a762e797a55f6336c9798f576c889658ba5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
