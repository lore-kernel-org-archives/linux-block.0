Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2416323D
	for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 04:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743048015; cv=none; b=HsBGhy6voMqwpiIIYS0KjEIuIowoyu4qtWescGgfUufKxHArMByH17pCmYxJivIfLdx9NSW5Hp+b04ci6YbAKmCxSlWScBxi2bfKkJsfg7/7ZyC80yS5TVl+FL2OQo4NIMI6H4tpOI+zSEEypCgKbsCfKy6eZxKa572Tk8mfxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743048015; c=relaxed/simple;
	bh=oHtBEdj9i039Tk5l/+BjLyTjnjlUJB3jEONsvHbHZ1I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LG8G3B9Ijyh08t6HF6qmPH8BysXsOIxERiZ3nl+htvkbhek8vQzZ0eOAwS4LhccHcL/e63fmIMZQvsmOeqeGzONGSkoNqIW+qQzkH1R1dn66U7io9x3PVhPnmfMoJs9kdTdheTlYNoCFN0arijuHSd6TTFwDemR6eByNPFvEwz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzhNnEZm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzhNnEZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DF0C4CEEB;
	Thu, 27 Mar 2025 04:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743048015;
	bh=oHtBEdj9i039Tk5l/+BjLyTjnjlUJB3jEONsvHbHZ1I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RzhNnEZmetEmGCs/sKAFS2RmtZ3Mq4VYmGvwaVVNHXed5cQ41IzGbQ6eQEMuEswaF
	 rEqAvFIdAFENeedsNnpVS7RriJYB8dwpXHaaKCYkPCt3FBRSCGSDkPz0YPNPP2MLP4
	 5R93aTVGHPaN719O8YjC0GFUmuIF7eyI8ZSzuPCNstojhtgSljEPba0sSF7ahOU/4F
	 Tqsi70H1xzX6lsHdnjhEajMr0tBQ97Brv8pXQq1lbqQ71cZaLv4qBbavx7gc5iRjo6
	 SJvsH5oUzYbVAWdAmWIt0MPezsDcN+8Bk1o4p2JR21DPFy8PEHtwPCCLXkIEER56dV
	 nEs24VRph4HEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35A42380AAFE;
	Thu, 27 Mar 2025 04:00:53 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aa7f515f-0db9-49f5-999e-eb75c9512e65@kernel.dk>
References: <aa7f515f-0db9-49f5-999e-eb75c9512e65@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <aa7f515f-0db9-49f5-999e-eb75c9512e65@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.15/block-20250322
X-PR-Tracked-Commit-Id: 3c9f0c9326b625bf008962d58996f89a3bba1e12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b960d8cd6f712cb2c03e2bdd4d5ca058238037f
Message-Id: <174304805212.1563585.11315271166857695531.pr-tracker-bot@kernel.org>
Date: Thu, 27 Mar 2025 04:00:52 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Mar 2025 11:37:43 -0600:

> git://git.kernel.dk/linux.git tags/for-6.15/block-20250322

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b960d8cd6f712cb2c03e2bdd4d5ca058238037f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
