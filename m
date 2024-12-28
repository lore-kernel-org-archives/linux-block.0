Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1AA1791F4
	for <linux-block@vger.kernel.org>; Sat, 28 Dec 2024 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735413370; cv=none; b=PQRdFqZ/uiXb0IRGlmCupR3Ni+lS8tmGFOwnx5lN/Ebmjnd/UWIijT3qwIrenEcz+H1uaMOuAEwhEH5rXvdxk8zLweEB2zPPulsuo+ZRH2buXKMOlt30qzkylkEELTDgljHI2EIXImfxMbXjDZS+tO7sPbmjsNGfib6RPgrUf/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735413370; c=relaxed/simple;
	bh=ZkafKFp3g1/XrRFjH7PqsSDexdFmPAjPxQcFyQfzM7w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g6C4VsL+I+fVVq2w3i+o8723Vkbe3Cimk3V9ZyBFtjOnBAHm2XzdszGqC8/de0xOx2JWyIpfmw1FqHrUH+9yNFvkRMK+hQ9zAYMTS0zAIX4mPxYsGyRkUHz1IsyjWUn4I25FjOwJ42vvJFkQR9gkUh7lX0WFrQilP86h/lTSiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEfZppwu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEfZppwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFD0C4CECD;
	Sat, 28 Dec 2024 19:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735413370;
	bh=ZkafKFp3g1/XrRFjH7PqsSDexdFmPAjPxQcFyQfzM7w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UEfZppwuoUPje4c2ygMM+94Ezrh2CXPpTvcBsjAvYzavDAl4U2k+JBXkXx0Gwz+SG
	 GJWKCj53Fbp6Iasa5JAJEsX1mx+FVA9KZn0KwbECcPVUOGXDOZBldBVh41YLRXNb+3
	 KPdLGc061W65U+kByTuA7haCY+NAPBt8H7sNFhR9mdSgu3+fNW841q3tjKQfjWW2vM
	 Px3L6NL0Koxnhuyzi0DHDuWzEWW5f12mECfJ7d6iTaoD//OVOqnnfBnuPMNvH1UKSP
	 +KEmdzYrstRiY4dEMN8SWzMui7Ez/Wogb5al7o2aD/HqeJfTfOozhDvu7xeZbULXpH
	 uZQg5P5/M2mIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F2F3805DB2;
	Sat, 28 Dec 2024 19:16:31 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.13-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <02b3499a-a9c2-4c0f-bea9-a9a5c7c3cf96@kernel.dk>
References: <02b3499a-a9c2-4c0f-bea9-a9a5c7c3cf96@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <02b3499a-a9c2-4c0f-bea9-a9a5c7c3cf96@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.13-20241228
X-PR-Tracked-Commit-Id: 75cd4005da5492129917a4a4ee45e81660556104
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 059dd502b263d8a4e2a84809cf1068d6a3905e6f
Message-Id: <173541338970.748444.15952940017395025577.pr-tracker-bot@kernel.org>
Date: Sat, 28 Dec 2024 19:16:29 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 28 Dec 2024 09:31:48 -0700:

> git://git.kernel.dk/linux.git tags/block-6.13-20241228

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/059dd502b263d8a4e2a84809cf1068d6a3905e6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
