Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1239115A8
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 00:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753747955; cv=none; b=d46nPNMo75GUn3R+Tt0MI8ogJCLIIS69ZPewWdrTfKjZrkGSz0DVo5osyzQAqmXdknM1SXiy0YZRhTWanOL4Ip+wzE/fgb2bt9HYGCX1NZuUFaPhflkDXjTRxq6krgGiFhr2xJCDkRrHn5c54AL69YLYNJ3Bm5bAvAiIHuJu8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753747955; c=relaxed/simple;
	bh=+/W2sBr6MYsc95/68MS8UoZRgRFo7wvtFT3icpTAZ2I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZCU24RhZGfS6vGqVw54enQ+Ew1Qa6xlZ6rziVTGs0gwGogJGY5sD+FXvwTehoKnJ5e+73TFth1uXdPNqjF96DJFemMqqo3VkQGSG5zanBN6cjDLKFNoGJSf0rl8r3dujEtaXH958ZERXdlg3fQlIZc3BVVbXcjdfLW//6BQl3mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fROWf4vP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fROWf4vP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA648C4CEE7;
	Tue, 29 Jul 2025 00:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753747955;
	bh=+/W2sBr6MYsc95/68MS8UoZRgRFo7wvtFT3icpTAZ2I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fROWf4vPEp6z9HNfoB0eKz+X7dm77iuxXtuLIOlHXyt4zBG4RdbT6ESE37/RS1DVb
	 y3EVLU2I+kPr49HfYptYYNJQyQpa7SauYMf1KAXRXbt4kWNuXaIgEH6cq23wuGGjTC
	 vTjdlkDR4BKLGSABzNqnAotUOMWjNIM9XpAwgxiylU9GvumcRcWV8jjQVbehREa0VI
	 6uz5PCejEqMJzcZIbV9LFkc4+rHggd1wITBaf4jYWwfkrOuQJTiOJsaGGRw6Vz+jd1
	 5fT0Md8NydVXGwwtv3qqFgn11B6Bxzn57xCF1mvZlBM2wfJ/UEwlwzBmGYCtrd78RV
	 EKDuXowqNGnQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEC9383BF5F;
	Tue, 29 Jul 2025 00:12:52 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <9855947c-74e1-43cb-bda9-a720293f33ae@kernel.dk>
References: <9855947c-74e1-43cb-bda9-a720293f33ae@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <9855947c-74e1-43cb-bda9-a720293f33ae@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.17/block-20250728
X-PR-Tracked-Commit-Id: 5989bfe6ac6bf230c2c84e118c786be0ed4be3f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e11664f148454a127dd89e8698c3e3e80e5f62f
Message-Id: <175374797135.902610.17736107003714980962.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 00:12:51 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 07:26:43 -0600:

> git://git.kernel.dk/linux.git tags/for-6.17/block-20250728

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e11664f148454a127dd89e8698c3e3e80e5f62f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
