Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125E2080C8
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766253747; cv=none; b=HydTAaOhdbPf+xXqPWCHEKNXs8PSpXAQ3EF5EY21eFbdHtt9OIXB5GJ3Onraio9RAzvIai+6KRqVHo7QRp8VI/mC5Pcb4p+n7R2eyb4pK7cI1x5unmzWoB4CFLjp20IoW2SezHA4TeFSW9yN7fuDrVz7oY3Y/b0a05tBRTSXIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766253747; c=relaxed/simple;
	bh=Ht+YK64HAlmMYMlG5xHKQ1e+0yfovRxgkOHtN8Dw7H0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DymHB3EeadNKKUbJuLnEWrTA+qwRfL3pHecO1ndYZhLRYTfh5ifaoGoYKjRWgcuvvcKcqXI+wXOrh+s1k7J8rEKmmLc+CA0t3sE0dg1BUs2fRf1OmcHdxn33rOdeZpzARG+OlHNni9J0Y8rv2T0U9GGyhApzykDDCwaf5KTkR8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJf9qL5O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJf9qL5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B7EC4CEF5;
	Sat, 20 Dec 2025 18:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766253746;
	bh=Ht+YK64HAlmMYMlG5xHKQ1e+0yfovRxgkOHtN8Dw7H0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CJf9qL5OPdnz+MzRwXZZsLoK5fxH858FYyBAgkawTIbx3BDzdEIaXnfpKyJnOxOLj
	 tqUPC2lpyCPnBHdd5RAvpFF0zufcL4oE34hHDRy/YqE9st+Js2xs2JdHFI24XAf5Vz
	 OdNK9p5XYrueOQUgC2w3K1OOiYhmCAkZwPNIxJVBM6RnsiF9UuwKHZ52pCxszhwd09
	 rgOFMN/UyxKyQIP5I8YWu57ozJ+q8rqea68FAXj+YuUz80yn4OmBJnvuTWPNg2fcRx
	 V+D0/SOYXXIZx+X5y/FsN9m47C6nXsNOuBN30dQRB4/gw8xbuywlfeVRf1GTRzzylC
	 wkgLx/gvSZExw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B9BC39F1DED;
	Sat, 20 Dec 2025 17:59:16 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.19-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <32fe4659-1347-4bee-9628-1dd1ce3b1987@kernel.dk>
References: <32fe4659-1347-4bee-9628-1dd1ce3b1987@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <32fe4659-1347-4bee-9628-1dd1ce3b1987@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20251218
X-PR-Tracked-Commit-Id: af65faf34f6e9919bdd2912770d25d2a73cbcc7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8ba32c5a460837a5f0b9619dac99fafb6faef07
Message-Id: <176625355482.102235.5876832879876354313.pr-tracker-bot@kernel.org>
Date: Sat, 20 Dec 2025 17:59:14 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Dec 2025 20:47:14 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20251218

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8ba32c5a460837a5f0b9619dac99fafb6faef07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
