Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAFEEEC0
	for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777069243; cv=none; b=pznIOu5HdIXi1aoUmsb3tcKi751mxVJBJ+QKfULx9jLZ5S/OQXwxMmuf/rFq17YViD+xrD8RWQgeFWUIJ4nseEyOeAMpvwYqS4I97c358B6vgq50G5P9pTPLcLb8P9z3OmBX7bbvSqMKrcZllKqtz63MwhVuBgybURlmHp0NIUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777069243; c=relaxed/simple;
	bh=ifP69oOSz3cNyWxgWXdgp3yhwPREVMtLW/2XB+W4J1c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M1b+YBJadOUA/9H+Ul/ucax9ADARlgMIpo2BumFuf4tzUNlFNRPc/fkLgi4z4RCVCGIaVkzmuJ9LaxrE4NyUtMdJrv6DOSda1zOuapuqjoPIWBDYlEvzgL8hsW0752Rxki/2IHFUUN1KntcNa+ZPymhpQX0Qx14upKvMdVDygV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEz+DTjm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEz+DTjm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D29C19425;
	Fri, 24 Apr 2026 22:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777069243;
	bh=ifP69oOSz3cNyWxgWXdgp3yhwPREVMtLW/2XB+W4J1c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PEz+DTjmylsMtf8vt3Gi71EXKU1E6njL9tBhRtpyJx8z++E2TRKW5xSF7c2khQxXX
	 55RQsawYlP4CYU+6V0YEuOcASWU8M1+mODzkG3KH7QyV4Z4bRmGOKKE+m4b2q12GFU
	 PpyTpH2/iF9uSWWUSsuBZ9War4T7b+nRryUVtITUbsG+P1IIvZxE/Sj1Hxav2zju5E
	 tvzpfK3ZWnlp0PZD0+zq0nt1auPSH4zM89m62zOywvq3FVlKZTMGpIWV58cYC1zbfa
	 U4BmANmEZZ34BKlPLbZ0fIcQEQrL7DDS5qz+02Kyv/JtHhy56nwT0PTqhM3R/uP7uC
	 tBwnSodeKq4Jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7F73038119C3;
	Fri, 24 Apr 2026 22:20:04 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <f707ffcc-fb6e-4da1-a91f-5ed37e10cc0d@kernel.dk>
References: <f707ffcc-fb6e-4da1-a91f-5ed37e10cc0d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f707ffcc-fb6e-4da1-a91f-5ed37e10cc0d@kernel.dk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.1-20260424
X-PR-Tracked-Commit-Id: 895a9b37917d2718ef2240a7ead7458c22f1f011
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3e3dbcea15e20f7413afd8c791a496f0b80e80b
Message-Id: <177706920328.1737979.17977365275666551298.pr-tracker-bot@kernel.org>
Date: Fri, 24 Apr 2026 22:20:03 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Apr 2026 09:24:49 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.1-20260424

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3e3dbcea15e20f7413afd8c791a496f0b80e80b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
