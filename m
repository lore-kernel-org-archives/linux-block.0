Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5B45FFCF
	for <linux-block@vger.kernel.org>; Sat,  5 Sep 2026 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788626244; cv=none; b=Hflycn9Fvs/ktU6b2prTdAVW7dld+HLLJITqzN1Z5Sy47EKacaSHQeCnAzwFAZulRHdkynQxohYoa6hTsYIX1bI3+d8vE1nw9hYwa8eDtP6njJRj1Sj4hjsEP2TbXnPHsc0FD9E/0FOGR1QvLdCYeWO0Gwruxc4izAUvPvJQ22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788626244; c=relaxed/simple;
	bh=AMYcnn/XW2no1i41k/bfIqCIlD2fh2D6Act6W14F00Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ku0yJz83hSOJYDgsxqHtl0gukl+AoQ6NlK9vwShp9hivKCjjZyOwPG7rgiuq0Na1jYOxUJZySxIIEK2nEhrJqII54+g5lBCpitEZi2NpKY4uKNtGofflgxDZc2ZdsZzii9H3D8bi0RSGiTPJz+DG9FZU9CybWJkJei5qxc6PfTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6GE8iWc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6GE8iWc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7B51F00A3A;
	Sat,  5 Sep 2026 16:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788626241;
	bh=WUljpZtYw0HqvIuhnl2x7hIPizuT38sIdFqRLR5r9b8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Q6GE8iWc0iGsjW1ra/LaduHWekM8GqenBdpf4J7yyFji1aSH31tb1eVYx7hatszIw
	 el/VL7v0KHMDE23UZL1BMQ1XdJVV79GjIzp15IZfTyjRL3L0zYqKNT7+kNrfkTbP54
	 Zg1hMi7stR3/J+KHsnWkJqZ618pe/oNd9VMEv2cPU5rou3SvyyVL4R1CfSiwyGSkEc
	 l6elsLX2rjxd7IQ+5YG0XqTTZzGQQRHRQOZ+i5POPTBkYmjge2iLt4gi4wYD8iAr/Y
	 xz4kSRXaPKSh11P6R8YUqvwW5edSpkT5ikkHgNOmEm3HHzS+8vP4lakSO0+IWkHsJZ
	 bXkl0z1cn8hDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199E03924FDA;
	Sat,  5 Sep 2026 16:36:23 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 7.3-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <fba0a84a-488f-43b7-b4da-0746180da780@kernel.dk>
References: <fba0a84a-488f-43b7-b4da-0746180da780@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <fba0a84a-488f-43b7-b4da-0746180da780@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.3-20260905
X-PR-Tracked-Commit-Id: 00ef2248c5dae08548f7ceb6951b022f89905330
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0fc310b4dfd334023b90d2423818044190c0f68
Message-Id: <178862618168.1285306.15537499930807127783.pr-tracker-bot@kernel.org>
Date: Sat, 05 Sep 2026 16:36:21 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 5 Sep 2026 05:21:07 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.3-20260905

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0fc310b4dfd334023b90d2423818044190c0f68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
