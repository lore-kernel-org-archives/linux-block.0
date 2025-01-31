Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B241F2C5D
	for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355141; cv=none; b=O1EEjPKOkRrrYkO0yAiJAgMzWyzMnSv/uIrV2SG+4yPiqhMaK9olPLqu1TqxGMMOvV3RSw7qu/Aiv5t0pbTNdFmNRyikYn1ElWs3vemCinNEBURpnSEcUNj5inoTjlvJbRVZkGFSTZ4Yh0x11MQRSVGcVU4okM3EgZfhZ6drH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355141; c=relaxed/simple;
	bh=VKMjdBllLpS1WJLmNnVMBboUe02GjNSewPvTvcYgXB4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sKjlrCkr4lmOGo8C8Lx3qNwk8gpM1d+xoNqJhHPFw5daaxwnBUOy/p4hBGP6qeqw2VaNY9is9HbQjuGuGD1Wc7KJ5vpIbc5GTZmpQ+nMbqVG2GU6gjtatCaSatNN5/HXrsIyqYHDDMYvNUqIjb0RmshTDbHQ4rqHmQ3j8e+sSGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G45blYlS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G45blYlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB4CC4CED1;
	Fri, 31 Jan 2025 20:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738355141;
	bh=VKMjdBllLpS1WJLmNnVMBboUe02GjNSewPvTvcYgXB4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G45blYlSgngoNx6j2KHmeFNvOELeCLRsKTC6piAN2CBk6a4v1S4tuFci2DgQbOcUz
	 MFO2B9rBa2DIcts+0Gj7DDWCgteqzeo8khfhOIQ8eLAoERBm4UyZBf4jCDy6Pj6zLS
	 kuFh8XaH6JJrmcbrcrH5YF9ZRqgaLBDUmbGdnpbyQqzAPgHfWCX7hk9tA6OuuVbsPu
	 TcwaFsw9KdsscDrmZ4U9wYRjvFpI0X1QMyaBYJLOWzXN6xTmNXX1ZdGM9soi7hd12J
	 uUhnPsO7gZwqQFdYNEMsNXQVVkrUkntphxUQyph3ZEJnpPQNwbzbFGg97GvAamldfT
	 wyYYAe6HG8wyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE823380AA7D;
	Fri, 31 Jan 2025 20:26:08 +0000 (UTC)
Subject: Re: [GIT PULL] Final block updates for 6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <a86c3ab3-831e-44c3-acda-66f6fc4f5912@kernel.dk>
References: <a86c3ab3-831e-44c3-acda-66f6fc4f5912@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <a86c3ab3-831e-44c3-acda-66f6fc4f5912@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.14-20250131
X-PR-Tracked-Commit-Id: 1e1a9cecfab3f22ebef0a976f849c87be8d03c1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9755ffd989aa04c298d265c27625806595875895
Message-Id: <173835516715.1719808.10161617815996900647.pr-tracker-bot@kernel.org>
Date: Fri, 31 Jan 2025 20:26:07 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Jan 2025 08:49:41 -0700:

> git://git.kernel.dk/linux.git tags/block-6.14-20250131

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9755ffd989aa04c298d265c27625806595875895

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
