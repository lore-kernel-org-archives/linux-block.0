Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A450E3909A4
	for <linux-block@vger.kernel.org>; Sat,  1 Aug 2026 00:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545858; cv=none; b=HiI3oz3K+Z0r+mTU38lKc1pmhdqoIErkqod2V8Lkr0AyYjh8tR6fSU5c4AhKkpqQVs+u0Wfz8cM6xmN68kGaKEfB2Fk5mdrdn6/ht/V90CIHM9nt00FTZ/qqDiqPhGaDU3PhV6od4vjfqoFdo9izwjnhDIt2uD7TvR8aVn2f9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545858; c=relaxed/simple;
	bh=UfzlsE4auz2T0YqxGu5mQMU9Z+c3EEhT8CrFd68zZy8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TzKzMY3eihOfGj6jNCgLoUp7TK9jyiwZ2x78rpltcegGD87vtUJmNCX58VFq3X/ZdjHHAzbzra5h8OtXuMzswAnBcK8h+fiGnnkuwDVadPnznrnWmZe3qWtKTPNJqRUjEHVGwnZcGNtjunT59owZnCYnBrssHOfX2yTi/rGFUnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZmy77kH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZmy77kH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711D51F00AC4;
	Sat,  1 Aug 2026 00:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785545857;
	bh=+t+ZmsDD+y3YhZYzTKyvzaROjMFv1wMariHeOCP5XgQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=VZmy77kHuH4TrVnMEQFDzH+23vgJGjIwLNCq3m75mXP0WrsevSWaEgPHCPhNJ+Uf+
	 dbV0XB196DvVsRjUJtHexioMtecX+f9ekanZ+JueW50MqdFBmSb4LsvyNYUh+1AWz1
	 RKJ7vluxfP982iclVOWsW8DlSgDBF9+0W8+ZQ7Blq+gSWC4LcMC6QN2avgz6Sph5+d
	 JsaygsUNOwm0k9HQhfHY7db/CzmgFr17ql2ULkM7aS7fLJ1ZGKLL1H2LMCEi9jCl5i
	 J+jdUQmLSSjiUC3NwgWrhUhoepZCCKM7XgskPqd2WeCZEwGFP/RmZZsX3+a/xun/2J
	 oGutTJU09MA9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AD4392665F;
	Sat,  1 Aug 2026 00:57:01 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 7.2-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <8a90f8b1-1b86-4fb5-aa5a-8d292aec8e70@kernel.dk>
References: <8a90f8b1-1b86-4fb5-aa5a-8d292aec8e70@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8a90f8b1-1b86-4fb5-aa5a-8d292aec8e70@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260731
X-PR-Tracked-Commit-Id: 7f40b346462f563a0d6e841a77b5163d2a882a04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f01618fd7915bd2acf945e47bf987383a60c4c45
Message-Id: <178554581987.970149.8401626373217391223.pr-tracker-bot@kernel.org>
Date: Sat, 01 Aug 2026 00:56:59 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Jul 2026 15:44:52 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260731

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f01618fd7915bd2acf945e47bf987383a60c4c45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
