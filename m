Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B71474CB
	for <linux-block@vger.kernel.org>; Fri, 16 Feb 2024 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708121406; cv=none; b=gKpuRQjvzm7TRXhB3/kvz6fjHaNnNuq88KdxRV0IasQLfWPdmERu5iUpYep6HRJF6NG1pOI+FW+/V/MLIJP34ie0pdGUv9xQ4PtIoIKb+jI2P1SMDouAiwS5VkFmff7YlseV7VwW40AOWKkzQzjp+0HZpvG/mj+gMxalFTeBfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708121406; c=relaxed/simple;
	bh=W76KFxt1nmoNkX249WNFlgfjMaNNSny7KoImRvcoySE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uUXr/j2EoFaOFESG6DQB0hUemkYKMv9VhRvm2K4pNGN+z6v9aR2jipLAeaB65iMO23QoEak4/PzEPc/BzpryiI7zXMiCTXYPThiwyFRLXfRWCt1+DFM/weEbAMrj0n+Cl5biafKpQR+7iDGmT+uvSIYnbwVYidOnxG0/0BGc/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqQ5zjSn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqQ5zjSn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB274C433F1;
	Fri, 16 Feb 2024 22:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708121405;
	bh=W76KFxt1nmoNkX249WNFlgfjMaNNSny7KoImRvcoySE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XqQ5zjSnGq5jKQvnKus+gKKCicqHu3nIQYZs2/GyAuPewTY6cId2Z2wJYjoe2R5T3
	 idKKFaO5neWLEqJk9L84R0N/PDux7gNmK5C1EsqB1kIqaSSOUykYIrVEhHTJEc9dow
	 /ltyd10aTwbb2z2d9gDLYOGQG3bAWzGgptd0cO3LguJNoDrp3H+2F/4aidS+zsun8A
	 hqbIZWZ7Vh2bf2iPJkxpo+TAzQ28OwU5nTq+vdH74ys/Nd2hmpoTHBsxpDXDY82/ua
	 RR/fptjkPlQcMe+c09Su8A6VYbRB1PdKcKwc2YAG+Ss7roWgi+/9HNQk2puXn6A/r/
	 NBczp2wCHWmAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97FEDDD4F02;
	Fri, 16 Feb 2024 22:10:05 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <c055359e-c84e-4b38-94bf-aae964abc093@kernel.dk>
References: <c055359e-c84e-4b38-94bf-aae964abc093@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c055359e-c84e-4b38-94bf-aae964abc093@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.8-2024-02-16
X-PR-Tracked-Commit-Id: 9c10f2b172eb26007e9b641271798234911d24c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7edfe0aaa6e74b8fb2aa178d3b140e1468cf85ff
Message-Id: <170812140561.30067.7665196369823446466.pr-tracker-bot@kernel.org>
Date: Fri, 16 Feb 2024 22:10:05 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Feb 2024 12:12:45 -0700:

> git://git.kernel.dk/linux.git tags/block-6.8-2024-02-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7edfe0aaa6e74b8fb2aa178d3b140e1468cf85ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
