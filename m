Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22172853F3
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772218786; cv=none; b=jGQJFpNr6RPvAErSIj06Svb3irEOpKcIDbr28o7HXb5NqFN9xVURRU4r7zf6KsqCHVCz/XERPAPjEp/gzwqZDz58gEQ1iP1mmOC0XYCzHgK+uzonkakQMXlnMqs7t+vhgMDntV39uBzvPMj8oJkzKjxKbjah6D3YZY0ZF660JPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772218786; c=relaxed/simple;
	bh=XcIkmx3L4LbIf8TKwxWj8byKa3YsNkNXdOBHj/oVNXk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OpT3MM3jXPFErbgJ1QLMvhw7S6HuuHn7MalO1oFwSR3Sj9VYegxcCGUIpdogsToy1UjrbpFvQmonUeNznBbdXgYTYHFartCobcYVwS78fCz9WSxTCEwtYEEUAskTPXG2QMEepQ2To84avkpEzF05URkMq7QwlRRPXUpnDBz1GFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCI6ZSOs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCI6ZSOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22A5C116C6;
	Fri, 27 Feb 2026 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772218785;
	bh=XcIkmx3L4LbIf8TKwxWj8byKa3YsNkNXdOBHj/oVNXk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bCI6ZSOs3LVl1FK9VrAqFEH3MAftHhaSuEI3NNSbAC+CEQ0/AqDPWpjxmmOqjxBQY
	 Uvl/ICVwzUWQMyUP9NNIU0A8eEAWtitVXhDndAP5ZcOMachKja29PjATHU2G2nvMmE
	 kN38SgV9j341hmPxHGg4/5Gi07G1oNzh0IrIElFijBCAXJ8Zqdbs2GXLbNV1uNN+A0
	 ILNRtBWTYAFRUEgq1inPxGf7szXJgil/sDjzSR/9nOCpVmXJyFwBb0yGm/LNO4eNOO
	 t0fkfu9MyT58TtgdKrnCblWUPVGNN2PKnd8fxkjLZBjjLhH31mkdupVTY2UQZAcHog
	 wxniw3WwMgrRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9ED139E9614;
	Fri, 27 Feb 2026 18:59:50 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 7.0-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <4cdfcc4f-2cf2-44c9-9365-a3babf9a05d1@kernel.dk>
References: <4cdfcc4f-2cf2-44c9-9365-a3babf9a05d1@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4cdfcc4f-2cf2-44c9-9365-a3babf9a05d1@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.0-20260227
X-PR-Tracked-Commit-Id: 3c4617117a2b7682cf037be5e5533e379707f050
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78d964c47f91c22e9214956316743d2759cd0fd2
Message-Id: <177221878923.2713791.12275884184998189830.pr-tracker-bot@kernel.org>
Date: Fri, 27 Feb 2026 18:59:49 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Feb 2026 09:32:11 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.0-20260227

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78d964c47f91c22e9214956316743d2759cd0fd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
