Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B05216419
	for <linux-block@vger.kernel.org>; Mon, 26 May 2025 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748287128; cv=none; b=pWisvb0UNc8JiCNw01HueARIlN9s1GfTTXTUBTQfH6aL072QtknGGe7dSijY2/v/5PtHSFRhmXfg5zPtX/Y2Pum1dr/dBHKWr6BIcRTNPE3/18gWT0WCffFk5s/jc67IIA5TmejfR48oXpeBuX9TWHgRIZZCoS/0nVPFk0GXleM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748287128; c=relaxed/simple;
	bh=5dkSGX2SqQmvVIex8G/1IF5+TuHaJH1rhVacDoPg8fQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bKk72FtNUsbV3WIWky8qZSgwqkrEm3VGt6TnyIy+Z11KjqX9A8qxvKg57w5/o6SrN4j+gtBN2Y6wAX63URdPRVZO4JxzvC06/5Jd5k3i9yieFrAvwWuftniqZenMbwk9JDHYiLSrht2R30VFSBTo+uBhp1p5upy0uNERuoyiifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzuY36Yw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzuY36Yw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CE4C4CEE7;
	Mon, 26 May 2025 19:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748287128;
	bh=5dkSGX2SqQmvVIex8G/1IF5+TuHaJH1rhVacDoPg8fQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BzuY36YwUrHAxP6poG+37FLuyGEfePA1fUDMMDoEJ2heYdKmi5mX/uXcPWi39WJKD
	 5rQWK4By1zJCjhKqgKHYToJcc7dh6EpoR4dcsf90xE/0JNSzgIrLImfrGlddSqTUNG
	 qakfmgopHQkVVbQSV4KLlT1odsYqHVQY15Jm7Rw/+ji9XPj+xFLEUC3dEGFXzrkSsl
	 e5rekjeB+hfwaIjqh/2+rrpx4DRrH/mQmEn7XaJhLGMzUlLqskcEfv0cVAOkkGBD5L
	 TBsH/HycUjxS+dHrs4h2wxQqQc41eIdMO6PmYizgCVKnESSMqwbjCTGNMI+HWxo0ec
	 C632XUMZ+MTfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2533805D8E;
	Mon, 26 May 2025 19:19:23 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <13d889a9-d907-4838-bc26-9fc91ace425f@kernel.dk>
References: <13d889a9-d907-4838-bc26-9fc91ace425f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <13d889a9-d907-4838-bc26-9fc91ace425f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.16/block-20250523
X-PR-Tracked-Commit-Id: 533c87e2ed742454957f14d7bef9f48d5a72e72d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f59de9bc0d576eb5a5edfea470527902315e924
Message-Id: <174828716255.1020600.7251846555612555659.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 19:19:22 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 14:45:22 -0600:

> git://git.kernel.dk/linux.git tags/for-6.16/block-20250523

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f59de9bc0d576eb5a5edfea470527902315e924

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
