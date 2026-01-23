Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3CC2DF136
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769203495; cv=none; b=DcFTIHo7nG+i+FL/R0tE2g03JF8NALnKWJTuQTvqPArr6r34do3VEEXsocwZILYS8M0kFoMSPKvF6R5paYqQnx06X7Z1B9Dyw+nQV1OsNAK3Z+qs7pAQoeq7QkGmLykmcvCLo2AIJGafhT6rXPBM9kCaIiJTjAk3kWPO+a+shyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769203495; c=relaxed/simple;
	bh=ELdgqiJ1aKH4ZjB0BRp35dScfAcil9YOXdi4a9UR4c0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cS93acbN3jn3PRMH49ZcicToDXqK4pODa0OFg23Sc8c/xhEcOoaT5zPA+qQZnWCCPrP7Ds7lR2mvRstWnXt/0OkvC43NIBjutzab6cgtZq787BfSZsvm/VkRMdUhv5/wdZa8ltozz73ATB/LIfgHdczZif745AqGgGAfPt4/v0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRyakRwn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRyakRwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D294C4CEF1;
	Fri, 23 Jan 2026 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769203495;
	bh=ELdgqiJ1aKH4ZjB0BRp35dScfAcil9YOXdi4a9UR4c0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BRyakRwnWQYbj8VMyixk2U48+VDBGToKgP46gCe3wOWVYEcUQBpmMmrM6IGIhdt93
	 LE6yNNO1thMzZVSaOcqCJnIjVYhy+x7lD2hjKfLzKAtRd3+TehYoYD4/0O4irueHaS
	 U9z4OuyUBgiK+TMlgEmO1Xc5pVon1lDPlY7Lx4biymO7c9Pvb66O7LjmBD9Wu74ZeF
	 39+fs0p5WBAyB+dvY1Q1nMpg1cSCjiC1iqYjF5UGBnf1nvOR3NQRP9x+IUksdupMi2
	 vmxy4LVby+lXNIRLvZtEfU88hPO/dha6ceFnTx11u6ekJ5/CCvKReZ8FfHOPKF3hBJ
	 sS0eaWAozkVnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BAD33808200;
	Fri, 23 Jan 2026 21:24:52 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.19-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <361664fa-25d6-48e9-9e7d-6cf7437cc9ce@kernel.dk>
References: <361664fa-25d6-48e9-9e7d-6cf7437cc9ce@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <361664fa-25d6-48e9-9e7d-6cf7437cc9ce@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260122
X-PR-Tracked-Commit-Id: 3ef825dfd4e487d6f92b23ee2df2455814583ef4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00d20db21e0ddefa0578a6b510f331ca34880f74
Message-Id: <176920349112.2720183.16612605514524492938.pr-tracker-bot@kernel.org>
Date: Fri, 23 Jan 2026 21:24:51 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Jan 2026 04:53:37 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260122

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00d20db21e0ddefa0578a6b510f331ca34880f74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
