Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5118D60887
	for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311338; cv=none; b=BisY5asLFiShSklaX/Z2A69VamfK4Ty/n7KloseCpiY5fvSy5iVU7vUUK2XITUBWoIfge94ymI5oBdx3s2cWeUyHrZ60bBccqNFQ9+whSpPTQq4Wph3dOUO/AeaPyoaWfM/sTpeQKHM5MPJz55N3lGNOf9urkQs6kIWsFu+SkUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311338; c=relaxed/simple;
	bh=OUa4ESMdfpGHN36mdX16La9UuFQKE3nkiOLHcB5mzpg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gOBXEfqW/+ML6MYz/ZuoczvOdJCwWL4+Ws6wSBhsVLSMuFY6t9Nhz9UVe7IRPIj+MfEcnCpiJW2buZv5r0K982UbDJqXNSt4wCL/UMdGsvTy5RRZqoNvyNdba8fT1WKpO4A6SZi0hJhXw+n6XXuUs+4DkkueoC395JV1iGv8fyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaOsB+Mj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaOsB+Mj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C31F6C433F1;
	Fri, 26 Jan 2024 23:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706311337;
	bh=OUa4ESMdfpGHN36mdX16La9UuFQKE3nkiOLHcB5mzpg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EaOsB+MjafoTMHzvxXBmMSFgbFsZIveJnn8dTvjq46tIE3NKfJJlcB7e/ByNIOQ3q
	 gpCM0TnPn01biONusK2afknS4ZA+XPe/B5dkfKtbcFCAbLjLKTzgSQJ8sYfOx+nZre
	 nySpopL+ddk9HiTRHKceGI8kPprpiyRT0X+cl8tMECtq6b8YFMJkU4upktupzpK1M1
	 ki4FAHZ7M5uZ4SGXly8jZVAxPmyuzK1G9DAirtTAHcn5wzp8KZz9q7iN2oXRJ35RRp
	 jGJQSD8+eRGciQdVimMHqxwJEeuKUbDPrr01I/6cG0ZR0TCLWaki5w2xBMz2kwX8bO
	 x5RxiVGkfAv5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B14DFDFF760;
	Fri, 26 Jan 2024 23:22:17 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.8-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <4d6d8fc5-669c-4b9e-ba54-0d72444ed1da@kernel.dk>
References: <4d6d8fc5-669c-4b9e-ba54-0d72444ed1da@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4d6d8fc5-669c-4b9e-ba54-0d72444ed1da@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.8-2024-01-26
X-PR-Tracked-Commit-Id: 5af2c3f44e004b5618ebef34ac30bd3511babb27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 914e17088e91a96ea4ce5af2504588678f96edb8
Message-Id: <170631133772.4030.8670200619768581711.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jan 2024 23:22:17 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jan 2024 11:27:33 -0700:

> git://git.kernel.dk/linux.git tags/block-6.8-2024-01-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/914e17088e91a96ea4ce5af2504588678f96edb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
