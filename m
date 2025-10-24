Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505E62C3252
	for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337955; cv=none; b=YjCUe3UUs/+lwUgKAmbgbp52L94tGhRyqtbGhCl26lpQJ02PMi7E70kWFl+rEypuQMhJ8U2mdpx3MhxD0R4r8iw+sK6u86k0+fT//wMAjbaoGXyUBMNaTLVx4gRCzU93l5Y1OApZfPLhVIMPeylqgR9rCUF5vQfGPAOMPaeA1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337955; c=relaxed/simple;
	bh=eKYZHC9JtGtWGjRn2yIQ26EEY/3E6KKX7ciKWHHlrpk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dSyjSuQlY995CbSjqUiVCv8I6Tgmnh+QMWbZu92B3n6YrdWMZc9k783Ix8ciXJUE1/Q/LaLObbhfAbvzyZUm95dAcS8e8rKkFu7lAypxCl+u/qTAN7IP05AMG3s7AdtWc4/jW0mIGhOQIBBpELphrIF4dmQpcXUKBXoJllVKG6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gITdRUL9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gITdRUL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33114C4CEF1;
	Fri, 24 Oct 2025 20:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761337955;
	bh=eKYZHC9JtGtWGjRn2yIQ26EEY/3E6KKX7ciKWHHlrpk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gITdRUL9xXxmUZOTZP1lMlnoSUuC7XPnlh/4NXAPmO0t9pHkJ0Cpbn7zBkeym6AGK
	 e6m7fS7qEr/LZit4F/B9D3RLjxtUyg2DVIldh+/54Xko0PfUxC+Z6PwwqbUt5LyFmB
	 0WN6tw/R6DjDn5tcAkFs7lCINnr17IVYMzWsuG6YjQ5+ZOwgEt5tCLeymPs0IzVSQT
	 go5MkXsssomSQ+bR/uPCM3B9G8srzx56+CAwEx3n+u0OreL5YEj5eP5L0n9nWa1ixn
	 zOFhoXbmN8Ui3EwHT7dQ4kz7dxBxaCSmi0tAybkz3rzPxk5NjuMfUK5w14VVxjrYWl
	 TnXvO4V4Ok4qQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341B2380AA4F;
	Fri, 24 Oct 2025 20:32:16 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
References: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251023
X-PR-Tracked-Commit-Id: 4c8cf6bd28d6fea23819f082ddc8063fd6fa963a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2818517e3486d11c9bd55aca3e14059e4c69886
Message-Id: <176133793475.4053949.17173315315650986233.pr-tracker-bot@kernel.org>
Date: Fri, 24 Oct 2025 20:32:14 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Oct 2025 07:58:20 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251023

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2818517e3486d11c9bd55aca3e14059e4c69886

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
