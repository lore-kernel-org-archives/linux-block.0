Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB71F61C
	for <linux-block@vger.kernel.org>; Sat,  2 Nov 2024 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730512060; cv=none; b=CM9RpDbBYetF8rmiVDSuD95AyZkRMBZ2BSTk0mbo9AO4ksSL1W9AxQMqvFdSYW/6b1oU8MUAsL8iG5BIW1K33Ne8v290JczX52xHty07NGG+GxChVdrM3vYl7QkQIsy7p9mmxqoG6DcktuvLnkyUiT3B5gan6Cq2WGEIX8hUBEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730512060; c=relaxed/simple;
	bh=XQ52TdvjhOE5Z16NVpv2GQDzhUrfftBb11+3DSZezWs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iru6zLcn8OTrEUsQVzZpk7wxqHLP2UdXlNBToA/lXE9u+nPJCJyWF/y/z3lulqbUrVHW4IftyQI9ZKsP/zUbqaKVEnWhgGyJefbF6VBJ5FhaKujvRDnOw0NqGM3KjVgRn6zpJqZaNvjGvb5uGoucWGJkwDo+9xviPZA5Nj6uVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugPkBjwc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugPkBjwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E08C4CECD;
	Sat,  2 Nov 2024 01:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730512060;
	bh=XQ52TdvjhOE5Z16NVpv2GQDzhUrfftBb11+3DSZezWs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ugPkBjwc0DNjFtkNyBWII4YQxyjXWGkqJBlH9e4XYI8cGfq3aAoRiuWmfRmLo0ZqM
	 WvC0DyUm27FBU3oDziGuO35Quw+ERejgxcXR7F9RMv3IBj6QNTjY2UIxAawxw9xQvR
	 ll6/GuNIJYnsOSov39ewRbD3zhlukmPkeu31fazHEcIBkigtH9jeoIkBlco/rlDtva
	 FRrzruq7cO//zONJHehWrYOTv1ocvJmHWn1nfNn9ZS1HFgGJs0VCLvWMGQ6zM6DVF7
	 fkVhRwTVb5qjpFJmb3kAE6Pkq07Mvnv0yQVAY+pL+wnN1A1OCaGk3W9BgYdGIWLjqE
	 dEx5M1k6m7WLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE13AB8A90;
	Sat,  2 Nov 2024 01:47:49 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <89bedd77-813e-4b5d-9ee6-87c97bd9b3ba@kernel.dk>
References: <89bedd77-813e-4b5d-9ee6-87c97bd9b3ba@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <89bedd77-813e-4b5d-9ee6-87c97bd9b3ba@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.12-20241101
X-PR-Tracked-Commit-Id: d0c6cc6c6a6164a853e86206309b5a5bc5e3e72b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4a1e8e36973e2034c9eac2b3538470f8b2748a4
Message-Id: <173051206817.2889628.8127622897465777102.pr-tracker-bot@kernel.org>
Date: Sat, 02 Nov 2024 01:47:48 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Nov 2024 12:12:08 -0600:

> git://git.kernel.dk/linux.git tags/block-6.12-20241101

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4a1e8e36973e2034c9eac2b3538470f8b2748a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
