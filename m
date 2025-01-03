Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A02B1C4A25
	for <linux-block@vger.kernel.org>; Fri,  3 Jan 2025 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735946540; cv=none; b=mjsnlIa8ur43I4NAmcDADwBwyFAb9YkPTg+FGZ6TEqywVFOjMBnB0aP+qh5+Ng4uA+LJr3e19CP9Iqol4JFha1ESRj7HAPR1bOzk8G5EJDmdTOMmoRsonXJiaRD+8n7NKaPSVNmaXEVjVYbg+NCo9NUvrRMNOwFtRzI8at8Orak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735946540; c=relaxed/simple;
	bh=CsBzFYKg1/w4c2guyLRD+KTBdzBxzTZr7XBsNAwgbrE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ci8W9E71z/Vdep2oMZnXiCXGoz1F0zXzFY8s10AnO1mScdNcgIeEllRuKMInCtkDOIrZGcx67F6QOfctHtkHHW/jn+MbxtUKT3U90bV2zfGciFa87tOEBb1NpK0xT7m/WQyauYMzQWuMYvHc7rZx+tMEegjd+LbL2rMB32uqk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRnSE/7C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRnSE/7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C7CC4CEDD;
	Fri,  3 Jan 2025 23:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735946540;
	bh=CsBzFYKg1/w4c2guyLRD+KTBdzBxzTZr7XBsNAwgbrE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FRnSE/7ClecK9rJHFg68v/9cIl6asvdVp+iOM0WjbK9pHrFcQR2yIWzSTEsPSnYXV
	 MRERmijQT8fN2edquRVdiO4tdIkJoLFf5ta18tnZ7tZnH7ngIY/Yk8gf5Z7B/So8zu
	 kOcv95Xq5BDFFoFs3tCyf6b+F9ewUAN08TBC8uwP2HlmUbogpdDJ3pbooENZBQEIl7
	 RHpJJrx3nxZa5KgAfPIe/N53xyYmZAcCPyCJ3ZSJ7waWn3jxnmn5x0e7v3LurybQ6M
	 RV2WFxCs5zJoa7KL7tL3Fi0Fjlds+7ZK7CNGVoMtS+13W9EN4Y6mj/9I+JC/LGFS8L
	 jpJdOWSYHhavA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34434380A974;
	Fri,  3 Jan 2025 23:22:42 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.13-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <4aec2afc-01c5-4e58-baf4-c9ba9dcb29b9@kernel.dk>
References: <4aec2afc-01c5-4e58-baf4-c9ba9dcb29b9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4aec2afc-01c5-4e58-baf4-c9ba9dcb29b9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.13-20250103
X-PR-Tracked-Commit-Id: cc0331e29fce4c3c2eaedeb7029360be6ed1185c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ae3aab55781428eaefecc10dc40ae65071150ed
Message-Id: <173594656075.2324745.12778029342954230920.pr-tracker-bot@kernel.org>
Date: Fri, 03 Jan 2025 23:22:40 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Jan 2025 13:05:41 -0700:

> git://git.kernel.dk/linux.git tags/block-6.13-20250103

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ae3aab55781428eaefecc10dc40ae65071150ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
