Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124677;
	b=FL6T3TDflLOuZCzK7rbGIxIuY/eX3ycjW5s3Vd0zu3cr01+kivpyR62oYXKW/CKyyRbp
	 fADnJMgW0QCyuXHKzwnAM8VLBLIGIZ//W2sHjPWTrmNb0WCqavNJZpC0BA+KJHFx3DL4J
	 uD/zHV9CPG2MaSitFLZwDm8HU5hJV6gsLDHuRfR4ald3XX0YL9ihybLPXzsVbzj7um6m0
	 3LCjv/HCP2IVSpCN7hhyWwvHfVBWMKhNY+/rL6xQzSX8oqBPl1uRfn/eiR4YSOIisO50U
	 XJ5JV4B1VHniZo7d+Y1zL4A+bNnhJwVKB7tipUoCDW7mIsjpMjB5Qz912nzYVhSEzQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124677;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=qpD3mjT41t9GE44t0T5p/kvuiG8IUHEz8mrIA+Dwlnc=;
	b=i9aGLlHJb+dOvGMmyhWnkbJ6AiQDvHxLMtDGObW85T3zSJ5fupgIhygqv5h3IetMdvsK
	 ZmfZ9upP/WDt0YV1Zv8d1/7X/g7vq3h3lAWVmZS+U3MRzZGO9A2ddZxsq8Sba+8nXx3sk
	 dD9+x59WytOndYXIEetDV+fW1bVh3CS/8bldOqQnTbyNxqWF+WCHjFu424BMxb+AKnGQW
	 OOmkM3WdpCXGWP07aolM2+MsMxwNM7wSDsYTXbvqquyiGvqI97NxnGs4ORZCco/DetXO3
	 JqrXjaM2qW+poy+sKHmyovpC/1XPd9hFSKCru6IXLER6auTtWY+fGizs/4Kmq0Jr+mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8BhAG68;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D174606A31D;
	Tue, 27 Oct 2026 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8BhAG68
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCD11F01825;
	Tue, 27 Oct 2026 18:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793124677;
	bh=qpD3mjT41t9GE44t0T5p/kvuiG8IUHEz8mrIA+Dwlnc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=T8BhAG68aWrEhAKg6nsMOO1rCeqY6w3mfXUBKbBiLnm55suNyaytEfn1uke0bg2XV
	 vfhfXFILJwXpOexIpyXhq7dtcqYzDitNLSsyo0Xf6fPgTBZC2g3tRVPxVNZHIVFI/S
	 c04Go9fHaZlNeMpGYLOZtJcznaDpmgv9tRzofu+n1EGEVJ/bXS7LzBxGN5lhx9V3rc
	 Azi2Xh69ZFiNWnLzqVKGb2Q9Kg8TCAFU0FW3Xepinxx6z80lUo+0OyA9XiwgHTtecU
	 UwCu8RBIJqNDSUJKSWVEk2f0pv15A4QLXuBIXDJi/dMrBkHetOOXx9PyFLVybXo+go
	 FAHe4RZYYN1hQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 077183AA9AA0;
	Tue, 27 Oct 2026 18:11:17 +0000 (UTC)
Subject: Re: [GIT PULL] io_uring dma-buf support for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <d38042c3-75f6-41fd-8998-da38f9420354@kernel.dk>
References: <d38042c3-75f6-41fd-8998-da38f9420354@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d38042c3-75f6-41fd-8998-da38f9420354@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.4/io_uring-dmabuf-20261023
X-PR-Tracked-Commit-Id: 45b716456dd99488a0cef58482120dc0474aa696
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed02f4f7ad9b5dabae2118e642cbbafe7dc9bb62
Message-Id: <179312467571.245349.11132213751620462463.pr-tracker-bot@kernel.org>
Date: Tue, 27 Oct 2026 18:11:15 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, io-uring <io-uring@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sun, 25 Oct 2026 07:29:55 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.4/io_uring-dmabuf-20261023

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed02f4f7ad9b5dabae2118e642cbbafe7dc9bb62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
