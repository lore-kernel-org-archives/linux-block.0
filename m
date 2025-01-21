Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042C114EC73
	for <linux-block@vger.kernel.org>; Tue, 21 Jan 2025 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737437488; cv=none; b=rsLzie2CSeTjjFx3UqmwNQZGId8fPfVD3y/CYD+nahNXQX9xrtn1/DOyovVrmchD3XtiAz3LnFH37PCRoadfWeuqw5Q2lBTek11OTgBHH1B7eB96VcVIGJPtK3zNP8ekFxTLvITxsmV9fxVGAB80NoZZy+6xgEWux2F4Yq3LUvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737437488; c=relaxed/simple;
	bh=98LHS/s+eivhJjRWnxgppkvu9cKC5YZS9/3XSejx0EE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Qb9jfjYX57YzndUUPKHV9LeZ54mpzq2Bt+3qpBXVBwu+BvHPVTHr6qK4h/LRCxgJV3aZ1wXjRifeBrxo449nzxdD0RPkjECHlX0Dl6oHNTHl8fqWP3jBi5VSX2m8RSYqiayh8IDp138tFIz5m7P/lK5sxPclxdlet7nrxpaS46Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmDP0l5F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmDP0l5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC4DC4CEDF;
	Tue, 21 Jan 2025 05:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737437487;
	bh=98LHS/s+eivhJjRWnxgppkvu9cKC5YZS9/3XSejx0EE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XmDP0l5FSQVlWwE4SCzwUAfUP0Nq94jLbIcW3keVLoSj70jLnxSCqdiiYBxXxUreM
	 h/1Dq4y6/1IJBRH79d4sWe2rd6LN4k4MH/ts9Y6BsH0nn8dWQkduoSz4or5XL8AgPd
	 nscnYr4lYTrT2XxlhduU9jEmUAUjqiLI474TdvRvAjcSiyH97+SwLF4exEX/hqnX5t
	 0CQ9e9WqaFUzobI5vv/r3n5rlZf0LaY2ZtPpOPBOK+6TN4fsnv4TVZOAt61hXVpwX/
	 tOTiVhJGcFvpyLeQvbFxabJnsN119uJes/X21OCYpKW7EG7JrspxwA95yCJcLHMjOG
	 UCYSs1b8uBhTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F79380AA62;
	Tue, 21 Jan 2025 05:31:53 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <488c1331-386f-4eba-a2d8-33f81a21e3c8@kernel.dk>
References: <488c1331-386f-4eba-a2d8-33f81a21e3c8@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <488c1331-386f-4eba-a2d8-33f81a21e3c8@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.14/block-20250118
X-PR-Tracked-Commit-Id: 554b22864cc79e28cd65e3a6e1d0d1dfa8581c68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1cbfb828e05171ca2dd77b5988d068e6872480fe
Message-Id: <173743751184.3750173.12097654150096658502.pr-tracker-bot@kernel.org>
Date: Tue, 21 Jan 2025 05:31:51 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 19 Jan 2025 08:56:58 -0700:

> git://git.kernel.dk/linux.git tags/for-6.14/block-20250118

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1cbfb828e05171ca2dd77b5988d068e6872480fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
