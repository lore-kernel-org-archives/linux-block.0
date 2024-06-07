Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06975B64E
	for <linux-block@vger.kernel.org>; Fri,  7 Jun 2024 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717804259; cv=none; b=G3IIkaBygcR/bb8KX5bDPE2ecuEMZyMI7ZNepv++Ny5UO7/HisBwSYmWbhsuhqHg48sRqUTzhYPlVtF4KpcoiWvWIEcPLR6v9Isz2JuAcMDOCc5+vx0hZtJqVGTib8PzVF/hNSLFNZwgj1AJsT0/Z8VWdgMTBFCfgH6M0wl0ruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717804259; c=relaxed/simple;
	bh=/4KOZtXFO6RiGGCy+PvTBVBWPmzGoHwx0AO6sQoF6C8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eKpv8UgFenLMhtn+PjbksFnOUdJnIS6SUTGU7GoI27cGhjC9jBk8asKc2TgTNhKwkYgeoBSi4pTfIRuvDeeUyMVwXhVDigBMzGmZEUEkhNdDfTR7gF7y8/6Q2YcW1+9KasQFvEfMju98gC8V5thl6RGeIHS3T7iPOnvYYpBn9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSBTnNWi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSBTnNWi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3ED9C2BBFC;
	Fri,  7 Jun 2024 23:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717804258;
	bh=/4KOZtXFO6RiGGCy+PvTBVBWPmzGoHwx0AO6sQoF6C8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JSBTnNWilw0xX/3wht+Ki1UUdGij9VC6dTRRB+FhtSlfBDyZ5c6vF5qJH7XfBQ4AV
	 Y9hRi/tgjy+cOq+pzuMmQdTA9ZKCJz+lntvyfUj65I4IO8L/1F7Efg3MqrI1oMLkcN
	 gXjYJ5U1L4cv7cEp92gZyy96BrXjAQl52/N02K6zwv96lSrWNv9Usuzhn4xSzOdbyq
	 DKLA+BQVhF1UBtfd3Z+DDLVQFZVnlqOlRSK1wCwDCywBjW1JYgk1UPhStygORnVJ7S
	 aQXP8nhXCaB9XX2EG5tKMI1BgCpL06iNFUx6GrE+Qr+r5HsImBHXa9lrzcf6Ic79JC
	 QUKJX9KviOCTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C823FCF3BA4;
	Fri,  7 Jun 2024 23:50:58 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <f39b75f0-054d-4a69-b647-53999bfdbf05@kernel.dk>
References: <f39b75f0-054d-4a69-b647-53999bfdbf05@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f39b75f0-054d-4a69-b647-53999bfdbf05@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.10-20240607
X-PR-Tracked-Commit-Id: 27d024235bdb16af917809d33916392452c3ac85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 602079a0a13c69d190e16297d123ad3d279364e5
Message-Id: <171780425880.23085.14710379671735600021.pr-tracker-bot@kernel.org>
Date: Fri, 07 Jun 2024 23:50:58 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Jun 2024 09:55:25 -0600:

> git://git.kernel.dk/linux.git tags/block-6.10-20240607

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/602079a0a13c69d190e16297d123ad3d279364e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
