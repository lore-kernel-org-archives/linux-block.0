Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC2B2AD24
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758313092; cv=none; b=UP6rO8gDxq2a8U0wSEM9VpKEHIMvgml2IHf9cRwKeftW2QmykxukIyFjf9gS5RFs5P4o4o5aYq6P/x+MylWiqAkhWFUAJTyo63onWJiRqoLhRzPc8TnHuwuXoT5udYvxWO7gfXhjtptd9wGygpPRFQMw46c0GovNdngZLviikxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758313092; c=relaxed/simple;
	bh=QaKCBoHBzRhmIEeuT1xCi08iyN8CiKwlso9x55AY+cU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cvwpB9y55VmISUO12NqOmUSWolrxVrjtUO7Sk4GbPeC5woGYqsgAdiZibkJC9ICQwjvyzElxK722wCWj8KMX2ysJII03e+DZS8+RIgTbN2TsxQmaaCGKzR7XKIanBv/0sX9gc0feVyLO06rc9R7F8vdcaBPD6sMHsxpt/T6QsVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ik0Zd6I9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ik0Zd6I9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC78C4CEF0;
	Fri, 19 Sep 2025 20:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758313091;
	bh=QaKCBoHBzRhmIEeuT1xCi08iyN8CiKwlso9x55AY+cU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ik0Zd6I9GMb+HChaAOjZjP8/f6mznY2HsWqett7wqcsGaCARJuo/qg7jAT5ms+J0j
	 o7DVOscww3+6nhVNnzFSxiIKzDcKbl7xSCLacn1z5R/ko0qKFR5gzrV0RQD8U1ajSu
	 lNZDdl9xW/jOUGYJu+TSx49HAyDCMVLrYWsaCcjPL9rB3hhWhZp5zUYU8lcHqCSc3g
	 nqfszRRikkQZ81LBegN8DyVYr3ZWJ92TGXfzr37kAKppO1di+15smz8YsAjluPJG6j
	 MeS5WVWheSLfK/Vz3A87BIfGVvW01F2rNqUsD2rLz3kQLg+s7WOcQhkju+rZfA1WdH
	 JlfKZOP6Pi2nQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3400239D0C20;
	Fri, 19 Sep 2025 20:18:12 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <74923ab7-080c-49de-9aee-faa8c0fb3444@kernel.dk>
References: <74923ab7-080c-49de-9aee-faa8c0fb3444@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <74923ab7-080c-49de-9aee-faa8c0fb3444@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.17-20250918
X-PR-Tracked-Commit-Id: 027a7a9c07d0d759ab496a7509990aa33a4b689c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1522b530ac3e2dadd75ccb351b88d3c7c4cf584e
Message-Id: <175831309062.3686704.17295546034310542489.pr-tracker-bot@kernel.org>
Date: Fri, 19 Sep 2025 20:18:10 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Sep 2025 07:54:07 -0600:

> git://git.kernel.dk/linux.git tags/block-6.17-20250918

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1522b530ac3e2dadd75ccb351b88d3c7c4cf584e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
