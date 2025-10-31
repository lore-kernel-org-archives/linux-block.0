Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9823161A1
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946201; cv=none; b=aXD3kyHnQaZC+OgbbpbEbxVj/pgyuPisUiWzcXx8fR90tQvBLf+2HCYz5h0H9t7HTpZxUiYrq7rjKzLWNSj5A8+TXMWimaR+Agc+duJyyH/K86E5i161kRqmrTtOCyQoTI705VMCIFYp2wDV+dqWj1Cwx2lakmRshk+5R2ys2M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946201; c=relaxed/simple;
	bh=nBo2z6FUej9bEIk1nx+iZ0gwM9PBdaOH58zXtMDrI1Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MmtGl3A4a5MKwGbPRlZg0kFLdr+FTUYnXzonzU6aWllbP7VPLko+B4rk38ZL/MbERIlbKvu81R9nYnOsq+POb1IkCQcuGZP/8fUsuNJC4f8uF3EyloyBD8PyS2D6+8tr21DpzWp9aORVOvqTkTgVSbW7eT8b+jR0biJ8uNKwd4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2JHO8dF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2JHO8dF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7E9C4CEE7;
	Fri, 31 Oct 2025 21:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761946200;
	bh=nBo2z6FUej9bEIk1nx+iZ0gwM9PBdaOH58zXtMDrI1Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=c2JHO8dF0lvN6gDINkB5g/kSXeyW86dtl02N6uG14Z5oY2YuQFpiYw2JxfLExjNCi
	 7ssyAcJVO1qvazIt3oPaWlRREmcxHaCBDqqJ0VRUb1qOVm8XJOUw0TZRDCeQoGz/PU
	 VPG0aIml6trQAP9g5zcfot25qq3fvzUqt/AD4o9NLsNYFLCLqWRZzBZUSML0s4lWf4
	 ibMQnQDMOwl8U0h3++is0meAmRJ3Wzwq6KXHiHFx+fuDdMBSebgb6wIdMVtWX0nq2a
	 jR8IP6mnZn08+CzLQ7eX27nDPH3g3edQiZSWpkP5Ep1hwC8YQVyY8mTN+oWj25KhH8
	 /5iXyRFN5sJGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB20F3809A00;
	Fri, 31 Oct 2025 21:29:37 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.18-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <abdcc067-2eab-422b-abb3-bb4ce8793c1b@kernel.dk>
References: <abdcc067-2eab-422b-abb3-bb4ce8793c1b@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <abdcc067-2eab-422b-abb3-bb4ce8793c1b@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251031
X-PR-Tracked-Commit-Id: 0d92a3eaa6726e64a18db74ece806c2c021aaac3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5beb58e53092f77b89181bec9d30c8bdced3103
Message-Id: <176194617649.642175.10743253041317748635.pr-tracker-bot@kernel.org>
Date: Fri, 31 Oct 2025 21:29:36 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Oct 2025 11:04:07 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251031

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5beb58e53092f77b89181bec9d30c8bdced3103

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
