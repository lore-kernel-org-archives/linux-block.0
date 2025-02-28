Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997751F4CB1
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764919; cv=none; b=g0a7GoRz1EDukZDXVoqhdbVKk6uEE/1AHuK7SAOkDyK6dVwX74H2gVS6BFentuBkwred8CbBfaxBeSJHCSHqGQ/Nd53S5NnNi79NTyh3jlwkSJCDPXEWRIAZ5NJ3zaJVAHu6SSzDnGeAc09Vo5xvV219iOXh1VqBp28UNV0meDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764919; c=relaxed/simple;
	bh=Q/FPQFy7GYjseK5137XMahOS4ZpoAW72b6FjIRVHqNo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mHa4ng6sCNGzO7Nndp7f0s9eJxnIb5KNTCu1kpPZlHeLjQ3q73yBGSIcVKKWntGar2dg7Yoz9c7sXDUi3NH5JqnYNl+De+6G7XM6q0qnAXYZNZih8PcznxHG57iOGed//9rqu1Bs4c++mJQCjO7UnQRtaGRChxES1FeEcwj7Ezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWtRp2CB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWtRp2CB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C619C4CED6;
	Fri, 28 Feb 2025 17:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740764919;
	bh=Q/FPQFy7GYjseK5137XMahOS4ZpoAW72b6FjIRVHqNo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eWtRp2CBjrbdPP6l6rDi5pqlAi04ThHefVSWi8jtIR6OTzO45UlpyHWOtiNGaDvH6
	 3OH6FQm4s9W++hv4sdHqm3mQ8udOTxV8IJdJrNNlydG5AGNzcK7CAlMZb69od1OEOa
	 ah5JQFYC0hxcLCpOAefXxCwe5LqQk9+KRG2HR7EnRLMhIbXJpJqR0vgEnDHF1Ad43+
	 9kp0AWsUbd0lXjyFICsNf4SDz2Grzgg93p7sgex4cuXQPVCjLP4wOKJXu9q6Blk5iA
	 JPjJ0JL+MoMsrIduVfGhh0AD9MXAoFc5y7Tx7hz46ABp8a3cUPvh8jEa4Bcr/QD4TU
	 K7qe/euTTjxKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD38380CFF1;
	Fri, 28 Feb 2025 17:49:12 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.14-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <e7425917-0e60-4c84-a6d0-8dd967a0d8a4@kernel.dk>
References: <e7425917-0e60-4c84-a6d0-8dd967a0d8a4@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e7425917-0e60-4c84-a6d0-8dd967a0d8a4@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.14-20250228
X-PR-Tracked-Commit-Id: b654f7a51ffb386131de42aa98ed831f8c126546
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 276f98efb64a2c31c099465ace78d3054c662a0f
Message-Id: <174076495160.2226632.8483338715255709911.pr-tracker-bot@kernel.org>
Date: Fri, 28 Feb 2025 17:49:11 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Feb 2025 07:12:18 -0700:

> git://git.kernel.dk/linux.git tags/block-6.14-20250228

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/276f98efb64a2c31c099465ace78d3054c662a0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
