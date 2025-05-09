Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C94237A3B
	for <linux-block@vger.kernel.org>; Fri,  9 May 2025 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746815419; cv=none; b=VE6dscgcbwQri5yOkZwSw8iHPk9ki9IBcZ3Zgbc7jJEl4rXlvJ1mrBqetBQay8rFmRz7DTzTCFak0rcU+D3jjoJM2qW9s+j38tLE0ff4FAQhWH3Z9LJMKBlrq4glXn4ORy5LhbDMKFMB3yUqtNeYdAIVIgF3fKb3XdCkwQhhVLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746815419; c=relaxed/simple;
	bh=ED4On+QKbMHwwMv2d07L5DpjEiCtSPJgxPzE2agghvA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CW+S3/Jd7TH1YoYSDsi//ZHAZOaZne3QkWntcmVmxhjBo4ggcGMXn8KwiHXVHT8Z5mS5owmuxlQpCMQqg6skN0LqUO3vbiQ22394XmqhofL9HVfthXCj/hnUtST0vbXiOvQzbEyKHIFoq2k9Pl+IBDWJWhR0tWFmfChLgcwE1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P45C0a99; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P45C0a99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0132FC4CEE4;
	Fri,  9 May 2025 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746815419;
	bh=ED4On+QKbMHwwMv2d07L5DpjEiCtSPJgxPzE2agghvA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P45C0a99D0RL4cWCG30QihCkZKrZkx86XIxMzyQ8n9hVId3J24DkN+P+dKJWZbB+d
	 Wg7kxzTpIs4isw3XLtq74KY/d+odP492/kUCNqRPMULRCR51ONISLs18uEmzHM9qLa
	 g0NzxXBPddBII+xgwwrTQvXfJPO5E/Xiynh+d4GwZSLaTaow19XJp8QePGsr7a6TPo
	 QNedzt/sd/0zYV7CwHIJKEvcCx7WNJaQVc9xl7bomIn4FR867CWuze94r3Kpn5P71W
	 YW6yDLksrLkG0DMqNoYYqjmFJ0D8ctCgVrxBxFcK8zTm4LYcNT2jGGbCwQMJy6TO4W
	 gpbf7ZRrwisLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEBD380DBCB;
	Fri,  9 May 2025 18:30:58 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.15-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <10083b7c-4ea7-4494-a6a4-764a700516c8@kernel.dk>
References: <10083b7c-4ea7-4494-a6a4-764a700516c8@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <10083b7c-4ea7-4494-a6a4-764a700516c8@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.15-20250509
X-PR-Tracked-Commit-Id: dd90905d5a8a15a6d4594d15fc8ed626587187ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc9f0629caee0cc54356743bf1ff54dca55275cf
Message-Id: <174681545739.3713200.5572909506267458703.pr-tracker-bot@kernel.org>
Date: Fri, 09 May 2025 18:30:57 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 May 2025 09:34:07 -0600:

> git://git.kernel.dk/linux.git tags/block-6.15-20250509

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc9f0629caee0cc54356743bf1ff54dca55275cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
