Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A816DEB3
	for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752867466; cv=none; b=V03/ev/Xb+PXCyQ04qrDCKNaYXXsfLnsHawj0lEIJnwAdp9TaXmTZLsqD4Xqs6wX/mWBTqI2tqqjTKUdLxTOWdfJpgtMwSg1NzBU/RtS2N4x+1la+SMDSfVl0vUcL/Zv+jxFigT7RLRb2hs+ROcMrOumUgaDcMC66qoI05nicbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752867466; c=relaxed/simple;
	bh=afgVbMlSLFmQ9dHWy9oDonNp6CvwT+qqwn4xIjcpv3w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DyMg5P3DFLqVu9yoIsiUSp9yeLjw+/G/+3l2ZwnTgr8G2DLDdklzPi9xVqZZt3KKqbYy3GOMO0X5lUYlJ5Syj/IqHdG9NM4aA4SuN5T7hjkr8F9goPqh7gPRZ7Hahnx8MNp3CukjbzfBkD88kS44ggGUcslmUBEGbk4sGYWkbEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fir0Zjw5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fir0Zjw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA33C4CEEB;
	Fri, 18 Jul 2025 19:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752867465;
	bh=afgVbMlSLFmQ9dHWy9oDonNp6CvwT+qqwn4xIjcpv3w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fir0Zjw5HiZgZ05/DqN3xiwcobc+M7acSSOcEpc0jaXzNSbkT7nzI7V646B/PLPi4
	 ZzlJNyzHsunKWAoemgeLUJZ3Ex8XSnpWj13aa5SDumMxHpdDvdmVkSsoW15O0ABzbs
	 PwtZVDH37kGMm8lrUn1hcuH+yWaKSHryUObaYmWGFxGn5hDLb4bR5wB6x0VDHQUgUj
	 OZYVhD8XttYmu0gFF9KwTXajiMG+nXPGKeP6BTYF04IsJfCLqxioqCuEew1FIpN3BK
	 O0n6If/vtqLm+aUURE3LCc/Tp/5wPDRO/ekxXpwIkl3gGdW+tqRJS076PFG5W6WzZq
	 6CGsDVUgIMxyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC00383BA3C;
	Fri, 18 Jul 2025 19:38:06 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <effd0d40-999f-4590-a10b-4422daf91662@kernel.dk>
References: <effd0d40-999f-4590-a10b-4422daf91662@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <effd0d40-999f-4590-a10b-4422daf91662@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.16-20250718
X-PR-Tracked-Commit-Id: 2680efde75ccdd745da7ae6f5e30026f70439588
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5ac874257bf06eba00282e5b627f23b72ac8f7d
Message-Id: <175286748546.2773756.5415345001261123495.pr-tracker-bot@kernel.org>
Date: Fri, 18 Jul 2025 19:38:05 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Jul 2025 10:55:35 -0600:

> git://git.kernel.dk/linux.git tags/block-6.16-20250718

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5ac874257bf06eba00282e5b627f23b72ac8f7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
