Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C61A2E06ED
	for <linux-block@vger.kernel.org>; Tue, 10 Feb 2026 02:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770691423; cv=none; b=X5LNlyYiqQafK68ZZRRFgAMII/UnbIceWgO2SIFpVTa4fUrJrJTfUAvpLcdZ+iP86zE2gWyhRgEJmJSIF7JhU9KtZM1fSM3r6pD9FvkPpm6pcMueKGpPFnqSjQ9T0Vg5xRPXyCFBuroNeOBZhroxYNaujq94vf34s3ZG6IY3t0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770691423; c=relaxed/simple;
	bh=++MAaOHcp4lp1hjgkl+6uqgSDrFHJoQimJf+K9D0PQo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZmgknK6o/m+9CR1MZtI9xivdds/64iNaTSFO13fI3TyOBQqwesjakoDa1kWMUKasgUJitkRVfiNCdeUBnCyYLxtT3z9iyWlrzUJnH8bDy8pT9vLxsgnoof5NsicuccmR7Xp76uk8GS9z1g1vwI6vNLzoBJC/cr1RVwvtawOfmJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd62ez6X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd62ez6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4382C116C6;
	Tue, 10 Feb 2026 02:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770691422;
	bh=++MAaOHcp4lp1hjgkl+6uqgSDrFHJoQimJf+K9D0PQo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xd62ez6X94Eo5QYAF54YikSsYJOCf2NoS5+xiOXPqgsTIo9C8Cum9Prrb0qqT7Uie
	 mKwRe1I3ebSfkn7FAsPwZPdqN7xImUrsvey4l4sa4yMTXmKDxHmrJdGCb1WZK9IYh/
	 e/vZQYO2d4u28WREPM7F1EKn/rhdQ9nfEQniQ5+4Sgeprb+2eD1/tYYWJMHqLdx/eJ
	 m5DdWwN0bTXeL1B34LcAtoIiqQlEvdwUjxVgWrsmeSsnf0O/b3Yz3F7/Zrlj5u/BLw
	 iHz00LKgtGkEmd65XS4sM0gyK+cLITbiHF8VRmjBgQ4kwCAXnhQ62pToU76yiMjND5
	 /Xtk+DtX+YaGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 85039380AA4F;
	Tue, 10 Feb 2026 02:43:39 +0000 (UTC)
Subject: Re: [GIT PULL] Block changes for 7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ae61b996-c874-4afd-b8e4-4ff3f90dd3e5@kernel.dk>
References: <ae61b996-c874-4afd-b8e4-4ff3f90dd3e5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ae61b996-c874-4afd-b8e4-4ff3f90dd3e5@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.0/block-20260206
X-PR-Tracked-Commit-Id: 72f4d6fca699a1e35b39c5e5dacac2926d254135
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c00ed308d0559fc216be0442a3df124e9e13533
Message-Id: <177069141805.3309876.17046937157717897579.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 02:43:38 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Feb 2026 11:58:15 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.0/block-20260206

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c00ed308d0559fc216be0442a3df124e9e13533

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
