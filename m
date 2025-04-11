Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C0B126C13
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385991; cv=none; b=Kw5KUhG8D05Tr/WVTjDxC+2oEMuIdYLTM1zNGYQmFb2oJI9NTnGAs2pgmPO4C9uSIestE0CbgyOLoQxDF751DVmP/CYlHub09v1yKFWowbqZ/uUwT5/e4OQq0miSzqVtGpps9hGa7CWM2PVWk6uLZ1VeozP9fyJQBQNhLGOVVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385991; c=relaxed/simple;
	bh=Jy1s3CMCbom8Y2hjZ41W8PBJuavD9mnXJg3wy2bkhgA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZFBraQgXPH5IWonuJ/8DCwzlhagxrtj2EC2kyu79IDczMLFzbpKyqcT1il7ocY0z9P9DnbmZGSFaLJaLSQsNO026z66CAXpmd1/t/+Ajl9huuGSwMMVlm5+AYo8oFv/vP4U63ItXkdtaVcQxkB9BMA/NaAr6FAGyWBUufclv1g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d19gwqMk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d19gwqMk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FE0C4CEE2;
	Fri, 11 Apr 2025 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744385990;
	bh=Jy1s3CMCbom8Y2hjZ41W8PBJuavD9mnXJg3wy2bkhgA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d19gwqMkmxqk3c4MUJSkjX9tYA6xCyWgKgrdj5/t93UAi7xfmpS7Atqrrifg4zEiX
	 FAI9UY8MZ3P1R5Z3ROaU310iWFeFE+il1yp6laZ0po5xTPJOjNCKB2I9v0rk1NZcWz
	 /NohdRBmzX4NxOgEpzjms7EsdPFQwJm0kjHjk8E45BPhWnWivyRUGo/0zezdHEmRiZ
	 uCVwXwN6Th+xt52Z+6oiX7QCPCk81jRhvJ6Ufc0zBt9AgpKb3SIys92Z7fGb9/26DI
	 gHc8LHDHimC4REC+FheCotBBEYbSqfmNSHLHNrzOFxk0aaAa4lXsWKz8bjp0S7xKO+
	 eWW2ER6IWsirg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7117F38111E2;
	Fri, 11 Apr 2025 15:40:29 +0000 (UTC)
Subject: Re: [GIT PULL] 2nd set of block fixes for 6.15-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <8d3e5d98-09b1-4274-af25-124c91342b7a@kernel.dk>
References: <8d3e5d98-09b1-4274-af25-124c91342b7a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8d3e5d98-09b1-4274-af25-124c91342b7a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.15-20250411
X-PR-Tracked-Commit-Id: 3b607b75a345b1d808031bf1bb1038e4dac8d521
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff885625298f83785b7db1b95af051a080aab7b4
Message-Id: <174438602795.317646.14614437756587686675.pr-tracker-bot@kernel.org>
Date: Fri, 11 Apr 2025 15:40:27 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Apr 2025 09:07:31 -0600:

> git://git.kernel.dk/linux.git tags/block-6.15-20250411

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff885625298f83785b7db1b95af051a080aab7b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
