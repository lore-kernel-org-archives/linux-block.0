Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19F2CCC0
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994751; cv=none; b=JWYJqUetBJkKpI96SyVMy3FkuE0zFnf6d5b8cm1DeKLYVS79IwFlaMod1Px8HXDt9oDgZvQ30S4g17w2Xuq8o0OhykQtLgMH7/bu6+wqOrlMD0ae2TcssFWDwrIwuLPwIjvymn66SzFz/vU7T3oRwwsJ8gYZm8foj3ksD9/sumU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994751; c=relaxed/simple;
	bh=mbOp3zG9U+E5T5D9VMBPMnc0wuXQQ1Fh7E4MqkEbRsc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TWVjO04CcNUi2P4eHM0J7bDQ8yKc2U6THMDnCUSrTNePpnRm9b5uSABwd1zJrU2MgOLmaSWGZlGmex/uAtENN6Y0+wyt3YjOb8LLi6XVPkj6nJejhiGU304cFYByJSZjJUyuTz/DFyANOwOTehDu1wUlBoD1hJDINe7k0iSyj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REuRIDLc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REuRIDLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2EBC4CEE2;
	Fri, 18 Apr 2025 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744994751;
	bh=mbOp3zG9U+E5T5D9VMBPMnc0wuXQQ1Fh7E4MqkEbRsc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=REuRIDLcVg2demLY7p95N36FUFL0W9UPOdzjE1h9J18R0LhyjNHePIx0aTulm7v5B
	 rEc4hYIBU2ePKx54j0/e0Q//YlyMYIfG7tcpjDZYv3dWJSJsDJ3CpWvChzIcrkGzZn
	 f69+4p9kamozz5uNAGRLUYUSF6PIBuVMXobLsz5O2Ghvjg5Y/dTzdw+3gBG0+v3PU6
	 2jx4/L3rv9ecKoK5jwT4UQVBqNFhyMzYMVeDEB8eG8yc0huaD7e/cundreySc2RPJU
	 bxZfYU3AS79buF0vuNsVu1jhla37Ntki+A1OP+TU+FFwUi/NNoh3NK7p5r/BfZB7cd
	 cKyXLIyJE96Cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1513822E07;
	Fri, 18 Apr 2025 16:46:30 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.15-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <441e0e5d-a493-4197-b64c-29c407c67bfb@kernel.dk>
References: <441e0e5d-a493-4197-b64c-29c407c67bfb@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <441e0e5d-a493-4197-b64c-29c407c67bfb@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.15-20250417
X-PR-Tracked-Commit-Id: 81dd1feb19c7a812e51fa6e2f988f4def5e6ae39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7c2ca25848b1da1843b7e0fa848ea721af6b132
Message-Id: <174499478951.267730.12885060820313399727.pr-tracker-bot@kernel.org>
Date: Fri, 18 Apr 2025 16:46:29 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Apr 2025 08:46:11 -0600:

> git://git.kernel.dk/linux.git tags/block-6.15-20250417

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7c2ca25848b1da1843b7e0fa848ea721af6b132

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
