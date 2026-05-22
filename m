Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D290357CED
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478748; cv=none; b=EaRfixuRdd17uoSZhXF/LIk5ZctJc6RInfqYWO+SwTdK/YV5vr65DvB4TEGgknEJfLLz0K92T5l21nmMjZu9maeAgUIaqleyiGVioxI92riVEDIdBdnhSADu8K8ZG5oPVqwAUQKsKMoXN5nfP28OrdaMMyjMmYHm56EeFEgz74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478748; c=relaxed/simple;
	bh=1TEK7xpb0lCTBautsJOrszInMvJw94L/RlIoBE28Nfk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Vgf1amnY8W8w0N5VdAYE8fYNOOsYgaLQivIKSx+Ed0N3uzP/ciGOHYBr/hoNt4ToZex5lv5u0BJxzRI09CWvMT6z5eDuQgwVM4mXCqyhebn7EjD7mysMleSK4AOcZMst4Dbehv7z7g0a0adrcTVycYh1DHqpurzX+AzRVKR4Q7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6k1sUUr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6k1sUUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D78F1F00ADF;
	Fri, 22 May 2026 19:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478747;
	bh=oGULZSxs3p43O8fR4vUyK9vRChagfeFCaH86HtkWWpA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=R6k1sUUrUXuL656TNGaML9DZ9P+d5ZJybWO5GYncmsTArhSdxoLVvxocF09IP5VHq
	 jUeB0raeWJLyyLUe5UOajPI/KsKwa4ze+sVjO2/Fv6QLdiVpLqQqDSow7Iz21Gm+tw
	 s2AM8M0czToPrEMNBHNY5h+0E3K8y+CG2AV+9UeSqeM1hs1s9ZYOT3fhtUMWZw4MN/
	 2RncZR271SvJ0ZB6Kr6Co/yb2ltnmKrlaGq4kdCQ9LaUqBU9rErpNReaTQUIBPRh06
	 dWqRZIIDheNUzoxyUfr1IDVTLX6ZPc6v8ZyHiDcnOBXpe0BmPppQi+PGYbyA6M25Ky
	 2GuT8h0QseAJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56CC13930FBA;
	Fri, 22 May 2026 19:39:17 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <a050fd86-b9dc-4a39-a274-57bbe1931d42@kernel.dk>
References: <a050fd86-b9dc-4a39-a274-57bbe1931d42@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <a050fd86-b9dc-4a39-a274-57bbe1931d42@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.1-20260522
X-PR-Tracked-Commit-Id: f6982769910ecddabdb5b8b9afdab0bb8b6668ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3997e3bb1d30a426c0599918ebaac51698fcc959
Message-Id: <177947875609.1341212.3122950451972178862.pr-tracker-bot@kernel.org>
Date: Fri, 22 May 2026 19:39:16 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 May 2026 09:53:29 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.1-20260522

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3997e3bb1d30a426c0599918ebaac51698fcc959

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
