Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D72D47E6
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821277; cv=none; b=S97drCmVBKDXPlyHy0B+LCJIPPcPTJXlZsDvREmzSLmNlvirtxfDKzb/W6Fke3KiWlSpfUtbn7qq7Ljlm2gIG04aHbhrjsZDttEdVvjlyfRPw7WA33ouDe1/aWVGHriupJkDYNt4uixhH8KwUp3oxPDBeJq0WiYiyx9WEzMl68o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821277; c=relaxed/simple;
	bh=yk5Jn7ASLRc0uzcVR4LFRPknW2FRPibu5Ln6ZcGozjU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MOmmAiwxSpPOpwiW5DoVfQfExaEs9ny29ktw1OqygZOJ5/ZZ/Z/l1zJGStqGaTu+/2JZUzYRonTBbL4FRNEfXVPLEUyNAmXPXuoEe9TBCMfDEQeOAUGG+o1M6if42iL6dqu8qQGrkhRj8NBeggm3r4C9y65MGnOvik4Uym7+Rwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIvEKYvf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIvEKYvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13967C4CEF7;
	Sat, 31 Jan 2026 01:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769821277;
	bh=yk5Jn7ASLRc0uzcVR4LFRPknW2FRPibu5Ln6ZcGozjU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JIvEKYvfQb1hzZh46qYZkhu83vR0mJjdvfy0f1Vdx+yrhO71dVcpUhJfAoM7pUMcK
	 akezPFvVpiTlySSH4vtCmYjQ4GCowo+/n6IQoUs7zMGAH+Sy9kKA4r3OopckdLe7lW
	 FKCjzHdnHVYVL1TNV3KwrfKUntDFUwlNx7o7k/urCfLjybVhkFb4hkqsITDwkowA/X
	 gagtbPg7znoQsXYxGe47VWyJmZZgKZJ40FufbYd+rmejiswDfinE8BSY10yEBG0Qs1
	 USrVJKkdQ+rIsfK5ko3RJQnGpAMdEBzEciwNyc2XJA0YvMrYAUCTLqWAJkRk9NzmXv
	 oMvecinW98bFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BC56380CFFB;
	Sat, 31 Jan 2026 01:01:10 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.19-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <33de2c33-8142-4909-afdd-dccc8981b3c8@kernel.dk>
References: <33de2c33-8142-4909-afdd-dccc8981b3c8@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <33de2c33-8142-4909-afdd-dccc8981b3c8@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260130
X-PR-Tracked-Commit-Id: 4da7c5c3ec34d839bba6e035c3d05c447a2f9d4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03610bd6b53cc5e42ce767faddd489220f0011ef
Message-Id: <176982126917.3947395.17407449517329213976.pr-tracker-bot@kernel.org>
Date: Sat, 31 Jan 2026 01:01:09 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 Jan 2026 08:29:20 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260130

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03610bd6b53cc5e42ce767faddd489220f0011ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
