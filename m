Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BDD1FC11C
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 22:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573597; cv=none; b=he6utU9iZK+UK9IFo3tH49O9HtaoDIkAcBt6qr9rfS/6+zJio0t/ojxQOoBGmYf21DLLv0OTn7O/jbpQEYm0E3YWt++eLBb04rTIUvyT/orjHJD3SjgG5duVcLqHF2BXuZXQk0NBwpHPXqWU0fF2/pW+xxO+4o/wlSoqg1Sk0Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573597; c=relaxed/simple;
	bh=jp1fAXgntbSuKCG2tYIprs5TLpy0sjQXnMB75r1mP8w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Mt2d/pcSQtgvPl0IuC8HwzrU+SXrKQFaAj4mTt1sqL90kReM8MYI+VOVSEl1vaghnv8q9vh+LDhfQddlTyQjndJP8VgCER6LV7SQD1jzBK6jYthUKFYXPCMqT4h0pX6hVhTEiDmJOBovsmHLiBB/hEtUTRwZDvd6cinvglC8MS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks55xqGy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks55xqGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EB8C4CED1;
	Fri, 14 Feb 2025 22:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739573597;
	bh=jp1fAXgntbSuKCG2tYIprs5TLpy0sjQXnMB75r1mP8w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ks55xqGyzqF3sP4nHZ5WmnBtGtBwbQYqDLEryEEmT8ckc0jNTf4/+hrogprBiezqy
	 Od27ZisakBjM7/H3jiBzzaXoxhAj/GsA9baxRraNJCfqXMdqzqkzqkj8iUiq9zi6+c
	 GJ3GPGPSWZMdVtqMWc/RjCYsZ+1wntXtKpu/xrJRQ/9ArD9r2hCKUoAmQfWy8+aB/l
	 K8lNIHgVqdKImtPGK5YJ7OemPctxDAyHUYiizKPryTMi8G3gr5nJDdGC9MJR4c6eSt
	 mhtILMBY8NP3CvJeqAxfBrKFtS5dI0BsQWcF3IFBic795lIejhyoNjYDj5HD7QOpzW
	 n18DnTs5df3XQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F3E380CEE8;
	Fri, 14 Feb 2025 22:53:48 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <b187b8a3-a9f1-42d8-903e-3fa713416a51@kernel.dk>
References: <b187b8a3-a9f1-42d8-903e-3fa713416a51@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b187b8a3-a9f1-42d8-903e-3fa713416a51@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.14-20250214
X-PR-Tracked-Commit-Id: 80e648042e512d5a767da251d44132553fe04ae0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b8c8cdad1749d68130147f187008a368d564933
Message-Id: <173957362700.2130743.8643314088419916421.pr-tracker-bot@kernel.org>
Date: Fri, 14 Feb 2025 22:53:47 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Feb 2025 10:29:54 -0700:

> git://git.kernel.dk/linux.git tags/block-6.14-20250214

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b8c8cdad1749d68130147f187008a368d564933

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
