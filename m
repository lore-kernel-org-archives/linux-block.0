Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053F18E1E
	for <linux-block@vger.kernel.org>; Sat,  6 Apr 2024 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362203; cv=none; b=TfgYTfeJ27mWgdGK0+Uu1qUomqdlOT5zZF/1c9UHuS88Vz+F+e8g8JaVJs1YxZhP2DJArgV6Qd/S8FqN/BQUssMOpsM0PZ0u7oA7UTKwU2e3WqKn7TCRV3MOpLJXOUhJ7GEuwCJDxHuzFu6/EW3MeLvZnbRwCruwpr0GbtTc/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362203; c=relaxed/simple;
	bh=b/Ycs3+Ey2ToL7Np5X/c6qL9pVKZz8Ccuwpu+1ava3I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=V8QNewL5hG7sSRS1NiDcr8W6tldVU14vZnOoxaBEqfH8rTI4MmeydH/TvPGtU55UpeRP8/2LDNzkwRb+iR3Tn47JOfb95T2VnLxiaZYs++j9FvOcgp5M96xynekqpXQoPpCNTrZevixSrUxaNyilgyjx6g3G3lu6tL3Fz7+1Jbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d34FdAFO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d34FdAFO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21731C43390;
	Sat,  6 Apr 2024 00:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712362203;
	bh=b/Ycs3+Ey2ToL7Np5X/c6qL9pVKZz8Ccuwpu+1ava3I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d34FdAFO9pM4jniHpxkn6F5U9Ns2IGGXeLzipureEEbQ06pdy3Zov3dc77YujgmR4
	 aiKUQU4Peov9uzkRS5UmUnlm/ajCyL9qrVOMuLctUWuiJuYCJkBJebgGlS3o/zpTot
	 fAXu4goLE9T9DYTPD/f90U4hhsx2ikzZyr8CVKeh/qp9sUhly+aZTHv2VxQyVVq5k8
	 jXV/ZbWtZASC/FvLDQNbDXCeVbKBJSmcbVzVUAWHlqdEcd0zrMF99fueinoTC7r3Ea
	 HED8bDSP48N2ewC1UYBWERU6uqEogUbCJ3JX1nIpphrp1dtGTnwD6gFQV7OiLrrhOl
	 8Mxvps2Fp7U+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18A8CD8A101;
	Sat,  6 Apr 2024 00:10:03 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.9-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <8b66a441-b45f-4b86-a8f1-5b6afb61cf92@kernel.dk>
References: <8b66a441-b45f-4b86-a8f1-5b6afb61cf92@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8b66a441-b45f-4b86-a8f1-5b6afb61cf92@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.9-20240405
X-PR-Tracked-Commit-Id: 9d0e8524204484702234e972a7e9f3015080987c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a05ef7087166d7fa0de986fb6a2d97850dbd551
Message-Id: <171236220309.3482.2637679962660018769.pr-tracker-bot@kernel.org>
Date: Sat, 06 Apr 2024 00:10:03 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Apr 2024 14:47:03 -0600:

> git://git.kernel.dk/linux.git tags/block-6.9-20240405

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a05ef7087166d7fa0de986fb6a2d97850dbd551

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
