Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B118A324705
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 07:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596489; cv=none; b=YiUU1iKj7s1c5bHaaevqkXAbVlhrSDvOb3wz9kPZ1EJH+O1bP1y3Y49AZfbDGDVIxA+xpoVftMjHBU9D547GgTmxUTWLyZL1cACoJ+E9L3eGidWlnMiwbf7siFe+kDqAeEAYAjw4LeZAAyXUl6QYhpv7Gk7pHqkMPp7GW0PxakA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596489; c=relaxed/simple;
	bh=fvYL0tLeWp8xXQFlraiA19JexYbDwRo8mvJ2m+/Nf2Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DTS8dyauXpZEUCURBf+qwUx+rkdqKdeWTd7gg4cwS2IK0PUZS7sKjFSLCBO+IWFIEnbSlIu+9riyxLiqIRZ6T4T2FmEL+3+pcdfgEUItoqlBw6j4QKML2Nrm8JrHn+xgzpowTZhDZ0JzVm3embpZfUYyZqcEoRUzxiwv/xcUY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha8ieYTA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha8ieYTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145F81F000E9;
	Tue, 16 Jun 2026 07:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781596488;
	bh=4IDaOs3FIThacGwshfmVYJ+PxpugSdHymW01YIckJFM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ha8ieYTARQc/7qqlUbiwmWwhFFzCdrMnrPrOuxIOlec3P/UlqYPeJjUd6hndxg/9L
	 S+ykTp+tJ3zlEedJsitxkX4l3bfY0p3x5TUkivApx3iPS2UmUSri4hnu4oDI3gP/uL
	 Sxl0k+d58hXTdaF3WgmxiUphv1/+jafKoXwZFyAZvSdL4+NbI+TTuQelkhGRoR59p4
	 /9lOpzpHx/fEahflh2jfv7RtRSNQ0JTvPlc3Hw+wq3wikm0WW6QZmq7bkSSQ/78ttj
	 50fWlKqZ5b8UKxGdcVi86sQJcUUPWntvV93imARabYkf0CE3UVRQexcmjIhXTU9col
	 otrOx3sUO9fNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1990E383BF68;
	Tue, 16 Jun 2026 07:54:44 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <28f00610-4a45-47f5-9e08-468c31736090@kernel.dk>
References: <28f00610-4a45-47f5-9e08-468c31736090@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <28f00610-4a45-47f5-9e08-468c31736090@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.2/block-20260615
X-PR-Tracked-Commit-Id: c7c76f9232bd34835d821f14abdc5fafc17bc938
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba9c792c824fff732df85119011d399d9b6d9155
Message-Id: <178159648268.515891.5399769672022950909.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jun 2026 07:54:42 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 09:24:22 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.2/block-20260615

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba9c792c824fff732df85119011d399d9b6d9155

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
