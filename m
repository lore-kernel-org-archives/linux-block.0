Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141337646A
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875796; cv=none; b=Wp4SI1axzWVimZgUn+z8CLnqGH1xbWDxEZjhGCm55rI8Jbc0351O/AT+oCF8HMLlujoo5AlPmRd1cjk3NhUfhG6BbQuFO2tgb+D6QsBe0xTA4ZeQ4Ck7Dh/QiSPUbwHppP/dNaSsrqoo9NUCvyrTXl2gXUu6ZXB202SDr5F26W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875796; c=relaxed/simple;
	bh=oYx+xc6/3wKB6vkI3mOZQcb3i3/bNN7HUBODUrF/mAg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YEbEZtJDyFwhK6hxaMW45OBPZTx+m3QhMi6B157hPgtFwX7r4tso7p4XvMT7TUIJPmJI+vGcNjSsvhpScTdfdsfRG7wEjcfsuH6T7qOA2icBaced6BkpjzOtIE4adRRK0Qy5IluZO5uFTIHJVEfLhV/pnudDKNT5Hd4bfJoEdiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqQ64LYw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqQ64LYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50222C2BCB0;
	Fri, 15 May 2026 20:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778875796;
	bh=oYx+xc6/3wKB6vkI3mOZQcb3i3/bNN7HUBODUrF/mAg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CqQ64LYwXz2C+KQj0QNuqHzh9FiKK3Ar8tqPXNMWgvWhaer+w3B24ILI81YUXefrp
	 gV5LMQwVPiKrbipBTqcZ9qYxoMq6/R8asud7jqAQfq+1vxM0SyaskgP9phCGZq4GPN
	 2/DP0hKOkIs3B4HjlcFOGhVKHQhUyCDXMzAcgFouYguisPskYYcqesBNreJ7vNnpaC
	 eO7d1jSNAgn0e7kyr+VLNMdf4q58WtUtwIpV/jvX73NjEy+ZCeE8of68lFJ/VOOGSM
	 +ydzFLBDTZXZ5RwSjFWPD+Z9YEJBBp/lrqkHWcpfygM3DgM7P9G8ciNb31qMZjlozz
	 ujNcXWgJiXTwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09083930A08;
	Fri, 15 May 2026 20:10:10 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 7.1-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <093dc3c7-5030-4400-9b38-727c41c5f511@kernel.dk>
References: <093dc3c7-5030-4400-9b38-727c41c5f511@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <093dc3c7-5030-4400-9b38-727c41c5f511@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.1-20260515
X-PR-Tracked-Commit-Id: 4141f46daa4cf1f8caa14129f8b6db86f17452f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d458a240344c4369bf6f3da203f2779515177738
Message-Id: <177887580947.138467.3593846393272567637.pr-tracker-bot@kernel.org>
Date: Fri, 15 May 2026 20:10:09 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 May 2026 08:20:27 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.1-20260515

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d458a240344c4369bf6f3da203f2779515177738

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
