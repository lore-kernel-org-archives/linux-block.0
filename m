Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209341;
	b=aX+8DxPxltPNphoqj4jZ0JFtH5FjZKi0JkqNYytLupaBz7tfQ+oRFtPOBuTUeffLJiqN
	 3QrE2cuRJT3ccH/AyVH2eA1nyK9jkh+3l9+a87ilg1bmHmGNtmPlZ6iG9cluchLB3L7zC
	 4ee8hRTWxNpQB+rzNIlvEXLnzdBirA1A0XpGJLjgQqp/owHfJESjiUq7kI6iqC7HC+JiG
	 qUvnmoH96HlwstN0GeMFSW3QRylKJtphD2FFLiXLFHnsi549NBKuSFJZ9hQXwnhCamk3F
	 YGJ1sJao8o3/Si4TJ6pvCOGXFDtORb97Hcr0+/7rzAQW5RDmQdYTnGf8XY5RVf3zeYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209341;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=cl9Ep7eSlSEuiCFRNH41CUmUBXgInI4zTo9ZQK9+u8o=;
	b=3DCBTNY0X1vMhVkLkK8bLML6bUqDygufA7yAKiBhliT0cdfviNkGiwWhVd35+8Xip+U9
	 XE46exKiL8Rc4I4XfEJt9fIGiQaMmr5TSPGVv28Ub1a+j0S63BGixOLVVOOwLpefc3AIK
	 1GjhGBfnjYnnDfaf09bHW/IXcnVpkBeGrSH48p2i8S8EXr9tWhWaOZoKBjNrfVx5OBANQ
	 D1MHWjeUpIs6RbeHwCXzj9ccaIR2pH4JL0dmOIaACTq9kdovtHyB4GF5T/2nkmoe3Lfqx
	 B5qlzzgTV7rmMRBhrUVJBeUmrpj8tqgD4v5gvbHMiGO0n2f9PARMiwV4+sHJtFiD0fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csMhsqdx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C799606A337
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csMhsqdx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42601F000C4;
	Fri, 20 Nov 2026 21:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795209340;
	bh=cl9Ep7eSlSEuiCFRNH41CUmUBXgInI4zTo9ZQK9+u8o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=csMhsqdxLVUYzW7RZtEwtFswuWcO4SsIx8gghSNqqFPkR8eLgx4QyP5y3Y667zcCN
	 RgXHYdouWk09sXLBalCMH599c2tKQX18Kc3D6dAvHgUwtlLyY7dtcnsjB2XIns4whN
	 BsVMvWYrEIz0hW9/VYKBsrIUeWMNryOGAxbYiahQ3vFGLeN3BS/1PdIve940petiza
	 gsWKAgD9I94co2Om7H41qAnLST8R3RMMdIzDaOReYoHbSyxFQEPZgjljo4LW+me3oe
	 k6aQhVftsNltXITEHGCJzbWJ0u9VNLKf7b3bno/hnV5Gzv8f6beL4mgftlD/ISDc3E
	 vPWx4ueFVUbJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B459F380A964;
	Fri, 20 Nov 2026 21:15:40 +0000 (UTC)
Subject: Re: [GIT PULL] block fixes for 7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <1ed7b839-af3c-4471-9c5a-b83fc1af3919@kernel.dk>
References: <1ed7b839-af3c-4471-9c5a-b83fc1af3919@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1ed7b839-af3c-4471-9c5a-b83fc1af3919@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux tags/block-7.4-20261119
X-PR-Tracked-Commit-Id: 5a29cfaf51105039d156dd8a61d2783e8b653667
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a904dcf3fdf29cdac99ea354789bc5c82df0d5ad
Message-Id: <179520933926.792202.3024201960184159274.pr-tracker-bot@kernel.org>
Date: Fri, 20 Nov 2026 21:15:39 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 20 Nov 2026 08:12:25 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux tags/block-7.4-20261119

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a904dcf3fdf29cdac99ea354789bc5c82df0d5ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
