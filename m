Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8966828A41A
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294140; cv=none; b=QtCb/9O8zut/XiWg8IWkTtIOQZd2FB3SBk9Un4RpfDx5iwMgvLsy7+T4bkxmxiCQkpqN72Lo2Y9bTGKdHs/CJy3l4Q1YUdcI9ocqIyC1CBKP5ecp9Qn7txn9B7UZmq4hv3fTrdvflP/hJxIGC15lz1HF+HsCpj3pUxwAkjMR21s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294140; c=relaxed/simple;
	bh=cpAQgm4shJZfxJNCAZ034+BoTN0tdAxTWTJMU610bfY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aCGlrhEdVUxjc8amD13pLdr2ByYl4jk0Vo9Omx2dLaNUVYjOQG/+iryXkDPtciRl9vgzxJS4yvOVnfP+CzWu5m3Nk2HF+bFdx/oMtj5nSf0kA7CbPuMtGCs6gQLj1errXsRf5Bs72ypIuUK6D4d+6Y69CmQh12sM11LwA9343ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRglXk4r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRglXk4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A545C4CEE8;
	Thu, 10 Apr 2025 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744294140;
	bh=cpAQgm4shJZfxJNCAZ034+BoTN0tdAxTWTJMU610bfY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CRglXk4r+FViTQzx9njg3LUQW7GBB+Row3oSTBP0Do/nqJi6bBDP0yPi443cf/B9y
	 NwaQvDcpIdCUI3tKxwsE/EYK4wdCDI4eLSy9ZwxBhlAd+ChKVwyb8vFsCfubApEVpu
	 2ftnVN9v5mRU8vvvrye/rveCWKBMMlJx+qQ8L+f4zw/y5c/XyejEw3xreBSYBrwLtH
	 5iRkmWC9WJiMCAEByo0kiFnDL4J+LdAowp4WZII3qGpTKIgurS8a6AALC0rAqRdhn2
	 ADNDIfBi7czSrHsjVffR5ZRjF7+Z26f7uUeQyCvrgcq3sMHzSKjeySaLQgV6jXiqG2
	 3rRYEAMer5bTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34206380CEF4;
	Thu, 10 Apr 2025 14:09:39 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.15-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <d33ce0e7-23e6-423e-9c5d-0899d99515b4@kernel.dk>
References: <d33ce0e7-23e6-423e-9c5d-0899d99515b4@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d33ce0e7-23e6-423e-9c5d-0899d99515b4@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.15-20250410
X-PR-Tracked-Commit-Id: 843c6cec1af85f05971b7baf3704801895e77d76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4742a89cfaced383db758bef94037637899487a
Message-Id: <174429417790.3685623.11351670150696692582.pr-tracker-bot@kernel.org>
Date: Thu, 10 Apr 2025 14:09:37 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 10 Apr 2025 07:26:40 -0600:

> git://git.kernel.dk/linux.git tags/block-6.15-20250410

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4742a89cfaced383db758bef94037637899487a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
