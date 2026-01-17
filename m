Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B22D77FF
	for <linux-block@vger.kernel.org>; Sat, 17 Jan 2026 05:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768626217; cv=none; b=CrdkaoQ5I4QgMfKScgYWoO2qie5C/0zAfsLNgwK94fd/GEv/5McGJYgtF8iPgDEGDeos1d18FTEVHCos69GlsqP/wAeyBlM7BtJJC0HIYdX10XoT8Skl0kt/VOvzp7rb3TNahI+VxmWHBI1CU/Q+oasTE7LnXV0XiT5y1cvr5xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768626217; c=relaxed/simple;
	bh=vt2Jk/m/8JhxCWapY4PQZBd/6CqCBQYKJAgd3ffHnb8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IwauyUFs40Xjvkgl2keOGa4rbXNwmqX+QukKBw9LTTM4+nnBkPOa16glZqZQBy0yGD8MpuOYZ360uO6gxn3kGrKEDnUEM/4w8IN873qiEOTe55WOhIVx93rGkihR0dShyY8F86na5ToQlfZdWPSG61pCFbRCQsT1UABnZJF9cQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5jy/kw0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5jy/kw0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BEBC4CEF7;
	Sat, 17 Jan 2026 05:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768626217;
	bh=vt2Jk/m/8JhxCWapY4PQZBd/6CqCBQYKJAgd3ffHnb8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o5jy/kw0xZGsTIDMnrjLhabYEH5sZOeso0BuIR17W9Y1H8MV4LCawMtX0Hb29kIiJ
	 ClpijnOVEh5lWpl2GqdqgT31n5QbaFEyabSQcE4+oSmchco9J5akdTNQvEqcB7KX8k
	 HfS2Af509piPmSMn9UUe/icPmqgQiRtDIZ/RaURLVBO35BbhHyODpSWWLeVmasjeML
	 h9zor1VSYVfSzLPoppaHI7DpWifhpRWKAAYpBCZg34ugbJYomuJgWZ/twhMutWWPHr
	 Cy1Q+x/L1u4dwvQ+nOEvHBv6EF1oPUFxxPz/x7a7gPU6/FNWm9EWFRNjVEvsNuwJFS
	 L2HjzycAR2B/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7882C380CEFE;
	Sat, 17 Jan 2026 05:00:09 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.19-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <4e5e1aba-adc4-4414-bc86-35d3c8d9f653@kernel.dk>
References: <4e5e1aba-adc4-4414-bc86-35d3c8d9f653@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4e5e1aba-adc4-4414-bc86-35d3c8d9f653@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260116
X-PR-Tracked-Commit-Id: ec19ed2b3e2af8ec5380400cdee9cb6560144506
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3eeb99bbc99cc5eb94a4a75ed4415a0272254ef
Message-Id: <176862600797.903237.3431669558191167616.pr-tracker-bot@kernel.org>
Date: Sat, 17 Jan 2026 05:00:07 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Jan 2026 20:53:03 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260116

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3eeb99bbc99cc5eb94a4a75ed4415a0272254ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
