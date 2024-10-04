Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E5F1E376B
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064225; cv=none; b=s3rZEC9gNlH29Xu4oGJRZ17w/24DHj6oQYs19WJ2CtKBXNJHbip2w9ksqNFrksXjgvgSOwj80I2L97pDZlE8SKnwI5ta6HGXwZwIoGqf/FLuITPMH6GgHmTZUe7WZI2WSugM1ggUwWEPjP0IPzJcHq6J2fyKoh5EQydKixPldBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064225; c=relaxed/simple;
	bh=RglY3TbkAOS1BRogoTQKJdu/JcBiZhLv6fxuhyJFx0M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LebmfhXxYrJ7TyNGXpdBkyU5PFz8NtBAg734/i99WnJj+diz5jP3684eXE7YpZrmyuHRj9W06luJRv3fkE9mfEFtLa33YNAtgCN06l8x5IhO8prvWDDJbFh+zg9gr/Xqh54rc0mH8d8twOwQbl09lavIbCsbS29BC6pk6ZUMQ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBj/NSIu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBj/NSIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2786AC4CEC6;
	Fri,  4 Oct 2024 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728064225;
	bh=RglY3TbkAOS1BRogoTQKJdu/JcBiZhLv6fxuhyJFx0M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XBj/NSIuMDH1wuI4dHpTe6QQYItoxhlI2lXspZ0daJ33/INT1vFeSU36I/hMo48QE
	 p9blKKnh2e6ZJX3i4fcQmgOd/jHuoDFSdRhWsSGdw7FCo5+ZpfSf60jvPTD4fBWKJg
	 5FXCu1SypR7VHJ0gHoah7C7FcvbdD9VbpTmfyI4qjwkyDwYySRBGk03kZa3rW5NmJx
	 yFeAFBfZ5Sk9JooDf8wJjKCdG2SFZtix+zOk92nTBIwK0gLc1shxt64x+3uJgX3VVM
	 X+YF1JBCbYxPSJK0XXvav00DzlNvJgOwAtebyPXIrg5CGxG7JSsUIhyBXBlpGmyw2O
	 6yqWn2ut0KK0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBC7B39F76FF;
	Fri,  4 Oct 2024 17:50:29 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <bc04d464-e0bd-457f-83d1-95f12b95f54e@kernel.dk>
References: <bc04d464-e0bd-457f-83d1-95f12b95f54e@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <bc04d464-e0bd-457f-83d1-95f12b95f54e@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.12-20241004
X-PR-Tracked-Commit-Id: 6d6e54fc71ad1ab0a87047fd9c211e75d86084a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 360c1f1f24c6ab1dfe422a81a90cc07f53f378c1
Message-Id: <172806422838.2676326.6774904858424659951.pr-tracker-bot@kernel.org>
Date: Fri, 04 Oct 2024 17:50:28 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Oct 2024 09:11:01 -0600:

> git://git.kernel.dk/linux.git tags/block-6.12-20241004

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/360c1f1f24c6ab1dfe422a81a90cc07f53f378c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
