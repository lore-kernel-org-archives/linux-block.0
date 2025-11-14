Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0748434888E
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144442; cv=none; b=iRIc92R4eBKh+bppEqhdCYfv6nZ4xngIiLsm5W/NbFh5Q4hXdP6dbV1/bOUEApCxFiOzuw161tPiAilkOhfMQqXrlutFvAtFY9GWsLV0vNPeRW0s0KAE0251UljU5hCYvVKjjJJbQIhMnMnUDVi40a2uKSthN6l8+8BCTRlDCwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144442; c=relaxed/simple;
	bh=2rC0RNTAHS5i0L9UnqgrI4oymCmt/osuEcurKu1ATCY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=e9K7nD/7POOrJnShp3bjRB5Lq4BPi/VVZV1R3ZJpz3Nk6IstvclYeXLIOP6PNJeg2ND9wBs/Ejz/tOEz5ZDKB/4lz/Hga2PKUheugmBTg1mGOyrrfrxFO/oh7eDWQT4b7E/pn7reBnphbPrUcUJIS7TnrbJy87WGa58UeDhaHrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiGNPSvC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiGNPSvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2B2C4CEF8;
	Fri, 14 Nov 2025 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763144441;
	bh=2rC0RNTAHS5i0L9UnqgrI4oymCmt/osuEcurKu1ATCY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oiGNPSvCyuH40cMfav209CUzwW4djdiqwvrB/yVFot26FuGQ8nDg8PHuDIEiWOopy
	 ipcyg8B74XFutl6FqVl4zzJZqys3onbtyqTjwgfFiciL4BMWOP9s66sm38TnO9iUQp
	 OhAQJ0mVvgQMCZpGrI+9Pg93+kPv/FqqxqlTp/Ri9GzntWo8UHRDF4W6AKgmEWYG3h
	 IztDMDyFnw79w2YWY+UR3uxuZ+enD880bzxG/7iKbgQ1HSolYLK16BmpWPFPBabfX8
	 tkm6+BxtwdR5qHh++A/LllQ2LHgqcjaMgJTbbz60pjenIzmqvWqgB64W0OBCq96Bi6
	 ivrSaFLw6XVug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEA823A78A5D;
	Fri, 14 Nov 2025 18:20:11 +0000 (UTC)
Subject: Re: [GIT PULL] Block tree update
From: pr-tracker-bot@kernel.org
In-Reply-To: <84cc4f70-9746-47bb-a606-0fd71b01332d@kernel.dk>
References: <84cc4f70-9746-47bb-a606-0fd71b01332d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <84cc4f70-9746-47bb-a606-0fd71b01332d@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251114
X-PR-Tracked-Commit-Id: 8f05967b022d255412640670915475ac4cdc10e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4f8cccc6230bd2f3aa28348a4c71f0dc3e89788
Message-Id: <176314441034.1790683.12869379197070317805.pr-tracker-bot@kernel.org>
Date: Fri, 14 Nov 2025 18:20:10 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Nov 2025 05:32:49 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251114

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4f8cccc6230bd2f3aa28348a4c71f0dc3e89788

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
