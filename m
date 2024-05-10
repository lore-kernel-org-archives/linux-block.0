Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80101BDC8
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362150; cv=none; b=ojATgpOgty5KoXfZOiEFOL/qt9D3RVFCyPsHmCZrGxBBSBv0ExIWY9IOvxfd6D0Z82ZV6CQ7MO/x/C5+ugF7+OVY2u8kyaWmWwQ7zCHN/NT4p1FBGNZP55/1k/Cy7dJhBj4sPib3S61zqN+9aNkEP11yU6uIcYEaQuEk1tMhrLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362150; c=relaxed/simple;
	bh=xNrtIrUaIghaotOnEq/E/pvrDBilNrAZkkKhSg7Tnt8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Co6J5b9nSn0oFeZDxQXPASUKiExRAlRx0ktEikyfKYUCqgNMZu4DgyIHTbq5fiABlZBKsD5VtdiqsFbWKoPDaSVhSSCoqcEoJw90COKnZE9qYf658lp1BcB3jVRQ9IMVhU5Z4vFQoUxuQ2wvhD2qc9rmqwoydNDTRID8q5DqMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmiv969/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmiv969/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45201C2BD10;
	Fri, 10 May 2024 17:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715362150;
	bh=xNrtIrUaIghaotOnEq/E/pvrDBilNrAZkkKhSg7Tnt8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dmiv969/lYU9gg6jJ+6jw90ch8rTwb9eLVCkL4YFw48x0I+zuCw48n1pW+JEcYBNL
	 FqYSJzlb5aj4tvPQk+pi0nilM4SSq+Gl4LT82yCATiRoQ4tKd+qmEM77gtmD4nckkG
	 zYJGHDq1ADDI4BqZWmj2qdtUCht06EAjrr/fQ57GBrgN/tiN5Y4t16phJaPYTMRYWH
	 QLkHqlsRSVl9nsvG1dMwvDdt2xyMnDR7lsZkOQHzVgghi9yo9OWN8BwD/q+T4i6ZBA
	 QnwywV1FP0QzcqZZ/pgHvpJ1bsDrFiD1VqRFfsG+1uTCrNM3TQHm7hlUPzO2ZRLXDZ
	 Fqi8wQmxHssog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C29FC04E27;
	Fri, 10 May 2024 17:29:10 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.9-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <232508dd-214e-47ef-92b9-8f34ec479584@kernel.dk>
References: <232508dd-214e-47ef-92b9-8f34ec479584@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <232508dd-214e-47ef-92b9-8f34ec479584@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.9-20240510
X-PR-Tracked-Commit-Id: a772178456f56e20778e41c19987f6744e20f2ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4345f05c0dfc73c617e66f3b809edb8ddd41075
Message-Id: <171536215024.32093.16841294358879031247.pr-tracker-bot@kernel.org>
Date: Fri, 10 May 2024 17:29:10 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 May 2024 10:46:31 -0600:

> git://git.kernel.dk/linux.git tags/block-6.9-20240510

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4345f05c0dfc73c617e66f3b809edb8ddd41075

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
