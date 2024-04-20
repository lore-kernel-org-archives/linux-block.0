Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9BD3D3BB
	for <linux-block@vger.kernel.org>; Sat, 20 Apr 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713637964; cv=none; b=lp6IDqON/XKuyfsBQmXmHawp1azuJZrq7gaefxSR7BFg/cuKTBUeeHLMdIJUKDMDwV6mTQWO1wIoABdS2c4IN3YUJ27Uorhim4hyPuvmmxpgoDvBMZn9DRaBBwl4y+S48nf7E/tRl5IvmaCIy15he+r0+HenOdlS6eCwDoFPboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713637964; c=relaxed/simple;
	bh=zFGGVjPb1l2NW/RRbegr374qCiofvk/U5Qxpa7CwQV4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s4Or8bVAKB1bahQOx5q3wZpUTSA1WTky3TR9UQlRscZafOv0L15w+XDpjOSmGKMwt5DENGVnHkrWWWOTj6Yvd0+TdM9rPn9TQufgOK4TNTp+pv2FFZZ/ddEychREn5kFsm3b4yx5BThVEgOzRcrN8McbY6nU12TdkZOtCel0VLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBjoKkfo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBjoKkfo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3A7EC3277B;
	Sat, 20 Apr 2024 18:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713637964;
	bh=zFGGVjPb1l2NW/RRbegr374qCiofvk/U5Qxpa7CwQV4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TBjoKkfoRVZVjc5gNM7IRr8AcR6GMk3Jj6Q4GSXk25UETCBadLdjLlRW9bCpHLAUC
	 ilyL0t/M1yNZVnyIvWHN9qxsCaqRzX1OEXZZ7cN9AmV2ooAm/99H6d22Nzx22vIwVP
	 2/IxkibvUKBYldpP7L0Kwgul1YbZbmcoymliBQp6guvRMcKTQp9sljLfdahfoiMlzk
	 SRf10wyVXidh6AFyUx9CytNtiemLcBjkAIzc8nLOk+W25AgC+5Ho3xqzq+qCLUGpxx
	 6rNnR9Y6frRjLwEkip7VVLPFGidQU3nf5Oroqz2j4sHY2nFqy24bNGqwxOzNkmiYft
	 Q0tfkwHnxP1tA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E91FBC43616;
	Sat, 20 Apr 2024 18:32:43 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <b3c34e74-a86c-4595-954d-e73ef31e8cb8@kernel.dk>
References: <b3c34e74-a86c-4595-954d-e73ef31e8cb8@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b3c34e74-a86c-4595-954d-e73ef31e8cb8@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.9-20240420
X-PR-Tracked-Commit-Id: 01bc4fda9ea0a6b52f12326486f07a4910666cf6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 977b1ef51866aa7170409af80740788d4f9c4841
Message-Id: <171363796394.22086.4804898538426937973.pr-tracker-bot@kernel.org>
Date: Sat, 20 Apr 2024 18:32:43 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Apr 2024 09:28:17 -0600:

> git://git.kernel.dk/linux.git tags/block-6.9-20240420

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/977b1ef51866aa7170409af80740788d4f9c4841

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
