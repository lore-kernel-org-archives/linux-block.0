Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDAC374170
	for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771350899; cv=none; b=u+d1g+PzwF1LFJbqjfpuvTrxO28Tc7ZMa/9Om8j6/RK92GfSvrwHzvz1IVXjqRoe7NZPFudIIOXvQF7kNgJAbP6t+d7660NMEJ54o2LThga7moJflOXIiggZyh3b9xqWGrYL4wMZDmwPZIzGUmu1ZCi+qlpFGsHyMhuZRfAgtK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771350899; c=relaxed/simple;
	bh=awyLbk7+IG/vYj0lF8jc6kJasU0KuVk+0nk3ENctSTE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QQB1szLvYA3OOOUMQo6iVVVVOMo1qX8KFGoLNij2Q7ctKj2l/4oBhr0j9QAR8NoeJLL8q7ZykuGSoUs9i07YQ2VmuP4kWh0FiLjSlyo2mXr5xA8SBkFHBbNgEYEc/uk+TaRSiKTy8Nf/peI8dh1f4HGQYXzS6g+r0mztnw1VFL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugtp+Pvy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugtp+Pvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A209AC4CEF7;
	Tue, 17 Feb 2026 17:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771350898;
	bh=awyLbk7+IG/vYj0lF8jc6kJasU0KuVk+0nk3ENctSTE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ugtp+PvyHVHuAaAXla4NVOyi1gQg24RT8p2k8GOq3wNCNKrBV8wXbuxlCIn8o/prx
	 NUvw+sW1sGvqHYn21aJ8jFrhDrmojlUKiSIcMJQCx0+SVzChQEw/forTd0gJCfVeKb
	 6LzlPbKtLVtz7uYqmTpfJMqBeLBQ8tN2YAol5caSvKdC2e9Q0OkVgQdMgaCK82xhAs
	 NsTNyQ5PvYqr1qKxzbu9p5F4qCLlkLnkp/jB5gmxrn4wBm0hNHR8RKbsiotM/Vdl5E
	 qjN5n0ijVb9E9/a/CXvjefq2XHjqHp/+2i8lFdITeJWXGCAu/tNIrP49N4Odps5ZXz
	 7ntsLvG6yFjng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C2282380AAF2;
	Tue, 17 Feb 2026 17:54:51 +0000 (UTC)
Subject: Re: [GIT PULL] Final block fixes and updates for 7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <bb793bbc-5f7a-4cb5-bb05-5cdaa0ab8a7a@kernel.dk>
References: <bb793bbc-5f7a-4cb5-bb05-5cdaa0ab8a7a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <bb793bbc-5f7a-4cb5-bb05-5cdaa0ab8a7a@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.0-20260216
X-PR-Tracked-Commit-Id: dfe48ea179733be948c432f6af2fc3913cf5dd28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99dfe2d4da67d863ff8f185d1e8033cce28e4c49
Message-Id: <177135089052.577366.11903462426708074216.pr-tracker-bot@kernel.org>
Date: Tue, 17 Feb 2026 17:54:50 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Feb 2026 20:58:49 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.0-20260216

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99dfe2d4da67d863ff8f185d1e8033cce28e4c49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
