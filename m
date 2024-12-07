Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD175809
	for <linux-block@vger.kernel.org>; Sat,  7 Dec 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733597608; cv=none; b=XBbO9s6XNGpSxy/mwOK/amGUJSHwbiehli3b/44sRCGSTFSWE9PcK8HHskV09NJGU92/rQOWWkO1BQX4+RmrL/cfsTPiGbGHCoPrNVC1coDzj8uMAFyetRbGC5zeTv2oF+GONGMwW+4iddBDRxfBpMoRYY4KcICHbmJgHcwpf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733597608; c=relaxed/simple;
	bh=AgPIH7nE+XPJvEPVS/8/FKBprDNudmP+v1WDsHtqw4w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a1McM0ybfPOa7xx/jETduqhhil6+tYDrXNjheBRuiBENcKzK4XQqabM6/nWKvgjThum/FjnMDdtF2MLU8ha1RMh7VGW2OgdGZ1V9NDtDrfROg0ZKJ0cdXkKS5ifbDQGdbYtX7r/rwkALtZd9hrdJwISXvro+WNY2i+XrT9cXzwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K84xpdir; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K84xpdir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F3CC4CEDC;
	Sat,  7 Dec 2024 18:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733597605;
	bh=AgPIH7nE+XPJvEPVS/8/FKBprDNudmP+v1WDsHtqw4w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K84xpdir76XKwkVBfiFtyjn3fVswWKD+QuhKRNy/soXHxbLEJw5Nzmz3T7xJKwgDK
	 6396GaPOYWSKfKWHzrdiBDAdhjcNaqcUxBO8sELCapph7uf14as+6PF+l5Ld4522ID
	 qmTTAeNil5WV+r5a93+ANYtlUPp+8bKCum8Xt0QFpmiIyzBVFRtHlCk5O3OUNt78xU
	 /Fwh01h0cHdaEHA08vrUZyikCpxENQOcxkXgF0ChnIBfuFrXxzzSa7ysgFD4c9ynkN
	 SPvuLE8Qe0PTyX2uLvTykg0lzbqPKSc0jCdTWMghSnR85Oj+lIjRcfblb/Wy0jG9iJ
	 N0JOnvqrK5ckw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F6B380A95D;
	Sat,  7 Dec 2024 18:53:42 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <84108c76-7be5-481a-be44-4aede8f6fab2@kernel.dk>
References: <84108c76-7be5-481a-be44-4aede8f6fab2@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <84108c76-7be5-481a-be44-4aede8f6fab2@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.13-20241207
X-PR-Tracked-Commit-Id: 22465bbac53c821319089016f268a2437de9b00a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7503345ac5f5e82fd9a36d6e6b447c016376403a
Message-Id: <173359762069.3037814.7380533240975792137.pr-tracker-bot@kernel.org>
Date: Sat, 07 Dec 2024 18:53:40 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 7 Dec 2024 08:14:39 -0700:

> git://git.kernel.dk/linux.git tags/block-6.13-20241207

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7503345ac5f5e82fd9a36d6e6b447c016376403a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
