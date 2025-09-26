Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50644307AD5
	for <linux-block@vger.kernel.org>; Fri, 26 Sep 2025 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919465; cv=none; b=pc8omEZMrM4FISXHgI6jTpnHI86RFsl0fe5MPB9yxq+7WHruvFCLJ0lrG53m5OQvP79gWHdm+bUpVGcxLXuZf3+Lk/uJbIbxb3CfQLaZn38VlVPPG/PkSbM3d9JgH4qGdBfnhhvas9taznEr243B1+RxyNjVQeV2bPBOqjlQb0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919465; c=relaxed/simple;
	bh=ggXxOLHkednufMcfZ3i4B+GLGkB8uVFX8KhTqndbYqw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c4yWhHKGhoyadINcqnGxtmQgnOxGqHMLsL0a4SMgOPA/TvcdYEhTlCTSfU/Y+IksGnnP9iXvJEJQYasHYVpJaTR9D+YyKQ1+9LgEc1OUtRhy2/CR/NzmPdh33IKlw8f3kE3frwuICHdJxWE2kZxhiMrgR83dMxAuLlmL0HI9mo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eu09KNCw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eu09KNCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE2EC4CEF8;
	Fri, 26 Sep 2025 20:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758919465;
	bh=ggXxOLHkednufMcfZ3i4B+GLGkB8uVFX8KhTqndbYqw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eu09KNCwZkYiCwWY6c3u5WLRbpwlk6UcpOGHj0g9EbZ3+66M9T3QMovnk9Ax4kzFD
	 2QnvftkApa0nEzBwJ9fECHiuXm77NHXqFpF6x0wS1vzITDY2EcQRgbi989kX37hFhY
	 GjNxe7T23yJ5pfHhiO3g4INa+Wpw5E8gr+Z1YM9U6SqwdHpT1nxDiK6FtrP1uttAkR
	 tfFRrg2/q2gy1x/V6BJaiEo4rLrM4CIi/RtCvKB9QO1tQV7qzGWDwYI0mrQxI1slDs
	 JwKp9bqMqfNMePFFfpM4/YTM/J8sKBlac34mwFOe1/eplEdlRskvZ4CpYMrlSE/4Y/
	 odvlKyu/39ZJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD8F39D0C3F;
	Fri, 26 Sep 2025 20:44:21 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.17 final
From: pr-tracker-bot@kernel.org
In-Reply-To: <c993fdf7-df9a-4689-a547-313b4cfde4b8@kernel.dk>
References: <c993fdf7-df9a-4689-a547-313b4cfde4b8@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c993fdf7-df9a-4689-a547-313b4cfde4b8@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.17-20250925
X-PR-Tracked-Commit-Id: 285213a65e91d0295751d740e2320d8fcd75d56e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a654ee549210f8aecfbebc7c699557666d17a4b
Message-Id: <175891946022.51956.10614783777127789950.pr-tracker-bot@kernel.org>
Date: Fri, 26 Sep 2025 20:44:20 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Sep 2025 23:54:32 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.17-20250925

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a654ee549210f8aecfbebc7c699557666d17a4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
