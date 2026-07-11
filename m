Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FA5255E43
	for <linux-block@vger.kernel.org>; Sat, 11 Jul 2026 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783790074; cv=none; b=Om2yjL5ZkID8nDfgq5RFCLTi13PMWV/Q28MFB2XpIE31tux2fK/WOx7v8FCIEtM0qON9iIamx8B+Wsl0kjjlGeS8di81hmoPwfxIGp0o58fO8whXgT3ywlQCNVxHgtmb8NrOHjGH6AdZQcSBRN6kmZg+rieaV+Db/2xNJ+aNHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783790074; c=relaxed/simple;
	bh=xENTJpyd+qp+HUFVJDUbmGn7CCmzHwXv/vSc9pJciDw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iuoSqaL2EZsBSphnEquKjJI9cOZh6h2twFSaAXtSA7K1T+997dJLUbN1sOMx2BDOkiK3Zvma/9EAGA2OoH5cULbb+itPwIGmZYveRPnsoWdipVflUEZjUSx/YGaTrheTkjwQfao0a4bLNLy7DTJwR3GkMt34i/4OKtAkP7VQqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MysGPjpv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MysGPjpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C7E1F00A3A;
	Sat, 11 Jul 2026 17:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783790073;
	bh=HAtlr4BiKPL8Iw2prHWbBq6AATXYMtMExMjsUqDslUc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=MysGPjpviLnUcn0yLzT4ac6W4redlZOA6Ik2sG3d3ZWHfAG3T7moJVqPucFdcuyTv
	 k/0xTwFKFGh05YsANIIiDo7gTiuXBglyxoleziLzd1Jtr7EfLuMLV7XIq+HvfMTemu
	 Irmv00HBS4Q/fV+MECY4AhndFvxyQnzSPq8kpWFIdRkqevZNKaNO9EWgDS7E0RmvpD
	 q7nKrMEQSFGNjKSQUQuF6StO+p2Imhra1gOQyLKMXTrDrOVmVicml2IM09CLvlqTK0
	 p/T97tdReKcuzMf40xiaggzISwDTCNBvYrur7Vpvh1D5+mYlhqygtPYEnHvdqhLrm0
	 xEVmraUWkqfCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568493924A0A;
	Sat, 11 Jul 2026 17:14:11 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 7.2-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <b7a2570e-321c-4a27-b97f-d95b3d2b8a16@kernel.dk>
References: <b7a2570e-321c-4a27-b97f-d95b3d2b8a16@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b7a2570e-321c-4a27-b97f-d95b3d2b8a16@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260710
X-PR-Tracked-Commit-Id: 181bb9c9eae4f69fe510a62a42c2932d0314a800
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64d9ca4b44f0c08db832e61df84921f9d1687bb7
Message-Id: <178379004991.1164209.14909677285980323842.pr-tracker-bot@kernel.org>
Date: Sat, 11 Jul 2026 17:14:09 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Jul 2026 22:32:27 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260710

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64d9ca4b44f0c08db832e61df84921f9d1687bb7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
