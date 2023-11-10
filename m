Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C493B289
	for <linux-block@vger.kernel.org>; Fri, 10 Nov 2023 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X568+iD7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 501C7C433CA;
	Fri, 10 Nov 2023 19:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699644541;
	bh=roNfXbekO181PPAAZsOkQFSDX5z5ByzwUeg/sMxSJ6A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X568+iD7mtUq4sW6V8kShigmnXJS2MZJQKAiSh4n7yGFubp4p7dCXu1xZAXR7fQ+u
	 T865yjCy0QVmOQmXZKM+DQy9XJy9snu9YSBvZuclR6U4+xJly0sG8kEHand4Ld0r/3
	 Kx92pw1Mu3ZrAQ6gt+y6Liz6ptz0rsoKrJNjwiV9iQ7YxN8p4m9AJgD2MRqWi6UOjE
	 1m8mxNAYNSiy1xKNWvP9AbTqcK3EDKjE5NLRVQyq5zrzXLxdNqRobLdQopCyD0GC9d
	 kdul6wGQK+XAl50oAjLpNJFXaDL7knuC4Xz5FYTGz4QOw0hduAEtGc25o6CBdiY7Mx
	 MqYBBFzftS8uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E7F3EAB08C;
	Fri, 10 Nov 2023 19:29:01 +0000 (UTC)
Subject: Re: [GIT PULL] block fixes for 6.7-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <c57188c7-52d4-4bc4-9cd1-7d9b25faa872@kernel.dk>
References: <c57188c7-52d4-4bc4-9cd1-7d9b25faa872@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c57188c7-52d4-4bc4-9cd1-7d9b25faa872@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.7-2023-11-10
X-PR-Tracked-Commit-Id: 37d9486874ec925fa298bcd7ba628a9b206e812f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b803784178d1721ba26cadd8aef13b2c7456730
Message-Id: <169964454125.4685.17801267932643648902.pr-tracker-bot@kernel.org>
Date: Fri, 10 Nov 2023 19:29:01 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Nov 2023 10:35:14 -0700:

> git://git.kernel.dk/linux.git tags/block-6.7-2023-11-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b803784178d1721ba26cadd8aef13b2c7456730

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
