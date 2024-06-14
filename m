Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA90619CD0F
	for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391136; cv=none; b=bG7uLEZhl37JdseqOK6OUlJlRmTBc0rbCyaDizmowqnvYy2w+ZY/QS8IU4Zw+3JhvGLe4bpzt6SQPyPD8JUKKOvubhYhJRLQF5Hsa8lvtTTciVQEY+8Uz9+ddJodKc43v2pY5mn0InF5HgbTObu8Es4JFxqRXqnY9ZOiArRJPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391136; c=relaxed/simple;
	bh=NVuned6Qn2ntXVKVgK6DeUflZsvHhOfK6sBCkSwhVC4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g7dfiCudxuauoWjOL2lcRgHnj+MPozeoYWvZifUyC4MRF/oDaYXjkLSm3ksLuIbFyMOlJHeB4Eq8MRwhJpMpI/3eCSAx5Nf2wl9guNH89azCmu5K7JutaTDFXMNT0hfwYWKkoS+cPQriDPHxQUyF4+wI6ITL7j0/D55gP64uYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN5qCbqk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN5qCbqk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CD27C2BD10;
	Fri, 14 Jun 2024 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718391136;
	bh=NVuned6Qn2ntXVKVgK6DeUflZsvHhOfK6sBCkSwhVC4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KN5qCbqkgI6d6WuTiI0hcnnEG+aMc6qJzWUMSb20WlG7647MWJwFEmOByxi8COsCZ
	 8ZIEpb5OJVDQcCIHtPAWCNS+/tvCGiPS3DgiccwnwgxVubwqPDYRCAdqr5P7cD0S0e
	 7OqiG6jKWPgSwAEEmUm18gHUYAaJAlnHXO4+WeN9X9DzjxZQlQSGacb2M8eMxPmLG4
	 +cyJAkBUsaP6Dw8WNzurwyaFK0jqVn2QmdiXer6Nx7UQz4ivbyjmsN9vUxg8dcpGap
	 8jtkPAJiKgslwG+IdTZLb/bCkl0u1dNRTZyzpNyjVy0iD0YFPZT8PSBGZ+pxhmkK1N
	 G+yxG2+PeCEeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94703C4332D;
	Fri, 14 Jun 2024 18:52:16 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <2392bf6b-f048-4a80-a9b2-8703ead1fa10@kernel.dk>
References: <2392bf6b-f048-4a80-a9b2-8703ead1fa10@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2392bf6b-f048-4a80-a9b2-8703ead1fa10@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.10-20240614
X-PR-Tracked-Commit-Id: 5f75e081ab5cbfbe7aca2112a802e69576ee9778
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c286c21ff94252f778515b21b6bebe749454a852
Message-Id: <171839113659.28657.3984622635721529363.pr-tracker-bot@kernel.org>
Date: Fri, 14 Jun 2024 18:52:16 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Jun 2024 10:10:38 -0600:

> git://git.kernel.dk/linux.git tags/block-6.10-20240614

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c286c21ff94252f778515b21b6bebe749454a852

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
