Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF6C79C2
	for <linux-block@vger.kernel.org>; Sun, 27 Oct 2024 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730055393; cv=none; b=l7n3rInRjk1WYgXBr6uCtAQPQv89IZ/heV8yCplkBZT08llrZP7FRhEbUE2Y14FqTdfCg9BftIg8EOp4M4alY/Vn12HYz/NwOBy1aa7LoP2++Rp95tkwCCFUyT7ay3KiyjVwOHUavBKQUepzV7LtpJcdt6rjemV7DqfPyI9vDnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730055393; c=relaxed/simple;
	bh=DuS7LYQZWAtefFIPZPM25sMZs/adfKCn/j1YGojyhaM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JdCnXW0DlKFj49+9ZrpXqceRKD49avH9+cLJ+llhY3ziGI+vnDUjAHoa5YppdKF2B1FBkP+MCxByL2NjPKkfm5Q8YjwIgUfRXAHkGrxMblDRuSgxMMVXqml7lqxiOtTLLX2WecUQXcF/DYaMlZJIiaGZtjxNkoftCq8LIeSessc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLaW33OE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLaW33OE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA062C4CEC3;
	Sun, 27 Oct 2024 18:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730055393;
	bh=DuS7LYQZWAtefFIPZPM25sMZs/adfKCn/j1YGojyhaM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aLaW33OEkR0bwu/pex2qmDKi9ZMgKVebdvac8w6rH5e130jAsAr0Vr5WAnzRLkZlF
	 WR15iAj6/vAPHGosm54JC8iZX9bPEAxgA1aepjPux87O834M9PutoCgJFlcDapuA0K
	 JyMz3HBCjz8OQvUJcwmK6FESO0r0kFXMyWcCromZQCXhar9fHZClSIAH5JgyTUuy13
	 F34uil0v5Po1ECbGxbKy+vandXBYcwUX+zbfbJ02lt32jooISgloi1ItukQlUjhlq0
	 oVw2VPw/el19t6BV1547yBjYZ/046x8Q/kTcgx56T4S+DUPYtPfRKXXIRK5H0hVqC6
	 kUKGFEdc/dIWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340E63809A8A;
	Sun, 27 Oct 2024 18:56:42 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ed75a79e-3b85-459d-9aa0-859957e0f4f5@kernel.dk>
References: <ed75a79e-3b85-459d-9aa0-859957e0f4f5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ed75a79e-3b85-459d-9aa0-859957e0f4f5@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.12-20241026
X-PR-Tracked-Commit-Id: 2ff949441802a8d076d9013c7761f63e8ae5a9bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75f8b2f52632fbbbbabc5e9c3a6f820282ff8920
Message-Id: <173005540085.3429718.10897615475851489725.pr-tracker-bot@kernel.org>
Date: Sun, 27 Oct 2024 18:56:40 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Oct 2024 07:19:22 -0600:

> git://git.kernel.dk/linux.git tags/block-6.12-20241026

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75f8b2f52632fbbbbabc5e9c3a6f820282ff8920

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
