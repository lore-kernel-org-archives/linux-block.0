Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177C9244692
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457919; cv=none; b=lgtlmeyApAjOlCwVQ0sYgSWaOMc/9+PjzoA7+hrq9vsuUZNZrJ5QMm41EZ+XCt/a03baaZZMwFGiuHt3f/ZlzFGeX3J2WBLPggLsBztQ+oqwwdqH3FDeCgNTpFxSsEmjrfMd18bAhIzn7NLd3if9IczX11gnJF0WfjoaepLWQXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457919; c=relaxed/simple;
	bh=JzD/vTuxSQtJatme9iY3cVWYW+v1ZzE7D+RXpeu/4U0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P6JF3xLaiqlMa2MUwiv747en2mzpXtH+skxRzNjekFMz2tjP5qbjh+dSUqIaZ7ZRz8NOjiJ0e/mNg1djoPJVp/qkoKr7eZ2YAJaSU24xZx+yCDUl+5qSKoMOU6+ShrBzhDPzN62FW7PNneHUfSEZhvHf96HtxlovAojGtVGRhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoTXKydj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoTXKydj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B904C4CEE7;
	Fri, 25 Jul 2025 15:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753457918;
	bh=JzD/vTuxSQtJatme9iY3cVWYW+v1ZzE7D+RXpeu/4U0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OoTXKydjQ1TpghDtDeVbLtTz5YTtFekpthdAJ0p1bn4KgTEcEQ/wr7dd4a2aOnh0o
	 4QhwaBck3LEJ1K127LrDpmCbNBX+QdGcaENdabrvJgsoyRcbk3+DgrqbnGXNh2xr4h
	 wQ6gcgkpUis78sqsp1v9Aqa20l9Y7BY5Gf7KyqcW/FtNYIaRiZxUDclpiloavV2Otc
	 H9houeiHvVNZXYEbqXsCulDoUgpXnskMYO8Jc76Y6LDo77Cy4nSYiu91/SJn1WhRKQ
	 YFO6QLhjb031zQEryuoJRbZzHct5iMZc9A/AgyZJB9QWHpeWT35P/b1/Lb1Uym/EnH
	 P88ow01BuwXGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71082383BF5B;
	Fri, 25 Jul 2025 15:38:57 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.16-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <a0ffa959-d8e5-4ac6-95cd-620aef122a23@kernel.dk>
References: <a0ffa959-d8e5-4ac6-95cd-620aef122a23@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <a0ffa959-d8e5-4ac6-95cd-620aef122a23@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.16-20250725
X-PR-Tracked-Commit-Id: 1966554b2e82b89d4f6490f430ce76a379e23f1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 327579671a9becc43369f7c0637febe7e03d4003
Message-Id: <175345793596.3175853.3020364385104776030.pr-tracker-bot@kernel.org>
Date: Fri, 25 Jul 2025 15:38:55 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 06:15:42 -0600:

> git://git.kernel.dk/linux.git tags/block-6.16-20250725

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/327579671a9becc43369f7c0637febe7e03d4003

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
