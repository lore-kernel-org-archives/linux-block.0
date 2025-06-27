Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538D2EA724
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041735; cv=none; b=EiwgN6cMXvA7eyN8gWuEPLryvAIrNuQH/ZR52m+UVOpxQTSuoN9G7MLhe6Qo3/Xa7Ef24zwAnSzBkQ9jKH+9HaVsJrtUtFp8sSUqFFQ3jhMiPZLftc3dZ6qrRGhzD5TR94VR6AVfBHFiHlOD1UP1ZoZDfwlNJGbZl+J0lHZn7zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041735; c=relaxed/simple;
	bh=R5+EcAQlyoKsJlkNfgBDUQDLRM4ujNvxpvp8/GT+GDI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=e9tu0CIi7stt3ViD31m0kXDcz5AkmRIXrCPsDQLy5aeOYpJOi/zlfwrVIt050F/T2SJ0jQtstcNtmFCPxJprrxjvEY91jtYos16xYA2w+N+6+9KvCTjuInEHrszRcoov0q1dJkbT+fJpI/+U3KLvBrwXpx7QQvszPTlAKhF1bgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXS2seDH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXS2seDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28371C4CEED;
	Fri, 27 Jun 2025 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751041735;
	bh=R5+EcAQlyoKsJlkNfgBDUQDLRM4ujNvxpvp8/GT+GDI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RXS2seDH3Xe/K2KLrp1dp2ZN0kpQQE7xvin6QG2t0SyGiiFwrFWzWXV3qmO6dLKJR
	 cgLb+8fmz7kKWCWzv9EXMTTwYRDGkBh8mw7ovZ/1KFA96ia2TlWOwp6AKhpCoCgz5D
	 pJzQWffBdNm1zkNewPNcpuLXrG1F9MTam54ITTwmBkzbtzKHYYQXFvzojvJuClKKFj
	 2bjJKUBCU74HEsW9Tm+FftFmhLYSs4Z/UeKuhTwYdv6Y9QnOVFeBjNUpIrBuIndW4t
	 slSIoZM5cjlIDTckeHKFvD00rQTak82KbvCkMUCPa6tNUgjT1JGyZCLZdcLHxS7BOj
	 QPW+vpa0qjB3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D32380DBEE;
	Fri, 27 Jun 2025 16:29:22 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.16-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <63eaea99-fa38-4aef-8254-934ec0504067@kernel.dk>
References: <63eaea99-fa38-4aef-8254-934ec0504067@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <63eaea99-fa38-4aef-8254-934ec0504067@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.16-20250626
X-PR-Tracked-Commit-Id: c007062188d8e402c294117db53a24b2bed2b83f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e540341508ce2f6e27810106253d5de194b66750
Message-Id: <175104176106.1986529.18349578049673949363.pr-tracker-bot@kernel.org>
Date: Fri, 27 Jun 2025 16:29:21 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Jun 2025 08:25:32 -0600:

> git://git.kernel.dk/linux.git tags/block-6.16-20250626

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e540341508ce2f6e27810106253d5de194b66750

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
