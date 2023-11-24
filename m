Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C05646
	for <linux-block@vger.kernel.org>; Fri, 24 Nov 2023 01:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxaOjv6D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFECEC433C7;
	Fri, 24 Nov 2023 01:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700790688;
	bh=szde06l/bCIgOioVtvRMndHLK11MPNsg0hUrheqYPrY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VxaOjv6Da6Xef4oWMbnUvGiUenc6UzXO7CN4LmgXbxMAKTsCezgmbIDs6RbSoNshO
	 NH7TymJucondJ/gtyXLbH8BNFydsJeANd4EUgHKjty3CbTxyOjysLzmmWPHcl4q9uC
	 +8nk8pasbf17YVFpSpBx04c7km7tnM2mfee3FpOwRDorGXL0FU+vVThrkl70CkORmV
	 I0NPv5mkyvpIUdo5jVMeCmzcl5fEvmjb/bXnWp2cYsbGGtekTThjOXV29iyb5zjU6J
	 XOi+Gnn0UHOSIpyC+KPZv63/oqxtLdwIz7x4u4uKOXWwyf/ZLKLPmtGIZZzGcZl5PH
	 z06bCJmXrN0RQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D834EAA95A;
	Fri, 24 Nov 2023 01:51:28 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.7-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <78b52c5b-91f5-4c1b-b89c-c942e880ac4d@kernel.dk>
References: <78b52c5b-91f5-4c1b-b89c-c942e880ac4d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <78b52c5b-91f5-4c1b-b89c-c942e880ac4d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.7-2023-11-23
X-PR-Tracked-Commit-Id: 0e6c4fe782e683ff55a27fbb10e9c6b5c241533b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc893f744ef04e118f7bcf848fd33f8016b63f7d
Message-Id: <170079068864.3340.15507300748325994084.pr-tracker-bot@kernel.org>
Date: Fri, 24 Nov 2023 01:51:28 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Nov 2023 12:54:33 -0700:

> git://git.kernel.dk/linux.git tags/block-6.7-2023-11-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc893f744ef04e118f7bcf848fd33f8016b63f7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
