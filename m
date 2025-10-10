Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB232FD1BF
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120802; cv=none; b=FoZ/pjtZ6WqJVfovKo8d/LPgeHxr20O4lp0YY+41jnyZzICdR9C2e48W/55s/mBTSv/ixdHcP/7fqoAfk36/4QRqm3GSfX0eNr8QYdzBrWOmp3qPo+P0dXwDZ6US9URQ/Q6G+HrxnvBXDykQrTeXnuW4nDt+ZugdqQ9HWqpdz3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120802; c=relaxed/simple;
	bh=n3tjntqkVxMgnGoqpUKERi7gsEGOX2xNWl+sljCj6I0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Az/2jeKWTX0qdyJRZULvEuxgWY+NznhLN7Rvo8tvRObMFlr2kljpP7R31qo3VWUztkZl/+e8xW67Tyz+eJmiowE4auaaijM4Gx2WPtDDfknm9yi1aWQvrRQdjF0zHt/P1WIqy76KMqEXdu4TDL1VCr9zmiIQhVLOmMhzchiiIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qh/RwBgo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qh/RwBgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAD9C4CEF1;
	Fri, 10 Oct 2025 18:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760120800;
	bh=n3tjntqkVxMgnGoqpUKERi7gsEGOX2xNWl+sljCj6I0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qh/RwBgoj29fzdKZn9zpHdgFA3okEDLItVWoAstiIbSOfG6+B8tLuUJ8jIeJk97V4
	 s9w1LIYTl+mCs+0lQdkwUHGKqa+F9NzY9NXVsCPCuNpu3L9HI1oSLDWwHefvyKlzUw
	 AtXY6BrKjCR0+jD0h246Vylms4gkYvwVEvxuMa+CzArpi4E3hljK60hp9i1IvnfQWm
	 AUNG5ZXuZuXZ1Nd4itm3wk4bWDZ+cJ9/6TdJJbabDkjUReALH+oswLKwl3FAr/Ryko
	 m1RtMUoC99y8XB0hcCMHwcBHGb7/B93Z6zgCScF36UtnXb9jurgjkUKqNv0bYJ3iiP
	 CePZH/9JdYWAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D513809A00;
	Fri, 10 Oct 2025 18:26:29 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <7358f984-58f4-4750-9213-64be0a5de371@kernel.dk>
References: <7358f984-58f4-4750-9213-64be0a5de371@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <7358f984-58f4-4750-9213-64be0a5de371@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251009
X-PR-Tracked-Commit-Id: 455281c0ef4e2cabdfe2e8b83fa6010d5210811c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b1391b9c4bfadcaeb89a87edf6c3520dd349e35
Message-Id: <176012078786.1074429.2410367173237307431.pr-tracker-bot@kernel.org>
Date: Fri, 10 Oct 2025 18:26:27 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Oct 2025 07:27:22 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.18-20251009

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b1391b9c4bfadcaeb89a87edf6c3520dd349e35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
