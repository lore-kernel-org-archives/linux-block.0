Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4873DF01A
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782407441; cv=none; b=ZRpLWUQKxB2o+/VgNzkhGSm/gkuuRU/WxfJAst/+sJEv+PMiCZQjKJgRjtCI6sx7Yw7QViMzOWUhJDGpAwegjwl/bax5GNueUg3JFuY7Y+wJAeEY6s16SLez5vb4uDrKU+n2Jke/QF5D7Jbbxn3k8/JMTBvWpZsR1q0L6x+HU+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782407441; c=relaxed/simple;
	bh=2fdfWf52xKLdwsmEyc7q6w2MRBgfNGe1PJ9TBpAllj4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J3ZKn8MhMYiFgYlMQRHR4kpQf3rAyZLP9uGDOzC22+Hxcf8W2uoemrX2b+PoeBZa81Fjele92lfnxTYMfpvaONH15c2SPWXlk272TNnIiwW3pZ/50X6b81ilK9rwo8BSI3HminpGWWFID7ayOhu7IrcCeCxe4biq5NJ0Hj6yZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7cC/RE/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7cC/RE/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045331F00A3F;
	Thu, 25 Jun 2026 17:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782407440;
	bh=vbiS8tKg+35Ibh6ZxiE6fh4aSh3Foi/NendKOi7r+rw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=N7cC/RE/EPwrUtCEhOjkzbskhZbyOSbGhZhcrjxEBl53Nv7Mt7ZCdSHQeXEKp7Djv
	 EPAnYs7npnoalJjvVu141ak9yow2yJgvh50kFDmxQHwivGtZNDDeVlvhu8VGakUrii
	 CC/gZvF3vJ7V2Su9f+0URxkWpXD/+wmC97FQO5vl9iwyOUS2s7XuzCrwwD9f0e8mwm
	 plfNotNZYNAV1RWMU+hccdkB/0IMegrUDrkf0PeyVIgv4jW4NnxcFfkg4xWr0yqDXw
	 mAYMVeTByPAFcJoXyayf6DIc3jxd+5pc87d9Fm7v5vzkDJ4mCPbtV/qbaHz0+6e35U
	 iUJZxPM2FWEmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D81C1393878F;
	Thu, 25 Jun 2026 17:10:28 +0000 (UTC)
Subject: Re: [GIT PULL] block fixes for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <824a5290-065f-4e38-ab38-2a4ac86f020f@kernel.dk>
References: <824a5290-065f-4e38-ab38-2a4ac86f020f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <824a5290-065f-4e38-ab38-2a4ac86f020f@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260625
X-PR-Tracked-Commit-Id: a1c8bdbbd72564cebb0d02948c1ed57b80b2e773
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a142da0b2d32b68a6d1b183343bbe43de8c222f9
Message-Id: <178240742774.72942.11952555069187853925.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jun 2026 17:10:27 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jun 2026 06:12:58 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260625

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a142da0b2d32b68a6d1b183343bbe43de8c222f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
