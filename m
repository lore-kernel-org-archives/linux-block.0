Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D6E246799
	for <linux-block@vger.kernel.org>; Fri,  5 Sep 2025 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103453; cv=none; b=iRYw47jR3vGDV8egrdSjUABko9+xrvWY9VkrXdBpBaiy4m7S6QV2KssG79NYHSGrZs6ibT0dwWBpqil7GPznTZJt0siiH47B0CAR8pt4G5Wbvo+F7uK3l9iCJJB/jmQ3cv9gkHD0IS2cnB50XIM0j2iuMKdSLN5j1p8S8EPS1PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103453; c=relaxed/simple;
	bh=PdRtbT0KUCT8ibchjgvkvNsXmvKuEQhL95LKHdMPm7g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GWUXP1UHW5vve7LoJacbwvjboaHzzvkMmP2u+L7SVq5+MQggszJEIlxXDKPvSczMyEza1eQ41YOB6jdLEeswEzGrq/Q10Jj9JVk42NI0RUTURutykEZT467HvQVRLyPJQIZVKIlUUmYxOVrqU04eW5w3XO2fKYfQa4pJSdk7pZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqJaTRxr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqJaTRxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B6FC4CEF1;
	Fri,  5 Sep 2025 20:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757103453;
	bh=PdRtbT0KUCT8ibchjgvkvNsXmvKuEQhL95LKHdMPm7g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qqJaTRxr1G1ztRGXCfcI7Bs6io98OXIP+xyacxJRjDNjUTsgmK22CmWlvq6lqhoZQ
	 MzLfgmRMdWIWxJji/oKnHKxfw+GEpnHf39JZP/quJyAYu3728WwzF/3Wv79NMgPhsB
	 EWcS1jcfbVlFDwboiZopvVZM7QdNiMC0J9BAFCPec0h5KJy/oZXq/l/iwBB9DpVYkd
	 BccHLB41K5pzU1/S5ggTtqzjBWxag6/vmXSuooo9wNK5kAsOvjhKR0W4TfzpPyw24H
	 67c73u9djD80We2NvrNuQ+cKv9IRpdeLlZUSACsWunAs8JBXKELb1QH4E5sR5zsDrS
	 H2hPnEUOaSSsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6D1CD383BF69;
	Fri,  5 Sep 2025 20:17:39 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.17-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <fc773af0-d2c2-4394-b286-9e7be415fd74@kernel.dk>
References: <fc773af0-d2c2-4394-b286-9e7be415fd74@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <fc773af0-d2c2-4394-b286-9e7be415fd74@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.17-20250905
X-PR-Tracked-Commit-Id: 743bf030947169c413a711f60cebe73f837e649f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9eaca6bf69d3f261b9bd51637420b05c9352965
Message-Id: <175710345818.2676293.5800121718379639664.pr-tracker-bot@kernel.org>
Date: Fri, 05 Sep 2025 20:17:38 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 5 Sep 2025 05:20:26 -0600:

> git://git.kernel.dk/linux.git tags/block-6.17-20250905

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9eaca6bf69d3f261b9bd51637420b05c9352965

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
